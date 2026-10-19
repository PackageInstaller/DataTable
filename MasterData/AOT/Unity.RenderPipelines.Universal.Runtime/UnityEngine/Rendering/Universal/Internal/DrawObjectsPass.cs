using System.Collections.Generic;

namespace UnityEngine.Rendering.Universal.Internal;

public class DrawObjectsPass : ScriptableRenderPass
{
	private FilteringSettings m_FilteringSettings;

	private RenderStateBlock m_RenderStateBlock;

	private int m_SpecialCharacterLayerMask;

	private List<ShaderTagId> m_ShaderTagIdList = new List<ShaderTagId>();

	private List<ShaderTagId> m_SpecialShaderTagIdList = new List<ShaderTagId>();

	private bool m_IsOpaque;

	private bool m_IsUICamara;

	private bool m_UseDepthPriming;

	private readonly bool m_WriteMotionFeatureMrt;

	private readonly RenderTargetIdentifier[] m_ColorAttachments = new RenderTargetIdentifier[2];

	private DrawingSettings drawSettings;

	private bool m_HasHairShadowTagState;

	private bool m_TransparentOutlineEnabled = true;

	private bool m_HairShadowEnabled = true;

	internal override bool supportsNativePostDeferredPass => true;

	private void ReplaceShaderTagList(ShaderTagId[] shaderTagIds)
	{
		m_ShaderTagIdList.Clear();
		foreach (ShaderTagId item in shaderTagIds)
		{
			m_ShaderTagIdList.Add(item);
		}
	}

	private void ReplaceSpecialShaderTagList(ShaderTagId[] shaderTagIds)
	{
		m_SpecialShaderTagIdList.Clear();
		foreach (ShaderTagId item in shaderTagIds)
		{
			m_SpecialShaderTagIdList.Add(item);
		}
	}

	internal void SetTransparentOutlineEnabled(bool enabled)
	{
		if (m_TransparentOutlineEnabled != enabled)
		{
			ReplaceShaderTagList(enabled ? ShaderPassTags.ForwardShaderTags : ShaderPassTags.ForwardShaderTagsWithoutCharacterOutline);
			ReplaceSpecialShaderTagList(ShaderPassTags.ForwardShaderTags);
			m_TransparentOutlineEnabled = enabled;
		}
	}

	public void SetHairShadowEnabled(bool enabled)
	{
		if (!m_HasHairShadowTagState || m_HairShadowEnabled != enabled)
		{
			ReplaceShaderTagList(enabled ? ShaderPassTags.DeferredForwardOnlyShaderTags : ShaderPassTags.DeferredForwardOnlyShaderTagsWithoutHairShadow);
			ReplaceSpecialShaderTagList(ShaderPassTags.DeferredForwardOnlyShaderTags);
			m_HairShadowEnabled = enabled;
			m_HasHairShadowTagState = true;
		}
	}

	internal void SetSpecialCharacterLayerMask(LayerMask layerMask)
	{
		m_SpecialCharacterLayerMask = layerMask;
	}

	public DrawObjectsPass(string profilerTag, ShaderTagId[] shaderTagIds, bool opaque, RenderPassEvent evt, RenderQueueRange renderQueueRange, LayerMask layerMask, RenderBufferStoreAction depthStoreAction, bool writeMotionFeatureMrt = false, LayerMask specialCharacterLayerMask = default(LayerMask))
	{
		profilingSampler = new ProfilingSampler(profilerTag);
		foreach (ShaderTagId item in shaderTagIds)
		{
			m_ShaderTagIdList.Add(item);
			m_SpecialShaderTagIdList.Add(item);
		}
		renderPassEvent = evt;
		m_FilteringSettings = new FilteringSettings(renderQueueRange, layerMask);
		m_RenderStateBlock = new RenderStateBlock(RenderStateMask.Nothing);
		m_SpecialCharacterLayerMask = specialCharacterLayerMask;
		m_IsOpaque = opaque;
		m_WriteMotionFeatureMrt = writeMotionFeatureMrt;
		ConfigureDepthAttachment(RenderBufferLoadAction.Load, depthStoreAction);
	}

	public DrawObjectsPass(string profilerTag, bool opaque, RenderPassEvent evt, RenderQueueRange renderQueueRange, LayerMask layerMask, RenderBufferStoreAction depthStoreAction, LayerMask specialCharacterLayerMask = default(LayerMask))
		: this(profilerTag, ShaderPassTags.ForwardShaderTags, opaque, evt, renderQueueRange, layerMask, depthStoreAction, writeMotionFeatureMrt: false, specialCharacterLayerMask)
	{
	}

	private bool WritesMotionFeatureMrt(ref RenderingData renderingData)
	{
		if (!m_WriteMotionFeatureMrt || !renderingData.postProcessingData.motionFeature)
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
		if (m_WriteMotionFeatureMrt)
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
	}

	public void Setup(bool gamma)
	{
		m_IsUICamara = gamma;
	}

	public override void BeginSubPass(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		NativeRenderPassManager nativeRenderPassManager = renderingData.nativeRenderPassManager;
		if (WritesMotionFeatureMrt(ref renderingData))
		{
			nativeRenderPassManager.ConfigureTarget(nativeRenderPassManager.CurrentCameraColorAttachment, nativeRenderPassManager.CurrentMotionFeatureAttachment);
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
			if (m_IsUICamara)
			{
				cmd.SetGlobalFloat(ShaderPropertyId.isInUICamera, 1f);
			}
			ref FilteringSettings filteringSettings = ref m_FilteringSettings;
			SortingCriteria sortingCriteria = (m_IsOpaque ? renderingData.cameraData.defaultOpaqueSortFlags : SortingCriteria.CommonTransparent);
			drawSettings = CreateDrawingSettings(m_ShaderTagIdList, ref renderingData, sortingCriteria);
			if (WritesMotionFeatureMrt(ref renderingData))
			{
				drawSettings.perObjectData |= PerObjectData.MotionVectors;
			}
			context.ExecuteCommandBuffer(cmd);
			cmd.Clear();
			int num = m_SpecialCharacterLayerMask & filteringSettings.layerMask;
			if (num == 0)
			{
				context.DrawRenderers(renderingData.cullResults, ref drawSettings, ref filteringSettings, ref m_RenderStateBlock);
			}
			else
			{
				FilteringSettings filteringSettings2 = filteringSettings;
				filteringSettings2.layerMask &= ~num;
				if (filteringSettings2.layerMask != 0)
				{
					context.DrawRenderers(renderingData.cullResults, ref drawSettings, ref filteringSettings2, ref m_RenderStateBlock);
				}
				FilteringSettings filteringSettings3 = filteringSettings;
				filteringSettings3.layerMask = num;
				DrawingSettings drawingSettings = CreateDrawingSettings(m_SpecialShaderTagIdList, ref renderingData, sortingCriteria);
				drawingSettings.perObjectData = drawSettings.perObjectData;
				context.DrawRenderers(renderingData.cullResults, ref drawingSettings, ref filteringSettings3, ref m_RenderStateBlock);
			}
			if (m_IsUICamara)
			{
				cmd.SetGlobalFloat(ShaderPropertyId.isInUICamera, 0f);
			}
		}
	}
}
