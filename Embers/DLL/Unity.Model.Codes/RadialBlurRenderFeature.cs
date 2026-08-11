using System;
using UnityEngine;
using UnityEngine.Rendering.Universal;

public class RadialBlurRenderFeature : ScriptableRendererFeature
{
	[Serializable]
	public class Settings
	{
		public RenderPassEvent renderPassEvent;

		public Shader shader;

		public Settings()
		{
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			renderPassEvent = (RenderPassEvent)550;
			base._002Ector();
		}
	}

	public Settings settings = new Settings();

	private RadialBlurPass radialBlurPass;

	public override void Create()
	{
		((UnityEngine.Object)this).name = "RadialBlur";
		radialBlurPass = new RadialBlurPass((RenderPassEvent)550, settings.shader);
	}

	public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)
	{
		renderer.EnqueuePass((ScriptableRenderPass)(object)radialBlurPass);
	}
}
