using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public class CustomOpaqueRenderPassFeature : ScriptableRendererFeature
{
	[Serializable]
	public class Settings
	{
		public RenderPassEvent renderPassEvent;

		public Settings()
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			renderPassEvent = (RenderPassEvent)450;
			base._002Ector();
		}
	}

	private class DesaturateStencilRenderPass : ScriptableRenderPass
	{
		private static readonly string RenderTag = "CustomOpaque";

		private RenderTargetIdentifier _currentTarget;

		public DesaturateStencilRenderPass(RenderPassEvent evt)
		{
			//IL_0007: Unknown result type (might be due to invalid IL or missing references)
			((ScriptableRenderPass)this)._002Ector();
			((ScriptableRenderPass)this).renderPassEvent = evt;
		}

		public void Setup(in RenderTargetIdentifier currentTarget)
		{
			_currentTarget = currentTarget;
		}

		public override void OnCameraSetup(CommandBuffer cmd, ref RenderingData renderingData)
		{
		}

		public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
		{
			CommandBuffer commandBuffer = CommandBufferPool.Get(RenderTag);
			Render(commandBuffer, ref renderingData);
			context.ExecuteCommandBuffer(commandBuffer);
			CommandBufferPool.Release(commandBuffer);
		}

		private void Render(CommandBuffer cmd, ref RenderingData renderingData)
		{
			ref CameraData cameraData = ref renderingData.cameraData;
			RenderTargetIdentifier currentTarget = _currentTarget;
			int num = Shader.PropertyToID("CustomOpaqueTexture");
			RenderTextureDescriptor cameraTargetDescriptor = cameraData.cameraTargetDescriptor;
			cameraTargetDescriptor.width >>= 1;
			cameraTargetDescriptor.height >>= 1;
			cmd.GetTemporaryRT(num, cameraTargetDescriptor);
			cmd.Blit(currentTarget, num);
			cmd.SetGlobalTexture("_CameraOpaqueTexture", num);
			cmd.ReleaseTemporaryRT(num);
			cmd.SetRenderTarget(cameraData.renderer.cameraColorTarget, RenderBufferLoadAction.Load, RenderBufferStoreAction.Store, cameraData.renderer.cameraDepthTarget, RenderBufferLoadAction.DontCare, RenderBufferStoreAction.DontCare);
		}

		public override void OnCameraCleanup(CommandBuffer cmd)
		{
		}
	}

	public Settings settings = new Settings();

	private DesaturateStencilRenderPass m_ScriptablePass;

	public override void Create()
	{
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		m_ScriptablePass = new DesaturateStencilRenderPass(settings.renderPassEvent);
	}

	public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)
	{
		if (renderingData.cameraData.cameraType == CameraType.SceneView || renderingData.cameraData.camera.CompareTag("MainCamera"))
		{
			m_ScriptablePass.Setup(renderer.cameraColorTarget);
			renderer.EnqueuePass((ScriptableRenderPass)(object)m_ScriptablePass);
		}
	}
}
