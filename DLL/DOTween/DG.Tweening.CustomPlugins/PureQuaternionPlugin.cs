using DG.Tweening.Core;
using DG.Tweening.Core.Easing;
using DG.Tweening.Core.Enums;
using DG.Tweening.Plugins.Core;
using DG.Tweening.Plugins.Options;
using UnityEngine;

namespace DG.Tweening.CustomPlugins;

public class PureQuaternionPlugin : ABSTweenPlugin<Quaternion, Quaternion, NoOptions>
{
	private static PureQuaternionPlugin _plug;

	public static PureQuaternionPlugin Plug()
	{
		if (_plug == null)
		{
			_plug = new PureQuaternionPlugin();
		}
		return _plug;
	}

	public override void Reset(TweenerCore<Quaternion, Quaternion, NoOptions> t)
	{
	}

	public override void SetFrom(TweenerCore<Quaternion, Quaternion, NoOptions> t, bool isRelative)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_000e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		//IL_0020: Unknown result type (might be due to invalid IL or missing references)
		//IL_0025: Unknown result type (might be due to invalid IL or missing references)
		//IL_0026: Unknown result type (might be due to invalid IL or missing references)
		//IL_001c: Unknown result type (might be due to invalid IL or missing references)
		//IL_002b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0037: Unknown result type (might be due to invalid IL or missing references)
		Quaternion endValue = t.endValue;
		t.endValue = t.getter();
		t.startValue = (isRelative ? (t.endValue * endValue) : endValue);
		t.setter(t.startValue);
	}

	public override void SetFrom(TweenerCore<Quaternion, Quaternion, NoOptions> t, Quaternion fromValue, bool setImmediately, bool isRelative)
	{
		//IL_002c: Unknown result type (might be due to invalid IL or missing references)
		//IL_002d: Unknown result type (might be due to invalid IL or missing references)
		//IL_000a: Unknown result type (might be due to invalid IL or missing references)
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0011: Unknown result type (might be due to invalid IL or missing references)
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		//IL_0018: Unknown result type (might be due to invalid IL or missing references)
		//IL_001d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0022: Unknown result type (might be due to invalid IL or missing references)
		//IL_0023: Unknown result type (might be due to invalid IL or missing references)
		//IL_0024: Unknown result type (might be due to invalid IL or missing references)
		//IL_0029: Unknown result type (might be due to invalid IL or missing references)
		//IL_003b: Unknown result type (might be due to invalid IL or missing references)
		if (isRelative)
		{
			Quaternion val = t.getter();
			t.endValue = val * t.endValue;
			fromValue = val * fromValue;
		}
		t.startValue = fromValue;
		if (setImmediately)
		{
			t.setter(fromValue);
		}
	}

	public override Quaternion ConvertToStartValue(TweenerCore<Quaternion, Quaternion, NoOptions> t, Quaternion value)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		return value;
	}

	public override void SetRelativeEndValue(TweenerCore<Quaternion, Quaternion, NoOptions> t)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0008: Unknown result type (might be due to invalid IL or missing references)
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0012: Unknown result type (might be due to invalid IL or missing references)
		t.endValue *= t.startValue;
	}

	public override void SetChangeValue(TweenerCore<Quaternion, Quaternion, NoOptions> t)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		t.changeValue = t.endValue;
	}

	public override float GetSpeedBasedDuration(NoOptions options, float unitsXSecond, Quaternion changeValue)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		Vector3 eulerAngles = ((Quaternion)(ref changeValue)).eulerAngles;
		return ((Vector3)(ref eulerAngles)).magnitude / unitsXSecond;
	}

	public override void EvaluateAndApply(NoOptions options, Tween t, bool isRelative, DOGetter<Quaternion> getter, DOSetter<Quaternion> setter, float elapsed, Quaternion startValue, Quaternion changeValue, float duration, bool usingInversePosition, int newCompletedSteps, UpdateNotice updateNotice)
	{
		//IL_0024: Unknown result type (might be due to invalid IL or missing references)
		//IL_0026: Unknown result type (might be due to invalid IL or missing references)
		//IL_0029: Unknown result type (might be due to invalid IL or missing references)
		float num = EaseManager.Evaluate(t.easeType, t.customEase, elapsed, duration, t.easeOvershootOrAmplitude, t.easePeriod);
		setter(Quaternion.Slerp(startValue, changeValue, num));
	}
}
