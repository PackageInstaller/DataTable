using System;

namespace UnityEngine.Rendering;

[Flags]
public enum RenderTargetFlags
{
	None = 0,
	ReadOnlyDepth = 1,
	ReadOnlyStencil = 2,
	ReadOnlyDepthStencil = ReadOnlyDepth | ReadOnlyStencil
}
