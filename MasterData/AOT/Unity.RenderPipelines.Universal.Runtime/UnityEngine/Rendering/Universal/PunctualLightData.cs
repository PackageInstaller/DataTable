namespace UnityEngine.Rendering.Universal;

public struct PunctualLightData
{
	public Vector3 wsPos;

	public float radius;

	public Vector4 color;

	public Vector4 attenuation;

	public Vector3 spotDirection;

	public int flags;

	public Vector4 occlusionProbeInfo;

	public uint layerMask;
}
