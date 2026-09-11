using System;

namespace UnityEngine;

[AttributeUsage(AttributeTargets.Field, Inherited = true, AllowMultiple = false)]
public sealed class ColorUsageAttribute : PropertyAttribute
{
	public readonly bool showAlpha = true;

	public readonly bool hdr = false;

	[Obsolete("This field is no longer used for anything.")]
	public readonly float minBrightness = 0f;

	[Obsolete("This field is no longer used for anything.")]
	public readonly float maxBrightness = 8f;

	[Obsolete("This field is no longer used for anything.")]
	public readonly float minExposureValue = 0.125f;

	[Obsolete("This field is no longer used for anything.")]
	public readonly float maxExposureValue = 3f;

	public ColorUsageAttribute(bool showAlpha)
	{
		this.showAlpha = showAlpha;
	}

	public ColorUsageAttribute(bool showAlpha, bool hdr)
	{
		this.showAlpha = showAlpha;
		this.hdr = hdr;
	}

	[Obsolete("Brightness and exposure parameters are no longer used for anything. Use ColorUsageAttribute(bool showAlpha, bool hdr)")]
	public ColorUsageAttribute(bool showAlpha, bool hdr, float minBrightness, float maxBrightness, float minExposureValue, float maxExposureValue)
	{
		this.showAlpha = showAlpha;
		this.hdr = hdr;
		this.minBrightness = minBrightness;
		this.maxBrightness = maxBrightness;
		this.minExposureValue = minExposureValue;
		this.maxExposureValue = maxExposureValue;
	}
}
