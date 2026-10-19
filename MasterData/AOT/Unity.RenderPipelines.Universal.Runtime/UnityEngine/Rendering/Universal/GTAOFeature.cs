using System;

namespace UnityEngine.Rendering.Universal;

public class GTAOFeature : ScriptableRendererFeature
{
	public enum Quality
	{
		Custom,
		Low,
		Medium,
		High,
		Ultra
	}

	[Serializable]
	public class Settings
	{
		public bool enableGTAO = true;

		public RenderPassEvent renderPassEvent = RenderPassEvent.GTAOPass;

		public Quality quality = Quality.High;

		[Range(1f, 6f)]
		public int downSample = 1;

		[Range(4f, 32f)]
		public int sampleCount = 12;

		[Range(1f, 128f)]
		public int sampleStepWidth = 48;

		[Range(1f, 8f)]
		public int sliceCount = 4;

		[Range(0.1f, 2f)]
		public float aoAngle = 1f;

		[Range(0f, 4f)]
		public float aoIntensity = 1f;

		[Range(0f, 1f)]
		public float roIntensity = 1f;

		[Range(0f, 0.3f)]
		public float thickness = 0.06f;

		[Range(0.25f, 4f)]
		public float falloff = 1.5f;

		[Range(0.25f, 4f)]
		public float power = 1f;

		[Range(0.5f, 4f)]
		public float denoiseSharpness = 1.25f;

		[Range(1f, 4f)]
		public int denoiseRadius = 2;

		public Settings Clone()
		{
			return (Settings)MemberwiseClone();
		}
	}

	[SerializeField]
	public Settings settings = new Settings();

	[NonSerialized]
	private Material m_Material;

	private GTAOPass m_Pass;

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

	public override void Create()
	{
		if (IsSupportedPlatform())
		{
			EnsureRuntimeSettings();
			if (m_Pass == null)
			{
				m_Pass = new GTAOPass();
			}
		}
	}

	public override void AddRenderPasses(ScriptableRenderer renderer, ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
		if (!IsSupportedPlatform() || !isActive || !renderingData.cameraData.isGameCamera || RenderPassScheduleModeUtility.IsMobile(renderer as UniversalRenderer))
		{
			return;
		}
		if (m_Pass == null)
		{
			Create();
		}
		if (runtimeSettings.enableGTAO)
		{
			Shader gTAOShader = GetGTAOShader(renderer);
			if (EnsureMaterial(gTAOShader) && m_Pass != null && m_Pass.Setup(runtimeSettings, m_Material))
			{
				renderer.EnqueuePass(m_Pass);
			}
		}
	}

	protected override void Dispose(bool disposing)
	{
		CoreUtils.Destroy(m_Material);
		m_Material = null;
		m_Pass = null;
	}

	private bool EnsureMaterial(Shader shader)
	{
		if (shader == null)
		{
			return false;
		}
		if (m_Material != null && m_Material.shader == shader)
		{
			return true;
		}
		CoreUtils.Destroy(m_Material);
		m_Material = CoreUtils.CreateEngineMaterial(shader);
		return m_Material != null;
	}

	private static Shader GetGTAOShader(ScriptableRenderer renderer)
	{
		return (renderer?.rendererData as UniversalRendererData)?.shaders?.GTAOPS;
	}

	private static bool IsSupportedPlatform()
	{
		return false;
	}
}
