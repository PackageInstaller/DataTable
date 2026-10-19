using System;

namespace UnityEngine.Rendering;

[Serializable]
public class AnimationCurveParameter : VolumeParameter<AnimationCurve>
{
	public AnimationCurveParameter(AnimationCurve value, bool overrideState = false)
		: base(value, overrideState)
	{
	}

	public override void Interp(AnimationCurve lhsCurve, AnimationCurve rhsCurve, float t)
	{
		m_Value = lhsCurve;
		KeyframeUtility.InterpAnimationCurve(ref m_Value, rhsCurve, t);
	}

	public override void SetValue(VolumeParameter parameter)
	{
		m_Value.CopyFrom(((AnimationCurveParameter)parameter).m_Value);
	}

	public override object Clone()
	{
		return new AnimationCurveParameter(new AnimationCurve(GetValue<AnimationCurve>().keys), overrideState);
	}

	public override int GetHashCode()
	{
		return overrideState.GetHashCode() * 23 + value.GetHashCode();
	}
}
