using DG.Tweening.Core;
using DG.Tweening.Core.Easing;
using DG.Tweening.Plugins;
using DG.Tweening.Plugins.Core.PathCore;
using DG.Tweening.Plugins.Options;
using UnityEngine;

namespace DG.Tweening;

public static class TweenSettingsExtensions
{
	public static T SetAutoKill<T>(this T t) where T : Tween
	{
		if (t == null || !t.active || t.creationLocked)
		{
			return t;
		}
		t.autoKill = true;
		return t;
	}

	public static T SetAutoKill<T>(this T t, bool autoKillOnCompletion) where T : Tween
	{
		if (t == null || !t.active || t.creationLocked)
		{
			return t;
		}
		t.autoKill = autoKillOnCompletion;
		return t;
	}

	public static T SetId<T>(this T t, object objectId) where T : Tween
	{
		if (t == null || !t.active)
		{
			return t;
		}
		t.id = objectId;
		return t;
	}

	public static T SetId<T>(this T t, string stringId) where T : Tween
	{
		if (t == null || !t.active)
		{
			return t;
		}
		t.stringId = stringId;
		return t;
	}

	public static T SetId<T>(this T t, int intId) where T : Tween
	{
		if (t == null || !t.active)
		{
			return t;
		}
		t.intId = intId;
		return t;
	}

	public static T SetLink<T>(this T t, GameObject gameObject) where T : Tween
	{
		if (t == null || !t.active || t.isSequenced || (Object)(object)gameObject == (Object)null)
		{
			return t;
		}
		TweenManager.AddTweenLink(t, new TweenLink(gameObject, LinkBehaviour.KillOnDestroy));
		return t;
	}

	public static T SetLink<T>(this T t, GameObject gameObject, LinkBehaviour behaviour) where T : Tween
	{
		if (t == null || !t.active || t.isSequenced || (Object)(object)gameObject == (Object)null)
		{
			return t;
		}
		TweenManager.AddTweenLink(t, new TweenLink(gameObject, behaviour));
		return t;
	}

	public static T SetTarget<T>(this T t, object target) where T : Tween
	{
		if (t == null || !t.active)
		{
			return t;
		}
		if (DOTween.debugStoreTargetId)
		{
			Component val = (Component)((target is Component) ? target : null);
			t.debugTargetId = (((Object)(object)val != (Object)null) ? ((Object)val).name : target.ToString());
		}
		t.target = target;
		return t;
	}

	public static T SetLoops<T>(this T t, int loops) where T : Tween
	{
		if (t == null || !t.active || t.creationLocked)
		{
			return t;
		}
		if (loops < -1)
		{
			loops = -1;
		}
		else if (loops == 0)
		{
			loops = 1;
		}
		t.loops = loops;
		if (t.tweenType == TweenType.Tweener)
		{
			if (loops > -1)
			{
				t.fullDuration = t.duration * (float)loops;
			}
			else
			{
				t.fullDuration = float.PositiveInfinity;
			}
		}
		return t;
	}

	public static T SetLoops<T>(this T t, int loops, LoopType loopType) where T : Tween
	{
		if (t == null || !t.active || t.creationLocked)
		{
			return t;
		}
		if (loops < -1)
		{
			loops = -1;
		}
		else if (loops == 0)
		{
			loops = 1;
		}
		t.loops = loops;
		t.loopType = loopType;
		if (t.tweenType == TweenType.Tweener)
		{
			if (loops > -1)
			{
				t.fullDuration = t.duration * (float)loops;
			}
			else
			{
				t.fullDuration = float.PositiveInfinity;
			}
		}
		return t;
	}

	public static T SetEase<T>(this T t, Ease ease) where T : Tween
	{
		if (t == null || !t.active)
		{
			return t;
		}
		t.easeType = ease;
		if (EaseManager.IsFlashEase(ease))
		{
			t.easeOvershootOrAmplitude = (int)t.easeOvershootOrAmplitude;
		}
		t.customEase = null;
		return t;
	}

