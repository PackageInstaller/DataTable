using System;

namespace ACT.Battle;

[Flags]
public enum SubTaskParameterFlag
{
	none = 0,
	cd = 1,
	weight = 2,
	frontDistance = 4,
	backDistance = 8,
	condition = 0x10
}
