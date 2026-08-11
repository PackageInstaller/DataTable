using System;
using DG.Tweening.Core;
using DG.Tweening.Core.Easing;
using DG.Tweening.Core.Enums;
using DG.Tweening.Plugins.Core;
using DG.Tweening.Plugins.Options;
using UnityEngine;

namespace DG.Tweening.Plugins;

public class Vector3ArrayPlugin : ABSTweenPlugin<Vector3, Vector3[], Vector3ArrayOptions>
{
	public override void Reset(TweenerCore<Vector3, Vector3[], Vector3ArrayOptions> t)
	{
		t.startValue = (t.endValue = (t.changeValue = null));
	}

	public override void SetFrom(TweenerCore<Vector3, Vector3[], Vector3ArrayOptions> t, bool isRelative)
	{
	}

	public override void SetFrom(TweenerCore<Vector3, Vector3[], Vector3ArrayOptions> t, Vector3[] fromValue, bool setImmediately, bool isRelative)
	{
	}

	public override Vector3[] ConvertToStartValue(TweenerCore<Vector3, Vector3[], Vector3ArrayOptions> t, Vector3 value)
	{
		//IL_002c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0031: Unknown result type (might be due to invalid IL or missing references)
		//IL_0019: Unknown result type (might be due to invalid IL or missing references)
		//IL_001a: Unknown result type (might be due to invalid IL or missing references)
		int num = t.endValue.Length;
		Vector3[] array = (Vector3[])(object)new Vector3[num];
		for (int i = 0; i < num; i++)
		{
			if (i == 0)
			{
				array[i] = value;
			}
			else
			{
				array[i] = t.endValue[i - 1];
			}
		}
		return array;
	}

	public override void SetRelativeEndValue(TweenerCore<Vector3, Vector3[], Vector3ArrayOptions> t)
	{
		//IL_0039: Unknown result type (might be due to invalid IL or missing references)
		//IL_0045: Unknown result type (might be due to invalid IL or missing references)
		//IL_004a: Unknown result type (might be due to invalid IL or missing references)
		//IL_004f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		//IL_0026: Unknown result type (might be due to invalid IL or missing references)
		int num = t.endValue.Length;
		for (int i = 0; i < num; i++)
		{
			if (i > 0)
			{
				t.startValue[i] = t.endValue[i - 1];
			}
			t.endValue[i] = t.startValue[i] + t.endValue[i];
		}
	}

	public override void SetChangeValue(TweenerCore<Vector3, Vector3[], Vector3ArrayOptions> t)
	{
		//IL_0027: Unknown result type (might be due to invalid IL or missing references)
		//IL_0033: Unknown result type (might be due to invalid IL or missing references)
		//IL_0038: Unknown result type (might be due to invalid IL or missing references)
		//IL_003d: Unknown result type (might be due to invalid IL or missing references)
		int num = t.endValue.Length;
		t.changeValue = (Vector3[])(object)new Vector3[num];
		for (int i = 0; i < num; i++)
		{
			t.changeValue[i] = t.endValue[i] - t.startValue[i];
		}
	}

	public override float GetSpeedBasedDuration(Vector3ArrayOptions options, float unitsXSecond, Vector3[] changeValue)
	{
		float num = 0f;
		int num2 = changeValue.Length;
		for (int i = 0; i < num2; i++)
		{
			float num3 = ((Vector3)(ref changeValue[i])).magnitude / options.durations[i];
			options.durations[i] = num3;
			num += num3;
		}
		return num;
	}