	public static T SetEase<T>(this T t, Ease ease, float overshoot) where T : Tween
	{
		if (t == null || !t.active)
		{
			return t;
		}
		t.easeType = ease;
		if (EaseManager.IsFlashEase(ease))
		{
			overshoot = (int)overshoot;
		}
		t.easeOvershootOrAmplitude = overshoot;
		t.customEase = null;
		return t;
	}

	public static T SetEase<T>(this T t, Ease ease, float amplitude, float period) where T : Tween
	{
		if (t == null || !t.active)
		{
			return t;
		}
		t.easeType = ease;
		if (EaseManager.IsFlashEase(ease))
		{
			amplitude = (int)amplitude;
		}
		t.easeOvershootOrAmplitude = amplitude;
		t.easePeriod = period;
		t.customEase = null;
		return t;
	}

	public static T SetEase<T>(this T t, AnimationCurve animCurve) where T : Tween
	{
		if (t == null || !t.active)
		{
			return t;
		}
		t.easeType = Ease.INTERNAL_Custom;
		t.customEase = new EaseCurve(animCurve).Evaluate;
		return t;
	}

	public static T SetEase<T>(this T t, EaseFunction customEase) where T : Tween
	{
		if (t == null || !t.active)
		{
			return t;
		}
		t.easeType = Ease.INTERNAL_Custom;
		t.customEase = customEase;
		return t;
	}

	public static T SetRecyclable<T>(this T t) where T : Tween
	{
		if (t == null || !t.active)
		{
			return t;
		}
		t.isRecyclable = true;
		return t;
	}

	public static T SetRecyclable<T>(this T t, bool recyclable) where T : Tween
	{
		if (t == null || !t.active)
		{
			return t;
		}
		t.isRecyclable = recyclable;
		return t;
	}

	public static T SetUpdate<T>(this T t, bool isIndependentUpdate) where T : Tween
	{
		if (t == null || !t.active)
		{
			return t;
		}
		TweenManager.SetUpdateType(t, DOTween.defaultUpdateType, isIndependentUpdate);
		return t;
	}

	public static T SetUpdate<T>(this T t, UpdateType updateType) where T : Tween
	{
		if (t == null || !t.active)
		{
			return t;
		}
		TweenManager.SetUpdateType(t, updateType, DOTween.defaultTimeScaleIndependent);
		return t;
	}

	public static T SetUpdate<T>(this T t, UpdateType updateType, bool isIndependentUpdate) where T : Tween
	{
		if (t == null || !t.active)
		{
			return t;
		}
		TweenManager.SetUpdateType(t, updateType, isIndependentUpdate);
		return t;
	}

	public static T SetInverted<T>(this T t) where T : Tween
	{
		if (t == null || !t.active || t.creationLocked)
		{
			return t;
		}
		t.isInverted = true;
		return t;
	}

	public static T SetInverted<T>(this T t, bool inverted) where T : Tween
	{
		if (t == null || !t.active || t.creationLocked)
		{
			return t;
		}
		t.isInverted = inverted;
		return t;
	}

	public static T OnStart<T>(this T t, TweenCallback action) where T : Tween
	{
		if (t == null || !t.active)
		{
			return t;
		}
		t.onStart = action;
		return t;
	}

	public static T OnPlay<T>(this T t, TweenCallback action) where T : Tween
	{
		if (t == null || !t.active)
		{
			return t;
		}
		t.onPlay = action;
		return t;
	}

	public static T OnPause<T>(this T t, TweenCallback action) where T : Tween
	{
		if (t == null || !t.active)
		{
			return t;
		}
		t.onPause = action;
		return t;
	}

	public static T OnRewind<T>(this T t, TweenCallback action) where T : Tween
	{
		if (t == null || !t.active)
		{
			return t;
		}
		t.onRewind = action;
		return t;
	}

	public static T OnUpdate<T>(this T t, TweenCallback action) where T : Tween
	{
		if (t == null || !t.active)
		{
			return t;
		}
		t.onUpdate = action;
		return t;
	}

