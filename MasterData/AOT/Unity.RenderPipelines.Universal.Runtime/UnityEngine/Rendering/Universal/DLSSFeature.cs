using System;

namespace UnityEngine.Rendering.Universal;

public class DLSSFeature : ScriptableRendererFeature
{
	public enum DLSSQuality
	{
		Performance,
		Balanced,
		Quality,
		DLAA
	}

	[Serializable]
	public class Settings
	{
		[Header("Base")]
		public bool enabled = true;

		[Header("Quality")]
		public DLSSQuality quality = DLSSQuality.DLAA;

		[Header("History")]
		[Range(0.01f, 1f)]
		public float historyResetDeltaTime = 0.1f;

		[Header("Behavior")]
		public bool debugLog;

		public Settings Clone()
		{
			return (Settings)MemberwiseClone();
		}
	}

	private const float PerformanceRenderScaleMultiplier = 0.5f;

	private const float BalancedRenderScaleMultiplier = 0.58f;

	private const float QualityRenderScaleMultiplier = 2f / 3f;

	private const float DLAARenderScaleMultiplier = 1f;

	[SerializeField]
	public Settings settings = new Settings();

	[NonSerialized]
	private Settings m_RuntimeSettings;

	[NonSerialized]
	private bool m_AppliedEnabled;

	[NonSerialized]
	private DLSSQuality m_AppliedQuality;

	[NonSerialized]
	private bool m_HasAppliedRuntimeSettings;

	internal static float activeRenderScaleMultiplier { get; private set; } = 1f;

	public static float ActiveRenderScaleMultiplier => activeRenderScaleMultiplier;

	public Settings runtimeSettings
	{
		get
		{
			EnsureRuntimeSettings();
			return m_RuntimeSettings;
		}
	}

	internal DLSSQuality Quality => runtimeSettings.quality;

	internal bool IsDLSSEnabled
	{
		get
		{
			if (isActive)
			{
				return runtimeSettings.enabled;
			}
			return false;
		}
	}

	internal bool CanUseRenderScaleMultiplier => IsDLSSEnabled;

	internal float RenderScaleMultiplier => GetRenderScaleMultiplier(runtimeSettings.quality);

	internal bool IsDLAAEnabled
	{
		get
		{
			if (isActive && runtimeSettings.enabled)
			{
				return IsDLAA(runtimeSettings.quality);
			}
			return false;
		}
	}

	internal static int ToNativeQuality(DLSSQuality quality)
	{
		return quality switch
		{
			DLSSQuality.Performance => 0, 
			DLSSQuality.Balanced => 1, 
			DLSSQuality.Quality => 2, 
			DLSSQuality.DLAA => 5, 
			_ => 2, 
		};
	}

	internal static bool IsDLAA(DLSSQuality quality)
	{
		return quality == DLSSQuality.DLAA;
	}

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
		if (num && settings.enabled)
		{
			TemporalUpscalerRenderScale.ResetRuntimeFailure(TemporalUpscaler.DLSS);
			DLSSRuntime.ResetAvailability();
		}
		if (flag)
		{
			DLSSRuntime.ResetAvailability();
		}
		m_AppliedEnabled = settings.enabled;
		m_AppliedQuality = settings.quality;
		m_HasAppliedRuntimeSettings = true;
		UpdateActiveRenderScaleMultiplier(this);
	}

	public static void UpdateActiveRenderScaleMultiplier(DLSSFeature feature)
	{
		activeRenderScaleMultiplier = 1f;
		TemporalUpscalerRenderScale.Set(TemporalUpscaler.DLSS, enabled: false, 1f);
	}

	public static float GetRenderScaleMultiplier(DLSSQuality quality)
	{
		return quality switch
		{
			DLSSQuality.Performance => 0.5f, 
			DLSSQuality.Balanced => 0.58f, 
			DLSSQuality.Quality => 2f / 3f, 
			DLSSQuality.DLAA => 1f, 
			_ => 2f / 3f, 
		};
	}

	public override void Create()
	{
		EnsureRuntimeSettings();
		UpdateActiveRenderScaleMultiplier(null);
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

	internal void ReleaseRuntimeResources(CommandBuffer cmd, bool destroyManagedResources = false)
	{
	}

	protected override void Dispose(bool disposing)
	{
		if (disposing)
		{
			TemporalUpscalerRenderScale.Set(TemporalUpscaler.DLSS, enabled: false, 1f);
		}
	}
}
