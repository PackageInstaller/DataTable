using System;

namespace UnityEngine.Rendering.Universal;

public class CapsuleAOFeature : ScriptableRendererFeature
{
	[Serializable]
	public class Settings
	{
		public bool enableCapsuleAO = true;

		[Min(0.001f)]
		public float LightAngle = 10f;

		[Min(0.001f)]
		public float AOIntensity = 1f;

		[Min(0.001f)]
		public float DirOcclusionIntensity = 1.5f;

		[Min(1f)]
		public int DownSample = 4;

		public Settings Clone()
		{
			return (Settings)MemberwiseClone();
		}
	}

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

	public override void Create()
	{
	}

	public override void AddRenderPasses(ScriptableRenderer renderer, ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
	}
}
