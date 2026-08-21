using UnityEngine.Rendering;

namespace UnityEngine.Experimental.Rendering.RenderGraphModule;

public struct FastMemoryDesc
{
	public bool inFastMemory;

	public FastMemoryFlags flags;

	public float residencyFraction;
}