	public static T OnStepComplete<T>(this T t, TweenCallback action) where T : Tween
	{
		if (t == null || !t.active)
		{
			return t;
		}
		t.onStepComplete = action;
		return t;
	}

	public static T OnComplete<T>(this T t, TweenCallback action) where T : Tween
	{
		if (t == null || !t.active)
		{
			return t;
		}
		t.onComplete = action;
		return t;
	}

	public static T OnKill<T>(this T t, TweenCallback action) where T : Tween
	{
		if (t == null || !t.active)
		{
			return t;
		}
		t.onKill = action;
		return t;
	}

	public static T OnWaypointChange<T>(this T t, TweenCallback<int> action) where T : Tween
	{
		if (t == null || !t.active)
		{
			return t;
		}
		t.onWaypointChange = action;
		return t;
	}

	public static T SetAs<T>(this T t, Tween asTween) where T : Tween
	{
		if (t == null || !t.active || t.creationLocked)
		{
			return t;
		}
		t.timeScale = asTween.timeScale;
		t.isBackwards = asTween.isBackwards;
		TweenManager.SetUpdateType(t, asTween.updateType, asTween.isIndependentUpdate);
		t.id = asTween.id;
		t.stringId = asTween.stringId;
		t.intId = asTween.intId;
		t.onStart = asTween.onStart;
		t.onPlay = asTween.onPlay;
		t.onRewind = asTween.onRewind;
		t.onUpdate = asTween.onUpdate;
		t.onStepComplete = asTween.onStepComplete;
		t.onComplete = asTween.onComplete;
		t.onKill = asTween.onKill;
		t.onWaypointChange = asTween.onWaypointChange;
		t.isRecyclable = asTween.isRecyclable;
		t.isSpeedBased = asTween.isSpeedBased;
		t.autoKill = asTween.autoKill;
		t.loops = asTween.loops;
		t.loopType = asTween.loopType;
		if (t.tweenType == TweenType.Tweener)
		{
			if (t.loops > -1)
			{
				t.fullDuration = t.duration * (float)t.loops;
			}
			else
			{
				t.fullDuration = float.PositiveInfinity;
			}
		}
		t.delay = asTween.delay;
		t.delayComplete = t.delay <= 0f;
		t.isRelative = asTween.isRelative;
		t.easeType = asTween.easeType;
		t.customEase = asTween.customEase;
		t.easeOvershootOrAmplitude = asTween.easeOvershootOrAmplitude;
		t.easePeriod = asTween.easePeriod;
		return t;
	}

	public static T SetAs<T>(this T t, TweenParams tweenParams) where T : Tween
	{
		if (t == null || !t.active || t.creationLocked)
		{
			return t;
		}
		TweenManager.SetUpdateType(t, tweenParams.updateType, tweenParams.isIndependentUpdate);
		t.id = tweenParams.id;
		t.stringId = tweenParams.stringId;
		t.intId = tweenParams.intId;
		t.onStart = tweenParams.onStart;
		t.onPlay = tweenParams.onPlay;
		t.onRewind = tweenParams.onRewind;
		t.onUpdate = tweenParams.onUpdate;
		t.onStepComplete = tweenParams.onStepComplete;
		t.onComplete = tweenParams.onComplete;
		t.onKill = tweenParams.onKill;
		t.onWaypointChange = tweenParams.onWaypointChange;
		t.isRecyclable = tweenParams.isRecyclable;
		t.isSpeedBased = tweenParams.isSpeedBased;
		t.autoKill = tweenParams.autoKill;
		t.loops = tweenParams.loops;
		t.loopType = tweenParams.loopType;
		if (t.tweenType == TweenType.Tweener)
		{
			if (t.loops > -1)
			{
				t.fullDuration = t.duration * (float)t.loops;
			}
			else
			{
				t.fullDuration = float.PositiveInfinity;
			}
		}
		t.delay = tweenParams.delay;
		t.delayComplete = t.delay <= 0f;
		t.isRelative = tweenParams.isRelative;
		if (tweenParams.easeType == Ease.Unset)
		{
			if (t.tweenType == TweenType.Sequence)
			{
				t.easeType = Ease.Linear;
			}
			else
			{
				t.easeType = DOTween.defaultEaseType;
			}
		}
		else
		{
			t.easeType = tweenParams.easeType;
		}
		t.customEase = tweenParams.customEase;
		t.easeOvershootOrAmplitude = tweenParams.easeOvershootOrAmplitude;
		t.easePeriod = tweenParams.easePeriod;
		return t;
	}

