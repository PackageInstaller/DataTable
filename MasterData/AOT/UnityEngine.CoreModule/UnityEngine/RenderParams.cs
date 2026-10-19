using UnityEngine.Rendering;

namespace UnityEngine;

public struct RenderParams(Material mat)
{
	public int layer { get; set; } = 0;

	public uint renderingLayerMask { get; set; } = GraphicsSettings.defaultRenderingLayerMask;

	public int rendererPriority { get; set; } = 0;

	public Bounds worldBounds { get; set; } = new Bounds(Vector3.zero, Vector3.zero);

	public Camera camera { get; set; } = null;

	public MotionVectorGenerationMode motionVectorMode { get; set; } = MotionVectorGenerationMode.Camera;

	public ReflectionProbeUsage reflectionProbeUsage { get; set; } = ReflectionProbeUsage.Off;

	public Material material { get; set; } = mat;

	public MaterialPropertyBlock matProps { get; set; } = null;

	public ShadowCastingMode shadowCastingMode { get; set; } = ShadowCastingMode.Off;

	public bool receiveShadows { get; set; } = false;

	public LightProbeUsage lightProbeUsage { get; set; } = LightProbeUsage.Off;

	public LightProbeProxyVolume lightProbeProxyVolume { get; set; } = null;
}
