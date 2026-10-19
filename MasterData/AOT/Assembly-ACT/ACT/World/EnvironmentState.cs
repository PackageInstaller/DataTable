using System;

namespace ACT.World;

[Flags]
public enum EnvironmentState
{
	None = 0,
	ForbideSyncGameInfo = 1
}
