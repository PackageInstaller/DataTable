namespace UnityEngine.Rendering.Universal;

public static class TemporalUpscalerRenderScale
{
	private static bool s_DLSSEnabled;

	private static bool s_FSR3Enabled;

	private static bool s_XeSSEnabled;

	private static bool s_MetalFXEnabled;

	private static int s_DLSSQuality = -1;

	private static float s_DLSSMultiplier = 1f;

	private static float s_FSR3Multiplier = 1f;

	private static float s_XeSSMultiplier = 1f;

	private static float s_MetalFXMultiplier = 1f;

	private static int s_DLSSCachedOutputWidth;

	private static int s_DLSSCachedOutputHeight;

	private static int s_DLSSCachedQuality = -1;

	private static int s_DLSSCachedInputWidth;

	private static int s_DLSSCachedInputHeight;

	private static int s_RuntimeFailureMask;

	public static float ActiveMultiplier
	{
		get
		{
			if (!s_DLSSEnabled)
			{
				if (!s_FSR3Enabled)
				{
					if (!s_XeSSEnabled)
					{
						if (!s_MetalFXEnabled)
						{
							return 1f;
						}
						return s_MetalFXMultiplier;
					}
					return s_XeSSMultiplier;
				}
				return s_FSR3Multiplier;
			}
			return s_DLSSMultiplier;
		}
	}

	internal static bool IsActive
	{
		get
		{
			if (!s_DLSSEnabled && !s_FSR3Enabled && !s_XeSSEnabled)
			{
				return s_MetalFXEnabled;
			}
			return true;
		}
	}

