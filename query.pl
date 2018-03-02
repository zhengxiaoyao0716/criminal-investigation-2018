:- use_module(library(clpfd)).

q(a). q(b). q(c). q(d).

qs([]).
qs([H|T]) :- q(H), qs(T).

qf(Q, a, [A,B,C,D|E]) :- call(Q, [A,  B,C,D|E]).
qf(Q, b, [A,B,C,D|E]) :- call(Q, [B,A,  C,D|E]).
qf(Q, c, [A,B,C,D|E]) :- call(Q, [C,A,B,  D|E]).
qf(Q, d, [A,B,C,D|E]) :- call(Q, [D,A,B,C  |E]).

count(_, [], 0).
count(Ans, [Ans|T], C) :- count(Ans, T, CC), C is CC + 1.
count(Ans, [H|T], C) :- count(Ans, T, C), Ans\=H.

ordinal(a, 0). ordinal(b, 1). ordinal(c, 2). ordinal(d, 3).

q2(a, c). q2(b, d). q2(c, a). q2(d, b).

q3([A, B, C, D]) :- A\=B, B=C, C=D.

q4([[A1,A2], [B1,B2], [C1,C2], [D1,D2]]) :- A1=A2, B1\=B2, C1\=C2, D1\=D2.

q5([A,B,C,D,Ans]) :- Ans=A, Ans\=B, Ans\=C, Ans\=D.

q6([A1,A2], Ans) :- Ans=A1, Ans=A2.
q6([A, B, C, D, R8]) :- q6(A,R8), \+(q6(B, R8)), \+(q6(C, R8)), \+(q6(D, R8)).

q7min(Ans, CS) :- ordinal(Ans, Index), nth0(Index, CS, Value), min_list(CS, Value).
q7(a, c). q7(b, b). q7(c, a). q7(d, d).
q7(R7, CS) :- q7min(Ans, CS), q7(R7, Ans).

q8near([A1, A2]) :- ordinal(A1, O1), ordinal(A2, O2), abs(O1 - O2, 1).
q8([A, B, C, D, R1]) :- \+(q8near([A, R1])), q8near([B, R1]), q8near([C, R1]), q8near([D, R1]).

q9([A, B, C, D, [R16, R16], R5]) :- A\=R5, B=R5, C=R5, D=R5.
q9([A, B, C, D, [R1, R6], R5]) :- R1\=R6, A=R5, B\=R5, C\=R5, D\=R5.

q10diff(CS, Diff) :- min_list(CS, Min), max_list(CS, Max), Diff #= Max - Min.
q10(a, 3). q10(b, 2). q10(c, 4). q10(d, 1).
q10(Ans, CS) :- q10diff(CS, Diff), q10(Ans, Diff).

query(RS) :- [R1,R2,R3,R4,R5,R6,R7,R8,R9,R10] = RS,
    qs(RS),
    q2(R2, R5),
    qf(q3, R3, [R3,R6,R2,R4]),
    qf(q4, R4, [[R1,R5],[R2,R7],[R1,R9],[R6,R10]]),
    qf(q5, R5, [R8,R4,R9,R7, R5]),
    qf(q6, R6, [[R2,R4],[R1,R6],[R3,R10],[R5,R9], R8]),
    count(a, RS, CA), count(b, RS, CB), count(c, RS, CC), count(d, RS, CD),
    q7(R7, [CA,CB,CC,CD]),
    qf(q8, R8, [R7, R5, R2, R10, R1]),
    qf(q9, R9, [R6, R10, R2, R9, [R1, R6], R5]),
    q10(R10, [CA,CB,CC,CD])
    .
