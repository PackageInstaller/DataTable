using System;

namespace ACT.Battle;

[Flags]
public enum EntityBehaveState
{
	Released = 0,
	Got = 1,
	LogicAvailable = 2,
	BehaveAvailable = 4,
	AINavAvailable = 8,
	CanRemove = 0x10,
	ToRemove = 0x20,
	OnRemove = 0x40
}