	public static Sequence Append(this Sequence s, Tween t)
	{
		if (!ValidateAddToSequence(s, t))
		{
			return s;
		}
		Sequence.DoInsert(s, t, s.duration);
		return s;
	}

	public static Sequence Prepend(this Sequence s, Tween t)
	{
		if (!ValidateAddToSequence(s, t))
		{
			return s;
		}
		Sequence.DoPrepend(s, t);
		return s;
	}

	public static Sequence Join(this Sequence s, Tween t)
	{
		if (!ValidateAddToSequence(s, t))
		{
			return s;
		}
		Sequence.DoInsert(s, t, s.lastTweenInsertTime);
		return s;
	}

	public static Sequence Insert(this Sequence s, float atPosition, Tween t)
	{
		if (!ValidateAddToSequence(s, t))
		{
			return s;
		}
		Sequence.DoInsert(s, t, atPosition);
		return s;
	}

	public static Sequence AppendInterval(this Sequence s, float interval)
	{
		if (!ValidateAddToSequence(s, null, ignoreTween: true))
		{
			return s;
		}
		Sequence.DoAppendInterval(s, interval);
		return s;
	}

	public static Sequence PrependInterval(this Sequence s, float interval)
	{
		if (!ValidateAddToSequence(s, null, ignoreTween: true))
		{
			return s;
		}
		Sequence.DoPrependInterval(s, interval);
		return s;
	}

	public static Sequence AppendCallback(this Sequence s, TweenCallback callback)
	{
		if (!ValidateAddToSequence(s, null, ignoreTween: true))
		{
			return s;
		}
		if (callback == null)
		{
			return s;
		}
		Sequence.DoInsertCallback(s, callback, s.duration);
		return s;
	}

	public static Sequence PrependCallback(this Sequence s, TweenCallback callback)
	{
		if (!ValidateAddToSequence(s, null, ignoreTween: true))
		{
			return s;
		}
		if (callback == null)
		{
			return s;
		}
		Sequence.DoInsertCallback(s, callback, 0f);
		return s;
	}

	public static Sequence InsertCallback(this Sequence s, float atPosition, TweenCallback callback)
	{
		if (!ValidateAddToSequence(s, null, ignoreTween: true))
		{
			return s;
		}
		if (callback == null)
		{
			return s;
		}
		Sequence.DoInsertCallback(s, callback, atPosition);
		return s;
	}

	private static bool ValidateAddToSequence(Sequence s, Tween t, bool ignoreTween = false)
	{
		if (s == null)
		{
			Debugger.Sequence.LogAddToNullSequence();
			return false;
		}
		if (!s.active)
		{
			Debugger.Sequence.LogAddToInactiveSequence();
			return false;
		}
		if (s.creationLocked)
		{
			Debugger.Sequence.LogAddToLockedSequence();
			return false;
		}
		if (!ignoreTween)
		{
			if (t == null)
			{
				Debugger.Sequence.LogAddNullTween();
				return false;
			}
			if (!t.active)
			{
				Debugger.Sequence.LogAddInactiveTween(t);
				return false;
			}
			if (t.isSequenced)
			{
				Debugger.Sequence.LogAddAlreadySequencedTween(t);
				return false;
			}
		}
		return true;
	}

	public static T From<T>(this T t) where T : Tweener
	{
		return t.From(setImmediately: true, isRelative: false);
	}

	public static T From<T>(this T t, bool isRelative) where T : Tweener
	{
		return t.From(setImmediately: true, isRelative);
	}

