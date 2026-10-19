using UnityEngine;

namespace ACT;

public readonly struct GraphicPerformanceLoad
{
	public bool Available { get; }

	public float RawDeviceRating { get; }

	public float RawLowGradeBaseRating { get; }

	public float DeviceRating { get; }

	public float LowGradeBaseRating { get; }

	public float AdditiveWeight { get; }

	public float MultiplicativeWeight { get; }

	public float SettingWeight { get; }

	public float RequiredRating { get; }

	public float RequiredRatingScale { get; }

	public float LoadRatio { get; }

	public float LoadPercent => LoadRatio * 100f;

	public float NormalizedLoad => Mathf.Clamp01(LoadRatio);

	public bool IsOverloaded => LoadRatio > 1f;

	public float PerformanceMarginRatio { get; }

	internal GraphicPerformanceLoad(float rawDeviceRating, float rawLowGradeBaseRating, float deviceRating, float lowGradeBaseRating, float additiveWeight, float multiplicativeWeight, float settingWeight, float requiredRating, float requiredRatingScale, float loadRatio, float performanceMarginRatio)
	{
		Available = true;
		RawDeviceRating = rawDeviceRating;
		RawLowGradeBaseRating = rawLowGradeBaseRating;
		DeviceRating = deviceRating;
		LowGradeBaseRating = lowGradeBaseRating;
		AdditiveWeight = additiveWeight;
		MultiplicativeWeight = multiplicativeWeight;
		SettingWeight = settingWeight;
		RequiredRating = requiredRating;
		RequiredRatingScale = requiredRatingScale;
		LoadRatio = loadRatio;
		PerformanceMarginRatio = performanceMarginRatio;
	}
}
