using System;
using UnityEngine;
using UnityEngine.Rendering;

namespace XPostProcessing;

[Serializable]
public sealed class NoInterpAnimationCurveParameter : AnimationCurveParameter
{
	public NoInterpAnimationCurveParameter(AnimationCurve value, bool overrideState = false)
		: base(value, overrideState)
	{
	}

	public override void Interp(AnimationCurve from, AnimationCurve to, float t)
	{
		m_Value.CopyFrom((t > 0f) ? to : from);
	}

	public override object Clone()
	{
		return new NoInterpAnimationCurveParameter(new AnimationCurve(value.keys), overrideState);
	}
}
