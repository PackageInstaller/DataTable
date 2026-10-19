using System;

namespace ACT.Battle;

[Flags]
public enum TimeType
{
	None = 0,
	Motion = 1,
	Physics = 2,
	Witch = 4,
	Ability = 8
}
