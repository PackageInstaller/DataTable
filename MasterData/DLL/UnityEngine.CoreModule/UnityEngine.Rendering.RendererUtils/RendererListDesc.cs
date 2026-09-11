#define UNITY_ASSERTIONS
using Unity.Collections;

namespace UnityEngine.Rendering.RendererUtils;

public struct RendererListDesc
{
	public SortingCriteria sortingCriteria;

	public PerObjectData rendererConfiguration;

	public RenderQueueRange renderQueueRange;

	public RenderStateBlock? stateBlock;

	public Shader overrideShader;

	public Material overrideMaterial;

	public bool excludeObjectMotionVectors;

	public int layerMask;

	public uint renderingLayerMask;

	public int overrideMaterialPassIndex;

	public int overrideShaderPassIndex;

	private static readonly ShaderTagId s_EmptyName = new ShaderTagId("");

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
		renderingLayerMask = uint.MaxValue;
		overrideMaterialPassIndex = 0;
		overrideShaderPassIndex = 0;
	}

	public bool IsValid()
	{
		if (camera == null || (passName == ShaderTagId.none && (passNames == null || passNames.Length == 0)))
		{
			return false;
		}
		return true;
	}

	public static RendererListParams ConvertToParameters(in RendererListDesc desc)
	{
		if (!desc.IsValid())
		{
			return RendererListParams.Invalid;
		}
		RendererListParams result = default(RendererListParams);
		SortingSettings sortingSettings = new SortingSettings(desc.camera);
		sortingSettings.criteria = desc.sortingCriteria;
		SortingSettings sortingSettings2 = sortingSettings;
		DrawingSettings drawingSettings = new DrawingSettings(s_EmptyName, sortingSettings2);
		drawingSettings.perObjectData = desc.rendererConfiguration;
		DrawingSettings drawSettings = drawingSettings;
		if (desc.passName != ShaderTagId.none)
		{
			Debug.Assert(desc.passNames == null);
			drawSettings.SetShaderPassName(0, desc.passName);
		}
		else
		{
			for (int i = 0; i < desc.passNames.Length; i++)
			{
				drawSettings.SetShaderPassName(i, desc.passNames[i]);
			}
		}
		if (desc.overrideShader != null)
		{
			drawSettings.overrideShader = desc.overrideShader;
			drawSettings.overrideShaderPassIndex = desc.overrideShaderPassIndex;
		}
		if (desc.overrideMaterial != null)
		{
			drawSettings.overrideMaterial = desc.overrideMaterial;
			drawSettings.overrideMaterialPassIndex = desc.overrideMaterialPassIndex;
		}
		FilteringSettings filteringSettings = new FilteringSettings(desc.renderQueueRange, desc.layerMask, desc.renderingLayerMask);
		filteringSettings.excludeMotionVectorObjects = desc.excludeObjectMotionVectors;
		FilteringSettings filteringSettings2 = filteringSettings;
		result.cullingResults = desc.cullingResult;
		result.drawSettings = drawSettings;
		result.filteringSettings = filteringSettings2;
		result.tagName = ShaderTagId.none;
		result.isPassTagName = false;
		if (desc.stateBlock.HasValue && desc.stateBlock.HasValue)
		{
			result.stateBlocks = new NativeArray<RenderStateBlock>(1, Allocator.Temp) { [0] = desc.stateBlock.Value };
			result.tagValues = new NativeArray<ShaderTagId>(1, Allocator.Temp) { [0] = ShaderTagId.none };
		}
		return result;
	}
}
