using System;

namespace ACT.Battle;

[Flags]
public enum EInputDir
{
	None = 0,
	Left = 1,
	Right = 2,
	Up = 4,
	Down = 8
}
