using System;
using UnityEngine;
using UnityEngine.Rendering.Universal;

public class RoomStencilRenderFeature : ScriptableRendererFeature
{
	[Serializable]
	public class Settings
	{
		public RenderPassEvent renderPassEvent;

		public Shader shader;

		public bool cameraStackMode;

		public Settings()
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			renderPassEvent = (RenderPassEvent)550;
			base._002Ector();
		}
	}

	public Settings settings = new Settings();

	private RoomStencilPass _roomStencilPass;

	public override void Create()
	{
		//IL_0012: Unknown result type (might be due to invalid IL or missing references)
		((UnityEngine.Object)this).name = "RoomStencil";
		_roomStencilPass = new RoomStencilPass(settings.renderPassEvent, settings.shader, settings.cameraStackMode);
	}

	public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)
	{
		if (renderingData.cameraData.cameraType == CameraType.SceneView || renderingData.cameraData.camera.CompareTag("MainCamera"))
		{
			_roomStencilPass.Setup(renderer.cameraColorTarget);
			renderer.EnqueuePass((ScriptableRenderPass)(object)_roomStencilPass);
		}
	}
}
