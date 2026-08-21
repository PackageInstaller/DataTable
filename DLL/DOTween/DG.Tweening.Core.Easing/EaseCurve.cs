using UnityEngine;

namespace DG.Tweening.Core.Easing;

public class EaseCurve
{
	private readonly AnimationCurve _animCurve;

	public EaseCurve(AnimationCurve animCurve)
	{
		_animCurve = animCurve;
	}

	public float Evaluate(float time, float duration, float unusedOvershoot, float unusedPeriod)
	{
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		//IL_0018: Unknown result type (might be due to invalid IL or missing references)
		Keyframe val = _animCurve[_animCurve.length - 1];
		float time2 = ((Keyframe)(ref val)).time;
		float num = time / duration;
		return _animCurve.Evaluate(num * time2);
	}
}
