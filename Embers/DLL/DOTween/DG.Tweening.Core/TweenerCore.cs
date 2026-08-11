using System;
using DG.Tweening.Core.Enums;
using DG.Tweening.Plugins.Core;
using DG.Tweening.Plugins.Options;
using UnityEngine;

namespace DG.Tweening.Core;

public class TweenerCore<T1, T2, TPlugOptions> : Tweener where TPlugOptions : struct, IPlugOptions
{
	public T2 startValue;

	public T2 endValue;

	public T2 changeValue;

	public TPlugOptions plugOptions;

	public DOGetter<T1> getter;

	public DOSetter<T1> setter;

	internal ABSTweenPlugin<T1, T2, TPlugOptions> tweenPlugin;

	private const string _TxtCantChangeSequencedValues = "You cannot change the values of a tween contained inside a Sequence";

	private Type _colorType = typeof(Color);

	private Type _color32Type = typeof(Color32);

	internal TweenerCore()
	{
		typeofT1 = typeof(T1);
		typeofT2 = typeof(T2);
		typeofTPlugOptions = typeof(TPlugOptions);
		tweenType = TweenType.Tweener;
		Reset();
	}

	public override Tweener ChangeStartValue(object newStartValue, float newDuration = -1f)
	{
		//IL_007c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0081: Unknown result type (might be due to invalid IL or missing references)
		if (isSequenced)
		{
			Debugger.LogError("You cannot change the values of a tween contained inside a Sequence", this);
			return this;
		}
		Type type = newStartValue.GetType();
		if (!ValidateChangeValueType(type, out var isColor32ToColor))
		{
			Debugger.LogError("ChangeStartValue: incorrect newStartValue type (is " + type?.ToString() + ", should be " + typeofT2?.ToString() + ")", this);
			return this;
		}
		if (isColor32ToColor)
		{
			return Tweener.DoChangeStartValue(this, (T2)(object)Color32.op_Implicit((Color32)newStartValue), newDuration);
		}
		return Tweener.DoChangeStartValue(this, (T2)newStartValue, newDuration);
	}

	public override Tweener ChangeEndValue(object newEndValue, bool snapStartValue)
	{
		return ChangeEndValue(newEndValue, -1f, snapStartValue);
	}

	public override Tweener ChangeEndValue(object newEndValue, float newDuration = -1f, bool snapStartValue = false)
	{
		//IL_007c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0081: Unknown result type (might be due to invalid IL or missing references)
		if (isSequenced)
		{
			Debugger.LogError("You cannot change the values of a tween contained inside a Sequence", this);
			return this;
		}
		Type type = newEndValue.GetType();
		if (!ValidateChangeValueType(type, out var isColor32ToColor))
		{
			Debugger.LogError("ChangeEndValue: incorrect newEndValue type (is " + type?.ToString() + ", should be " + typeofT2?.ToString() + ")", this);
			return this;
		}
		if (isColor32ToColor)
		{
			return Tweener.DoChangeEndValue(this, (T2)(object)Color32.op_Implicit((Color32)newEndValue), newDuration, snapStartValue);
		}
		return Tweener.DoChangeEndValue(this, (T2)newEndValue, newDuration, snapStartValue);
	}

	public override Tweener ChangeValues(object newStartValue, object newEndValue, float newDuration = -1f)
	{
		//IL_00de: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e3: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f3: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f8: Unknown result type (might be due to invalid IL or missing references)
		if (isSequenced)
		{
			Debugger.LogError("You cannot change the values of a tween contained inside a Sequence", this);
			return this;
		}
		Type type = newStartValue.GetType();
		Type type2 = newEndValue.GetType();
		if (!ValidateChangeValueType(type, out var isColor32ToColor))
		{
			Debugger.LogError("ChangeValues: incorrect value type (is " + type?.ToString() + ", should be " + typeofT2?.ToString() + ")", this);
			return this;
		}
		if (!ValidateChangeValueType(type2, out isColor32ToColor))
		{
			Debugger.LogError("ChangeValues: incorrect value type (is " + type2?.ToString() + ", should be " + typeofT2?.ToString() + ")", this);
			return this;
		}
		if (isColor32ToColor)
		{
			return Tweener.DoChangeValues(this, (T2)(object)Color32.op_Implicit((Color32)newStartValue), (T2)(object)Color32.op_Implicit((Color32)newEndValue), newDuration);
		}
		return Tweener.DoChangeValues(this, (T2)newStartValue, (T2)newEndValue, newDuration);
	}

