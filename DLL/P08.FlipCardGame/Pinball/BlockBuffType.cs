using System;

namespace Pinball;

[Flags]
public enum BlockBuffType
{
	None = 0,
	protect = 1,
	affect = 2,
	affected = 4
}
