using System;

namespace UnityEngine.Rendering.Universal;

public class FSR3Feature : ScriptableRendererFeature
{
	public enum Quality
	{
		Performance,
		Balanced,
		Quality,
		NativeAA
	}

	[Serializable]
	public class Settings
	{
		public bool enabled;

		public Quality quality = Quality.Balanced;

		[Range(0.01f, 1f)]
		public float historyResetDeltaTime = 0.1f;

		public bool debugLog;

		public Settings Clone()
		{
			return (Settings)MemberwiseClone();
		}
	}

	[SerializeField]
	public Settings settings = new Settings();

	[NonSerialized]
	private Settings m_RuntimeSettings;

	[NonSerialized]
	private bool m_AppliedEnabled;

	[NonSerialized]
	private Quality m_AppliedQuality;

	[NonSerialized]
	private bool m_HasAppliedRuntimeSettings;

	private static float s_ActiveRenderScaleMultiplier = 1f;

	public Settings runtimeSettings
	{
		get
		{
			EnsureRuntimeSettings();
			return m_RuntimeSettings;
		}
	}

	public static float ActiveRenderScaleMultiplier => s_ActiveRenderScaleMultiplier;

	private void EnsureRuntimeSettings()
	{
		if (m_RuntimeSettings == null)
		{
			m_RuntimeSettings = ((settings != null) ? settings.Clone() : new Settings());
		}
	}

	public override void ApplyRuntimeSettings()
	{
		Settings settings = runtimeSettings;
		bool num = !m_HasAppliedRuntimeSettings || m_AppliedEnabled != settings.enabled;
		bool flag = !m_HasAppliedRuntimeSettings || m_AppliedQuality != settings.quality;
		if ((num && settings.enabled) | flag)
		{
			TemporalUpscalerRenderScale.ResetRuntimeFailure(TemporalUpscaler.FSR3);
		}
		m_AppliedEnabled = settings.enabled;
		m_AppliedQuality = settings.quality;
		m_HasAppliedRuntimeSettings = true;
		UpdateActiveRenderScaleMultiplier(this);
	}

	public static bool IsSupported()
	{
		return false;
	}

	public override void Create()
	{
		EnsureRuntimeSettings();
		UpdateActiveRenderScaleMultiplier(null);
	}

	public static void UpdateActiveRenderScaleMultiplier(FSR3Feature feature)
	{
		s_ActiveRenderScaleMultiplier = 1f;
		TemporalUpscalerRenderScale.Set(TemporalUpscaler.FSR3, enabled: false, s_ActiveRenderScaleMultiplier);
	}

	public static float GetRenderScaleMultiplier(Quality quality)
	{
		return quality switch
		{
			Quality.Performance => 0.5f, 
			Quality.Balanced => 0.58823526f, 
			Quality.Quality => 2f / 3f, 
			Quality.NativeAA => 1f, 
			_ => 1f, 
		};
	}

	public override void AddRenderPasses(ScriptableRenderer renderer, ref ScriptableRenderContext context, ref RenderingData renderingData)
	{
	}

	internal override void ReconcilePersistentRenderResources(CommandBuffer cmd, ref RenderingData renderingData)
	{
	}

	internal override void OnActiveStateChanged()
	{
		UpdateActiveRenderScaleMultiplier(this);
	}

	protected override void Dispose(bool disposing)
	{
		if (disposing)
		{
			TemporalUpscalerRenderScale.Set(TemporalUpscaler.FSR3, enabled: false, 1f);
		}
	}
}