	public static T From<T>(this T t, bool setImmediately, bool isRelative) where T : Tweener
	{
		if (t == null || !t.active || t.creationLocked || !t.isFromAllowed)
		{
			return t;
		}
		t.isFrom = true;
		if (setImmediately)
		{
			t.SetFrom(isRelative && !t.isBlendable);
		}
		else
		{
			t.isRelative = isRelative;
		}
		return t;
	}

	public static TweenerCore<T1, T2, TPlugOptions> From<T1, T2, TPlugOptions>(this TweenerCore<T1, T2, TPlugOptions> t, T2 fromValue, bool setImmediately = true, bool isRelative = false) where TPlugOptions : struct, IPlugOptions
	{
		if (t == null || !t.active || t.creationLocked || !t.isFromAllowed)
		{
			return t;
		}
		t.isFrom = true;
		t.SetFrom(fromValue, setImmediately, isRelative);
		return t;
	}

	public static TweenerCore<Color, Color, ColorOptions> From(this TweenerCore<Color, Color, ColorOptions> t, float fromAlphaValue, bool setImmediately = true, bool isRelative = false)
	{
		//IL_0035: Unknown result type (might be due to invalid IL or missing references)
		if (t == null || !t.active || t.creationLocked || !t.isFromAllowed)
		{
			return t;
		}
		t.isFrom = true;
		t.SetFrom(new Color(0f, 0f, 0f, fromAlphaValue), setImmediately, isRelative);
		return t;
	}

	public static TweenerCore<Vector3, Vector3, VectorOptions> From(this TweenerCore<Vector3, Vector3, VectorOptions> t, float fromValue, bool setImmediately = true, bool isRelative = false)
	{
		//IL_0028: Unknown result type (might be due to invalid IL or missing references)
		if (t == null || !t.active || t.creationLocked || !t.isFromAllowed)
		{
			return t;
		}
		t.isFrom = true;
		t.SetFrom(new Vector3(fromValue, fromValue, fromValue), setImmediately, isRelative);
		return t;
	}

	public static TweenerCore<Vector2, Vector2, CircleOptions> From(this TweenerCore<Vector2, Vector2, CircleOptions> t, float fromValueDegrees, bool setImmediately = true, bool isRelative = false)
	{
		//IL_002b: Unknown result type (might be due to invalid IL or missing references)
		if (t == null || !t.active || t.creationLocked || !t.isFromAllowed)
		{
			return t;
		}
		t.isFrom = true;
		t.SetFrom(new Vector2(fromValueDegrees, 0f), setImmediately, isRelative);
		return t;
	}

	public static T SetDelay<T>(this T t, float delay) where T : Tween
	{
		if (t == null || !t.active || t.creationLocked)
		{
			return t;
		}
		if (t.tweenType == TweenType.Sequence)
		{
			(t as Sequence).PrependInterval(delay);
		}
		else
		{
			t.delay = delay;
			t.delayComplete = delay <= 0f;
		}
		return t;
	}

	public static T SetDelay<T>(this T t, float delay, bool asPrependedIntervalIfSequence) where T : Tween
	{
		if (t == null || !t.active || t.creationLocked)
		{
			return t;
		}
		if (t.tweenType != TweenType.Sequence || !asPrependedIntervalIfSequence)
		{
			t.delay = delay;
			t.delayComplete = delay <= 0f;
		}
		else
		{
			(t as Sequence).PrependInterval(delay);
		}
		return t;
	}

	public static T SetRelative<T>(this T t) where T : Tween
	{
		if (t == null || !t.active || t.creationLocked || t.isFrom || t.isBlendable)
		{
			return t;
		}
		t.isRelative = true;
		return t;
	}

	public static T SetRelative<T>(this T t, bool isRelative) where T : Tween
	{
		if (t == null || !t.active || t.creationLocked || t.isFrom || t.isBlendable)
		{
			return t;
		}
		t.isRelative = isRelative;
		return t;
	}

