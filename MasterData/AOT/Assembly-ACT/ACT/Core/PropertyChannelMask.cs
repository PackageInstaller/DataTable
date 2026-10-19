using System;

namespace ACT.Core;

[Flags]
public enum PropertyChannelMask
{
	None = 0,
	Base = 1,
	Add = 2,
	Mul = 4,
	Max = 8,
	All = Base | Add | Mul
}
