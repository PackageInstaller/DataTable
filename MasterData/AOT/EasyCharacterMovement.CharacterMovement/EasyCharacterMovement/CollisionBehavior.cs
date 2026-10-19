using System;

namespace EasyCharacterMovement;

[Flags]
public enum CollisionBehavior
{
	Default = 0,
	Walkable = 1,
	NotWalkable = 2,
	CanPerchOn = 4,
	CanNotPerchOn = 8,
	CanStepOn = 0x10,
	CanNotStepOn = 0x20,
	CanRideOn = 0x40,
	CanNotRideOn = 0x80,
	CanClimb = 0x100,
	CanNotClimb = 0x200,
	CanDodgeAssist = 0x400,
	CanNotDodgeAssist = 0x800,
	IncreaseSlopeSlide = 0x1000,
	CanOffCliff = 0x2000
}
