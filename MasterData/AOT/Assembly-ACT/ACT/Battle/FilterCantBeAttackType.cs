using System;

namespace ACT.Battle;

[Flags]
public enum FilterCantBeAttackType
{
	Null = 0,
	Property = 1,
	EntityIgnoreAttack = 2,
	MotionInvincibility = 4,
	AbilityInvincibility = 8
}
