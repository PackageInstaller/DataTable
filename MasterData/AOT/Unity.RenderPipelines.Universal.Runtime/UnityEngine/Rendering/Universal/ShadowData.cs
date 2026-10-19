namespace UnityEngine.Rendering.Universal;

public struct ShadowData
{
	public bool supportsMainLightShadows;

	public int mainLightShadowmapWidth;

	public int mainLightShadowmapHeight;

	public int mainLightShadowCascadesCount;

	public Vector3 mainLightShadowCascadesSplit;

	public float mainLightShadowCascadeBorder;

	public bool supportsAdditionalLightShadows;

	public int additionalLightsShadowmapWidth;

	public int additionalLightsShadowSliceResolution;

	public bool additionalShadowTimeSlicingEnabled;

	public int maxAdditionalShadowTilesPerFrame;

	public Vector4 mainLightCascadeDepthBias;

	public Vector4 mainLightCascadeSlopeBias;

	public float additionalLightShadowDepthBias;

	public float additionalLightShadowNormalBias;

	public float additionalLightShadowSlopeBias;
}
