using System;

namespace UnityEngine.Rendering;

[Serializable]
public struct GlobalDynamicResolutionSettings
{
	public bool enabled;

	public bool useMipBias;

	public bool enableDLSS;

	public uint DLSSPerfQualitySetting;

	public bool DLSSUseOptimalSettings;

	[Range(0f, 1f)]
	public float DLSSSharpness;

	public float maxPercentage;

	public float minPercentage;

	public DynamicResolutionType dynResType;

	public DynamicResUpscaleFilter upsampleFilter;

	public bool forceResolution;

	public float forcedPercentage;

	public float lowResTransparencyMinimumThreshold;

	public float rayTracingHalfResThreshold;

	public static GlobalDynamicResolutionSettings NewDefault()
	{
		return new GlobalDynamicResolutionSettings
		{
			useMipBias = false,
			maxPercentage = 100f,
			minPercentage = 100f,
			dynResType = DynamicResolutionType.Hardware,
			upsampleFilter = DynamicResUpscaleFilter.CatmullRom,
			forcedPercentage = 100f,
			lowResTransparencyMinimumThreshold = 0f,
			rayTracingHalfResThreshold = 50f,
			enableDLSS = false,
			DLSSUseOptimalSettings = true,
			DLSSPerfQualitySetting = 0u,
			DLSSSharpness = 0.5f
		};
	}
}
