using System;

namespace FlowCanvas.Nodes;

[Flags]
public enum GatherTargetType
{
	None = 0,
	Noraml = 1,
	Elitel = 2,
	Boss = 4
}
