using System;

namespace ACT.Battle.Configs;

[Flags]
public enum AbilityLogEnum
{
	none = 0,
	abilityCurStack = 2,
	abilityCurDuration = 4,
	abilityCurTarget = 8,
	curTIme = 0x10
}
