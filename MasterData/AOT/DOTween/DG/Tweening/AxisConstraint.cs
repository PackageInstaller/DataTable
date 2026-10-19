using System;

namespace DG.Tweening;

[Flags]
public enum AxisConstraint
{
	None = 0,
	X = 2,
	Y = 4,
	Z = 8,
	W = 0x10
}
