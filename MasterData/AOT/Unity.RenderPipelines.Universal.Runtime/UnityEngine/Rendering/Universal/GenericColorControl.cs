using System;

namespace UnityEngine.Rendering.Universal;

[Serializable]
public sealed class GenericColorControl : VolumeComponent, IPostProcessComponent
{
	[Tooltip("Controls the overall weight of Generic lighting EV adjustments.")]
	public ClampedFloatParameter intensity = new ClampedFloatParameter(0f, 0f, 1f);

	[Tooltip("Adjusts Generic material environment lighting in EV.")]
	public ClampedFloatParameter ambientLightEV = new ClampedFloatParameter(0f, -5f, 5f);

	[Tooltip("Adjusts Generic material direct lighting in EV.")]
	public ClampedFloatParameter directLightEV = new ClampedFloatParameter(0f, -5f, 5f);

	[Tooltip("Adjusts reflection probe lighting in EV.")]
	public ClampedFloatParameter reflectionProbeEV = new ClampedFloatParameter(0f, -5f, 5f);

	public bool IsActive()
	{
		if (intensity.value > 0f)
		{
			if (Mathf.Approximately(ambientLightEV.value, 0f) && Mathf.Approximately(directLightEV.value, 0f))
			{
				return !Mathf.Approximately(reflectionProbeEV.value, 0f);
			}
			return true;
		}
		return false;
	}

	public bool IsTileCompatible()
	{
		return true;
	}
}
