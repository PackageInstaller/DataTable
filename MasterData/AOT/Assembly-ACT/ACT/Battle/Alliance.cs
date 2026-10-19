using System;

namespace ACT.Battle;

[Flags]
public enum Alliance
{
	Character = 1,
	Enemy = 2,
	Netural = 4,
	All = Character | Enemy | Netural
}
