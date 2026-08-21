#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using GameFramework;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public class PostprocessFogRenderPassFeature : ScriptableRendererFeature
{
	[Serializable]
	public class Settings
	{
		public RenderPassEvent renderPassEvent;

		public Material materia;

		public MaterialPropertyBlock materialPropertyBlock;

		public bool EnableInEditMode;

		public Settings()
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			renderPassEvent = (RenderPassEvent)450;
			base._002Ector();
		}
	}

	private class PostprocessFogRenderPass : ScriptableRenderPass
	{
		private static readonly string RenderTag = "PostprocessFog";

		private PostprecessFogVolume _postProcessVolume;

		private MaterialPropertyBlock _materialPropertyBlock;

		private Material _postProcessMat;

		private RenderTargetIdentifier _currentTarget;

		private bool _desaturateOpaque;

		public PostprocessFogRenderPass(RenderPassEvent evt, Material postProcessMaterial, Settings settings)
		{
			//IL_0007: Unknown result type (might be due to invalid IL or missing references)
			((ScriptableRenderPass)this)._002Ector();
			((ScriptableRenderPass)this).renderPassEvent = evt;
			if (postProcessMaterial == null)
			{
				Log.Error("没有指定后处理雾材质");
				return;
			}
			settings.materialPropertyBlock = new MaterialPropertyBlock();
			_postProcessMat = postProcessMaterial;
			_materialPropertyBlock = settings.materialPropertyBlock;
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
			_postProcessVolume = stack.GetComponent<PostprecessFogVolume>();
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
			Camera camera = renderingData.cameraData.camera;
			Matrix4x4 cameraToWorldMatrix = camera.cameraToWorldMatrix;
			Vector4 value = new Vector4(cameraToWorldMatrix.m03, cameraToWorldMatrix.m13, cameraToWorldMatrix.m23, cameraToWorldMatrix.m33);
			_postProcessMat.SetVector("_CameraPositionWS", value);
			cmd.SetViewProjectionMatrices(Matrix4x4.identity, Matrix4x4.identity);
			cmd.DrawMesh(RenderingUtils.fullscreenMesh, Matrix4x4.identity, _postProcessMat, 0, 0, _materialPropertyBlock);
			cmd.SetViewProjectionMatrices(camera.worldToCameraMatrix, camera.projectionMatrix);
		}

		public override void OnCameraCleanup(CommandBuffer cmd)
		{
		}
	}

	public Settings settings = new Settings();

	private PostprocessFogRenderPass m_ScriptablePass;

	public override void Create()
	{
		//IL_0012: Unknown result type (might be due to invalid IL or missing references)
		((UnityEngine.Object)this).name = "PostprocessFog";
		m_ScriptablePass = new PostprocessFogRenderPass(settings.renderPassEvent, settings.materia, settings);
	}

	public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)
	{
		if ((renderingData.cameraData.cameraType == CameraType.SceneView || renderingData.cameraData.camera.CompareTag("MainCamera")) && (renderingData.cameraData.cameraType != CameraType.SceneView || settings.EnableInEditMode))
		{
			m_ScriptablePass.Setup(renderer.cameraColorTarget);
			renderer.EnqueuePass((ScriptableRenderPass)(object)m_ScriptablePass);
		}
	}
}
