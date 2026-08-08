using System;

[Flags]
public enum SummerRacePresentationPhaseMask
{
	None = 0,
	Rejected = 1,
	Fired = 2,
	Activated = 4,
	ActiveExpired = 8,
	Spawned = 0x10,
	ReturnStarted = 0x20,
	Hit = 0x40,
	Recycled = 0x80,
	Impact = 0x100
}