	public TweenerCore<T1, T2, TPlugOptions> ChangeStartValue(T2 newStartValue, float newDuration = -1f)
	{
		if (isSequenced)
		{
			Debugger.LogError("You cannot change the values of a tween contained inside a Sequence", this);
			return this;
		}
		return Tweener.DoChangeStartValue(this, newStartValue, newDuration);
	}

	public TweenerCore<T1, T2, TPlugOptions> ChangeEndValue(T2 newEndValue, bool snapStartValue)
	{
		return ChangeEndValue(newEndValue, -1f, snapStartValue);
	}

	public TweenerCore<T1, T2, TPlugOptions> ChangeEndValue(T2 newEndValue, float newDuration = -1f, bool snapStartValue = false)
	{
		if (isSequenced)
		{
			Debugger.LogError("You cannot change the values of a tween contained inside a Sequence", this);
			return this;
		}
		return Tweener.DoChangeEndValue(this, newEndValue, newDuration, snapStartValue);
	}

	public TweenerCore<T1, T2, TPlugOptions> ChangeValues(T2 newStartValue, T2 newEndValue, float newDuration = -1f)
	{
		if (isSequenced)
		{
			Debugger.LogError("You cannot change the values of a tween contained inside a Sequence", this);
			return this;
		}
		return Tweener.DoChangeValues(this, newStartValue, newEndValue, newDuration);
	}

	internal override Tweener SetFrom(bool relative)
	{
		tweenPlugin.SetFrom(this, relative);
		hasManuallySetStartValue = true;
		return this;
	}

	internal Tweener SetFrom(T2 fromValue, bool setImmediately, bool relative)
	{
		tweenPlugin.SetFrom(this, fromValue, setImmediately, relative);
		hasManuallySetStartValue = true;
		return this;
	}

	internal sealed override void Reset()
	{
		base.Reset();
		if (tweenPlugin != null)
		{
			tweenPlugin.Reset(this);
		}
		plugOptions.Reset();
		getter = null;
		setter = null;
		hasManuallySetStartValue = false;
		isFromAllowed = true;
	}

	internal override bool Validate()
	{
		try
		{
			getter();
		}
		catch
		{
			return false;
		}
		return true;
	}

	private bool ValidateChangeValueType(Type newType, out bool isColor32ToColor)
	{
		if ((object)newType == typeofT2)
		{
			isColor32ToColor = false;
			return true;
		}
		if ((object)typeofT2 == _colorType && (object)newType == _color32Type)
		{
			isColor32ToColor = true;
			return true;
		}
		isColor32ToColor = false;
		return false;
	}

	internal override float UpdateDelay(float elapsed)
	{
		return Tweener.DoUpdateDelay(this, elapsed);
	}

	internal override bool Startup()
	{
		return Tweener.DoStartup(this);
	}

	internal override bool ApplyTween(float prevPosition, int prevCompletedLoops, int newCompletedSteps, bool useInversePosition, UpdateMode updateMode, UpdateNotice updateNotice)
	{
		if (isInverted)
		{
			useInversePosition = !useInversePosition;
		}
		float elapsed = (useInversePosition ? (duration - base.position) : base.position);
		if (DOTween.useSafeMode)
		{
			try
			{
				tweenPlugin.EvaluateAndApply(plugOptions, this, base.isRelative, getter, setter, elapsed, startValue, changeValue, duration, useInversePosition, newCompletedSteps, updateNotice);
			}
			catch (Exception ex)
			{
				if (Debugger.ShouldLogSafeModeCapturedError())
				{
					Debugger.LogSafeModeCapturedError($"Target or field is missing/null ({ex.TargetSite}) ► {ex.Message}\n\n{ex.StackTrace}\n\n", this);
				}
				DOTween.safeModeReport.Add(SafeModeReport.SafeModeReportType.TargetOrFieldMissing);
				return true;
			}
		}
		else
		{
			tweenPlugin.EvaluateAndApply(plugOptions, this, base.isRelative, getter, setter, elapsed, startValue, changeValue, duration, useInversePosition, newCompletedSteps, updateNotice);
		}
		return false;
	}
}
