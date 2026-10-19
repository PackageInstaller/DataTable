using System;

namespace UnityEngine.Rendering.Universal;

[Serializable]
public sealed class TemporalDepthOfFieldQualityParameter : VolumeParameter<TemporalDepthOfFieldQuality>
{
	public TemporalDepthOfFieldQualityParameter(TemporalDepthOfFieldQuality value, bool overrideState = false)
		: base(value, overrideState)
	{
	}
}
