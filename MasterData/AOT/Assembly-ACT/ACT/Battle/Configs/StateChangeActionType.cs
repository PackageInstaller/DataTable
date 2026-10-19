using System;

namespace ACT.Battle.Configs;

[Flags]
public enum StateChangeActionType
{
	None = 0,
	CurrentBehave = 1,
	SwitchBehave = 2
}