	public static T SetSpeedBased<T>(this T t) where T : Tween
	{
		if (t == null || !t.active || t.creationLocked)
		{
			return t;
		}
		t.isSpeedBased = true;
		return t;
	}

	public static T SetSpeedBased<T>(this T t, bool isSpeedBased) where T : Tween
	{
		if (t == null || !t.active || t.creationLocked)
		{
			return t;
		}
		t.isSpeedBased = isSpeedBased;
		return t;
	}

	public static Tweener SetOptions(this TweenerCore<float, float, FloatOptions> t, bool snapping)
	{
		if (t == null || !t.active)
		{
			return t;
		}
		t.plugOptions.snapping = snapping;
		return t;
	}

	public static Tweener SetOptions(this TweenerCore<Vector2, Vector2, VectorOptions> t, bool snapping)
	{
		if (t == null || !t.active)
		{
			return t;
		}
		t.plugOptions.snapping = snapping;
		return t;
	}

	public static Tweener SetOptions(this TweenerCore<Vector2, Vector2, VectorOptions> t, AxisConstraint axisConstraint, bool snapping = false)
	{
		if (t == null || !t.active)
		{
			return t;
		}
		t.plugOptions.axisConstraint = axisConstraint;
		t.plugOptions.snapping = snapping;
		return t;
	}

	public static Tweener SetOptions(this TweenerCore<Vector3, Vector3, VectorOptions> t, bool snapping)
	{
		if (t == null || !t.active)
		{
			return t;
		}
		t.plugOptions.snapping = snapping;
		return t;
	}

	public static Tweener SetOptions(this TweenerCore<Vector3, Vector3, VectorOptions> t, AxisConstraint axisConstraint, bool snapping = false)
	{
		if (t == null || !t.active)
		{
			return t;
		}
		t.plugOptions.axisConstraint = axisConstraint;
		t.plugOptions.snapping = snapping;
		return t;
	}

	public static Tweener SetOptions(this TweenerCore<Vector4, Vector4, VectorOptions> t, bool snapping)
	{
		if (t == null || !t.active)
		{
			return t;
		}
		t.plugOptions.snapping = snapping;
		return t;
	}

	public static Tweener SetOptions(this TweenerCore<Vector4, Vector4, VectorOptions> t, AxisConstraint axisConstraint, bool snapping = false)
	{
		if (t == null || !t.active)
		{
			return t;
		}
		t.plugOptions.axisConstraint = axisConstraint;
		t.plugOptions.snapping = snapping;
		return t;
	}

	public static Tweener SetOptions(this TweenerCore<Quaternion, Vector3, QuaternionOptions> t, bool useShortest360Route = true)
	{
		if (t == null || !t.active)
		{
			return t;
		}
		t.plugOptions.rotateMode = ((!useShortest360Route) ? RotateMode.FastBeyond360 : RotateMode.Fast);
		return t;
	}

	public static Tweener SetOptions(this TweenerCore<Color, Color, ColorOptions> t, bool alphaOnly)
	{
		if (t == null || !t.active)
		{
			return t;
		}
		t.plugOptions.alphaOnly = alphaOnly;
		return t;
	}

	public static Tweener SetOptions(this TweenerCore<Rect, Rect, RectOptions> t, bool snapping)
	{
		if (t == null || !t.active)
		{
			return t;
		}
		t.plugOptions.snapping = snapping;
		return t;
	}

	public static Tweener SetOptions(this TweenerCore<string, string, StringOptions> t, bool richTextEnabled, ScrambleMode scrambleMode = ScrambleMode.None, string scrambleChars = null)
	{
		if (t == null || !t.active)
		{
			return t;
		}
		t.plugOptions.richTextEnabled = richTextEnabled;
		t.plugOptions.scrambleMode = scrambleMode;
		if (!string.IsNullOrEmpty(scrambleChars))
		{
			if (scrambleChars.Length <= 1)
			{
				scrambleChars += scrambleChars;
			}
			t.plugOptions.scrambledChars = scrambleChars.ToCharArray();
			t.plugOptions.scrambledChars.ScrambleChars();
		}
		return t;
	}

