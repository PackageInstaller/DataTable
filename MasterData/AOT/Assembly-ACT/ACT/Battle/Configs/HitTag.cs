using System;

namespace ACT.Battle.Configs;

[Flags]
public enum HitTag
{
	None = 0,
	ForcedToFly = 1,
	Roar = 2,
	BreakImmunity = 4,
	HeavyPunch = 8,
	NoPerfectDodge = 0x10,
	NoParry = 0x20,
	NoWitchDodge = 0x40
}
