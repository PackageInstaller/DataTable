using System;
using DG.Tweening.Core;
using DG.Tweening.Core.Easing;
using DG.Tweening.Core.Enums;
using DG.Tweening.Plugins.Core;
using DG.Tweening.Plugins.Options;

namespace DG.Tweening.Plugins;

public class UintPlugin : ABSTweenPlugin<uint, uint, UintOptions>
{
	public override void Reset(TweenerCore<uint, uint, UintOptions> t)
	{
	}

	public override void SetFrom(TweenerCore<uint, uint, UintOptions> t, bool isRelative)
	{
		uint endValue = t.endValue;
		t.endValue = t.getter();
		t.startValue = (isRelative ? (t.endValue + endValue) : endValue);
		t.setter(t.startValue);
	}

	public override void SetFrom(TweenerCore<uint, uint, UintOptions> t, uint fromValue, bool setImmediately, bool isRelative)
	{
		if (isRelative)
		{
			uint num = t.getter();
			t.endValue += num;
			fromValue += num;
		}
		t.startValue = fromValue;
		if (setImmediately)
		{
			t.setter(fromValue);
		}
	}

	public override uint ConvertToStartValue(TweenerCore<uint, uint, UintOptions> t, uint value)
	{
		return value;
	}

	public override void SetRelativeEndValue(TweenerCore<uint, uint, UintOptions> t)
	{
		t.endValue += t.startValue;
	}

	public override void SetChangeValue(TweenerCore<uint, uint, UintOptions> t)
	{
		t.plugOptions.isNegativeChangeValue = t.endValue < t.startValue;
		t.changeValue = (t.plugOptions.isNegativeChangeValue ? (t.startValue - t.endValue) : (t.endValue - t.startValue));
	}

	public override float GetSpeedBasedDuration(UintOptions options, float unitsXSecond, uint changeValue)
	{
		float num = (float)changeValue / unitsXSecond;
		if (num < 0f)
		{
			num = 0f - num;
		}
		return num;
	}

	public override void EvaluateAndApply(UintOptions options, Tween t, bool isRelative, DOGetter<uint> getter, DOSetter<uint> setter, float elapsed, uint startValue, uint changeValue, float duration, bool usingInversePosition, int newCompletedSteps, UpdateNotice updateNotice)
	{
		uint num;
		if (t.loopType == LoopType.Incremental)
		{
			num = (uint)(changeValue * (t.isComplete ? (t.completedLoops - 1) : t.completedLoops));
			startValue = ((!options.isNegativeChangeValue) ? (startValue + num) : (startValue - num));
		}
		if (t.isSequenced && t.sequenceParent.loopType == LoopType.Incremental)
		{
			num = (uint)(changeValue * ((t.loopType != LoopType.Incremental) ? 1 : t.loops) * (t.sequenceParent.isComplete ? (t.sequenceParent.completedLoops - 1) : t.sequenceParent.completedLoops));
			startValue = ((!options.isNegativeChangeValue) ? (startValue + num) : (startValue - num));
		}
		num = (uint)Math.Round((float)changeValue * EaseManager.Evaluate(t.easeType, t.customEase, elapsed, duration, t.easeOvershootOrAmplitude, t.easePeriod));
		if (options.isNegativeChangeValue)
		{
			setter(startValue - num);
		}
		else
		{
			setter(startValue + num);
		}
	}
}
