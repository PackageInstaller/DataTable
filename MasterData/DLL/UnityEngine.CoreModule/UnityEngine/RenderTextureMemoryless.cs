using System;

namespace UnityEngine;

[Flags]
public enum RenderTextureMemoryless
{
	None = 0,
	Color = 1,
	Depth = 2,
	MSAA = 4
}
