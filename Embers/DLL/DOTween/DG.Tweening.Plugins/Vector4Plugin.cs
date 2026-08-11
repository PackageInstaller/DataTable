using System;
using DG.Tweening.Core;
using DG.Tweening.Core.Easing;
using DG.Tweening.Core.Enums;
using DG.Tweening.Plugins.Core;
using DG.Tweening.Plugins.Options;
using UnityEngine;

namespace DG.Tweening.Plugins;

public class Vector4Plugin : ABSTweenPlugin<Vector4, Vector4, VectorOptions>
{
	public override void Reset(TweenerCore<Vector4, Vector4, VectorOptions> t)
	{
	}

	public override void SetFrom(TweenerCore<Vector4, Vector4, VectorOptions> t, bool isRelative)
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
		//IL_0116: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c2: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d6: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ea: Unknown result type (might be due to invalid IL or missing references)
		//IL_00fe: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ad: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b2: Unknown result type (might be due to invalid IL or missing references)
		Vector4 endValue = t.endValue;
		t.endValue = t.getter();
		t.startValue = (isRelative ? (t.endValue + endValue) : endValue);
		Vector4 val = t.endValue;
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
		case AxisConstraint.W:
			val.w = t.startValue.w;
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
			val.w = (float)Math.Round(val.w);
		}
		t.setter(val);
	}

	public override void SetFrom(TweenerCore<Vector4, Vector4, VectorOptions> t, Vector4 fromValue, bool setImmediately, bool isRelative)
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
		//IL_0099: Unknown result type (might be due to invalid IL or missing references)
		//IL_009e: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a1: Unknown result type (might be due to invalid IL or missing references)
		//IL_0063: Unknown result type (might be due to invalid IL or missing references)
		//IL_0068: Unknown result type (might be due to invalid IL or missing references)
		//IL_006b: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b4: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00bc: Unknown result type (might be due to invalid IL or missing references)
		//IL_007e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0083: Unknown result type (might be due to invalid IL or missing references)
		//IL_0086: Unknown result type (might be due to invalid IL or missing references)
		//IL_012e: Unknown result type (might be due to invalid IL or missing references)
		//IL_00da: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ee: Unknown result type (might be due to invalid IL or missing references)
		//IL_0102: Unknown result type (might be due to invalid IL or missing references)
		//IL_0116: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ca: Unknown result type (might be due to invalid IL or missing references)
		if (isRelative)
		{
			Vector4 val = t.getter();
			t.endValue += val;
			fromValue += val;
		}
		t.startValue = fromValue;
		if (setImmediately)
		{
			Vector4 val2;
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
			case AxisConstraint.W:
				val2 = t.getter();
				val2.w = fromValue.w;
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
				val2.w = (float)Math.Round(val2.w);
			}
			t.setter(val2);
		}
	}

	public override Vector4 ConvertToStartValue(TweenerCore<Vector4, Vector4, VectorOptions> t, Vector4 value)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		return value;
	}

	public override void SetRelativeEndValue(TweenerCore<Vector4, Vector4, VectorOptions> t)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0008: Unknown result type (might be due to invalid IL or missing references)
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0012: Unknown result type (might be due to invalid IL or missing references)
		t.endValue += t.startValue;
	}

	public override void SetChangeValue(TweenerCore<Vector4, Vector4, VectorOptions> t)
	{
		//IL_00b9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00be: Unknown result type (might be due to invalid IL or missing references)
		//IL_0055: Unknown result type (might be due to invalid IL or missing references)
		//IL_005a: Unknown result type (might be due to invalid IL or missing references)
		//IL_00eb: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f0: Unknown result type (might be due to invalid IL or missing references)
		//IL_0087: Unknown result type (might be due to invalid IL or missing references)
		//IL_008c: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f8: Unknown result type (might be due to invalid IL or missing references)
		//IL_00fe: Unknown result type (might be due to invalid IL or missing references)
		//IL_0103: Unknown result type (might be due to invalid IL or missing references)
		//IL_0108: Unknown result type (might be due to invalid IL or missing references)
		switch (t.plugOptions.axisConstraint)
		{
		case AxisConstraint.X:
			t.changeValue = new Vector4(t.endValue.x - t.startValue.x, 0f, 0f, 0f);
			break;
		case AxisConstraint.Y:
			t.changeValue = new Vector4(0f, t.endValue.y - t.startValue.y, 0f, 0f);
			break;
		case AxisConstraint.Z:
			t.changeValue = new Vector4(0f, 0f, t.endValue.z - t.startValue.z, 0f);
			break;
		case AxisConstraint.W:
			t.changeValue = new Vector4(0f, 0f, 0f, t.endValue.w - t.startValue.w);
			break;
		default:
			t.changeValue = t.endValue - t.startValue;
			break;
		}
	}

	public override float GetSpeedBasedDuration(VectorOptions options, float unitsXSecond, Vector4 changeValue)
	{
		return ((Vector4)(ref changeValue)).magnitude / unitsXSecond;
	}

	public override void EvaluateAndApply(VectorOptions options, Tween t, bool isRelative, DOGetter<Vector4> getter, DOSetter<Vector4> setter, float elapsed, Vector4 startValue, Vector4 changeValue, float duration, bool usingInversePosition, int newCompletedSteps, UpdateNotice updateNotice)
	{
		//IL_0009: Unknown result type (might be due to invalid IL or missing references)
		//IL_000b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0048: Unknown result type (might be due to invalid IL or missing references)
		//IL_004a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0026: Unknown result type (might be due to invalid IL or missing references)
		//IL_002b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0030: Unknown result type (might be due to invalid IL or missing references)
		//IL_0178: Unknown result type (might be due to invalid IL or missing references)
		//IL_017d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0180: Unknown result type (might be due to invalid IL or missing references)
		//IL_0187: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ee: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f3: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f6: Unknown result type (might be due to invalid IL or missing references)
		//IL_00fd: Unknown result type (might be due to invalid IL or missing references)
		//IL_01b4: Unknown result type (might be due to invalid IL or missing references)
		//IL_01a0: Unknown result type (might be due to invalid IL or missing references)
		//IL_01bd: Unknown result type (might be due to invalid IL or missing references)
		//IL_01c2: Unknown result type (might be due to invalid IL or missing references)
		//IL_01c6: Unknown result type (might be due to invalid IL or missing references)
		//IL_01cd: Unknown result type (might be due to invalid IL or missing references)
		//IL_012a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0116: Unknown result type (might be due to invalid IL or missing references)
		//IL_0133: Unknown result type (might be due to invalid IL or missing references)
		//IL_0138: Unknown result type (might be due to invalid IL or missing references)
		//IL_013b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0142: Unknown result type (might be due to invalid IL or missing references)
		//IL_005f: Unknown result type (might be due to invalid IL or missing references)
		//IL_01fb: Unknown result type (might be due to invalid IL or missing references)
		//IL_01e6: Unknown result type (might be due to invalid IL or missing references)
		//IL_020c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0220: Unknown result type (might be due to invalid IL or missing references)
		//IL_0234: Unknown result type (might be due to invalid IL or missing references)
		//IL_0248: Unknown result type (might be due to invalid IL or missing references)
		//IL_016f: Unknown result type (might be due to invalid IL or missing references)
		//IL_015b: Unknown result type (might be due to invalid IL or missing references)
		//IL_02b1: Unknown result type (might be due to invalid IL or missing references)
		//IL_025d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0272: Unknown result type (might be due to invalid IL or missing references)
		//IL_0287: Unknown result type (might be due to invalid IL or missing references)
		//IL_029c: Unknown result type (might be due to invalid IL or missing references)
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
			Vector4 val2 = getter();
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
			Vector4 val4 = getter();
			val4.y = startValue.y + changeValue.y * num;
			if (options.snapping)
			{
				val4.y = (float)Math.Round(val4.y);
			}
			setter(val4);
			return;
		}
		case AxisConstraint.Z:
		{
			Vector4 val = getter();
			val.z = startValue.z + changeValue.z * num;
			if (options.snapping)
			{
				val.z = (float)Math.Round(val.z);
			}
			setter(val);
			return;
		}
		case AxisConstraint.W:
		{
			Vector4 val3 = getter();
			val3.w = startValue.w + changeValue.w * num;
			if (options.snapping)
			{
				val3.w = (float)Math.Round(val3.w);
			}
			setter(val3);
			return;
		}
		}
		startValue.x += changeValue.x * num;
		startValue.y += changeValue.y * num;
		startValue.z += changeValue.z * num;
		startValue.w += changeValue.w * num;
		if (options.snapping)
		{
			startValue.x = (float)Math.Round(startValue.x);
			startValue.y = (float)Math.Round(startValue.y);
			startValue.z = (float)Math.Round(startValue.z);
			startValue.w = (float)Math.Round(startValue.w);
		}
		setter(startValue);
	}
}
