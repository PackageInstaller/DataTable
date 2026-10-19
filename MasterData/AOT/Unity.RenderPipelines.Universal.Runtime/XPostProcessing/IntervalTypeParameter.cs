using System;
using UnityEngine.Rendering;

namespace XPostProcessing;

[Serializable]
public sealed class IntervalTypeParameter : VolumeParameter<IntervalType>
{
	public IntervalTypeParameter(IntervalType value, bool overrideState = false)
		: base(value, overrideState)
	{
	}
}
