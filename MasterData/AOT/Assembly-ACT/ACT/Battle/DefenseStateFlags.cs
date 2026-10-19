using System;

namespace ACT.Battle;

[Flags]
public enum DefenseStateFlags
{
	None = 0,
	Invincible = 1,
	TrueInvincible = 2,
	BlockThrow = 4
}
