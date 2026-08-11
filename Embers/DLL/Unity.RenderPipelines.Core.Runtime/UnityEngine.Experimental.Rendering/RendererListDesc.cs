using System;
using UnityEngine.Rendering;

namespace UnityEngine.Experimental.Rendering;

[Obsolete("Use the updated RendererList API which is defined in the UnityEngine.Rendering.RendererUtils namespace.")]
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

	internal CullingResults cullingResult { get; private set; }

	internal Camera camera { get; set; }

	internal ShaderTagId passName { get; private set; }

	internal ShaderTagId[] passNames { get; private set; }

	public RendererListDesc(ShaderTagId passName, CullingResults cullingResult, Camera camera)
	{
		this = default(RendererListDesc);
		this.passName = passName;
		passNames = null;
		this.cullingResult = cullingResult;
		this.camera = camera;
		layerMask = -1;
		overrideMaterialPassIndex = 0;
	}

	public RendererListDesc(ShaderTagId[] passNames, CullingResults cullingResult, Camera camera)
	{
		this = default(RendererListDesc);
		this.passNames = passNames;
		passName = ShaderTagId.none;
		this.cullingResult = cullingResult;
		this.camera = camera;
		layerMask = -1;
		overrideMaterialPassIndex = 0;
	}

	public bool IsValid()
	{
		if (camera == null || (passName == ShaderTagId.none && (passNames == null || passNames.Length == 0)))
		{
			return false;
		}
		return true;
	}
}
