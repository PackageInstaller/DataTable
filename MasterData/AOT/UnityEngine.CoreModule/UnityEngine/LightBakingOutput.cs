using UnityEngine.Bindings;

namespace UnityEngine;

[NativeHeader("Runtime/Camera/SharedLightData.h")]
public struct LightBakingOutput
{
	public int probeOcclusionLightIndex;

	public int occlusionMaskChannel;

	[NativeName("lightmapBakeMode.lightmapBakeType")]
	public LightmapBakeType lightmapBakeType;

	[NativeName("lightmapBakeMode.mixedLightingMode")]
	public MixedLightingMode mixedLightingMode;

	public bool isBaked;
}