	public static Tweener SetOptions(this TweenerCore<Vector3, Vector3[], Vector3ArrayOptions> t, bool snapping)
	{
		if (t == null || !t.active)
		{
			return t;
		}
		t.plugOptions.snapping = snapping;
		return t;
	}

	public static Tweener SetOptions(this TweenerCore<Vector3, Vector3[], Vector3ArrayOptions> t, AxisConstraint axisConstraint, bool snapping = false)
	{
		if (t == null || !t.active)
		{
			return t;
		}
		t.plugOptions.axisConstraint = axisConstraint;
		t.plugOptions.snapping = snapping;
		return t;
	}

	public static Tweener SetOptions(this TweenerCore<Vector2, Vector2, CircleOptions> t, float endValueDegrees, bool relativeCenter = true, bool snapping = false)
	{
		if (t == null || !t.active)
		{
			return t;
		}
		t.plugOptions.endValueDegrees = endValueDegrees;
		t.plugOptions.relativeCenter = relativeCenter;
		t.plugOptions.snapping = snapping;
		return t;
	}

	public static TweenerCore<Vector3, Path, PathOptions> SetOptions(this TweenerCore<Vector3, Path, PathOptions> t, AxisConstraint lockPosition, AxisConstraint lockRotation = AxisConstraint.None)
	{
		return t.SetOptions(closePath: false, lockPosition, lockRotation);
	}

	public static TweenerCore<Vector3, Path, PathOptions> SetOptions(this TweenerCore<Vector3, Path, PathOptions> t, bool closePath, AxisConstraint lockPosition = AxisConstraint.None, AxisConstraint lockRotation = AxisConstraint.None)
	{
		if (t == null || !t.active)
		{
			return t;
		}
		t.plugOptions.isClosedPath = closePath;
		t.plugOptions.lockPositionAxis = lockPosition;
		t.plugOptions.lockRotationAxis = lockRotation;
		return t;
	}

