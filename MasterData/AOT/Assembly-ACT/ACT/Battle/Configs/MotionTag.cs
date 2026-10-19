using System;
using UnityEngine;

namespace ACT.Battle.Configs;

[Flags]
public enum MotionTag
{
	None = 0,
	ChangeDir = 1,
	ForbidSwitch = 2,
	TenResistance = 4,
	SuperArmor = 8,
	Invincibility = 0x10,
	IgnoreEffectCollision = 0x20,
	IgnoreBlackViscous = 0x40,
	ForbidUpdraft = 0x80,
	ForbidDodgeAndGrab = 0x100,
	TimelineAllowRootMotion = 0x200,
	ForbidSwitchSkill = 0x400,
	SynergySkill = 0x800,
	Groundprotection = 0x1000,
	GravityControl = 0x2000,
	InputControl = 0x4000,
	TryDownMove = 0x8000,
	ForbidFallSpeedAccumulate = 0x10000,
	CanDoClimbCompensation = 0x20000,
	[HideInInspector]
	TenacityImmune = 0x40000,
	ForbidUltra = 0x80000,
	ForbidJump = 0x100000,
	ForbidWeapon1 = 0x200000,
	ForbidWeapon2 = 0x400000,
	UltraState = 0x800000,
	DodgeAssist = 0x1000000,
	CanDoWallClimb = 0x2000000,
	[HideInInspector]
	ForbidPlayerAIMoveInput = 0x4000000,
	CantSpring = 0x8000000,
	CanBeDeflect = 0x10000000,
	JumpAssist = 0x20000000,
	Uncrossable = 0x40000000
}
