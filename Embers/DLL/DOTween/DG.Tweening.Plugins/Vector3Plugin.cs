using System;
using DG.Tweening.Core;
using DG.Tweening.Core.Easing;
using DG.Tweening.Core.Enums;
using DG.Tweening.Plugins.Core;
using DG.Tweening.Plugins.Options;
using UnityEngine;

namespace DG.Tweening.Plugins;

public class Vector3Plugin : ABSTweenPlugin<Vector3, Vector3, VectorOptions>
{
	public override void Reset(TweenerCore<Vector3, Vector3, VectorOptions> t)
	{
	}

	public override void SetFrom(TweenerCore<Vector3, Vector3, VectorOptions> t, bool isRelative)
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
		//IL_00e3: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a3: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b7: Unknown result type (might be due to invalid IL or missing references)
		//IL_00cb: Unknown result type (might be due to invalid IL or missing references)
		//IL_008e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0093: Unknown result type (might be due to invalid IL or missing references)
		Vector3 endValue = t.endValue;
		t.endValue = t.getter();
		t.startValue = (isRelative ? (t.endValue + endValue) : endValue);
		Vector3 val = t.endValue;
		switch (t.plugOptions.axisConstraint)
		{
		case AxisConstraint.X:
			val.x = t.startValue.x;
			break;
		case AxisConstraint.Y:
			val.y = t.startValue.y;
			break;
		case AxisConstraint.Z:
			val.z = t.startValue.z;
			break;
		default:
			val = t.startValue;
			break;
		}
		if (t.plugOptions.snapping)
		{
			val.x = (float)Math.Round(val.x);
			val.y = (float)Math.Round(val.y);
			val.z = (float)Math.Round(val.z);
		}
		t.setter(val);
	}

	public override void SetFrom(TweenerCore<Vector3, Vector3, VectorOptions> t, Vector3 fromValue, bool setImmediately, bool isRelative)
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
		//IL_0058: Unknown result type (might be due to invalid IL or missing references)
		//IL_005d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0060: Unknown result type (might be due to invalid IL or missing references)
		//IL_0073: Unknown result type (might be due to invalid IL or missing references)
		//IL_0078: Unknown result type (might be due to invalid IL or missing references)
		//IL_007b: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f4: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b4: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c8: Unknown result type (might be due to invalid IL or missing references)
		//IL_00dc: Unknown result type (might be due to invalid IL or missing references)
		//IL_008e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0093: Unknown result type (might be due to invalid IL or missing references)
		//IL_0096: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a3: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a4: Unknown result type (might be due to invalid IL or missing references)
		if (isRelative)
		{
			Vector3 val = t.getter();
			t.endValue += val;
			fromValue += val;
		}
		t.startValue = fromValue;
		if (setImmediately)
		{
			Vector3 val2;
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
			case AxisConstraint.Z:
				val2 = t.getter();
				val2.z = fromValue.z;
				break;
			default:
				val2 = fromValue;
				break;
			}
			if (t.plugOptions.snapping)
			{
				val2.x = (float)Math.Round(val2.x);
				val2.y = (float)Math.Round(val2.y);
				val2.z = (float)Math.Round(val2.z);
			}
			t.setter(val2);
		}
	}

	public override Vector3 ConvertToStartValue(TweenerCore<Vector3, Vector3, VectorOptions> t, Vector3 value)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		return value;
	}

	public override void SetRelativeEndValue(TweenerCore<Vector3, Vector3, VectorOptions> t)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0008: Unknown result type (might be due to invalid IL or missing references)
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0012: Unknown result type (might be due to invalid IL or missing references)
		t.endValue += t.startValue;
	}

	public override void SetChangeValue(TweenerCore<Vector3, Vector3, VectorOptions> t)
	{
		//IL_003f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0044: Unknown result type (might be due to invalid IL or missing references)
		//IL_006c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0071: Unknown result type (might be due to invalid IL or missing references)
		//IL_0099: Unknown result type (might be due to invalid IL or missing references)
		//IL_009e: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a6: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ac: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b1: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b6: Unknown result type (might be due to invalid IL or missing references)
		switch (t.plugOptions.axisConstraint)
		{
		case AxisConstraint.X:
			t.changeValue = new Vector3(t.endValue.x - t.startValue.x, 0f, 0f);
			break;
		case AxisConstraint.Y:
			t.changeValue = new Vector3(0f, t.endValue.y - t.startValue.y, 0f);
			break;
		case AxisConstraint.Z:
			t.changeValue = new Vector3(0f, 0f, t.endValue.z - t.startValue.z);
			break;
		default:
			t.changeValue = t.endValue - t.startValue;
			break;
		}
	}

	public override float GetSpeedBasedDuration(VectorOptions options, float unitsXSecond, Vector3 changeValue)
	{
		return ((Vector3)(ref changeValue)).magnitude / unitsXSecond;
	}

	public override void EvaluateAndApply(VectorOptions options, Tween t, bool isRelative, DOGetter<Vector3> getter, DOSetter<Vector3> setter, float elapsed, Vector3 startValue, Vector3 changeValue, float duration, bool usingInversePosition, int newCompletedSteps, UpdateNotice updateNotice)
	{
		//IL_0009: Unknown result type (might be due to invalid IL or missing references)
		//IL_000b: Unknown result type (might be due to invalid IL or missing references)
		//IL_00db: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e0: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e3: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ea: Unknown result type (might be due to invalid IL or missing references)
		//IL_0048: Unknown result type (might be due to invalid IL or missing references)
		//IL_004a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0026: Unknown result type (might be due to invalid IL or missing references)
		//IL_002b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0030: Unknown result type (might be due to invalid IL or missing references)
		//IL_0117: Unknown result type (might be due to invalid IL or missing references)
		//IL_0103: Unknown result type (might be due to invalid IL or missing references)
		//IL_0120: Unknown result type (might be due to invalid IL or missing references)
		//IL_0125: Unknown result type (might be due to invalid IL or missing references)
		//IL_0128: Unknown result type (might be due to invalid IL or missing references)
		//IL_012f: Unknown result type (might be due to invalid IL or missing references)
		//IL_015c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0148: Unknown result type (might be due to invalid IL or missing references)
		//IL_0165: Unknown result type (might be due to invalid IL or missing references)
		//IL_016a: Unknown result type (might be due to invalid IL or missing references)
		//IL_016d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0174: Unknown result type (might be due to invalid IL or missing references)
		//IL_005f: Unknown result type (might be due to invalid IL or missing references)
		//IL_01a1: Unknown result type (might be due to invalid IL or missing references)
		//IL_018d: Unknown result type (might be due to invalid IL or missing references)
		//IL_01b1: Unknown result type (might be due to invalid IL or missing references)
		//IL_01c5: Unknown result type (might be due to invalid IL or missing references)
		//IL_01d9: Unknown result type (might be due to invalid IL or missing references)
		//IL_022d: Unknown result type (might be due to invalid IL or missing references)
		//IL_01ee: Unknown result type (might be due to invalid IL or missing references)
		//IL_0203: Unknown result type (might be due to invalid IL or missing references)
		//IL_0218: Unknown result type (might be due to invalid IL or missing references)
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
			Vector3 val2 = getter();
			val2.x = startValue.x + changeValue.x * num;
			if (options.snapping)
			{
				val2.x = (float)Math.Round(val2.x);
			}
			setter(val2);
			return;
		}
		case AxisConstraint.Y:
		{
			Vector3 val = getter();
			val.y = startValue.y + changeValue.y * num;
			if (options.snapping)
			{
				val.y = (float)Math.Round(val.y);
			}
			setter(val);
			return;
		}
		case AxisConstraint.Z:
		{
			Vector3 val3 = getter();
			val3.z = startValue.z + changeValue.z * num;
			if (options.snapping)
			{
				val3.z = (float)Math.Round(val3.z);
			}
			setter(val3);
			return;
		}
		}
		startValue.x += changeValue.x * num;
		startValue.y += changeValue.y * num;
		startValue.z += changeValue.z * num;
		if (options.snapping)
		{
			startValue.x = (float)Math.Round(startValue.x);
			startValue.y = (float)Math.Round(startValue.y);
			startValue.z = (float)Math.Round(startValue.z);
		}
		setter(startValue);
	}
}
