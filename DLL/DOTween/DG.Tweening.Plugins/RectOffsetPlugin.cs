using System;
using DG.Tweening.Core;
using DG.Tweening.Core.Easing;
using DG.Tweening.Core.Enums;
using DG.Tweening.Plugins.Core;
using DG.Tweening.Plugins.Options;
using UnityEngine;

namespace DG.Tweening.Plugins;

public class RectOffsetPlugin : ABSTweenPlugin<RectOffset, RectOffset, NoOptions>
{
	private static RectOffset _r;

	public override void Reset(TweenerCore<RectOffset, RectOffset, NoOptions> t)
	{
		t.startValue = (t.endValue = (t.changeValue = null));
	}

	public override void SetFrom(TweenerCore<RectOffset, RectOffset, NoOptions> t, bool isRelative)
	{
		RectOffset endValue = t.endValue;
		t.endValue = t.getter();
		t.startValue = endValue;
		if (isRelative)
		{
			RectOffset startValue = t.startValue;
			startValue.left += t.endValue.left;
			RectOffset startValue2 = t.startValue;
			startValue2.right += t.endValue.right;
			RectOffset startValue3 = t.startValue;
			startValue3.top += t.endValue.top;
			RectOffset startValue4 = t.startValue;
			startValue4.bottom += t.endValue.bottom;
		}
		t.setter(t.startValue);
	}

	public override void SetFrom(TweenerCore<RectOffset, RectOffset, NoOptions> t, RectOffset fromValue, bool setImmediately, bool isRelative)
	{
		if (isRelative)
		{
			RectOffset val = t.getter();
			RectOffset endValue = t.endValue;
			endValue.left += val.left;
			RectOffset endValue2 = t.endValue;
			endValue2.right += val.right;
			RectOffset endValue3 = t.endValue;
			endValue3.top += val.top;
			RectOffset endValue4 = t.endValue;
			endValue4.bottom += val.bottom;
			fromValue.left += val.left;
			fromValue.right += val.right;
			fromValue.top += val.top;
			fromValue.bottom += val.bottom;
		}
		t.startValue = fromValue;
		if (setImmediately)
		{
			t.setter(fromValue);
		}
	}

	public override RectOffset ConvertToStartValue(TweenerCore<RectOffset, RectOffset, NoOptions> t, RectOffset value)
	{
		//IL_0018: Unknown result type (might be due to invalid IL or missing references)
		//IL_001e: Expected O, but got Unknown
		return new RectOffset(value.left, value.right, value.top, value.bottom);
	}

	public override void SetRelativeEndValue(TweenerCore<RectOffset, RectOffset, NoOptions> t)
	{
		RectOffset endValue = t.endValue;
		endValue.left += t.startValue.left;
		RectOffset endValue2 = t.endValue;
		endValue2.right += t.startValue.right;
		RectOffset endValue3 = t.endValue;
		endValue3.top += t.startValue.top;
		RectOffset endValue4 = t.endValue;
		endValue4.bottom += t.startValue.bottom;
	}

	public override void SetChangeValue(TweenerCore<RectOffset, RectOffset, NoOptions> t)
	{
		//IL_005d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0067: Expected O, but got Unknown
		t.changeValue = new RectOffset(t.endValue.left - t.startValue.left, t.endValue.right - t.startValue.right, t.endValue.top - t.startValue.top, t.endValue.bottom - t.startValue.bottom);
	}

	public override float GetSpeedBasedDuration(NoOptions options, float unitsXSecond, RectOffset changeValue)
	{
		float num = changeValue.right;
		if (num < 0f)
		{
			num = 0f - num;
		}
		float num2 = changeValue.bottom;
		if (num2 < 0f)
		{
			num2 = 0f - num2;
		}
		return (float)Math.Sqrt(num * num + num2 * num2) / unitsXSecond;
	}

	public override void EvaluateAndApply(NoOptions options, Tween t, bool isRelative, DOGetter<RectOffset> getter, DOSetter<RectOffset> setter, float elapsed, RectOffset startValue, RectOffset changeValue, float duration, bool usingInversePosition, int newCompletedSteps, UpdateNotice updateNotice)
	{
		//IL_0228: Unknown result type (might be due to invalid IL or missing references)
		//IL_0232: Expected O, but got Unknown
		_r.left = startValue.left;
		_r.right = startValue.right;
		_r.top = startValue.top;
		_r.bottom = startValue.bottom;
		if (t.loopType == LoopType.Incremental)
		{
			int num = (t.isComplete ? (t.completedLoops - 1) : t.completedLoops);
			RectOffset r = _r;
			r.left += changeValue.left * num;
			RectOffset r2 = _r;
			r2.right += changeValue.right * num;
			RectOffset r3 = _r;
			r3.top += changeValue.top * num;
			RectOffset r4 = _r;
			r4.bottom += changeValue.bottom * num;
		}
		if (t.isSequenced && t.sequenceParent.loopType == LoopType.Incremental)
		{
			int num2 = ((t.loopType != LoopType.Incremental) ? 1 : t.loops) * (t.sequenceParent.isComplete ? (t.sequenceParent.completedLoops - 1) : t.sequenceParent.completedLoops);
			RectOffset r5 = _r;
			r5.left += changeValue.left * num2;
			RectOffset r6 = _r;
			r6.right += changeValue.right * num2;
			RectOffset r7 = _r;
			r7.top += changeValue.top * num2;
			RectOffset r8 = _r;
			r8.bottom += changeValue.bottom * num2;
		}
		float num3 = EaseManager.Evaluate(t.easeType, t.customEase, elapsed, duration, t.easeOvershootOrAmplitude, t.easePeriod);
		setter(new RectOffset((int)Math.Round((float)_r.left + (float)changeValue.left * num3), (int)Math.Round((float)_r.right + (float)changeValue.right * num3), (int)Math.Round((float)_r.top + (float)changeValue.top * num3), (int)Math.Round((float)_r.bottom + (float)changeValue.bottom * num3)));
	}

	static RectOffsetPlugin()
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_000a: Expected O, but got Unknown
		_r = new RectOffset();
	}
}
