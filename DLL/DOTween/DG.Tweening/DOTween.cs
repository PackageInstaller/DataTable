using System;
using System.Collections.Generic;
using DG.Tweening.Core;
using DG.Tweening.Core.Enums;
using DG.Tweening.Plugins.Core;
using DG.Tweening.Plugins.Options;
using UnityEngine;

namespace DG.Tweening;

public class DOTween
{
	public static readonly string Version = "1.2.745";

	public static bool useSafeMode = true;

	public static SafeModeLogBehaviour safeModeLogBehaviour = SafeModeLogBehaviour.Warning;

	public static NestedTweenFailureBehaviour nestedTweenFailureBehaviour = NestedTweenFailureBehaviour.TryToPreserveSequence;

	public static bool showUnityEditorReport = false;

	public static float timeScale = 1f;

	public static float unscaledTimeScale = 1f;

	public static bool useSmoothDeltaTime;

	public static float maxSmoothUnscaledTime = 0.15f;

	internal static RewindCallbackMode rewindCallbackMode = RewindCallbackMode.FireIfPositionChanged;

	private static LogBehaviour _logBehaviour = LogBehaviour.ErrorsOnly;

	public static Func<LogType, object, bool> onWillLog;

	public static bool drawGizmos = true;

	public static bool debugMode = false;

	private static bool _fooDebugStoreTargetId = true;

	public static UpdateType defaultUpdateType = UpdateType.Normal;

	public static bool defaultTimeScaleIndependent = false;

	public static AutoPlay defaultAutoPlay = AutoPlay.All;

	public static bool defaultAutoKill = true;

	public static LoopType defaultLoopType = LoopType.Restart;

	public static bool defaultRecyclable;

	public static Ease defaultEaseType = Ease.OutQuad;

	public static float defaultEaseOvershootOrAmplitude = 1.70158f;

	public static float defaultEasePeriod = 0f;

	public static DOTweenComponent instance;

	private static bool _foo_isQuitting;

	internal static int maxActiveTweenersReached;

	internal static int maxActiveSequencesReached;

	internal static SafeModeReport safeModeReport;

	internal static readonly List<TweenCallback> GizmosDelegates = new List<TweenCallback>();

	internal static bool initialized;

	private static int _isQuittingFrame = -1;

	public static LogBehaviour logBehaviour
	{
		get
		{
			return _logBehaviour;
		}
		set
		{
			_logBehaviour = value;
			Debugger.SetLogPriority(_logBehaviour);
		}
	}

	public static bool debugStoreTargetId
	{
		get
		{
			if (debugMode && useSafeMode)
			{
				return _fooDebugStoreTargetId;
			}
			return false;
		}
		set
		{
			_fooDebugStoreTargetId = value;
		}
	}

	internal static bool isQuitting
	{
		get
		{
			if (!_foo_isQuitting)
			{
				return false;
			}
			if (Time.frameCount >= 0 && _isQuittingFrame != Time.frameCount)
			{
				_foo_isQuitting = false;
				return false;
			}
			return true;
		}
		set
		{
			_foo_isQuitting = value;
			if (value)
			{
				_isQuittingFrame = Time.frameCount;
			}
		}
	}

	public static IDOTweenInit Init(bool? recycleAllByDefault = null, bool? useSafeMode = null, LogBehaviour? logBehaviour = null)
	{
		if (initialized)
		{
			return instance;
		}
		if (!Application.isPlaying || isQuitting)
		{
			return null;
		}
		return Init(Resources.Load("DOTweenSettings") as DOTweenSettings, recycleAllByDefault, useSafeMode, logBehaviour);
	}

	private static void AutoInit()
	{
		if (Application.isPlaying && !isQuitting)
		{
			Init(Resources.Load("DOTweenSettings") as DOTweenSettings, null, null, null);
		}
	}