	public override void EvaluateAndApply(Vector3ArrayOptions options, Tween t, bool isRelative, DOGetter<Vector3> getter, DOSetter<Vector3> setter, float elapsed, Vector3[] startValue, Vector3[] changeValue, float duration, bool usingInversePosition, int newCompletedSteps, UpdateNotice updateNotice)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0005: Unknown result type (might be due to invalid IL or missing references)
		//IL_003a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0043: Unknown result type (might be due to invalid IL or missing references)
		//IL_0048: Unknown result type (might be due to invalid IL or missing references)
		//IL_0050: Unknown result type (might be due to invalid IL or missing references)
		//IL_0055: Unknown result type (might be due to invalid IL or missing references)
		//IL_005d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0062: Unknown result type (might be due to invalid IL or missing references)
		//IL_0190: Unknown result type (might be due to invalid IL or missing references)
		//IL_0195: Unknown result type (might be due to invalid IL or missing references)
		//IL_01a6: Unknown result type (might be due to invalid IL or missing references)
		//IL_01e2: Unknown result type (might be due to invalid IL or missing references)
		//IL_01cd: Unknown result type (might be due to invalid IL or missing references)
		//IL_01ec: Unknown result type (might be due to invalid IL or missing references)
		//IL_01f1: Unknown result type (might be due to invalid IL or missing references)
		//IL_0202: Unknown result type (might be due to invalid IL or missing references)
		//IL_023e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0229: Unknown result type (might be due to invalid IL or missing references)
		//IL_0248: Unknown result type (might be due to invalid IL or missing references)
		//IL_024d: Unknown result type (might be due to invalid IL or missing references)
		//IL_025e: Unknown result type (might be due to invalid IL or missing references)
		//IL_029a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0285: Unknown result type (might be due to invalid IL or missing references)
		//IL_02b1: Unknown result type (might be due to invalid IL or missing references)
		//IL_02dd: Unknown result type (might be due to invalid IL or missing references)
		//IL_0309: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c5: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ca: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d3: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d8: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e0: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e5: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ed: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f2: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f7: Unknown result type (might be due to invalid IL or missing references)
		//IL_036f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0330: Unknown result type (might be due to invalid IL or missing references)
		//IL_0345: Unknown result type (might be due to invalid IL or missing references)
		//IL_035a: Unknown result type (might be due to invalid IL or missing references)
		Vector3 val = Vector3.zero;
		if (t.loopType == LoopType.Incremental)
		{
			int num = (t.isComplete ? (t.completedLoops - 1) : t.completedLoops);
			if (num > 0)
			{
				int num2 = startValue.Length - 1;
				val = (startValue[num2] + changeValue[num2] - startValue[0]) * (float)num;
			}
		}
		if (t.isSequenced && t.sequenceParent.loopType == LoopType.Incremental)
		{
			int num3 = ((t.loopType != LoopType.Incremental) ? 1 : t.loops) * (t.sequenceParent.isComplete ? (t.sequenceParent.completedLoops - 1) : t.sequenceParent.completedLoops);
			if (num3 > 0)
			{
				int num4 = startValue.Length - 1;
				val += (startValue[num4] + changeValue[num4] - startValue[0]) * (float)num3;
			}
		}
		int num5 = 0;
		float num6 = 0f;
		float num7 = 0f;
		int num8 = options.durations.Length;
		float num9 = 0f;
		for (int i = 0; i < num8; i++)
		{
			num7 = options.durations[i];
			num9 += num7;
			if (elapsed > num9)
			{
				num6 += num7;
				continue;
			}
			num5 = i;
			num6 = elapsed - num6;
			break;
		}
		float num10 = EaseManager.Evaluate(t.easeType, t.customEase, num6, num7, t.easeOvershootOrAmplitude, t.easePeriod);
		Vector3 val2 = default(Vector3);
		switch (options.axisConstraint)
		{
		case AxisConstraint.X:
			val2 = getter();
			val2.x = startValue[num5].x + val.x + changeValue[num5].x * num10;
			if (options.snapping)
			{
				val2.x = (float)Math.Round(val2.x);
			}
			setter(val2);
			return;
		case AxisConstraint.Y:
			val2 = getter();
			val2.y = startValue[num5].y + val.y + changeValue[num5].y * num10;
			if (options.snapping)
			{
				val2.y = (float)Math.Round(val2.y);
			}
			setter(val2);
			return;
		case AxisConstraint.Z:
			val2 = getter();
			val2.z = startValue[num5].z + val.z + changeValue[num5].z * num10;
			if (options.snapping)
			{
				val2.z = (float)Math.Round(val2.z);
			}
			setter(val2);
			return;
		}
		val2.x = startValue[num5].x + val.x + changeValue[num5].x * num10;
		val2.y = startValue[num5].y + val.y + changeValue[num5].y * num10;
		val2.z = startValue[num5].z + val.z + changeValue[num5].z * num10;
		if (options.snapping)
		{
			val2.x = (float)Math.Round(val2.x);
			val2.y = (float)Math.Round(val2.y);
			val2.z = (float)Math.Round(val2.z);
		}
		setter(val2);
	}
}
