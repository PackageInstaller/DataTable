using System;

namespace ACT.Battle.Configs;

[Flags]
public enum BuffTag
{
	CantClearOnDie = 1,
	ForceClearOnDie = 2,
	SharedTriggerBuff = 4,
	TrapBuff = 8,
	FreezeBuff = 0x10,
	PojiaBuff = 0x20,
	TechBuff = 0x40,
	EchoBuff = 0x80,
	CantInteract = 0x100,
	BurstBuff = 0x200,
	Striker = 0x400,
	Breaker = 0x800,
	AssistStriker = 0x1000,
	LockHp = 0x2000,
	DamageTypeMask = Striker | Breaker | AssistStriker
}
