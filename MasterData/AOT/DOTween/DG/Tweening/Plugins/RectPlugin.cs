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
			startValue.x += t.endValue.x;
			ref Rect startValue2 = ref t.startValue;
			startValue2.y += t.endValue.y;
			ref Rect startValue3 = ref t.startValue;
			startValue3.width += t.endValue.width;
			ref Rect startValue4 = ref t.startValue;
			startValue4.height += t.endValue.height;
		}
		Rect startValue5 = t.startValue;
		if (t.plugOptions.snapping)
		{
			startValue5.x = (float)Math.Round(startValue5.x);
			startValue5.y = (float)Math.Round(startValue5.y);
			startValue5.width = (float)Math.Round(startValue5.width);
			startValue5.height = (float)Math.Round(startValue5.height);
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
			endValue.x += val.x;
			ref Rect endValue2 = ref t.endValue;
			endValue2.y += val.y;
			ref Rect endValue3 = ref t.endValue;
			endValue3.width += val.width;
			ref Rect endValue4 = ref t.endValue;
			endValue4.height += val.height;
			fromValue.x += val.x;
			fromValue.y += val.y;
			fromValue.width += val.width;
			fromValue.height += val.height;
		}
		t.startValue = fromValue;
		if (setImmediately)
		{
			Rect pNewValue = fromValue;
			if (t.plugOptions.snapping)
			{
				pNewValue.x = (float)Math.Round(pNewValue.x);
				pNewValue.y = (float)Math.Round(pNewValue.y);
				pNewValue.width = (float)Math.Round(pNewValue.width);
				pNewValue.height = (float)Math.Round(pNewValue.height);
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
		endValue.x += t.startValue.x;
		ref Rect endValue2 = ref t.endValue;
		endValue2.y += t.startValue.y;
		ref Rect endValue3 = ref t.endValue;
		endValue3.width += t.startValue.width;
		ref Rect endValue4 = ref t.endValue;
		endValue4.height += t.startValue.height;
	}

	public override void SetChangeValue(TweenerCore<Rect, Rect, RectOptions> t)
	{
		//IL_005d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0062: Unknown result type (might be due to invalid IL or missing references)
		t.changeValue = new Rect(t.endValue.x - t.startValue.x, t.endValue.y - t.startValue.y, t.endValue.width - t.startValue.width, t.endValue.height - t.startValue.height);
	}

	public override float GetSpeedBasedDuration(RectOptions options, float unitsXSecond, Rect changeValue)
	{
		float width = changeValue.width;
		float height = changeValue.height;
		return (float)Math.Sqrt(width * width + height * height) / unitsXSecond;
	}

	public override void EvaluateAndApply(RectOptions options, Tween t, bool isRelative, DOGetter<Rect> getter, DOSetter<Rect> setter, float elapsed, Rect startValue, Rect changeValue, float duration, bool usingInversePosition, int newCompletedSteps, UpdateNotice updateNotice)
	{
		//IL_0215: Unknown result type (might be due to invalid IL or missing references)
		if (t.loopType == LoopType.Incremental)
		{
			int num = (t.isComplete ? (t.completedLoops - 1) : t.completedLoops);
			startValue.x += changeValue.x * (float)num;
			startValue.y += changeValue.y * (float)num;
			startValue.width += changeValue.width * (float)num;
			startValue.height += changeValue.height * (float)num;
		}
		if (t.isSequenced && t.sequenceParent.loopType == LoopType.Incremental)
		{
			int num2 = ((t.loopType != LoopType.Incremental) ? 1 : t.loops) * (t.sequenceParent.isComplete ? (t.sequenceParent.completedLoops - 1) : t.sequenceParent.completedLoops);
			startValue.x += changeValue.x * (float)num2;
			startValue.y += changeValue.y * (float)num2;
			startValue.width += changeValue.width * (float)num2;
			startValue.height += changeValue.height * (float)num2;
		}
		float num3 = EaseManager.Evaluate(t.easeType, t.customEase, elapsed, duration, t.easeOvershootOrAmplitude, t.easePeriod);
		startValue.x += changeValue.x * num3;
		startValue.y += changeValue.y * num3;
		startValue.width += changeValue.width * num3;
		startValue.height += changeValue.height * num3;
		if (options.snapping)
		{
			startValue.x = (float)Math.Round(startValue.x);
			startValue.y = (float)Math.Round(startValue.y);
			startValue.width = (float)Math.Round(startValue.width);
			startValue.height = (float)Math.Round(startValue.height);
		}
		setter(startValue);
	}
}
