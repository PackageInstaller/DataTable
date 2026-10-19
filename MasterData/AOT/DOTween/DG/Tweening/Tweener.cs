using System;
using DG.Tweening.Core;
using DG.Tweening.Core.Enums;
using DG.Tweening.Plugins.Core;
using DG.Tweening.Plugins.Options;
using UnityEngine;

namespace DG.Tweening;

public abstract class Tweener : Tween
{
	internal bool hasManuallySetStartValue;

	internal bool isFromAllowed = true;

	internal Tweener()
	{
	}

	public abstract Tweener ChangeStartValue(object newStartValue, float newDuration = -1f);

	public abstract Tweener ChangeEndValue(object newEndValue, float newDuration = -1f, bool snapStartValue = false);

	public abstract Tweener ChangeEndValue(object newEndValue, bool snapStartValue);

	public abstract Tweener ChangeValues(object newStartValue, object newEndValue, float newDuration = -1f);

	internal abstract Tweener SetFrom(bool relative);

	internal static bool Setup<T1, T2, TPlugOptions>(TweenerCore<T1, T2, TPlugOptions> t, DOGetter<T1> getter, DOSetter<T1> setter, T2 endValue, float duration, ABSTweenPlugin<T1, T2, TPlugOptions> plugin = null) where TPlugOptions : struct, IPlugOptions
	{
		if (plugin != null)
		{
			t.tweenPlugin = plugin;
		}
		else
		{
			if (t.tweenPlugin == null)
			{
				t.tweenPlugin = PluginsManager.GetDefaultPlugin<T1, T2, TPlugOptions>();
			}
			if (t.tweenPlugin == null)
			{
				Debugger.LogError("No suitable plugin found for this type");
				return false;
			}
		}
		t.getter = getter;
		t.setter = setter;
		t.endValue = endValue;
		t.duration = duration;
		t.autoKill = DOTween.defaultAutoKill;
		t.isRecyclable = DOTween.defaultRecyclable;
		t.easeType = DOTween.defaultEaseType;
		t.easeOvershootOrAmplitude = DOTween.defaultEaseOvershootOrAmplitude;
		t.easePeriod = DOTween.defaultEasePeriod;
		t.loopType = DOTween.defaultLoopType;
		t.isPlaying = DOTween.defaultAutoPlay == AutoPlay.All || DOTween.defaultAutoPlay == AutoPlay.AutoPlayTweeners;
		return true;
	}

	internal static float DoUpdateDelay<T1, T2, TPlugOptions>(TweenerCore<T1, T2, TPlugOptions> t, float elapsed) where TPlugOptions : struct, IPlugOptions
	{
		float num = t.delay;
		if (elapsed > num)
		{
			t.elapsedDelay = num;
			t.delayComplete = true;
			return elapsed - num;
		}
		t.elapsedDelay = elapsed;
		return 0f;
	}

	internal static bool DoStartup<T1, T2, TPlugOptions>(TweenerCore<T1, T2, TPlugOptions> t) where TPlugOptions : struct, IPlugOptions
	{
		t.startupDone = true;
		if (t.specialStartupMode != SpecialStartupMode.None && !DOStartupSpecials(t))
		{
			return false;
		}
		if (!t.hasManuallySetStartValue)
		{
			if (DOTween.useSafeMode)
			{
				try
				{
					if (t.isFrom)
					{
						t.SetFrom(t.isRelative && !t.isBlendable);
						t.isRelative = false;
					}
					else
					{
						t.startValue = t.tweenPlugin.ConvertToStartValue(t, t.getter());
					}
				}
				catch (Exception ex)
				{
					if (Debugger.ShouldLogSafeModeCapturedError())
					{
						Debugger.LogSafeModeCapturedError($"Tween startup failed (NULL target/property - {ex.TargetSite}): the tween will now be killed ► {ex.Message}", t);
					}
					DOTween.safeModeReport.Add(SafeModeReport.SafeModeReportType.StartupFailure);
					return false;
				}
			}
			else if (t.isFrom)
			{
				t.SetFrom(t.isRelative && !t.isBlendable);
				t.isRelative = false;
			}
			else
			{
				t.startValue = t.tweenPlugin.ConvertToStartValue(t, t.getter());
			}
		}
		if (t.isRelative)
		{
			t.tweenPlugin.SetRelativeEndValue(t);
		}
		t.tweenPlugin.SetChangeValue(t);
		DOStartupDurationBased(t);
		if (t.duration <= 0f)
		{
			t.easeType = Ease.INTERNAL_Zero;
		}
		return true;
	}

