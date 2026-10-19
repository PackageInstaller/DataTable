using System;

namespace PathFinding2D.Runtime.Models;

[Flags]
public enum EndPointDirection
{
	None = 0,
	Left = 1,
	Right = 2,
	Vertical = 4
}