	private static IDOTweenInit Init(DOTweenSettings settings, bool? recycleAllByDefault, bool? useSafeMode, LogBehaviour? logBehaviour)
	{
		initialized = true;
		if (recycleAllByDefault.HasValue)
		{
			defaultRecyclable = recycleAllByDefault.Value;
		}
		if (useSafeMode.HasValue)
		{
			DOTween.useSafeMode = useSafeMode.Value;
		}
		if (logBehaviour.HasValue)
		{
			DOTween.logBehaviour = logBehaviour.Value;
		}
		DOTweenComponent.Create();
		if ((Object)(object)settings != (Object)null)
		{
			if (!useSafeMode.HasValue)
			{
				DOTween.useSafeMode = settings.useSafeMode;
			}
			if (!logBehaviour.HasValue)
			{
				DOTween.logBehaviour = settings.logBehaviour;
			}
			if (!recycleAllByDefault.HasValue)
			{
				defaultRecyclable = settings.defaultRecyclable;
			}
			safeModeLogBehaviour = settings.safeModeOptions.logBehaviour;
			nestedTweenFailureBehaviour = settings.safeModeOptions.nestedTweenFailureBehaviour;
			timeScale = settings.timeScale;
			unscaledTimeScale = settings.unscaledTimeScale;
			useSmoothDeltaTime = settings.useSmoothDeltaTime;
			maxSmoothUnscaledTime = settings.maxSmoothUnscaledTime;
			rewindCallbackMode = settings.rewindCallbackMode;
			defaultRecyclable = ((!recycleAllByDefault.HasValue) ? settings.defaultRecyclable : recycleAllByDefault.Value);
			showUnityEditorReport = settings.showUnityEditorReport;
			drawGizmos = settings.drawGizmos;
			defaultAutoPlay = settings.defaultAutoPlay;
			defaultUpdateType = settings.defaultUpdateType;
			defaultTimeScaleIndependent = settings.defaultTimeScaleIndependent;
			defaultEaseType = settings.defaultEaseType;
			defaultEaseOvershootOrAmplitude = settings.defaultEaseOvershootOrAmplitude;
			defaultEasePeriod = settings.defaultEasePeriod;
			defaultAutoKill = settings.defaultAutoKill;
			defaultLoopType = settings.defaultLoopType;
			debugMode = settings.debugMode;
			debugStoreTargetId = settings.debugStoreTargetId;
		}
		if (Debugger.logPriority >= 2)
		{
			Debugger.Log("DOTween initialization (useSafeMode: " + DOTween.useSafeMode + ", recycling: " + (defaultRecyclable ? "ON" : "OFF") + ", logBehaviour: " + DOTween.logBehaviour.ToString() + ")");
		}
		return instance;
	}

	public static void SetTweensCapacity(int tweenersCapacity, int sequencesCapacity)
	{
		TweenManager.SetCapacities(tweenersCapacity, sequencesCapacity);
	}

	public static void Clear(bool destroy = false)
	{
		Clear(destroy, isApplicationQuitting: false);
	}

	internal static void Clear(bool destroy, bool isApplicationQuitting)
	{
		TweenManager.PurgeAll(isApplicationQuitting);
		PluginsManager.PurgeAll();
		if (destroy)
		{
			initialized = false;
			useSafeMode = false;
			safeModeLogBehaviour = SafeModeLogBehaviour.Warning;
			nestedTweenFailureBehaviour = NestedTweenFailureBehaviour.TryToPreserveSequence;
			showUnityEditorReport = false;
			drawGizmos = true;
			timeScale = 1f;
			unscaledTimeScale = 1f;
			useSmoothDeltaTime = false;
			maxSmoothUnscaledTime = 0.15f;
			rewindCallbackMode = RewindCallbackMode.FireIfPositionChanged;
			logBehaviour = LogBehaviour.ErrorsOnly;
			onWillLog = null;
			defaultEaseType = Ease.OutQuad;
			defaultEaseOvershootOrAmplitude = 1.70158f;
			defaultEasePeriod = 0f;
			defaultUpdateType = UpdateType.Normal;
			defaultTimeScaleIndependent = false;
			defaultAutoPlay = AutoPlay.All;
			defaultLoopType = LoopType.Restart;
			defaultAutoKill = true;
			defaultRecyclable = false;
			maxActiveTweenersReached = (maxActiveSequencesReached = 0);
			GizmosDelegates.Clear();
			DOTweenComponent.DestroyInstance();
		}
	}

	public static void ClearCachedTweens()
	{
		TweenManager.PurgePools();
	}

	public static int Validate()
	{
		return TweenManager.Validate();
	}

	public static void ManualUpdate(float deltaTime, float unscaledDeltaTime)
	{
		InitCheck();
		if (TweenManager.hasActiveManualTweens)
		{
			TweenManager.Update(UpdateType.Manual, deltaTime * timeScale, unscaledDeltaTime * unscaledTimeScale * timeScale);
		}
	}

	public static TweenerCore<float, float, FloatOptions> To(DOGetter<float> getter, DOSetter<float> setter, float endValue, float duration)
	{
		return ApplyTo<float, float, FloatOptions>(getter, setter, endValue, duration);
	}

