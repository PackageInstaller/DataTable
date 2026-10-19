using System;

namespace ACT.Battle.Configs;

[Obsolete]
[Flags]
public enum AttackTypeTag
{
	normally = 1,
	skill = 2,
	buff = 4,
	summon = 8,
	tear = 0x10,
	decay = 0x20,
	SpecialAttactk = 0x40,
	DownAttack = 0x80,
	UpAttack = 0x100,
	AirAttactk = 0x200,
	AccumulatedAttack = 0x400,
	SwitchSkill = 0x800,
	ExtraAttack = 0x1000,
	ultraAttack = 0x2000,
	bulletAttack = 0x4000,
	trap = 0x8000
}
