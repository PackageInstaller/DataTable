using System;

namespace UnityEngine;

public enum RenderingPath
{
	UsePlayerSettings = -1,
	VertexLit,
	Forward,
	[Obsolete("DeferredLighting has been removed. Use DeferredShading, Forward or HDRP/URP instead.", false)]
	DeferredLighting,
	DeferredShading
}
