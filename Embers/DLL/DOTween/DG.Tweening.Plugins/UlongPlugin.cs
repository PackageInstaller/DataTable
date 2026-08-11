using DG.Tweening.Core;
using DG.Tweening.Core.Easing;
using DG.Tweening.Core.Enums;
using DG.Tweening.Plugins.Core;
using DG.Tweening.Plugins.Options;

namespace DG.Tweening.Plugins;

public class UlongPlugin : ABSTweenPlugin<ulong, ulong, NoOptions>
{
	public override void Reset(TweenerCore<ulong, ulong, NoOptions> t)
	{
	}

	public override void SetFrom(TweenerCore<ulong, ulong, NoOptions> t, bool isRelative)
	{
		ulong endValue = t.endValue;
		t.endValue = t.getter();
		t.startValue = (isRelative ? (t.endValue + endValue) : endValue);
		t.setter(t.startValue);
	}

	public override void SetFrom(TweenerCore<ulong, ulong, NoOptions> t, ulong fromValue, bool setImmediately, bool isRelative)
	{
		if (isRelative)
		{
			ulong num = t.getter();
			t.endValue += num;
			fromValue += num;
		}
		t.startValue = fromValue;
		if (setImmediately)
		{
			t.setter(fromValue);
		}
	}

	public override ulong ConvertToStartValue(TweenerCore<ulong, ulong, NoOptions> t, ulong value)
	{
		return value;
	}

	public override void SetRelativeEndValue(TweenerCore<ulong, ulong, NoOptions> t)
	{
		t.endValue += t.startValue;
	}

	public override void SetChangeValue(TweenerCore<ulong, ulong, NoOptions> t)
	{
		t.changeValue = t.endValue - t.startValue;
	}

	public override float GetSpeedBasedDuration(NoOptions options, float unitsXSecond, ulong changeValue)
	{
		float num = (float)changeValue / unitsXSecond;
		if (num < 0f)
		{
			num = 0f - num;
		}
		return num;
	}

	public override void EvaluateAndApply(NoOptions options, Tween t, bool isRelative, DOGetter<ulong> getter, DOSetter<ulong> setter, float elapsed, ulong startValue, ulong changeValue, float duration, bool usingInversePosition, int newCompletedSteps, UpdateNotice updateNotice)
	{
		if (t.loopType == LoopType.Incremental)
		{
			startValue += changeValue * (uint)(t.isComplete ? (t.completedLoops - 1) : t.completedLoops);
		}
		if (t.isSequenced && t.sequenceParent.loopType == LoopType.Incremental)
		{
			startValue += changeValue * (uint)((t.loopType != LoopType.Incremental) ? 1 : t.loops) * (uint)(t.sequenceParent.isComplete ? (t.sequenceParent.completedLoops - 1) : t.sequenceParent.completedLoops);
		}
		setter((ulong)((decimal)startValue + (decimal)changeValue * (decimal)EaseManager.Evaluate(t.easeType, t.customEase, elapsed, duration, t.easeOvershootOrAmplitude, t.easePeriod)));
	}
}
