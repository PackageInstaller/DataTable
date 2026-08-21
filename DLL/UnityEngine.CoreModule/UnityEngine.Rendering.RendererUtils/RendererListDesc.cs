namespace UnityEngine.Rendering.RendererUtils;

public struct RendererListDesc
{
	public SortingCriteria sortingCriteria;

	public PerObjectData rendererConfiguration;

	public RenderQueueRange renderQueueRange;

	public RenderStateBlock? stateBlock;

	public Material overrideMaterial;

	public bool excludeObjectMotionVectors;

	public int layerMask;

	public int overrideMaterialPassIndex;

	internal CullingResults cullingResult { get; }

	internal Camera camera { get; }

	internal ShaderTagId passName { get; }

	internal ShaderTagId[] passNames { get; }

	public bool IsValid()
	{
		if (camera == null || (passName == ShaderTagId.none && (passNames == null || passNames.Length == 0)))
		{
			return false;
		}
		return true;
	}
}
