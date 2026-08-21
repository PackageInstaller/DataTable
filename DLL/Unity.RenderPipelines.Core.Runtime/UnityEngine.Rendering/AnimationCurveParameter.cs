using System;

namespace UnityEngine.Rendering;

[Serializable]
public class AnimationCurveParameter : VolumeParameter<AnimationCurve>
{
	public AnimationCurveParameter(AnimationCurve value, bool overrideState = false)
		: base(value, overrideState)
	{
	}
}
