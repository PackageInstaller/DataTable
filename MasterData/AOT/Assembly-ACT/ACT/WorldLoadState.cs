using System;

namespace ACT;

[Flags]
public enum WorldLoadState
{
	None = 0,
	Reopening = 1,
	GiveUp = 2
}