	internal static TweenerCore<T1, T2, TPlugOptions> DoChangeStartValue<T1, T2, TPlugOptions>(TweenerCore<T1, T2, TPlugOptions> t, T2 newStartValue, float newDuration) where TPlugOptions : struct, IPlugOptions
	{
		t.hasManuallySetStartValue = true;
		t.startValue = newStartValue;
		if (t.startupDone)
		{
			if (t.specialStartupMode != SpecialStartupMode.None && !DOStartupSpecials(t))
			{
				return null;
			}
			t.tweenPlugin.SetChangeValue(t);
		}
		if (newDuration > 0f)
		{
			t.duration = newDuration;
			if (t.startupDone)
			{
				DOStartupDurationBased(t);
			}
		}
		Tween.DoGoto(t, 0f, 0, UpdateMode.IgnoreOnUpdate);
		return t;
	}

	internal static TweenerCore<T1, T2, TPlugOptions> DoChangeEndValue<T1, T2, TPlugOptions>(TweenerCore<T1, T2, TPlugOptions> t, T2 newEndValue, float newDuration, bool snapStartValue) where TPlugOptions : struct, IPlugOptions
	{
		t.endValue = newEndValue;
		t.isRelative = false;
		if (t.startupDone)
		{
			if (t.specialStartupMode != SpecialStartupMode.None && !DOStartupSpecials(t))
			{
				return null;
			}
			if (snapStartValue)
			{
				if (DOTween.useSafeMode)
				{
					try
					{
						t.startValue = t.tweenPlugin.ConvertToStartValue(t, t.getter());
					}
					catch (Exception ex)
					{
						if (Debugger.ShouldLogSafeModeCapturedError())
						{
							Debugger.LogSafeModeCapturedError($"Target or field is missing/null ({ex.TargetSite}) ► {ex.Message}\n\n{ex.StackTrace}\n\n", t);
						}
						TweenManager.Despawn(t);
						DOTween.safeModeReport.Add(SafeModeReport.SafeModeReportType.TargetOrFieldMissing);
						return null;
					}
				}
				else
				{
					t.startValue = t.tweenPlugin.ConvertToStartValue(t, t.getter());
				}
			}
			t.tweenPlugin.SetChangeValue(t);
		}
		if (newDuration > 0f)
		{
			t.duration = newDuration;
			if (t.startupDone)
			{
				DOStartupDurationBased(t);
			}
		}
		Tween.DoGoto(t, 0f, 0, UpdateMode.IgnoreOnUpdate);
		return t;
	}

	internal static TweenerCore<T1, T2, TPlugOptions> DoChangeValues<T1, T2, TPlugOptions>(TweenerCore<T1, T2, TPlugOptions> t, T2 newStartValue, T2 newEndValue, float newDuration) where TPlugOptions : struct, IPlugOptions
	{
		t.hasManuallySetStartValue = true;
		t.isRelative = (t.isFrom = false);
		t.startValue = newStartValue;
		t.endValue = newEndValue;
		if (t.startupDone)
		{
			if (t.specialStartupMode != SpecialStartupMode.None && !DOStartupSpecials(t))
			{
				return null;
			}
			t.tweenPlugin.SetChangeValue(t);
		}
		if (newDuration > 0f)
		{
			t.duration = newDuration;
			if (t.startupDone)
			{
				DOStartupDurationBased(t);
			}
		}
		Tween.DoGoto(t, 0f, 0, UpdateMode.IgnoreOnUpdate);
		return t;
	}

	private static bool DOStartupSpecials<T1, T2, TPlugOptions>(TweenerCore<T1, T2, TPlugOptions> t) where TPlugOptions : struct, IPlugOptions
	{
		try
		{
			switch (t.specialStartupMode)
			{
			case SpecialStartupMode.SetLookAt:
				if (!SpecialPluginsUtils.SetLookAt(t as TweenerCore<Quaternion, Vector3, QuaternionOptions>))
				{
					return false;
				}
				break;
			case SpecialStartupMode.SetPunch:
				if (!SpecialPluginsUtils.SetPunch(t as TweenerCore<Vector3, Vector3[], Vector3ArrayOptions>))
				{
					return false;
				}
				break;
			case SpecialStartupMode.SetShake:
				if (!SpecialPluginsUtils.SetShake(t as TweenerCore<Vector3, Vector3[], Vector3ArrayOptions>))
				{
					return false;
				}
				break;
			case SpecialStartupMode.SetCameraShakePosition:
				if (!SpecialPluginsUtils.SetCameraShakePosition(t as TweenerCore<Vector3, Vector3[], Vector3ArrayOptions>))
				{
					return false;
				}
				break;
			}
			return true;
		}
		catch
		{
			return false;
		}
	}

	private static void DOStartupDurationBased<T1, T2, TPlugOptions>(TweenerCore<T1, T2, TPlugOptions> t) where TPlugOptions : struct, IPlugOptions
	{
		if (t.isSpeedBased)
		{
			t.duration = t.tweenPlugin.GetSpeedBasedDuration(t.plugOptions, t.duration, t.changeValue);
		}
		t.fullDuration = ((t.loops > -1) ? (t.duration * (float)t.loops) : float.PositiveInfinity);
	}
}
