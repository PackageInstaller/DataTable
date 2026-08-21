#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using GameFramework;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public class DesaturateStencilRenderPassFeature : ScriptableRendererFeature
{
	[Serializable]
	public class Settings
	{
		public RenderPassEvent renderPassEvent;

		public Shader shader;

		public Settings()
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			renderPassEvent = (RenderPassEvent)450;
			base._002Ector();
		}
	}

	private class DesaturateStencilRenderPass : ScriptableRenderPass
	{
		private static readonly string RenderTag = "DesaturateStencil";

		private static readonly int BlurBufferID = Shader.PropertyToID("_BlurBuffer");

		private DesaturateStencilVolume _postProcessVolume;

		private Material _postProcessMat;

		private RenderTargetIdentifier _currentTarget;

		private bool _desaturateOpaque;

		public DesaturateStencilRenderPass(RenderPassEvent evt, Shader postProcessShader, Settings settings)
		{
			//IL_0007: Unknown result type (might be due to invalid IL or missing references)
			//IL_002e: Unknown result type (might be due to invalid IL or missing references)
			//IL_0034: Invalid comparison between Unknown and I4
			((ScriptableRenderPass)this)._002Ector();
			((ScriptableRenderPass)this).renderPassEvent = evt;
			if (postProcessShader == null)
			{
				Log.Error("没有指定Shader");
				return;
			}
			_postProcessMat = CoreUtils.CreateEngineMaterial(postProcessShader);
			_desaturateOpaque = (int)evt == 450;
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
			if (_postProcessMat == null)
			{
				Log.Error("材质初始化失败");
				return;
			}
			VolumeStack stack = VolumeManager.instance.stack;
			_postProcessVolume = stack.GetComponent<DesaturateStencilVolume>();
			if (_postProcessVolume == null)
			{
				Log.Error("Volume组件获取失败");
			}
			else if (_postProcessVolume.IsActive())
			{
				CommandBuffer commandBuffer = CommandBufferPool.Get(RenderTag);
				Render(commandBuffer, ref renderingData);
				context.ExecuteCommandBuffer(commandBuffer);
				CommandBufferPool.Release(commandBuffer);
			}
		}

		private void Render(CommandBuffer cmd, ref RenderingData renderingData)
		{
			_postProcessMat.SetInt("_RefValue", _postProcessVolume.stencilRefValue.value);
			_postProcessMat.SetFloat("_Desaturate", _postProcessVolume.desaturate.value);
			_postProcessMat.SetInt("_StencilComp", (int)_postProcessVolume.stencilCompare.value);
			ref CameraData cameraData = ref renderingData.cameraData;
			Camera camera = cameraData.camera;
			RenderTargetIdentifier currentTarget = _currentTarget;
			if (!_desaturateOpaque)
			{
				int num = Shader.PropertyToID("tmpSceneColor_desaturate");
				RenderTextureDescriptor cameraTargetDescriptor = cameraData.cameraTargetDescriptor;
				cmd.GetTemporaryRT(num, cameraTargetDescriptor);
				cmd.Blit(currentTarget, num);
				cmd.SetGlobalTexture("_CameraOpaqueTexture", num);
				cmd.SetViewProjectionMatrices(Matrix4x4.identity, Matrix4x4.identity);
				cmd.DrawMesh(RenderingUtils.fullscreenMesh, Matrix4x4.identity, _postProcessMat, 0, 0);
				cmd.SetViewProjectionMatrices(camera.worldToCameraMatrix, camera.projectionMatrix);
				cmd.ReleaseTemporaryRT(num);
			}
			else
			{
				cmd.SetViewProjectionMatrices(Matrix4x4.identity, Matrix4x4.identity);
				cmd.DrawMesh(RenderingUtils.fullscreenMesh, Matrix4x4.identity, _postProcessMat, 0, 1);
				cmd.SetViewProjectionMatrices(camera.worldToCameraMatrix, camera.projectionMatrix);
			}
		}

		public override void OnCameraCleanup(CommandBuffer cmd)
		{
		}
	}

	public Settings settings = new Settings();

	private DesaturateStencilRenderPass m_ScriptablePass;

	public override void Create()
	{
		//IL_0012: Unknown result type (might be due to invalid IL or missing references)
		((UnityEngine.Object)this).name = "DesaturateStencil";
		m_ScriptablePass = new DesaturateStencilRenderPass(settings.renderPassEvent, settings.shader, settings);
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
