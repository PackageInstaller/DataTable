using System;
using UnityEngine.Rendering;

namespace UnityEngine.Experimental.Rendering;

[Obsolete("Use the updated RendererList API which is defined in the UnityEngine.Rendering.RendererUtils namespace.")]
public struct RendererList
{
	private static readonly ShaderTagId s_EmptyName = new ShaderTagId("");

	public static readonly RendererList nullRendererList = default(RendererList);

	public CullingResults cullingResult;

	public DrawingSettings drawSettings;

	public FilteringSettings filteringSettings;

	public RenderStateBlock? stateBlock;

	public bool isValid { get; private set; }

	public static RendererList Create(in RendererListDesc desc)
	{
		RendererList result = default(RendererList);
		if (!desc.IsValid())
		{
			return result;
		}
		SortingSettings sortingSettings = new SortingSettings(desc.camera);
		sortingSettings.criteria = desc.sortingCriteria;
		SortingSettings sortingSettings2 = sortingSettings;
		DrawingSettings drawingSettings = new DrawingSettings(s_EmptyName, sortingSettings2);
		drawingSettings.perObjectData = desc.rendererConfiguration;
		DrawingSettings drawingSettings2 = drawingSettings;
		if (desc.passName != ShaderTagId.none)
		{
			drawingSettings2.SetShaderPassName(0, desc.passName);
		}
		else
		{
			for (int i = 0; i < desc.passNames.Length; i++)
			{
				drawingSettings2.SetShaderPassName(i, desc.passNames[i]);
			}
		}
		if (desc.overrideMaterial != null)
		{
			drawingSettings2.overrideMaterial = desc.overrideMaterial;
			drawingSettings2.overrideMaterialPassIndex = desc.overrideMaterialPassIndex;
		}
		FilteringSettings filteringSettings = new FilteringSettings(desc.renderQueueRange, desc.layerMask);
		filteringSettings.excludeMotionVectorObjects = desc.excludeObjectMotionVectors;
		FilteringSettings filteringSettings2 = filteringSettings;
		result.isValid = true;
		result.cullingResult = desc.cullingResult;
		result.drawSettings = drawingSettings2;
		result.filteringSettings = filteringSettings2;
		result.stateBlock = desc.stateBlock;
		return result;
	}
}
