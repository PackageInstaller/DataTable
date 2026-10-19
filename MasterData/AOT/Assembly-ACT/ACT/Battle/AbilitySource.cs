using System;

namespace ACT.Battle;

[Flags]
public enum AbilitySource
{
	None = 0,
	Passive = 1,
	UpgradeSkill = 2,
	Weapon = 4,
	Chip = 8,
	NetSync = 0x10,
	Motion = 0x20,
	BehaviourTree = 0x40,
	BluePrint = 0x80,
	Ability = 0x100,
	System = 0x200,
	RogueCard = 0x400,
	RogueArtifact = 0x800,
	RogueTrigger = 0x1000,
	Environment = 0x2000,
	Equip = 0x4000,
	Elite = 0x8000,
	BloodBottle = 0x10000,
	Constellation = 0x20000,
	GM = 0x40000000
}
