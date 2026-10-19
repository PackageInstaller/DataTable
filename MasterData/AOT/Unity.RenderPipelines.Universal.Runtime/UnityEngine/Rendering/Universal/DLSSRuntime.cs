namespace UnityEngine.Rendering.Universal;

public static class DLSSRuntime
{
	public enum UnavailableReason
	{
		None = 0,
		NotStandaloneWindowsTarget = 1,
		PluginNotLoaded = 2,
		GPUNotSupported = 3,
		DLSSNotAvailableOnDevice = 4,
		GraphicsAPIUnsupported = 5,
		Unknown = 99
	}

	private const string k_PluginName = "DLSSUnityPlugin";

	private const int k_NvidiaVendorId = 4318;

	private static bool s_Initialized;

	private static bool s_Available;

	private static UnavailableReason s_UnavailableReason;

	public static bool IsAvailable(out UnavailableReason reason)
	{
		if (!s_Initialized)
		{
			s_Available = TryCheckAvailability(out s_UnavailableReason);
			s_Initialized = true;
		}
		reason = s_UnavailableReason;
		return s_Available;
	}

	private static bool TryCheckAvailability(out UnavailableReason reason)
	{
		reason = UnavailableReason.NotStandaloneWindowsTarget;
		return false;
	}

	internal static void ReportNativeFailure(UnavailableReason reason)
	{
		s_Available = false;
		s_UnavailableReason = ((reason == UnavailableReason.None) ? UnavailableReason.Unknown : reason);
		s_Initialized = true;
		TemporalUpscalerRenderScale.MarkRuntimeFailure(TemporalUpscaler.DLSS);
		DLSSFeature.UpdateActiveRenderScaleMultiplier(null);
	}

	[RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.SubsystemRegistration)]
	internal static void ResetAvailability()
	{
		s_Initialized = false;
		s_Available = false;
		s_UnavailableReason = UnavailableReason.None;
		TemporalUpscalerRenderScale.ResetRuntimeFailure(TemporalUpscaler.DLSS);
	}

	internal static bool TryGetOptimalInputResolution(int outputWidth, int outputHeight, int nativeQuality, out int inputWidth, out int inputHeight)
	{
		inputWidth = 0;
		inputHeight = 0;
		return false;
	}
}
