using System;

namespace Pinball;

[Flags]
public enum BallBuffType
{
	None = 0,
	explosion = 1,
	spare = 2,
	arrow = 4
}