	public static TweenerCore<double, double, NoOptions> To(DOGetter<double> getter, DOSetter<double> setter, double endValue, float duration)
	{
		return ApplyTo<double, double, NoOptions>(getter, setter, endValue, duration);
	}

	public static TweenerCore<int, int, NoOptions> To(DOGetter<int> getter, DOSetter<int> setter, int endValue, float duration)
	{
		return ApplyTo<int, int, NoOptions>(getter, setter, endValue, duration);
	}

	public static TweenerCore<uint, uint, UintOptions> To(DOGetter<uint> getter, DOSetter<uint> setter, uint endValue, float duration)
	{
		return ApplyTo<uint, uint, UintOptions>(getter, setter, endValue, duration);
	}

	public static TweenerCore<long, long, NoOptions> To(DOGetter<long> getter, DOSetter<long> setter, long endValue, float duration)
	{
		return ApplyTo<long, long, NoOptions>(getter, setter, endValue, duration);
	}

	public static TweenerCore<ulong, ulong, NoOptions> To(DOGetter<ulong> getter, DOSetter<ulong> setter, ulong endValue, float duration)
	{
		return ApplyTo<ulong, ulong, NoOptions>(getter, setter, endValue, duration);
	}

	public static TweenerCore<string, string, StringOptions> To(DOGetter<string> getter, DOSetter<string> setter, string endValue, float duration)
	{
		return ApplyTo<string, string, StringOptions>(getter, setter, endValue, duration);
	}