	[RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.SubsystemRegistration)]
	private static void ResetRuntimeState()
	{
		s_DLSSEnabled = false;
		s_FSR3Enabled = false;
		s_XeSSEnabled = false;
		s_MetalFXEnabled = false;
		s_DLSSQuality = -1;
		s_DLSSMultiplier = 1f;
		s_FSR3Multiplier = 1f;
		s_XeSSMultiplier = 1f;
		s_MetalFXMultiplier = 1f;
		s_RuntimeFailureMask = 0;
		ClearDLSSOptimalResolution();
	}

	public static void Set(TemporalUpscaler upscaler, bool enabled, float multiplier, int nativeQuality = -1)
	{
		enabled &= !HasRuntimeFailure(upscaler);
		multiplier = Mathf.Max(0.01f, multiplier);
		switch (upscaler)
		{
		case TemporalUpscaler.DLSS:
			if (s_DLSSEnabled != enabled || s_DLSSQuality != nativeQuality)
			{
				ClearDLSSOptimalResolution();
			}
			s_DLSSEnabled = enabled;
			s_DLSSMultiplier = multiplier;
			s_DLSSQuality = nativeQuality;
			break;
		case TemporalUpscaler.FSR3:
			s_FSR3Enabled = enabled;
			s_FSR3Multiplier = multiplier;
			break;
		case TemporalUpscaler.XeSS:
			s_XeSSEnabled = enabled;
			s_XeSSMultiplier = multiplier;
			break;
		case TemporalUpscaler.MetalFX:
			s_MetalFXEnabled = enabled;
			s_MetalFXMultiplier = multiplier;
			break;
		}
	}

	public static bool HasRuntimeFailure(TemporalUpscaler upscaler)
	{
		return (s_RuntimeFailureMask & (1 << (int)upscaler)) != 0;
	}

	internal static void MarkRuntimeFailure(TemporalUpscaler upscaler)
	{
		s_RuntimeFailureMask |= 1 << (int)upscaler;
		switch (upscaler)
		{
		case TemporalUpscaler.DLSS:
			s_DLSSEnabled = false;
			ClearDLSSOptimalResolution();
			break;
		case TemporalUpscaler.FSR3:
			s_FSR3Enabled = false;
			break;
		case TemporalUpscaler.XeSS:
			s_XeSSEnabled = false;
			break;
		case TemporalUpscaler.MetalFX:
			s_MetalFXEnabled = false;
			break;
		}
	}

	internal static void ResetRuntimeFailure(TemporalUpscaler upscaler)
	{
		s_RuntimeFailureMask &= ~(1 << (int)upscaler);
	}

	public static void GetActiveInputResolution(int outputWidth, int outputHeight, out int inputWidth, out int inputHeight)
	{
		outputWidth = Mathf.Max(1, outputWidth);
		outputHeight = Mathf.Max(1, outputHeight);
		if (s_DLSSEnabled)
		{
			if (!(s_DLSSMultiplier < 1f) || !TryGetDLSSOptimalResolution(outputWidth, outputHeight, s_DLSSQuality, out inputWidth, out inputHeight))
			{
				inputWidth = outputWidth;
				inputHeight = outputHeight;
			}
			return;
		}
		float activeMultiplier = ActiveMultiplier;
		int outputWidth2;
		int outputHeight2;
		if (activeMultiplier >= 1f)
		{
			inputWidth = outputWidth;
			inputHeight = outputHeight;
		}
		else if (!s_MetalFXEnabled || !TryGetMetalFXDimensions(outputWidth, outputHeight, 1f, out inputWidth, out inputHeight, out outputWidth2, out outputHeight2))
		{
			bool flag = !s_DLSSEnabled && !s_FSR3Enabled && s_XeSSEnabled;
			inputWidth = Mathf.Max(1, flag ? Mathf.CeilToInt((float)outputWidth * activeMultiplier) : Mathf.RoundToInt((float)outputWidth * activeMultiplier));
			inputHeight = Mathf.Max(1, flag ? Mathf.CeilToInt((float)outputHeight * activeMultiplier) : Mathf.RoundToInt((float)outputHeight * activeMultiplier));
		}
	}

	internal static bool TryGetDLSSOptimalResolution(int outputWidth, int outputHeight, int nativeQuality, out int inputWidth, out int inputHeight)
	{
		if (s_DLSSCachedOutputWidth == outputWidth && s_DLSSCachedOutputHeight == outputHeight && s_DLSSCachedQuality == nativeQuality)
		{
			inputWidth = s_DLSSCachedInputWidth;
			inputHeight = s_DLSSCachedInputHeight;
			if (inputWidth > 0)
			{
				return inputHeight > 0;
			}
			return false;
		}
		if (!DLSSRuntime.TryGetOptimalInputResolution(outputWidth, outputHeight, nativeQuality, out inputWidth, out inputHeight))
		{
			return false;
		}
		s_DLSSCachedOutputWidth = outputWidth;
		s_DLSSCachedOutputHeight = outputHeight;
		s_DLSSCachedQuality = nativeQuality;
		s_DLSSCachedInputWidth = inputWidth;
		s_DLSSCachedInputHeight = inputHeight;
		return true;
	}

	internal static void ClearDLSSOptimalResolution()
	{
		s_DLSSCachedOutputWidth = 0;
		s_DLSSCachedOutputHeight = 0;
		s_DLSSCachedQuality = -1;
		s_DLSSCachedInputWidth = 0;
		s_DLSSCachedInputHeight = 0;
	}

	internal static void MarkDLSSOptimalResolutionUnavailable(int outputWidth, int outputHeight, int nativeQuality)
	{
		s_DLSSCachedOutputWidth = outputWidth;
		s_DLSSCachedOutputHeight = outputHeight;
		s_DLSSCachedQuality = nativeQuality;
		s_DLSSCachedInputWidth = 0;
		s_DLSSCachedInputHeight = 0;
	}

	internal static bool TryGetMetalFXDimensions(int pixelWidth, int pixelHeight, float outputRenderScale, out int inputWidth, out int inputHeight, out int outputWidth, out int outputHeight)
	{
		inputWidth = 0;
		inputHeight = 0;
		outputWidth = 0;
		outputHeight = 0;
		if (s_DLSSEnabled || s_FSR3Enabled || s_XeSSEnabled || !s_MetalFXEnabled || pixelWidth <= 0 || pixelHeight <= 0)
		{
			return false;
		}
		float a = s_MetalFXMultiplier;
		int num;
		int num2;
		if (Mathf.Approximately(a, 0.5f))
		{
			num = 1;
			num2 = 2;
		}
		else if (Mathf.Approximately(a, 150f / 255f))
		{
			num = 10;
			num2 = 17;
		}
		else if (Mathf.Approximately(a, 2f / 3f))
		{
			num = 2;
			num2 = 3;
		}
		else
		{
			if (!Mathf.Approximately(a, 1f))
			{
				return false;
			}
			num = 1;
			num2 = 1;
		}
		int num3 = Mathf.Max(1, Mathf.RoundToInt((float)pixelWidth * outputRenderScale));
		int num4 = Mathf.Max(1, Mathf.RoundToInt((float)pixelHeight * outputRenderScale));
		int num5 = GreatestCommonDivisor(num3, num4);
		int num6 = Mathf.Clamp(Mathf.RoundToInt((float)num5 * (float)num / (float)num2), 1, num5);
		int num7 = num3 / num5;
		int num8 = num4 / num5;
		int num9 = num7 * num6;
		int num10 = num8 * num6;
		int num11 = Mathf.Max(1, Mathf.RoundToInt((float)num3 * (float)num / (float)num2));
		int num12 = Mathf.Max(1, Mathf.RoundToInt((float)num4 * (float)num / (float)num2));
		if ((num == num2 || num6 < num5) && Mathf.Abs(num9 - num11) <= num && Mathf.Abs(num10 - num12) <= num)
		{
			inputWidth = num9;
			inputHeight = num10;
			outputWidth = num3;
			outputHeight = num4;
			return true;
		}
		outputWidth = AlignUp(num3, num2);
		outputHeight = AlignUp(num4, num2);
		inputWidth = outputWidth / num2 * num;
		inputHeight = outputHeight / num2 * num;
		return true;
	}

	public static bool TryGetMetalFXInputResolution(int pixelWidth, int pixelHeight, float outputRenderScale, out int inputWidth, out int inputHeight)
	{
		int outputWidth;
		int outputHeight;
		return TryGetMetalFXDimensions(pixelWidth, pixelHeight, outputRenderScale, out inputWidth, out inputHeight, out outputWidth, out outputHeight);
	}

	public static bool TryGetMetalFXResolutions(int pixelWidth, int pixelHeight, float outputRenderScale, out int inputWidth, out int inputHeight, out int outputWidth, out int outputHeight)
	{
		return TryGetMetalFXDimensions(pixelWidth, pixelHeight, outputRenderScale, out inputWidth, out inputHeight, out outputWidth, out outputHeight);
	}

	public static bool TryGetMetalFXFrameResolutions(int frameWidth, int frameHeight, out int inputWidth, out int inputHeight, out int outputWidth, out int outputHeight)
	{
		return TryGetMetalFXDimensions(frameWidth, frameHeight, 1f, out inputWidth, out inputHeight, out outputWidth, out outputHeight);
	}

	private static int AlignUp(int value, int alignment)
	{
		return (value + alignment - 1) / alignment * alignment;
	}

	private static int GreatestCommonDivisor(int a, int b)
	{
		while (b != 0)
		{
			int num = a % b;
			a = b;
			b = num;
		}
		return a;
	}
}
