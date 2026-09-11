using System;

namespace BilliardGame.Runtime;

[Serializable]
public enum BilliardTurnType
{
	None = 1,
	AfterPreTurn,
	FixedTurn
}
