using System;

namespace UnityEngine.Rendering.Universal;

public class LightHaloFeature : ScriptableRendererFeature
{
	[Serializable]
	public class Settings
	{
		[Tooltip("Runtime content switch. The Renderer Feature Active checkbox remains the authoring-level gate.")]
		public bool enabled = true;

		public float searchWidth = 0.001f;

		[Tooltip("x/y are min/max distance. The min distance uses halo.size as screen-space size.")]
		public Vector2 additionalLightHaloScaleRange = new Vector2(0f, 100f);

		[Tooltip("Exp decay k for additional light halo screen scale.")]
		public float additionalLightHaloDistanceDecay = 0.3f;

		[Tooltip("World distance before max range where additional light halo starts fading out.")]
		public float additionalLightHaloFadeDistance = 20f;

		public Settings Clone()
		{
			return (Settings)MemberwiseClone();
		}
	}

	private LightHaloPass m_LightHaloPass;

	public ComputeShader m_Shader;

	[SerializeField]
	public Settings settings = new Settings();

	[NonSerialized]
	private Settings m_RuntimeSettings;

	public Settings runtimeSettings
	{
		get
		{
			EnsureRuntimeSettings();
			return m_RuntimeSettings;
		}
	}

	private void EnsureRuntimeSettings()
	{
		if (m_RuntimeSettings == null)
		{
			m_RuntimeSettings = ((settings != null) ? settings.Clone() : new Settings());
		}
	}

	public override void AddRenderPasses(ScriptableRenderer renderer, ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		if (renderingData.cameraData.isBase)
		{
			Settings settings = runtimeSettings;
			if (settings.enabled && renderingData.lightData.preparedLights != null && renderingData.lightData.preparedLights.haloCandidateCount != 0 && m_LightHaloPass != null && m_LightHaloPass.Setup(settings))
			{
				renderer.EnqueuePass(m_LightHaloPass);
			}
		}
	}

	public override void Create()
	{
		EnsureRuntimeSettings();
		m_LightHaloPass?.Release();
		m_LightHaloPass = new LightHaloPass(m_Shader, runtimeSettings);
	}

	protected override void Dispose(bool disposing)
	{
		m_LightHaloPass?.Release();
		m_LightHaloPass = null;
	}
}
