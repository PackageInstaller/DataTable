namespace UnityEngine.Rendering;

internal struct CullingAllocationInfo
{
	public unsafe VisibleLight* visibleLightsPtr;

	public unsafe VisibleLight* visibleOffscreenVertexLightsPtr;

	public unsafe VisibleReflectionProbe* visibleReflectionProbesPtr;

	public int visibleLightCount;

	public int visibleOffscreenVertexLightCount;

	public int visibleReflectionProbeCount;
}
