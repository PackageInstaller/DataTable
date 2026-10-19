using System;

namespace ACT.Battle.Configs;

[Flags]
public enum Adjust2AttackTypeTag
{
	None = 0,
	DotAttack = 2,
	SummoningAttack = 4,
	AirAttack = 8,
	BreakerManner = 0x10,
	StrategistManner = 0x20,
	GeneralistManner = 0x40,
	Role_05_01_SpecialAttack = 0x80,
	BreakImmunity = 0x100,
	Role_11_01_SpecialAttack = 0x200,
	ForceCritical = 0x400,
	NoneCritical = 0x800,
	DropAttack = 0x1000,
	HeavyAttack = 0x2000,
	EnhancedAttack = 0x4000,
	ParryAttack = 0x8000
}
