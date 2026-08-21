using System;

namespace UnityEngine.Rendering;

[Flags]
public enum BatchCullingFlags
{
	None = 0,
	CullLightmappedShadowCasters = 1
}
