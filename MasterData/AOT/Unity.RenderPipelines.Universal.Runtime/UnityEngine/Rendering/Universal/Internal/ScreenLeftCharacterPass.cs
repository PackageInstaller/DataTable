using System.Collections.Generic;

namespace UnityEngine.Rendering.Universal.Internal;

internal sealed class ScreenLeftCharacterPass : ScriptableRenderPass
{
	private readonly List<ShaderTagId> m_ShaderTagIds = new List<ShaderTagId>(4)
	{
		ShaderPassTags.CharacterGBuffer,
		ShaderPassTags.GBufferHair,
		ShaderPassTags.GBufferHairOverEye,
		ShaderPassTags.CharacterGBufferOutline
	};

	private FilteringSettings m_FilteringSettings;

	private RenderStateBlock m_ShaderDepthStateBlock;

	private RenderStateBlock m_FallbackDepthStateBlock;

	private readonly RenderTargetIdentifier[] m_ColorAttachments = new RenderTargetIdentifier[2];

	private bool m_PreZPrimed;

	internal override bool supportsNativePostDeferredPass => true;

	internal ScreenLeftCharacterPass(string profilerTag, RenderPassEvent evt)
	{
		profilingSampler = new ProfilingSampler(profilerTag);
		renderPassEvent = evt;
		m_FilteringSettings = new FilteringSettings(RenderQueueRange.all, 33554432);
		m_ShaderDepthStateBlock = new RenderStateBlock(RenderStateMask.Nothing);
		m_FallbackDepthStateBlock = new RenderStateBlock(RenderStateMask.Depth)
		{
			depthState = new DepthState(writeEnabled: true, CompareFunction.LessEqual)
		};
		ConfigureDepthAttachment();
	}

	internal void SetPreZPrimed(bool primed)
	{
		m_PreZPrimed = primed;
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
			ScreenLeftCharacterFov.OverrideState state = ScreenLeftCharacterFov.Apply(ref renderingData, cmd);
			context.ExecuteCommandBuffer(cmd);
			cmd.Clear();
			DrawingSettings drawingSettings = CreateDrawingSettings(m_ShaderTagIds, ref renderingData, SortingCriteria.CommonTransparent);
			if (renderingData.postProcessingData.requiresMotionVectorOutput)
			{
				drawingSettings.perObjectData |= PerObjectData.MotionVectors;
			}
			RenderStateBlock stateBlock = (m_PreZPrimed ? m_ShaderDepthStateBlock : m_FallbackDepthStateBlock);
			context.DrawRenderers(renderingData.cullResults, ref drawingSettings, ref m_FilteringSettings, ref stateBlock);
			ScreenLeftCharacterFov.Restore(cmd, state, recordFrame: true);
		}
	}
}
