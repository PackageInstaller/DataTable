using Unity.Collections;

namespace UnityEngine.Rendering.Universal;

public struct LightData
{
	public int mainLightIndex;

	public int additionalLightsCount;

	public int maxPerObjectAdditionalLightsCount;

	public NativeArray<VisibleLight> visibleLights;

	internal PreparedLightFrameData preparedLights;

	public bool shadeAdditionalLightsPerVertex;

	public bool supportsLightLayers;

	public bool supportsAdditionalLights;
}
