using System;

namespace UnityEngine.Rendering.Universal;

[Serializable]
public sealed class DepthOfFieldModeParameter : VolumeParameter<DepthOfFieldMode>
{
	public DepthOfFieldModeParameter(DepthOfFieldMode value, bool overrideState = false)
		: base(value, overrideState)
	{
	}
}
