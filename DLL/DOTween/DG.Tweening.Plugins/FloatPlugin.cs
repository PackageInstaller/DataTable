using System;
using DG.Tweening.Core;
using DG.Tweening.Core.Easing;
using DG.Tweening.Core.Enums;
using DG.Tweening.Plugins.Core;
using DG.Tweening.Plugins.Options;

namespace DG.Tweening.Plugins;

public class FloatPlugin : ABSTweenPlugin<float, float, FloatOptions>
{
	public override void Reset(TweenerCore<float, float, FloatOptions> t)
	{
	}

	public override void SetFrom(TweenerCore<float, float, FloatOptions> t, bool isRelative)
	{
		float endValue = t.endValue;
		t.endValue = t.getter();
		t.startValue = (isRelative ? (t.endValue + endValue) : endValue);
		t.setter((!t.plugOptions.snapping) ? t.startValue : ((float)Math.Round(t.startValue)));
	}

	public override void SetFrom(TweenerCore<float, float, FloatOptions> t, float fromValue, bool setImmediately, bool isRelative)
	{
		if (isRelative)
		{
			float num = t.getter();
			t.endValue += num;
			fromValue += num;
		}
		t.startValue = fromValue;
		if (setImmediately)
		{
			t.setter((!t.plugOptions.snapping) ? fromValue : ((float)Math.Round(fromValue)));
		}
	}

	public override float ConvertToStartValue(TweenerCore<float, float, FloatOptions> t, float value)
	{
		return value;
	}

	public override void SetRelativeEndValue(TweenerCore<float, float, FloatOptions> t)
	{
		t.endValue += t.startValue;
	}

	public override void SetChangeValue(TweenerCore<float, float, FloatOptions> t)
	{
		t.changeValue = t.endValue - t.startValue;
	}

	public override float GetSpeedBasedDuration(FloatOptions options, float unitsXSecond, float changeValue)
	{
		float num = changeValue / unitsXSecond;
		if (num < 0f)
		{
			num = 0f - num;
		}
		return num;
	}

	public override void EvaluateAndApply(FloatOptions options, Tween t, bool isRelative, DOGetter<float> getter, DOSetter<float> setter, float elapsed, float startValue, float changeValue, float duration, bool usingInversePosition, int newCompletedSteps, UpdateNotice updateNotice)
	{
		if (t.loopType == LoopType.Incremental)
		{
			startValue += changeValue * (float)(t.isComplete ? (t.completedLoops - 1) : t.completedLoops);
		}
		if (t.isSequenced && t.sequenceParent.loopType == LoopType.Incremental)
		{
			startValue += changeValue * (float)((t.loopType != LoopType.Incremental) ? 1 : t.loops) * (float)(t.sequenceParent.isComplete ? (t.sequenceParent.completedLoops - 1) : t.sequenceParent.completedLoops);
		}
		setter((!options.snapping) ? (startValue + changeValue * EaseManager.Evaluate(t.easeType, t.customEase, elapsed, duration, t.easeOvershootOrAmplitude, t.easePeriod)) : ((float)Math.Round(startValue + changeValue * EaseManager.Evaluate(t.easeType, t.customEase, elapsed, duration, t.easeOvershootOrAmplitude, t.easePeriod))));
	}
}
