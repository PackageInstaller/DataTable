using System;

namespace UnityEngine.Rendering;

[Flags]
public enum FastMemoryFlags
{
	None = 0,
	SpillTop = 1,
	SpillBottom = 2
}
