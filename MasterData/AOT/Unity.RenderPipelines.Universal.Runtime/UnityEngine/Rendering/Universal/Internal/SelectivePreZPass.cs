using System;

namespace UnityEngine.Rendering.Universal.Internal;

internal sealed class SelectivePreZPass : ScriptableRenderPass, IDisposable
{
	private FilteringSettings m_FilteringSettings;

	private readonly PassStencilStateOverride m_NormalHairStencilOverride;

	private int m_SpecialCharacterLayerMask;

	private bool m_AdvancedFaceHairEnabled = true;

	private static RenderStateBlock CreateNormalHairStencilOverride()
	{
		StencilState stencilState = new StencilState(enabled: true, 19, 19, CompareFunction.Always, StencilOp.Replace);
		RenderStateBlock result = new RenderStateBlock(RenderStateMask.Stencil);
		result.stencilReference = 35;
		result.stencilState = stencilState;
		return result;
	}

	internal void SetAdvancedFaceHairEnabled(bool enabled)
	{
		m_AdvancedFaceHairEnabled = enabled;
	}

	internal void SetSpecialCharacterLayerMask(LayerMask layerMask)
	{
		m_SpecialCharacterLayerMask = layerMask;
	}

	internal SelectivePreZPass(RenderPassEvent evt, RenderQueueRange renderQueueRange, LayerMask layerMask, LayerMask specialCharacterLayerMask)
	{
		profilingSampler = new ProfilingSampler("SelectivePreZPass");
		renderPassEvent = evt;
		m_FilteringSettings = new FilteringSettings(renderQueueRange, layerMask);
		m_SpecialCharacterLayerMask = specialCharacterLayerMask;
		m_NormalHairStencilOverride = new PassStencilStateOverride(ShaderPassTags.CharacterHairDepthOnly, CreateNormalHairStencilOverride(), new RenderStateBlock(RenderStateMask.Nothing));
		ConfigureDepthAttachment();
	}

	public override void OnCameraSetup(CommandBuffer cmd, ref RenderingData renderingData)
	{
		ConfigureTarget(renderingData.cameraData.renderer.cameraDepthTarget, UniversalRenderer.cameraDepthStencilFormat, depth: true);
	}

	public override void BeginSubPass(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		NativeRenderPassManager nativeRenderPassManager = renderingData.nativeRenderPassManager;
		nativeRenderPassManager.ConfigureTarget(nativeRenderPassManager.CurrentCameraColorAttachment);
		nativeRenderPassManager.BeginSubPass(ref context);
	}

	public override void Execute(ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		CommandBuffer cmd = renderingData.cmd;
		using (new ProfilingScope(cmd, profilingSampler))
		{
			context.ExecuteCommandBuffer(cmd);
			cmd.Clear();
			SortingCriteria defaultOpaqueSortFlags = renderingData.cameraData.defaultOpaqueSortFlags;
			DrawingSettings drawingSettings = CreateDrawingSettings(ShaderPassTags.DepthOnly, ref renderingData, defaultOpaqueSortFlags);
			drawingSettings.SetShaderPassName(1, ShaderPassTags.CharacterHairDepthOnly);
			drawingSettings.perObjectData = (renderingData.postProcessingData.requiresMotionVectorOutput ? PerObjectData.MotionVectors : PerObjectData.None);
			if (m_AdvancedFaceHairEnabled)
			{
				context.DrawRenderers(renderingData.cullResults, ref drawingSettings, ref m_FilteringSettings);
			}
			else
			{
				int num = m_SpecialCharacterLayerMask & m_FilteringSettings.layerMask;
				if (num == 0)
				{
					m_NormalHairStencilOverride.DrawRenderers(ref context, renderingData.cullResults, ref drawingSettings, ref m_FilteringSettings);
				}
				else
				{
					FilteringSettings filteringSettings = m_FilteringSettings;
					filteringSettings.layerMask &= ~num;
					if (filteringSettings.layerMask != 0)
					{
						m_NormalHairStencilOverride.DrawRenderers(ref context, renderingData.cullResults, ref drawingSettings, ref filteringSettings);
					}
					FilteringSettings filteringSettings2 = m_FilteringSettings;
					filteringSettings2.layerMask = num;
					context.DrawRenderers(renderingData.cullResults, ref drawingSettings, ref filteringSettings2);
				}
			}
			DrawScreenLeftCharacterPreZ(ref context, ref renderingData, ref drawingSettings);
		}
	}

	private void DrawScreenLeftCharacterPreZ(ref ScriptableRenderContext context, ref RenderingData renderingData, ref DrawingSettings depthSettings)
	{
		FilteringSettings filteringSettings = m_FilteringSettings;
		filteringSettings.layerMask = 33554432;
		filteringSettings.renderQueueRange = RenderQueueRange.all;
		CommandBuffer cmd = renderingData.cmd;
		ScreenLeftCharacterFov.OverrideState state = ScreenLeftCharacterFov.Apply(ref renderingData, cmd);
		if (state.applied)
		{
			context.ExecuteCommandBuffer(cmd);
			cmd.Clear();
		}
		context.DrawRenderers(renderingData.cullResults, ref depthSettings, ref filteringSettings);
		ScreenLeftCharacterFov.Restore(cmd, state, recordFrame: false);
	}

	public void Dispose()
	{
		m_NormalHairStencilOverride.Dispose();
	}
}
