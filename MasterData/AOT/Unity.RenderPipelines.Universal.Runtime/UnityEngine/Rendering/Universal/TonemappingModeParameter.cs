using System;

namespace UnityEngine.Rendering.Universal;

[Serializable]
public sealed class TonemappingModeParameter : VolumeParameter<TonemappingMode>
{
	public TonemappingModeParameter(TonemappingMode value, bool overrideState = false)
		: base(value, overrideState)
	{
	}
}
