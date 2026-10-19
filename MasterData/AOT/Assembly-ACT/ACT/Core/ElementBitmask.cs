using System;

namespace ACT.Core;

[Flags]
public enum ElementBitmask
{
	None = 0,
	Promote = 2,
	Disturb = 4,
	Operate = 8,
	Born = 0x10,
	Ash = 0x20,
	Dark = 0x40,
	ALL = Promote | Disturb | Operate | Ash | Dark
}
