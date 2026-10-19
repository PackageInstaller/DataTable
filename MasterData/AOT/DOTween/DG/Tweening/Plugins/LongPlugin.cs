using System;
using DG.Tweening.Core;
using DG.Tweening.Core.Easing;
using DG.Tweening.Core.Enums;
using DG.Tweening.Plugins.Core;
using DG.Tweening.Plugins.Options;

namespace DG.Tweening.Plugins;

public class LongPlugin : ABSTweenPlugin<long, long, NoOptions>
{
	public override void Reset(TweenerCore<long, long, NoOptions> t)
	{
	}

	public override void SetFrom(TweenerCore<long, long, NoOptions> t, bool isRelative)
	{
		long endValue = t.endValue;
		t.endValue = t.getter();
		t.startValue = (isRelative ? (t.endValue + endValue) : endValue);
		t.setter(t.startValue);
	}

	public override void SetFrom(TweenerCore<long, long, NoOptions> t, long fromValue, bool setImmediately, bool isRelative)
	{
		if (isRelative)
		{
			long num = t.getter();
			t.endValue += num;
			fromValue += num;
		}
		t.startValue = fromValue;
		if (setImmediately)
		{
			t.setter(fromValue);
		}
	}

	public override long ConvertToStartValue(TweenerCore<long, long, NoOptions> t, long value)
	{
		return value;
	}

	public override void SetRelativeEndValue(TweenerCore<long, long, NoOptions> t)
	{
		t.endValue += t.startValue;
	}

	public override void SetChangeValue(TweenerCore<long, long, NoOptions> t)
	{
		t.changeValue = t.endValue - t.startValue;
	}

	public override float GetSpeedBasedDuration(NoOptions options, float unitsXSecond, long changeValue)
	{
		float num = (float)changeValue / unitsXSecond;
		if (num < 0f)
		{
			num = 0f - num;
		}
		return num;
	}

	public override void EvaluateAndApply(NoOptions options, Tween t, bool isRelative, DOGetter<long> getter, DOSetter<long> setter, float elapsed, long startValue, long changeValue, float duration, bool usingInversePosition, int newCompletedSteps, UpdateNotice updateNotice)
	{
		if (t.loopType == LoopType.Incremental)
		{
			startValue += changeValue * (t.isComplete ? (t.completedLoops - 1) : t.completedLoops);
		}
		if (t.isSequenced && t.sequenceParent.loopType == LoopType.Incremental)
		{
			startValue += changeValue * ((t.loopType != LoopType.Incremental) ? 1 : t.loops) * (t.sequenceParent.isComplete ? (t.sequenceParent.completedLoops - 1) : t.sequenceParent.completedLoops);
		}
		setter((long)Math.Round((float)startValue + (float)changeValue * EaseManager.Evaluate(t.easeType, t.customEase, elapsed, duration, t.easeOvershootOrAmplitude, t.easePeriod)));
	}
}