	public static TweenerCore<Vector3, Path, PathOptions> SetLookAt(this TweenerCore<Vector3, Path, PathOptions> t, Vector3 lookAtPosition, Vector3? forwardDirection = null, Vector3? up = null)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		return t.SetLookAt(OrientType.LookAtPosition, lookAtPosition, null, -1f, forwardDirection, up);
	}

	public static TweenerCore<Vector3, Path, PathOptions> SetLookAt(this TweenerCore<Vector3, Path, PathOptions> t, Vector3 lookAtPosition, bool stableZRotation)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		return t.SetLookAt(OrientType.LookAtPosition, lookAtPosition, null, -1f, null, null, stableZRotation);
	}

	public static TweenerCore<Vector3, Path, PathOptions> SetLookAt(this TweenerCore<Vector3, Path, PathOptions> t, Transform lookAtTransform, Vector3? forwardDirection = null, Vector3? up = null)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		return t.SetLookAt(OrientType.LookAtTransform, Vector3.zero, lookAtTransform, -1f, forwardDirection, up);
	}

	public static TweenerCore<Vector3, Path, PathOptions> SetLookAt(this TweenerCore<Vector3, Path, PathOptions> t, Transform lookAtTransform, bool stableZRotation)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		return t.SetLookAt(OrientType.LookAtTransform, Vector3.zero, lookAtTransform, -1f, null, null, stableZRotation);
	}

	public static TweenerCore<Vector3, Path, PathOptions> SetLookAt(this TweenerCore<Vector3, Path, PathOptions> t, float lookAhead, Vector3? forwardDirection = null, Vector3? up = null)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		return t.SetLookAt(OrientType.ToPath, Vector3.zero, null, lookAhead, forwardDirection, up);
	}

	public static TweenerCore<Vector3, Path, PathOptions> SetLookAt(this TweenerCore<Vector3, Path, PathOptions> t, float lookAhead, bool stableZRotation)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		return t.SetLookAt(OrientType.ToPath, Vector3.zero, null, lookAhead, null, null, stableZRotation);
	}

	private static TweenerCore<Vector3, Path, PathOptions> SetLookAt(this TweenerCore<Vector3, Path, PathOptions> t, OrientType orientType, Vector3 lookAtPosition, Transform lookAtTransform, float lookAhead, Vector3? forwardDirection = null, Vector3? up = null, bool stableZRotation = false)
	{
		//IL_0035: Unknown result type (might be due to invalid IL or missing references)
		//IL_0036: Unknown result type (might be due to invalid IL or missing references)
		//IL_006e: Unknown result type (might be due to invalid IL or missing references)
		//IL_006f: Unknown result type (might be due to invalid IL or missing references)
		if (t == null || !t.active)
		{
			return t;
		}
		t.plugOptions.orientType = orientType;
		switch (orientType)
		{
		case OrientType.LookAtPosition:
			t.plugOptions.lookAtPosition = lookAtPosition;
			break;
		case OrientType.LookAtTransform:
			t.plugOptions.lookAtTransform = lookAtTransform;
			break;
		case OrientType.ToPath:
			if (lookAhead < 0.0001f)
			{
				lookAhead = 0.0001f;
			}
			t.plugOptions.lookAhead = lookAhead;
			break;
		}
		t.plugOptions.lookAtPosition = lookAtPosition;
		t.plugOptions.stableZRotation = stableZRotation;
		t.SetPathForwardDirection(forwardDirection, up);
		return t;
	}

	private static void SetPathForwardDirection(this TweenerCore<Vector3, Path, PathOptions> t, Vector3? forwardDirection = null, Vector3? up = null)
	{
		//IL_001d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0022: Unknown result type (might be due to invalid IL or missing references)
		//IL_0055: Unknown result type (might be due to invalid IL or missing references)
		//IL_005a: Unknown result type (might be due to invalid IL or missing references)
		//IL_003d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0042: Unknown result type (might be due to invalid IL or missing references)
		//IL_009a: Unknown result type (might be due to invalid IL or missing references)
		//IL_009f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0075: Unknown result type (might be due to invalid IL or missing references)
		//IL_007a: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ba: Unknown result type (might be due to invalid IL or missing references)
		//IL_00bf: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00eb: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e4: Unknown result type (might be due to invalid IL or missing references)
		//IL_0102: Unknown result type (might be due to invalid IL or missing references)
		//IL_00fb: Unknown result type (might be due to invalid IL or missing references)
		//IL_0107: Unknown result type (might be due to invalid IL or missing references)
		//IL_010c: Unknown result type (might be due to invalid IL or missing references)
		if (t == null || !t.active)
		{
			return;
		}
		ref PathOptions plugOptions = ref t.plugOptions;
		int hasCustomForwardDirection;
		if (forwardDirection.HasValue)
		{
			Vector3? val = forwardDirection;
			Vector3 zero = Vector3.zero;
			if (!val.HasValue || (val.HasValue && val.GetValueOrDefault() != zero))
			{
				hasCustomForwardDirection = 1;
				goto IL_0086;
			}
		}
		if (up.HasValue)
		{
			Vector3? val = up;
			Vector3 zero = Vector3.zero;
			hasCustomForwardDirection = ((!val.HasValue || (val.HasValue && val.GetValueOrDefault() != zero)) ? 1 : 0);
		}
		else
		{
			hasCustomForwardDirection = 0;
		}
		goto IL_0086;
		IL_0086:
		plugOptions.hasCustomForwardDirection = (byte)hasCustomForwardDirection != 0;
		if (t.plugOptions.hasCustomForwardDirection)
		{
			Vector3? val = forwardDirection;
			Vector3 zero = Vector3.zero;
			if (val.HasValue && (!val.HasValue || val.GetValueOrDefault() == zero))
			{
				forwardDirection = Vector3.forward;
			}
			t.plugOptions.forward = Quaternion.LookRotation((!forwardDirection.HasValue) ? Vector3.forward : forwardDirection.Value, (!up.HasValue) ? Vector3.up : up.Value);
		}
	}
}
