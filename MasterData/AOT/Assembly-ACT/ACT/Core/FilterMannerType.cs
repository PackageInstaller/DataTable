using System;

namespace ACT.Core;

[Flags]
public enum FilterMannerType
{
	Null = 0,
	Breaker = 1,
	Ranger = 2,
	Insight = 4,
	Strategist = 8,
	Generalist = 0x10
}
