using System.Collections.Generic;

namespace UnityEngine.Rendering.Universal.Internal;

internal sealed class TransparentForwardPass : ScriptableRenderPass
{
	private FilteringSettings m_FilteringSettings;

	private RenderStateBlock m_RenderStateBlock;

	private readonly List<ShaderTagId> m_PreZShaderTagIds = new List<ShaderTagId>(2);

	private readonly List<ShaderTagId> m_ColorShaderTagIds = new List<ShaderTagId>();

	private readonly List<ShaderTagId> m_SpecialColorShaderTagIds = new List<ShaderTagId>();

	private int m_SpecialCharacterLayerMask;

	private readonly RenderTargetIdentifier[] m_ColorAttachments = new RenderTargetIdentifier[2];

	private bool m_IsUICamera;

	private bool m_OutlineEnabled = true;

	internal override bool supportsNativePostDeferredPass => true;

	internal TransparentForwardPass(string profilerTag, RenderPassEvent evt, RenderQueueRange renderQueueRange, LayerMask layerMask, RenderBufferStoreAction depthStoreAction, LayerMask specialCharacterLayerMask = default(LayerMask))
	{
		profilingSampler = new ProfilingSampler(profilerTag);
		renderPassEvent = evt;
		m_FilteringSettings = new FilteringSettings(renderQueueRange, layerMask);
		m_RenderStateBlock = new RenderStateBlock(RenderStateMask.Nothing);
		m_SpecialCharacterLayerMask = specialCharacterLayerMask;
		RebuildShaderTagLists(outlineEnabled: true);
		ConfigureDepthAttachment(RenderBufferLoadAction.Load, depthStoreAction);
	}

	private void RebuildShaderTagLists(bool outlineEnabled)
	{
		m_PreZShaderTagIds.Clear();
		m_ColorShaderTagIds.Clear();
		m_SpecialColorShaderTagIds.Clear();
		m_PreZShaderTagIds.Add(ShaderPassTags.TransPreZ);
		ShaderTagId[] forwardShaderTagsWithoutCharacterOutline = ShaderPassTags.ForwardShaderTagsWithoutCharacterOutline;
		for (int i = 0; i < forwardShaderTagsWithoutCharacterOutline.Length; i++)
		{
			m_ColorShaderTagIds.Add(forwardShaderTagsWithoutCharacterOutline[i]);
		}
		if (outlineEnabled)
		{
			m_ColorShaderTagIds.Add(ShaderPassTags.TransparentOutline);
		}
		for (int j = 0; j < ShaderPassTags.ForwardShaderTags.Length; j++)
		{
			m_SpecialColorShaderTagIds.Add(ShaderPassTags.ForwardShaderTags[j]);
		}
	}

	internal void Setup(bool isUICamera)
	{
		m_IsUICamera = isUICamera;
	}

	internal void SetSpecialCharacterLayerMask(LayerMask layerMask)
	{
		m_SpecialCharacterLayerMask = layerMask;
	}

	internal void SetOutlineEnabled(bool enabled)
	{
		if (m_OutlineEnabled != enabled)
		{
			m_OutlineEnabled = enabled;
			RebuildShaderTagLists(enabled);
		}
	}

	private bool WritesMotionFeatureMrt(ref RenderingData renderingData)
	{
		if (!renderingData.postProcessingData.motionFeature)
		{
			return false;
		}
		UniversalRenderer renderer = renderingData.cameraData.renderer;
		if (renderer != null)
		{
			return renderer.gBuffer2TextureRT != null;
		}
		return false;
	}

	public override void Configure(ref RenderingData renderingData)
	{
		ScriptableRenderer renderer = renderingData.cameraData.renderer;
		UniversalRenderer universalRenderer = renderer as UniversalRenderer;
		if (WritesMotionFeatureMrt(ref renderingData))
		{
			m_ColorAttachments[0] = renderer.cameraColorTarget;
			m_ColorAttachments[1] = universalRenderer.gBuffer2Texture;
			ConfigureTarget(m_ColorAttachments, renderer.cameraDepthTarget);
		}
		else
		{
			targetCount = 1u;
			ConfigureTarget(renderer.cameraColorTarget, renderer.cameraDepthTarget);
		}
	}

	public override void BeginSubPass(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		NativeRenderPassManager nativeRenderPassManager = renderingData.nativeRenderPassManager;
		if (WritesMotionFeatureMrt(ref renderingData) && nativeRenderPassManager.CurrentPassType == NativeRenderPassType.PostDeferred)
		{
			nativeRenderPassManager.ConfigureTarget(nativeRenderPassManager.CurrentCameraColorAttachment, 2);
		}
		else
		{
			nativeRenderPassManager.ConfigureTarget(nativeRenderPassManager.CurrentCameraColorAttachment);
		}
		nativeRenderPassManager.BeginSubPass(ref context);
	}

	public override void Execute(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		CommandBuffer cmd = renderingData.cmd;
		using (new ProfilingScope(cmd, profilingSampler))
		{
			if (m_IsUICamera)
			{
				cmd.SetGlobalFloat(ShaderPropertyId.isInUICamera, 1f);
			}
			ref FilteringSettings filteringSettings = ref m_FilteringSettings;
			SortingCriteria sortingCriteria = SortingCriteria.CommonTransparent;
			DrawingSettings drawingSettings = CreateDrawingSettings(m_PreZShaderTagIds, ref renderingData, sortingCriteria);
			DrawingSettings drawingSettings2 = CreateDrawingSettings(m_ColorShaderTagIds, ref renderingData, sortingCriteria);
			if (renderingData.postProcessingData.requiresMotionVectorOutput)
			{
				drawingSettings2.perObjectData |= PerObjectData.MotionVectors;
			}
			context.ExecuteCommandBuffer(cmd);
			cmd.Clear();
			context.DrawRenderers(renderingData.cullResults, ref drawingSettings, ref filteringSettings, ref m_RenderStateBlock);
			int num = m_SpecialCharacterLayerMask & filteringSettings.layerMask;
			if (num == 0)
			{
				context.DrawRenderers(renderingData.cullResults, ref drawingSettings2, ref filteringSettings, ref m_RenderStateBlock);
			}
			else
			{
				FilteringSettings filteringSettings2 = filteringSettings;
				filteringSettings2.layerMask &= ~num;
				if (filteringSettings2.layerMask != 0)
				{
					context.DrawRenderers(renderingData.cullResults, ref drawingSettings2, ref filteringSettings2, ref m_RenderStateBlock);
				}
				FilteringSettings filteringSettings3 = filteringSettings;
				filteringSettings3.layerMask = num;
				DrawingSettings drawingSettings3 = CreateDrawingSettings(m_SpecialColorShaderTagIds, ref renderingData, sortingCriteria);
				drawingSettings3.perObjectData = drawingSettings2.perObjectData;
				context.DrawRenderers(renderingData.cullResults, ref drawingSettings3, ref filteringSettings3, ref m_RenderStateBlock);
			}
			if (m_IsUICamera)
			{
				cmd.SetGlobalFloat(ShaderPropertyId.isInUICamera, 0f);
			}
		}
	}
}
