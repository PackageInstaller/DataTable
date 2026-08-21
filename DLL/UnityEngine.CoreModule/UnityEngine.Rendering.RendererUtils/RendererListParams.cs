#define UNITY_ASSERTIONS
using System.Diagnostics;
using System.Runtime.CompilerServices;

namespace UnityEngine.Rendering.RendererUtils;

internal struct RendererListParams
{
	private static readonly ShaderTagId s_EmptyName = new ShaderTagId("");

	public static readonly RendererListParams nullRendererList = default(RendererListParams);

	[DebuggerBrowsable(DebuggerBrowsableState.Never)]
	[CompilerGenerated]
	private bool _003CisValid_003Ek__BackingField;

	internal CullingResults cullingResult;

	internal DrawingSettings drawSettings;

	internal FilteringSettings filteringSettings;

	internal RenderStateBlock? stateBlock;

	private bool isValid
	{
		[CompilerGenerated]
		set
		{
			_003CisValid_003Ek__BackingField = value;
		}
	}

	internal static RendererListParams Create(in RendererListDesc desc)
	{
		RendererListParams result = default(RendererListParams);
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
			Debug.Assert(desc.passNames == null);
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
