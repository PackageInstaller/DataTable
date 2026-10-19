using System;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

namespace UnityEngine.Experimental.Rendering.Universal;

[ExcludeFromPreset]
[Tooltip("Render Objects simplifies the injection of additional render passes by exposing a selection of commonly used settings.")]
public class RenderObjects : ScriptableRendererFeature
{
	[Serializable]
	public class RenderObjectsSettings
	{
		public string passTag = "RenderObjectsFeature";

		public RenderPassEvent Event = RenderPassEvent.RenderObjectsAfterOpaquePass;

		public FilterSettings filterSettings = new FilterSettings();

		public CustomCameraSettings cameraSettings = new CustomCameraSettings();
	}

	[Serializable]
	public class FilterSettings
	{
		public RenderQueueType RenderQueueType;

		public LayerMask LayerMask;

		public uint RenderingLayerMask;

		public string[] PassNames;

		public FilterSettings()
		{
			RenderQueueType = RenderQueueType.Opaque;
			LayerMask = 0;
			RenderingLayerMask = 1u;
		}
	}

	[Serializable]
	public class CustomCameraSettings
	{
		public bool overrideCamera;

		public bool restoreCamera = true;

		public Vector4 offset;

		public float cameraFieldOfView = 60f;
	}

	public RenderObjectsSettings settings = new RenderObjectsSettings();

	private RenderObjectsPass renderObjectsPass;

	public override void Create()
	{
		FilterSettings filterSettings = settings.filterSettings;
		if (settings.Event < RenderPassEvent.RenderBlockBeforeRenderEnd)
		{
			settings.Event = RenderPassEvent.RenderBlockBeforeRenderEnd;
		}
		renderObjectsPass = new RenderObjectsPass(settings.passTag, settings.Event, filterSettings.PassNames, filterSettings.RenderQueueType, filterSettings.LayerMask, settings.cameraSettings, filterSettings.RenderingLayerMask);
	}

	public override void AddRenderPasses(ScriptableRenderer renderer, ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		renderer.EnqueuePass(renderObjectsPass);
	}
}
