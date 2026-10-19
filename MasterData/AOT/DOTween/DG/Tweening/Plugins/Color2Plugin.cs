using DG.Tweening.Core;
using DG.Tweening.Core.Easing;
using DG.Tweening.Core.Enums;
using DG.Tweening.Plugins.Core;
using DG.Tweening.Plugins.Options;

namespace DG.Tweening.Plugins;

internal class Color2Plugin : ABSTweenPlugin<Color2, Color2, ColorOptions>
{
	public override void Reset(TweenerCore<Color2, Color2, ColorOptions> t)
	{
	}

	public override void SetFrom(TweenerCore<Color2, Color2, ColorOptions> t, bool isRelative)
	{
		//IL_0056: Unknown result type (might be due to invalid IL or missing references)
		//IL_005c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0022: Unknown result type (might be due to invalid IL or missing references)
		//IL_0028: Unknown result type (might be due to invalid IL or missing references)
		//IL_002d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0038: Unknown result type (might be due to invalid IL or missing references)
		//IL_003e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0043: Unknown result type (might be due to invalid IL or missing references)
		Color2 endValue = t.endValue;
		t.endValue = t.getter();
		if (isRelative)
		{
			t.startValue = new Color2(t.endValue.ca + endValue.ca, t.endValue.cb + endValue.cb);
		}
		else
		{
			t.startValue = new Color2(endValue.ca, endValue.cb);
		}
		Color2 pNewValue = t.endValue;
		if (!t.plugOptions.alphaOnly)
		{
			pNewValue = t.startValue;
		}
		else
		{
			pNewValue.ca.a = t.startValue.ca.a;
			pNewValue.cb.a = t.startValue.cb.a;
		}
		t.setter(pNewValue);
	}

	public override void SetFrom(TweenerCore<Color2, Color2, ColorOptions> t, Color2 fromValue, bool setImmediately, bool isRelative)
	{
		//IL_0058: Unknown result type (might be due to invalid IL or missing references)
		//IL_006f: Unknown result type (might be due to invalid IL or missing references)
		if (isRelative)
		{
			Color2 color = t.getter();
			t.endValue += color;
			fromValue += color;
		}
		t.startValue = fromValue;
		if (setImmediately)
		{
			Color2 pNewValue = fromValue;
			if (t.plugOptions.alphaOnly)
			{
				pNewValue = t.getter();
				pNewValue.ca.a = fromValue.ca.a;
				pNewValue.cb.a = fromValue.cb.a;
			}
			t.setter(pNewValue);
		}
	}

	public override Color2 ConvertToStartValue(TweenerCore<Color2, Color2, ColorOptions> t, Color2 value)
	{
		return value;
	}

	public override void SetRelativeEndValue(TweenerCore<Color2, Color2, ColorOptions> t)
	{
		t.endValue += t.startValue;
	}

	public override void SetChangeValue(TweenerCore<Color2, Color2, ColorOptions> t)
	{
		t.changeValue = t.endValue - t.startValue;
	}

	public override float GetSpeedBasedDuration(ColorOptions options, float unitsXSecond, Color2 changeValue)
	{
		return 1f / unitsXSecond;
	}

	public override void EvaluateAndApply(ColorOptions options, Tween t, bool isRelative, DOGetter<Color2> getter, DOSetter<Color2> setter, float elapsed, Color2 startValue, Color2 changeValue, float duration, bool usingInversePosition, int newCompletedSteps, UpdateNotice updateNotice)
	{
		//IL_01d0: Unknown result type (might be due to invalid IL or missing references)
		//IL_01dc: Unknown result type (might be due to invalid IL or missing references)
		//IL_01f7: Unknown result type (might be due to invalid IL or missing references)
		//IL_0203: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d5: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f3: Unknown result type (might be due to invalid IL or missing references)
		//IL_0111: Unknown result type (might be due to invalid IL or missing references)
		//IL_012f: Unknown result type (might be due to invalid IL or missing references)
		//IL_014d: Unknown result type (might be due to invalid IL or missing references)
		//IL_016b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0189: Unknown result type (might be due to invalid IL or missing references)
		//IL_01a7: Unknown result type (might be due to invalid IL or missing references)
		if (t.loopType == LoopType.Incremental)
		{
			startValue += changeValue * (t.isComplete ? (t.completedLoops - 1) : t.completedLoops);
		}
		if (t.isSequenced && t.sequenceParent.loopType == LoopType.Incremental)
		{
			startValue += changeValue * ((t.loopType != LoopType.Incremental) ? 1 : t.loops) * (t.sequenceParent.isComplete ? (t.sequenceParent.completedLoops - 1) : t.sequenceParent.completedLoops);
		}
		float num = EaseManager.Evaluate(t.easeType, t.customEase, elapsed, duration, t.easeOvershootOrAmplitude, t.easePeriod);
		if (!options.alphaOnly)
		{
			startValue.ca.r += changeValue.ca.r * num;
			startValue.ca.g += changeValue.ca.g * num;
			startValue.ca.b += changeValue.ca.b * num;
			startValue.ca.a += changeValue.ca.a * num;
			startValue.cb.r += changeValue.cb.r * num;
			startValue.cb.g += changeValue.cb.g * num;
			startValue.cb.b += changeValue.cb.b * num;
			startValue.cb.a += changeValue.cb.a * num;
			setter(startValue);
		}
		else
		{
			Color2 pNewValue = getter();
			pNewValue.ca.a = startValue.ca.a + changeValue.ca.a * num;
			pNewValue.cb.a = startValue.cb.a + changeValue.cb.a * num;
			setter(pNewValue);
		}
	}
}
