using System;
using DG.Tweening.Core;
using DG.Tweening.Core.Easing;
using DG.Tweening.Core.Enums;
using DG.Tweening.Plugins.Core;
using DG.Tweening.Plugins.Options;
using UnityEngine;

namespace DG.Tweening.Plugins;

public class Vector2Plugin : ABSTweenPlugin<Vector2, Vector2, VectorOptions>
{
	public override void Reset(TweenerCore<Vector2, Vector2, VectorOptions> t)
	{
	}

	public override void SetFrom(TweenerCore<Vector2, Vector2, VectorOptions> t, bool isRelative)
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
		//IL_0031: Unknown result type (might be due to invalid IL or missing references)
		//IL_0036: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b7: Unknown result type (might be due to invalid IL or missing references)
		//IL_008b: Unknown result type (might be due to invalid IL or missing references)
		//IL_009f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0076: Unknown result type (might be due to invalid IL or missing references)
		//IL_007b: Unknown result type (might be due to invalid IL or missing references)
		Vector2 endValue = t.endValue;
		t.endValue = t.getter();
		t.startValue = (isRelative ? (t.endValue + endValue) : endValue);
		Vector2 val = t.endValue;
		switch (t.plugOptions.axisConstraint)
		{
		case AxisConstraint.X:
			val.x = t.startValue.x;
			break;
		case AxisConstraint.Y:
			val.y = t.startValue.y;
			break;
		default:
			val = t.startValue;
			break;
		}
		if (t.plugOptions.snapping)
		{
			val.x = (float)Math.Round(val.x);
			val.y = (float)Math.Round(val.y);
		}
		t.setter(val);
	}

	public override void SetFrom(TweenerCore<Vector2, Vector2, VectorOptions> t, Vector2 fromValue, bool setImmediately, bool isRelative)
	{
		//IL_002c: Unknown result type (might be due to invalid IL or missing references)
		//IL_002d: Unknown result type (might be due to invalid IL or missing references)
		//IL_000a: Unknown result type (might be due to invalid IL or missing references)
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0012: Unknown result type (might be due to invalid IL or missing references)
		//IL_0017: Unknown result type (might be due to invalid IL or missing references)
		//IL_0018: Unknown result type (might be due to invalid IL or missing references)
		//IL_001d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0022: Unknown result type (might be due to invalid IL or missing references)
		//IL_0023: Unknown result type (might be due to invalid IL or missing references)
		//IL_0024: Unknown result type (might be due to invalid IL or missing references)
		//IL_0029: Unknown result type (might be due to invalid IL or missing references)
		//IL_0054: Unknown result type (might be due to invalid IL or missing references)
		//IL_0059: Unknown result type (might be due to invalid IL or missing references)
		//IL_005c: Unknown result type (might be due to invalid IL or missing references)
		//IL_006f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0074: Unknown result type (might be due to invalid IL or missing references)
		//IL_0077: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c1: Unknown result type (might be due to invalid IL or missing references)
		//IL_0095: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a9: Unknown result type (might be due to invalid IL or missing references)
		//IL_0084: Unknown result type (might be due to invalid IL or missing references)
		//IL_0085: Unknown result type (might be due to invalid IL or missing references)
		if (isRelative)
		{
			Vector2 val = t.getter();
			t.endValue += val;
			fromValue += val;
		}
		t.startValue = fromValue;
		if (setImmediately)
		{
			Vector2 val2;
			switch (t.plugOptions.axisConstraint)
			{
			case AxisConstraint.X:
				val2 = t.getter();
				val2.x = fromValue.x;
				break;
			case AxisConstraint.Y:
				val2 = t.getter();
				val2.y = fromValue.y;
				break;
			default:
				val2 = fromValue;
				break;
			}
			if (t.plugOptions.snapping)
			{
				val2.x = (float)Math.Round(val2.x);
				val2.y = (float)Math.Round(val2.y);
			}
			t.setter(val2);
		}
	}

	public override Vector2 ConvertToStartValue(TweenerCore<Vector2, Vector2, VectorOptions> t, Vector2 value)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		return value;
	}

	public override void SetRelativeEndValue(TweenerCore<Vector2, Vector2, VectorOptions> t)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0008: Unknown result type (might be due to invalid IL or missing references)
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0012: Unknown result type (might be due to invalid IL or missing references)
		t.endValue += t.startValue;
	}

	public override void SetChangeValue(TweenerCore<Vector2, Vector2, VectorOptions> t)
	{
		//IL_0033: Unknown result type (might be due to invalid IL or missing references)
		//IL_0038: Unknown result type (might be due to invalid IL or missing references)
		//IL_005b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0060: Unknown result type (might be due to invalid IL or missing references)
		//IL_0068: Unknown result type (might be due to invalid IL or missing references)
		//IL_006e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0073: Unknown result type (might be due to invalid IL or missing references)
		//IL_0078: Unknown result type (might be due to invalid IL or missing references)
		switch (t.plugOptions.axisConstraint)
		{
		case AxisConstraint.X:
			t.changeValue = new Vector2(t.endValue.x - t.startValue.x, 0f);
			break;
		case AxisConstraint.Y:
			t.changeValue = new Vector2(0f, t.endValue.y - t.startValue.y);
			break;
		default:
			t.changeValue = t.endValue - t.startValue;
			break;
		}
	}

	public override float GetSpeedBasedDuration(VectorOptions options, float unitsXSecond, Vector2 changeValue)
	{
		return ((Vector2)(ref changeValue)).magnitude / unitsXSecond;
	}

	public override void EvaluateAndApply(VectorOptions options, Tween t, bool isRelative, DOGetter<Vector2> getter, DOSetter<Vector2> setter, float elapsed, Vector2 startValue, Vector2 changeValue, float duration, bool usingInversePosition, int newCompletedSteps, UpdateNotice updateNotice)
	{
		//IL_0009: Unknown result type (might be due to invalid IL or missing references)
		//IL_000b: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d0: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d5: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d8: Unknown result type (might be due to invalid IL or missing references)
		//IL_00df: Unknown result type (might be due to invalid IL or missing references)
		//IL_0048: Unknown result type (might be due to invalid IL or missing references)
		//IL_004a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0026: Unknown result type (might be due to invalid IL or missing references)
		//IL_002b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0030: Unknown result type (might be due to invalid IL or missing references)
		//IL_010c: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f8: Unknown result type (might be due to invalid IL or missing references)
		//IL_0115: Unknown result type (might be due to invalid IL or missing references)
		//IL_011a: Unknown result type (might be due to invalid IL or missing references)
		//IL_011d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0124: Unknown result type (might be due to invalid IL or missing references)
		//IL_0151: Unknown result type (might be due to invalid IL or missing references)
		//IL_013d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0161: Unknown result type (might be due to invalid IL or missing references)
		//IL_0175: Unknown result type (might be due to invalid IL or missing references)
		//IL_005f: Unknown result type (might be due to invalid IL or missing references)
		//IL_01b4: Unknown result type (might be due to invalid IL or missing references)
		//IL_018a: Unknown result type (might be due to invalid IL or missing references)
		//IL_019f: Unknown result type (might be due to invalid IL or missing references)
		//IL_008c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0091: Unknown result type (might be due to invalid IL or missing references)
		//IL_0096: Unknown result type (might be due to invalid IL or missing references)
		if (t.loopType == LoopType.Incremental)
		{
			startValue += changeValue * (float)(t.isComplete ? (t.completedLoops - 1) : t.completedLoops);
		}
		if (t.isSequenced && t.sequenceParent.loopType == LoopType.Incremental)
		{
			startValue += changeValue * (float)((t.loopType != LoopType.Incremental) ? 1 : t.loops) * (float)(t.sequenceParent.isComplete ? (t.sequenceParent.completedLoops - 1) : t.sequenceParent.completedLoops);
		}
		float num = EaseManager.Evaluate(t.easeType, t.customEase, elapsed, duration, t.easeOvershootOrAmplitude, t.easePeriod);
		switch (options.axisConstraint)
		{
		case AxisConstraint.X:
		{
			Vector2 val = getter();
			val.x = startValue.x + changeValue.x * num;
			if (options.snapping)
			{
				val.x = (float)Math.Round(val.x);
			}
			setter(val);
			return;
		}
		case AxisConstraint.Y:
		{
			Vector2 val2 = getter();
			val2.y = startValue.y + changeValue.y * num;
			if (options.snapping)
			{
				val2.y = (float)Math.Round(val2.y);
			}
			setter(val2);
			return;
		}
		}
		startValue.x += changeValue.x * num;
		startValue.y += changeValue.y * num;
		if (options.snapping)
		{
			startValue.x = (float)Math.Round(startValue.x);
			startValue.y = (float)Math.Round(startValue.y);
		}
		setter(startValue);
	}
}
