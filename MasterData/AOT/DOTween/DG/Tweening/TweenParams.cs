using DG.Tweening.Core.Easing;
using UnityEngine;

namespace DG.Tweening;

public class TweenParams
{
	public static readonly TweenParams Params = new TweenParams();

	internal object id;

	internal string stringId;

	internal int intId = -999;

	internal object target;

	internal UpdateType updateType;

	internal bool isIndependentUpdate;

	internal TweenCallback onStart;

	internal TweenCallback onPlay;

	internal TweenCallback onRewind;

	internal TweenCallback onUpdate;

	internal TweenCallback onStepComplete;

	internal TweenCallback onComplete;

	internal TweenCallback onKill;

	internal TweenCallback<int> onWaypointChange;

	internal bool isRecyclable;

	internal bool isSpeedBased;

	internal bool autoKill;

	internal int loops;

	internal LoopType loopType;

	internal float delay;

	internal bool isRelative;

	internal Ease easeType;

	internal EaseFunction customEase;

	internal float easeOvershootOrAmplitude;

	internal float easePeriod;

	public TweenParams()
	{
		Clear();
	}

	public TweenParams Clear()
	{
		id = (target = null);
		stringId = null;
		intId = -999;
		updateType = DOTween.defaultUpdateType;
		isIndependentUpdate = DOTween.defaultTimeScaleIndependent;
		onStart = (onPlay = (onRewind = (onUpdate = (onStepComplete = (onComplete = (onKill = null))))));
		onWaypointChange = null;
		isRecyclable = DOTween.defaultRecyclable;
		isSpeedBased = false;
		autoKill = DOTween.defaultAutoKill;
		loops = 1;
		loopType = DOTween.defaultLoopType;
		delay = 0f;
		isRelative = false;
		easeType = Ease.Unset;
		customEase = null;
		easeOvershootOrAmplitude = DOTween.defaultEaseOvershootOrAmplitude;
		easePeriod = DOTween.defaultEasePeriod;
		return this;
	}

	public TweenParams SetAutoKill(bool autoKillOnCompletion = true)
	{
		autoKill = autoKillOnCompletion;
		return this;
	}

	public TweenParams SetId(object objectId)
	{
		id = objectId;
		return this;
	}

	public TweenParams SetId(string stringId)
	{
		this.stringId = stringId;
		return this;
	}

	public TweenParams SetId(int intId)
	{
		this.intId = intId;
		return this;
	}

	public TweenParams SetTarget(object target)
	{
		this.target = target;
		return this;
	}

	public TweenParams SetLoops(int loops, LoopType? loopType = null)
	{
		if (loops < -1)
		{
			loops = -1;
		}
		else if (loops == 0)
		{
			loops = 1;
		}
		this.loops = loops;
		if (loopType.HasValue)
		{
			this.loopType = loopType.Value;
		}
		return this;
	}

	public TweenParams SetEase(Ease ease, float? overshootOrAmplitude = null, float? period = null)
	{
		easeType = ease;
		easeOvershootOrAmplitude = (overshootOrAmplitude.HasValue ? overshootOrAmplitude.Value : DOTween.defaultEaseOvershootOrAmplitude);
		easePeriod = (period.HasValue ? period.Value : DOTween.defaultEasePeriod);
		customEase = null;
		return this;
	}

	public TweenParams SetEase(AnimationCurve animCurve)
	{
		easeType = Ease.INTERNAL_Custom;
		customEase = new EaseCurve(animCurve).Evaluate;
		return this;
	}

	public TweenParams SetEase(EaseFunction customEase)
	{
		easeType = Ease.INTERNAL_Custom;
		this.customEase = customEase;
		return this;
	}

	public TweenParams SetRecyclable(bool recyclable = true)
	{
		isRecyclable = recyclable;
		return this;
	}

	public TweenParams SetUpdate(bool isIndependentUpdate)
	{
		updateType = DOTween.defaultUpdateType;
		this.isIndependentUpdate = isIndependentUpdate;
		return this;
	}

	public TweenParams SetUpdate(UpdateType updateType, bool isIndependentUpdate = false)
	{
		this.updateType = updateType;
		this.isIndependentUpdate = isIndependentUpdate;
		return this;
	}

	public TweenParams OnStart(TweenCallback action)
	{
		onStart = action;
		return this;
	}

	public TweenParams OnPlay(TweenCallback action)
	{
		onPlay = action;
		return this;
	}

	public TweenParams OnRewind(TweenCallback action)
	{
		onRewind = action;
		return this;
	}

	public TweenParams OnUpdate(TweenCallback action)
	{
		onUpdate = action;
		return this;
	}

	public TweenParams OnStepComplete(TweenCallback action)
	{
		onStepComplete = action;
		return this;
	}

	public TweenParams OnComplete(TweenCallback action)
	{
		onComplete = action;
		return this;
	}

	public TweenParams OnKill(TweenCallback action)
	{
		onKill = action;
		return this;
	}

	public TweenParams OnWaypointChange(TweenCallback<int> action)
	{
		onWaypointChange = action;
		return this;
	}

	public TweenParams SetDelay(float delay)
	{
		this.delay = delay;
		return this;
	}

	public TweenParams SetRelative(bool isRelative = true)
	{
		this.isRelative = isRelative;
		return this;
	}

	public TweenParams SetSpeedBased(bool isSpeedBased = true)
	{
		this.isSpeedBased = isSpeedBased;
		return this;
	}
}