	public static TweenerCore<Vector2, Vector2, VectorOptions> To(DOGetter<Vector2> getter, DOSetter<Vector2> setter, Vector2 endValue, float duration)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		return ApplyTo<Vector2, Vector2, VectorOptions>(getter, setter, endValue, duration);
	}

	public static TweenerCore<Vector3, Vector3, VectorOptions> To(DOGetter<Vector3> getter, DOSetter<Vector3> setter, Vector3 endValue, float duration)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		return ApplyTo<Vector3, Vector3, VectorOptions>(getter, setter, endValue, duration);
	}

	public static TweenerCore<Vector4, Vector4, VectorOptions> To(DOGetter<Vector4> getter, DOSetter<Vector4> setter, Vector4 endValue, float duration)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		return ApplyTo<Vector4, Vector4, VectorOptions>(getter, setter, endValue, duration);
	}

	public static TweenerCore<Quaternion, Vector3, QuaternionOptions> To(DOGetter<Quaternion> getter, DOSetter<Quaternion> setter, Vector3 endValue, float duration)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		return ApplyTo<Quaternion, Vector3, QuaternionOptions>(getter, setter, endValue, duration);
	}

	public static TweenerCore<Color, Color, ColorOptions> To(DOGetter<Color> getter, DOSetter<Color> setter, Color endValue, float duration)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		return ApplyTo<Color, Color, ColorOptions>(getter, setter, endValue, duration);
	}

	public static TweenerCore<Rect, Rect, RectOptions> To(DOGetter<Rect> getter, DOSetter<Rect> setter, Rect endValue, float duration)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		return ApplyTo<Rect, Rect, RectOptions>(getter, setter, endValue, duration);
	}

	public static Tweener To(DOGetter<RectOffset> getter, DOSetter<RectOffset> setter, RectOffset endValue, float duration)
	{
		return ApplyTo<RectOffset, RectOffset, NoOptions>(getter, setter, endValue, duration);
	}

	public static TweenerCore<T1, T2, TPlugOptions> To<T1, T2, TPlugOptions>(ABSTweenPlugin<T1, T2, TPlugOptions> plugin, DOGetter<T1> getter, DOSetter<T1> setter, T2 endValue, float duration) where TPlugOptions : struct, IPlugOptions
	{
		return ApplyTo(getter, setter, endValue, duration, plugin);
	}

	public static TweenerCore<Vector3, Vector3, VectorOptions> ToAxis(DOGetter<Vector3> getter, DOSetter<Vector3> setter, float endValue, float duration, AxisConstraint axisConstraint = AxisConstraint.X)
	{
		//IL_0005: Unknown result type (might be due to invalid IL or missing references)
		TweenerCore<Vector3, Vector3, VectorOptions> tweenerCore = ApplyTo<Vector3, Vector3, VectorOptions>(getter, setter, new Vector3(endValue, endValue, endValue), duration);
		tweenerCore.plugOptions.axisConstraint = axisConstraint;
		return tweenerCore;
	}

	public static TweenerCore<Color, Color, ColorOptions> ToAlpha(DOGetter<Color> getter, DOSetter<Color> setter, float endValue, float duration)
	{
		//IL_0012: Unknown result type (might be due to invalid IL or missing references)
		TweenerCore<Color, Color, ColorOptions> tweenerCore = ApplyTo<Color, Color, ColorOptions>(getter, setter, new Color(0f, 0f, 0f, endValue), duration);
		tweenerCore.SetOptions(alphaOnly: true);
		return tweenerCore;
	}

	public static Tweener To(DOSetter<float> setter, float startValue, float endValue, float duration)
	{
		return To(() => startValue, delegate(float x)
		{
			startValue = x;
			setter(startValue);
		}, endValue, duration).NoFrom();
	}

	public static TweenerCore<Vector3, Vector3[], Vector3ArrayOptions> Punch(DOGetter<Vector3> getter, DOSetter<Vector3> setter, Vector3 direction, float duration, int vibrato = 10, float elasticity = 1f)
	{
		//IL_00f6: Unknown result type (might be due to invalid IL or missing references)
		//IL_00fb: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b4: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b5: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e0: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e2: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e7: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c6: Unknown result type (might be due to invalid IL or missing references)
		//IL_00cb: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d0: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d5: Unknown result type (might be due to invalid IL or missing references)
		if (elasticity > 1f)
		{
			elasticity = 1f;
		}
		else if (elasticity < 0f)
		{
			elasticity = 0f;
		}
		float num = ((Vector3)(ref direction)).magnitude;
		int num2 = (int)((float)vibrato * duration);
		if (num2 < 2)
		{
			num2 = 2;
		}
		float num3 = num / (float)num2;
		float[] array = new float[num2];
		float num4 = 0f;
		for (int i = 0; i < num2; i++)
		{
			float num5 = (float)(i + 1) / (float)num2;
			float num6 = duration * num5;
			num4 += num6;
			array[i] = num6;
		}
		float num7 = duration / num4;
		for (int j = 0; j < num2; j++)
		{
			array[j] *= num7;
		}
		Vector3[] array2 = (Vector3[])(object)new Vector3[num2];
		for (int k = 0; k < num2; k++)
		{
			if (k < num2 - 1)
			{
				if (k == 0)
				{
					array2[k] = direction;
				}
				else if (k % 2 != 0)
				{
					array2[k] = -Vector3.ClampMagnitude(direction, num * elasticity);
				}
				else
				{
					array2[k] = Vector3.ClampMagnitude(direction, num);
				}
				num -= num3;
			}
			else
			{
				array2[k] = Vector3.zero;
			}
		}
		return ToArray(getter, setter, array2, array).NoFrom().SetSpecialStartupMode(SpecialStartupMode.SetPunch);
	}

	public static TweenerCore<Vector3, Vector3[], Vector3ArrayOptions> Shake(DOGetter<Vector3> getter, DOSetter<Vector3> setter, float duration, float strength = 3f, int vibrato = 10, float randomness = 90f, bool ignoreZAxis = true, bool fadeOut = true, ShakeRandomnessMode randomnessMode = ShakeRandomnessMode.Full)
	{
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		return Shake(getter, setter, duration, new Vector3(strength, strength, strength), vibrato, randomness, ignoreZAxis, vectorBased: false, fadeOut, randomnessMode);
	}

	public static TweenerCore<Vector3, Vector3[], Vector3ArrayOptions> Shake(DOGetter<Vector3> getter, DOSetter<Vector3> setter, float duration, Vector3 strength, int vibrato = 10, float randomness = 90f, bool fadeOut = true, ShakeRandomnessMode randomnessMode = ShakeRandomnessMode.Full)
	{
		//IL_0003: Unknown result type (might be due to invalid IL or missing references)
		return Shake(getter, setter, duration, strength, vibrato, randomness, ignoreZAxis: false, vectorBased: true, fadeOut, randomnessMode);
	}

	private static TweenerCore<Vector3, Vector3[], Vector3ArrayOptions> Shake(DOGetter<Vector3> getter, DOSetter<Vector3> setter, float duration, Vector3 strength, int vibrato, float randomness, bool ignoreZAxis, bool vectorBased, bool fadeOut, ShakeRandomnessMode randomnessMode)
	{
		//IL_0004: Unknown result type (might be due to invalid IL or missing references)
		//IL_0206: Unknown result type (might be due to invalid IL or missing references)
		//IL_020b: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b7: Unknown result type (might be due to invalid IL or missing references)
		//IL_00bc: Unknown result type (might be due to invalid IL or missing references)
		//IL_012d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0132: Unknown result type (might be due to invalid IL or missing references)
		//IL_0137: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f3: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f8: Unknown result type (might be due to invalid IL or missing references)
		//IL_00fd: Unknown result type (might be due to invalid IL or missing references)
		//IL_0140: Unknown result type (might be due to invalid IL or missing references)
		//IL_0145: Unknown result type (might be due to invalid IL or missing references)
		//IL_014a: Unknown result type (might be due to invalid IL or missing references)
		//IL_014f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0153: Unknown result type (might be due to invalid IL or missing references)
		//IL_0155: Unknown result type (might be due to invalid IL or missing references)
		//IL_015b: Unknown result type (might be due to invalid IL or missing references)
		//IL_016c: Unknown result type (might be due to invalid IL or missing references)
		//IL_016e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0174: Unknown result type (might be due to invalid IL or missing references)
		//IL_0185: Unknown result type (might be due to invalid IL or missing references)
		//IL_0187: Unknown result type (might be due to invalid IL or missing references)
		//IL_018d: Unknown result type (might be due to invalid IL or missing references)
		//IL_019e: Unknown result type (might be due to invalid IL or missing references)
		//IL_01a4: Unknown result type (might be due to invalid IL or missing references)
		//IL_01a9: Unknown result type (might be due to invalid IL or missing references)
		//IL_01af: Unknown result type (might be due to invalid IL or missing references)
		//IL_01b1: Unknown result type (might be due to invalid IL or missing references)
		//IL_01e4: Unknown result type (might be due to invalid IL or missing references)
		//IL_01e9: Unknown result type (might be due to invalid IL or missing references)
		//IL_01ee: Unknown result type (might be due to invalid IL or missing references)
		//IL_01f3: Unknown result type (might be due to invalid IL or missing references)
		//IL_01d4: Unknown result type (might be due to invalid IL or missing references)
		//IL_01d9: Unknown result type (might be due to invalid IL or missing references)
		//IL_01be: Unknown result type (might be due to invalid IL or missing references)
		//IL_01c0: Unknown result type (might be due to invalid IL or missing references)
		//IL_01c5: Unknown result type (might be due to invalid IL or missing references)
		float num = (vectorBased ? ((Vector3)(ref strength)).magnitude : strength.x);
		int num2 = (int)((float)vibrato * duration);
		if (num2 < 2)
		{
			num2 = 2;
		}
		float num3 = num / (float)num2;
		float[] array = new float[num2];
		float num4 = 0f;
		for (int i = 0; i < num2; i++)
		{
			float num5 = (float)(i + 1) / (float)num2;
			float num6 = (fadeOut ? (duration * num5) : (duration / (float)num2));
			num4 += num6;
			array[i] = num6;
		}
		float num7 = duration / num4;
		for (int j = 0; j < num2; j++)
		{
			array[j] *= num7;
		}
		float num8 = Random.Range(0f, 360f);
		Vector3[] array2 = (Vector3[])(object)new Vector3[num2];
		for (int k = 0; k < num2; k++)
		{
			if (k < num2 - 1)
			{
				Quaternion val = Quaternion.identity;
				if (randomnessMode == ShakeRandomnessMode.Harmonic)
				{
					if (k > 0)
					{
						num8 = num8 - 180f + Random.Range(0f, randomness);
					}
					if (vectorBased || !ignoreZAxis)
					{
						val = Quaternion.AngleAxis(Random.Range(0f, randomness), Vector3.up);
					}
				}
				else
				{
					if (k > 0)
					{
						num8 = num8 - 180f + Random.Range(0f - randomness, randomness);
					}
					if (vectorBased || !ignoreZAxis)
					{
						val = Quaternion.AngleAxis(Random.Range(0f - randomness, randomness), Vector3.up);
					}
				}
				if (vectorBased)
				{
					Vector3 val2 = val * DOTweenUtils.Vector3FromAngle(num8, num);
					val2.x = Vector3.ClampMagnitude(val2, strength.x).x;
					val2.y = Vector3.ClampMagnitude(val2, strength.y).y;
					val2.z = Vector3.ClampMagnitude(val2, strength.z).z;
					val2 = (array2[k] = ((Vector3)(ref val2)).normalized * num);
					if (fadeOut)
					{
						num -= num3;
					}
					strength = Vector3.ClampMagnitude(strength, num);
				}
				else
				{
					if (ignoreZAxis)
					{
						array2[k] = DOTweenUtils.Vector3FromAngle(num8, num);
					}
					else
					{
						array2[k] = val * DOTweenUtils.Vector3FromAngle(num8, num);
					}
					if (fadeOut)
					{
						num -= num3;
					}
				}
			}
			else
			{
				array2[k] = Vector3.zero;
			}
		}
		return ToArray(getter, setter, array2, array).NoFrom().SetSpecialStartupMode(SpecialStartupMode.SetShake);
	}

	public static TweenerCore<Vector3, Vector3[], Vector3ArrayOptions> ToArray(DOGetter<Vector3> getter, DOSetter<Vector3> setter, Vector3[] endValues, float[] durations)
	{
		//IL_0030: Unknown result type (might be due to invalid IL or missing references)
		//IL_0035: Unknown result type (might be due to invalid IL or missing references)
		int num = durations.Length;
		if (num != endValues.Length)
		{
			Debugger.LogError("To Vector3 array tween: endValues and durations arrays must have the same length");
			return null;
		}
		Vector3[] array = (Vector3[])(object)new Vector3[num];
		float[] array2 = new float[num];
		for (int i = 0; i < num; i++)
		{
			array[i] = endValues[i];
			array2[i] = durations[i];
		}
		float num2 = 0f;
		for (int j = 0; j < num; j++)
		{
			num2 += array2[j];
		}
		TweenerCore<Vector3, Vector3[], Vector3ArrayOptions> tweenerCore = ApplyTo<Vector3, Vector3[], Vector3ArrayOptions>(getter, setter, array, num2).NoFrom();
		tweenerCore.plugOptions.durations = array2;
		return tweenerCore;
	}

	internal static TweenerCore<Color2, Color2, ColorOptions> To(DOGetter<Color2> getter, DOSetter<Color2> setter, Color2 endValue, float duration)
	{
		return ApplyTo<Color2, Color2, ColorOptions>(getter, setter, endValue, duration);
	}

	public static Sequence Sequence()
	{
		InitCheck();
		Sequence sequence = TweenManager.GetSequence();
		DG.Tweening.Sequence.Setup(sequence);
		return sequence;
	}

	public static Sequence Sequence(object target)
	{
		return Sequence().SetTarget(target);
	}

	public static int CompleteAll(bool withCallbacks = false)
	{
		return TweenManager.FilteredOperation(OperationType.Complete, FilterType.All, null, optionalBool: false, withCallbacks ? 1 : 0);
	}

	public static int Complete(object targetOrId, bool withCallbacks = false)
	{
		if (targetOrId == null)
		{
			return 0;
		}
		return TweenManager.FilteredOperation(OperationType.Complete, FilterType.TargetOrId, targetOrId, optionalBool: false, withCallbacks ? 1 : 0);
	}

	internal static int CompleteAndReturnKilledTot()
	{
		return TweenManager.FilteredOperation(OperationType.Complete, FilterType.All, null, optionalBool: true, 0f);
	}

	internal static int CompleteAndReturnKilledTot(object targetOrId)
	{
		if (targetOrId == null)
		{
			return 0;
		}
		return TweenManager.FilteredOperation(OperationType.Complete, FilterType.TargetOrId, targetOrId, optionalBool: true, 0f);
	}

	internal static int CompleteAndReturnKilledTot(object target, object id)
	{
		if (target == null || id == null)
		{
			return 0;
		}
		return TweenManager.FilteredOperation(OperationType.Complete, FilterType.TargetAndId, id, optionalBool: true, 0f, target);
	}

	internal static int CompleteAndReturnKilledTotExceptFor(params object[] excludeTargetsOrIds)
	{
		return TweenManager.FilteredOperation(OperationType.Complete, FilterType.AllExceptTargetsOrIds, null, optionalBool: true, 0f, null, excludeTargetsOrIds);
	}

	public static int FlipAll()
	{
		return TweenManager.FilteredOperation(OperationType.Flip, FilterType.All, null, optionalBool: false, 0f);
	}

	public static int Flip(object targetOrId)
	{
		if (targetOrId == null)
		{
			return 0;
		}
		return TweenManager.FilteredOperation(OperationType.Flip, FilterType.TargetOrId, targetOrId, optionalBool: false, 0f);
	}

	public static int GotoAll(float to, bool andPlay = false)
	{
		return TweenManager.FilteredOperation(OperationType.Goto, FilterType.All, null, andPlay, to);
	}

	public static int Goto(object targetOrId, float to, bool andPlay = false)
	{
		if (targetOrId == null)
		{
			return 0;
		}
		return TweenManager.FilteredOperation(OperationType.Goto, FilterType.TargetOrId, targetOrId, andPlay, to);
	}

	public static int KillAll(bool complete = false)
	{
		return (complete ? CompleteAndReturnKilledTot() : 0) + TweenManager.DespawnAll();
	}

	public static int KillAll(bool complete, params object[] idsOrTargetsToExclude)
	{
		if (idsOrTargetsToExclude == null)
		{
			return (complete ? CompleteAndReturnKilledTot() : 0) + TweenManager.DespawnAll();
		}
		return (complete ? CompleteAndReturnKilledTotExceptFor(idsOrTargetsToExclude) : 0) + TweenManager.FilteredOperation(OperationType.Despawn, FilterType.AllExceptTargetsOrIds, null, optionalBool: false, 0f, null, idsOrTargetsToExclude);
	}

	public static int Kill(object targetOrId, bool complete = false)
	{
		if (targetOrId == null)
		{
			return 0;
		}
		return (complete ? CompleteAndReturnKilledTot(targetOrId) : 0) + TweenManager.FilteredOperation(OperationType.Despawn, FilterType.TargetOrId, targetOrId, optionalBool: false, 0f);
	}

	public static int Kill(object target, object id, bool complete = false)
	{
		if (target == null || id == null)
		{
			return 0;
		}
		return (complete ? CompleteAndReturnKilledTot(target, id) : 0) + TweenManager.FilteredOperation(OperationType.Despawn, FilterType.TargetAndId, id, optionalBool: false, 0f, target);
	}

	public static int PauseAll()
	{
		return TweenManager.FilteredOperation(OperationType.Pause, FilterType.All, null, optionalBool: false, 0f);
	}

	public static int Pause(object targetOrId)
	{
		if (targetOrId == null)
		{
			return 0;
		}
		return TweenManager.FilteredOperation(OperationType.Pause, FilterType.TargetOrId, targetOrId, optionalBool: false, 0f);
	}

	public static int PlayAll()
	{
		return TweenManager.FilteredOperation(OperationType.Play, FilterType.All, null, optionalBool: false, 0f);
	}

	public static int Play(object targetOrId)
	{
		if (targetOrId == null)
		{
			return 0;
		}
		return TweenManager.FilteredOperation(OperationType.Play, FilterType.TargetOrId, targetOrId, optionalBool: false, 0f);
	}

	public static int Play(object target, object id)
	{
		if (target == null || id == null)
		{
			return 0;
		}
		return TweenManager.FilteredOperation(OperationType.Play, FilterType.TargetAndId, id, optionalBool: false, 0f, target);
	}

	public static int PlayBackwardsAll()
	{
		return TweenManager.FilteredOperation(OperationType.PlayBackwards, FilterType.All, null, optionalBool: false, 0f);
	}

	public static int PlayBackwards(object targetOrId)
	{
		if (targetOrId == null)
		{
			return 0;
		}
		return TweenManager.FilteredOperation(OperationType.PlayBackwards, FilterType.TargetOrId, targetOrId, optionalBool: false, 0f);
	}

	public static int PlayBackwards(object target, object id)
	{
		if (target == null || id == null)
		{
			return 0;
		}
		return TweenManager.FilteredOperation(OperationType.PlayBackwards, FilterType.TargetAndId, id, optionalBool: false, 0f, target);
	}

	public static int PlayForwardAll()
	{
		return TweenManager.FilteredOperation(OperationType.PlayForward, FilterType.All, null, optionalBool: false, 0f);
	}

	public static int PlayForward(object targetOrId)
	{
		if (targetOrId == null)
		{
			return 0;
		}
		return TweenManager.FilteredOperation(OperationType.PlayForward, FilterType.TargetOrId, targetOrId, optionalBool: false, 0f);
	}

	public static int PlayForward(object target, object id)
	{
		if (target == null || id == null)
		{
			return 0;
		}
		return TweenManager.FilteredOperation(OperationType.PlayForward, FilterType.TargetAndId, id, optionalBool: false, 0f, target);
	}

	public static int RestartAll(bool includeDelay = true)
	{
		return TweenManager.FilteredOperation(OperationType.Restart, FilterType.All, null, includeDelay, 0f);
	}

	public static int Restart(object targetOrId, bool includeDelay = true, float changeDelayTo = -1f)
	{
		if (targetOrId == null)
		{
			return 0;
		}
		return TweenManager.FilteredOperation(OperationType.Restart, FilterType.TargetOrId, targetOrId, includeDelay, changeDelayTo);
	}

	public static int Restart(object target, object id, bool includeDelay = true, float changeDelayTo = -1f)
	{
		if (target == null || id == null)
		{
			return 0;
		}
		return TweenManager.FilteredOperation(OperationType.Restart, FilterType.TargetAndId, id, includeDelay, changeDelayTo, target);
	}

	public static int RewindAll(bool includeDelay = true)
	{
		return TweenManager.FilteredOperation(OperationType.Rewind, FilterType.All, null, includeDelay, 0f);
	}

	public static int Rewind(object targetOrId, bool includeDelay = true)
	{
		if (targetOrId == null)
		{
			return 0;
		}
		return TweenManager.FilteredOperation(OperationType.Rewind, FilterType.TargetOrId, targetOrId, includeDelay, 0f);
	}

	public static int SmoothRewindAll()
	{
		return TweenManager.FilteredOperation(OperationType.SmoothRewind, FilterType.All, null, optionalBool: false, 0f);
	}

	public static int SmoothRewind(object targetOrId)
	{
		if (targetOrId == null)
		{
			return 0;
		}
		return TweenManager.FilteredOperation(OperationType.SmoothRewind, FilterType.TargetOrId, targetOrId, optionalBool: false, 0f);
	}

	public static int TogglePauseAll()
	{
		return TweenManager.FilteredOperation(OperationType.TogglePause, FilterType.All, null, optionalBool: false, 0f);
	}

	public static int TogglePause(object targetOrId)
	{
		if (targetOrId == null)
		{
			return 0;
		}
		return TweenManager.FilteredOperation(OperationType.TogglePause, FilterType.TargetOrId, targetOrId, optionalBool: false, 0f);
	}

	public static bool IsTweening(object targetOrId, bool alsoCheckIfIsPlaying = false)
	{
		return TweenManager.FilteredOperation(OperationType.IsTweening, FilterType.TargetOrId, targetOrId, alsoCheckIfIsPlaying, 0f) > 0;
	}

	public static int TotalActiveTweens()
	{
		return TweenManager.totActiveTweens;
	}

	public static int TotalActiveTweeners()
	{
		return TweenManager.totActiveTweeners;
	}

	public static int TotalActiveSequences()
	{
		return TweenManager.totActiveSequences;
	}

	public static int TotalPlayingTweens()
	{
		return TweenManager.TotalPlayingTweens();
	}

	public static int TotalTweensById(object id, bool playingOnly = false)
	{
		if (id == null)
		{
			return 0;
		}
		return TweenManager.TotalTweensById(id, playingOnly);
	}

	public static List<Tween> PlayingTweens(List<Tween> fillableList = null)
	{
		fillableList?.Clear();
		return TweenManager.GetActiveTweens(playing: true, fillableList);
	}

	public static List<Tween> PausedTweens(List<Tween> fillableList = null)
	{
		fillableList?.Clear();
		return TweenManager.GetActiveTweens(playing: false, fillableList);
	}

	public static List<Tween> TweensById(object id, bool playingOnly = false, List<Tween> fillableList = null)
	{
		if (id == null)
		{
			return null;
		}
		fillableList?.Clear();
		return TweenManager.GetTweensById(id, playingOnly, fillableList);
	}

	public static List<Tween> TweensByTarget(object target, bool playingOnly = false, List<Tween> fillableList = null)
	{
		fillableList?.Clear();
		return TweenManager.GetTweensByTarget(target, playingOnly, fillableList);
	}

	private static void InitCheck()
	{
		if (!initialized && Application.isPlaying && !isQuitting)
		{
			AutoInit();
		}
	}

	private static TweenerCore<T1, T2, TPlugOptions> ApplyTo<T1, T2, TPlugOptions>(DOGetter<T1> getter, DOSetter<T1> setter, T2 endValue, float duration, ABSTweenPlugin<T1, T2, TPlugOptions> plugin = null) where TPlugOptions : struct, IPlugOptions
	{
		InitCheck();
		TweenerCore<T1, T2, TPlugOptions> tweener = TweenManager.GetTweener<T1, T2, TPlugOptions>();
		if (!Tweener.Setup(tweener, getter, setter, endValue, duration, plugin))
		{
			TweenManager.Despawn(tweener);
			return null;
		}
		return tweener;
	}
}
