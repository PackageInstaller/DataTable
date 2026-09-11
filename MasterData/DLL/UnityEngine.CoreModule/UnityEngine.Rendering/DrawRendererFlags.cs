using System;

namespace UnityEngine.Rendering;

[Flags]
internal enum DrawRendererFlags
{
	None = 0,
	EnableDynamicBatching = 1,
	EnableInstancing = 2
}
