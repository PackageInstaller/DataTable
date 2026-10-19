using UnityEngine;
using UnityEngine.Rendering.Universal;

namespace ACT;

public static class TemporalUpscalerCapabilityResolver
{
	private const int NvidiaVendorId = 4318;

	private const int IntelVendorId = 32902;

	public static TemporalUpscalerKind Resolve(SettingUsage usage)
	{
		switch (usage)
		{
		case SettingUsage.PC:
			return ResolvePC();
		case SettingUsage.iOS:
			if (!MetalFXFeature.IsSupported())
			{
				return TemporalUpscalerKind.None;
			}
			return TemporalUpscalerKind.MetalFX;
		default:
			return TemporalUpscalerKind.None;
		}
	}

	public static bool Matches(TemporalUpscalerKind kind, TemporalUpscaler runtimeUpscaler)
	{
		switch (kind)
		{
		case TemporalUpscalerKind.DLSS:
			return runtimeUpscaler == TemporalUpscaler.DLSS;
		case TemporalUpscalerKind.FSR4:
		case TemporalUpscalerKind.FSR3:
			return runtimeUpscaler == TemporalUpscaler.FSR3;
		case TemporalUpscalerKind.MetalFX:
			return runtimeUpscaler == TemporalUpscaler.MetalFX;
		case TemporalUpscalerKind.XeSS:
			return runtimeUpscaler == TemporalUpscaler.XeSS;
		default:
			return false;
		}
	}

	private static TemporalUpscalerKind ResolvePC()
	{
		int graphicsDeviceVendorID = SystemInfo.graphicsDeviceVendorID;
		if (graphicsDeviceVendorID == 4318 && DLSSRuntime.IsAvailable(out var _))
		{
			return TemporalUpscalerKind.DLSS;
		}
		if (FSR3Feature.IsSupported())
		{
			if (graphicsDeviceVendorID == 32902 && XeSSFeature.IsSupported())
			{
				return TemporalUpscalerKind.XeSS;
			}
			return TemporalUpscalerKind.FSR3;
		}
		if (graphicsDeviceVendorID == 32902 && XeSSFeature.IsSupported())
		{
			return TemporalUpscalerKind.XeSS;
		}
		return TemporalUpscalerKind.None;
	}
}
