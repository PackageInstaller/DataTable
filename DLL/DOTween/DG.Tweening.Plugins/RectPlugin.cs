using System;
using DG.Tweening.Core;
using DG.Tweening.Core.Easing;
using DG.Tweening.Core.Enums;
using DG.Tweening.Plugins.Core;
using DG.Tweening.Plugins.Options;
using UnityEngine;

namespace DG.Tweening.Plugins;

public class RectPlugin : ABSTweenPlugin<Rect, Rect, RectOptions>
{
	public override void Reset(TweenerCore<Rect, Rect, RectOptions> t)
	{
	}

	public override void SetFrom(TweenerCore<Rect, Rect, RectOptions> t, bool isRelative)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_000e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		//IL_0019: Unknown result type (might be due to invalid IL or missing references)
		//IL_001a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0097: Unknown result type (might be due to invalid IL or missing references)
		//IL_009c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0104: Unknown result type (might be due to invalid IL or missing references)
		Rect endValue = t.endValue;
		t.endValue = t.getter();
		t.startValue = endValue;
		if (isRelative)
		{
			ref Rect startValue = ref t.startValue;
			((Rect)(ref startValue)).x = ((Rect)(ref startValue)).x + ((Rect)(ref t.endValue)).x;
			ref Rect startValue2 = ref t.startValue;
			((Rect)(ref startValue2)).y = ((Rect)(ref startValue2)).y + ((Rect)(ref t.endValue)).y;
			ref Rect startValue3 = ref t.startValue;
			((Rect)(ref startValue3)).width = ((Rect)(ref startValue3)).width + ((Rect)(ref t.endValue)).width;
			ref Rect startValue4 = ref t.startValue;
			((Rect)(ref startValue4)).height = ((Rect)(ref startValue4)).height + ((Rect)(ref t.endValue)).height;
		}
		Rect startValue5 = t.startValue;
		if (t.plugOptions.snapping)
		{
			((Rect)(ref startValue5)).x = (float)Math.Round(((Rect)(ref startValue5)).x);
			((Rect)(ref startValue5)).y = (float)Math.Round(((Rect)(ref startValue5)).y);
			((Rect)(ref startValue5)).width = (float)Math.Round(((Rect)(ref startValue5)).width);
			((Rect)(ref startValue5)).height = (float)Math.Round(((Rect)(ref startValue5)).height);
		}
		t.setter(startValue5);
	}

	public override void SetFrom(TweenerCore<Rect, Rect, RectOptions> t, Rect fromValue, bool setImmediately, bool isRelative)
	{
		//IL_00cc: Unknown result type (might be due to invalid IL or missing references)
		//IL_00cd: Unknown result type (might be due to invalid IL or missing references)
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0012: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d5: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d6: Unknown result type (might be due to invalid IL or missing references)
		//IL_013e: Unknown result type (might be due to invalid IL or missing references)
		if (isRelative)
		{
			Rect val = t.getter();
			ref Rect endValue = ref t.endValue;
			((Rect)(ref endValue)).x = ((Rect)(ref endValue)).x + ((Rect)(ref val)).x;
			ref Rect endValue2 = ref t.endValue;
			((Rect)(ref endValue2)).y = ((Rect)(ref endValue2)).y + ((Rect)(ref val)).y;
			ref Rect endValue3 = ref t.endValue;
			((Rect)(ref endValue3)).width = ((Rect)(ref endValue3)).width + ((Rect)(ref val)).width;
			ref Rect endValue4 = ref t.endValue;
			((Rect)(ref endValue4)).height = ((Rect)(ref endValue4)).height + ((Rect)(ref val)).height;
			((Rect)(ref fromValue)).x = ((Rect)(ref fromValue)).x + ((Rect)(ref val)).x;
			((Rect)(ref fromValue)).y = ((Rect)(ref fromValue)).y + ((Rect)(ref val)).y;
			((Rect)(ref fromValue)).width = ((Rect)(ref fromValue)).width + ((Rect)(ref val)).width;
			((Rect)(ref fromValue)).height = ((Rect)(ref fromValue)).height + ((Rect)(ref val)).height;
		}
		t.startValue = fromValue;
		if (setImmediately)
		{
			Rect pNewValue = fromValue;
			if (t.plugOptions.snapping)
			{
				((Rect)(ref pNewValue)).x = (float)Math.Round(((Rect)(ref pNewValue)).x);
				((Rect)(ref pNewValue)).y = (float)Math.Round(((Rect)(ref pNewValue)).y);
				((Rect)(ref pNewValue)).width = (float)Math.Round(((Rect)(ref pNewValue)).width);
				((Rect)(ref pNewValue)).height = (float)Math.Round(((Rect)(ref pNewValue)).height);
			}
			t.setter(pNewValue);
		}
	}

	public override Rect ConvertToStartValue(TweenerCore<Rect, Rect, RectOptions> t, Rect value)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		return value;
	}

	public override void SetRelativeEndValue(TweenerCore<Rect, Rect, RectOptions> t)
	{
		ref Rect endValue = ref t.endValue;
		((Rect)(ref endValue)).x = ((Rect)(ref endValue)).x + ((Rect)(ref t.startValue)).x;
		ref Rect endValue2 = ref t.endValue;
		((Rect)(ref endValue2)).y = ((Rect)(ref endValue2)).y + ((Rect)(ref t.startValue)).y;
		ref Rect endValue3 = ref t.endValue;
		((Rect)(ref endValue3)).width = ((Rect)(ref endValue3)).width + ((Rect)(ref t.startValue)).width;
		ref Rect endValue4 = ref t.endValue;
		((Rect)(ref endValue4)).height = ((Rect)(ref endValue4)).height + ((Rect)(ref t.startValue)).height;
	}

	public override void SetChangeValue(TweenerCore<Rect, Rect, RectOptions> t)
	{
		//IL_005d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0062: Unknown result type (might be due to invalid IL or missing references)
		t.changeValue = new Rect(((Rect)(ref t.endValue)).x - ((Rect)(ref t.startValue)).x, ((Rect)(ref t.endValue)).y - ((Rect)(ref t.startValue)).y, ((Rect)(ref t.endValue)).width - ((Rect)(ref t.startValue)).width, ((Rect)(ref t.endValue)).height - ((Rect)(ref t.startValue)).height);
	}

	public override float GetSpeedBasedDuration(RectOptions options, float unitsXSecond, Rect changeValue)
	{
		float width = ((Rect)(ref changeValue)).width;
		float height = ((Rect)(ref changeValue)).height;
		return (float)Math.Sqrt(width * width + height * height) / unitsXSecond;
	}

	public override void EvaluateAndApply(RectOptions options, Tween t, bool isRelative, DOGetter<Rect> getter, DOSetter<Rect> setter, float elapsed, Rect startValue, Rect changeValue, float duration, bool usingInversePosition, int newCompletedSteps, UpdateNotice updateNotice)
	{
		//IL_0215: Unknown result type (might be due to invalid IL or missing references)
		if (t.loopType == LoopType.Incremental)
		{
			int num = (t.isComplete ? (t.completedLoops - 1) : t.completedLoops);
			((Rect)(ref startValue)).x = ((Rect)(ref startValue)).x + ((Rect)(ref changeValue)).x * (float)num;
			((Rect)(ref startValue)).y = ((Rect)(ref startValue)).y + ((Rect)(ref changeValue)).y * (float)num;
			((Rect)(ref startValue)).width = ((Rect)(ref startValue)).width + ((Rect)(ref changeValue)).width * (float)num;
			((Rect)(ref startValue)).height = ((Rect)(ref startValue)).height + ((Rect)(ref changeValue)).height * (float)num;
		}
		if (t.isSequenced && t.sequenceParent.loopType == LoopType.Incremental)
		{
			int num2 = ((t.loopType != LoopType.Incremental) ? 1 : t.loops) * (t.sequenceParent.isComplete ? (t.sequenceParent.completedLoops - 1) : t.sequenceParent.completedLoops);
			((Rect)(ref startValue)).x = ((Rect)(ref startValue)).x + ((Rect)(ref changeValue)).x * (float)num2;
			((Rect)(ref startValue)).y = ((Rect)(ref startValue)).y + ((Rect)(ref changeValue)).y * (float)num2;
			((Rect)(ref startValue)).width = ((Rect)(ref startValue)).width + ((Rect)(ref changeValue)).width * (float)num2;
			((Rect)(ref startValue)).height = ((Rect)(ref startValue)).height + ((Rect)(ref changeValue)).height * (float)num2;
		}
		float num3 = EaseManager.Evaluate(t.easeType, t.customEase, elapsed, duration, t.easeOvershootOrAmplitude, t.easePeriod);
		((Rect)(ref startValue)).x = ((Rect)(ref startValue)).x + ((Rect)(ref changeValue)).x * num3;
		((Rect)(ref startValue)).y = ((Rect)(ref startValue)).y + ((Rect)(ref changeValue)).y * num3;
		((Rect)(ref startValue)).width = ((Rect)(ref startValue)).width + ((Rect)(ref changeValue)).width * num3;
		((Rect)(ref startValue)).height = ((Rect)(ref startValue)).height + ((Rect)(ref changeValue)).height * num3;
		if (options.snapping)
		{
			((Rect)(ref startValue)).x = (float)Math.Round(((Rect)(ref startValue)).x);
			((Rect)(ref startValue)).y = (float)Math.Round(((Rect)(ref startValue)).y);
			((Rect)(ref startValue)).width = (float)Math.Round(((Rect)(ref startValue)).width);
			((Rect)(ref startValue)).height = (float)Math.Round(((Rect)(ref startValue)).height);
		}
		setter(startValue);
	}
}
