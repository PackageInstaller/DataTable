using System;
using Com.ForbiddenByte.OSA.Core;
using Com.ForbiddenByte.OSA.Core.Data.Animations;
using UnityEngine;

namespace Com.ForbiddenByte.OSA.Util.Animations;

public class ExpandCollapseAnimationState
{
	public readonly float expandingStartTime;

	public float initialExpandedAmount;

	public float targetExpandedAmount;

	public float duration;

	public int itemIndex;

	private bool _ForcefullyFinished;

	private readonly bool _UseUnscaledTime;

	private readonly Func<double, double> _Fn;

	public float CurrentExpandedAmount => Mathf.Lerp(initialExpandedAmount, targetExpandedAmount, Progress01);

	public float CurrentExpandedAmountInverse => Mathf.Lerp(targetExpandedAmount, initialExpandedAmount, Progress01);

	public float Progress01 => CurrentAnimationElapsedTimeSmooth01;

	public bool IsDone => CurrentAnimationElapsedTime01 == 1f;

	public bool IsExpanding => targetExpandedAmount > initialExpandedAmount;

	private float CurrentAnimationElapsedTime01
	{
		get
		{
			if (_ForcefullyFinished)
			{
				return 1f;
			}
			if (duration == 0f)
			{
				return 1f;
			}
			float num = (Time - expandingStartTime) / duration;
			if (num >= 1f)
			{
				num = 1f;
			}
			return num;
		}
	}

	private float CurrentAnimationElapsedTimeSmooth01
	{
		get
		{
			float currentAnimationElapsedTime = CurrentAnimationElapsedTime01;
			if (currentAnimationElapsedTime == 1f)
			{
				return currentAnimationElapsedTime;
			}
			return (float)_Fn(currentAnimationElapsedTime);
		}
	}

	private float Time
	{
		get
		{
			if (!_UseUnscaledTime)
			{
				return UnityEngine.Time.time;
			}
			return UnityEngine.Time.unscaledTime;
		}
	}

	public ExpandCollapseAnimationState(bool useUnscaledTime, AnimationFunctionType animationFunctionType = AnimationFunctionType.SLOW_OUT)
	{
		_UseUnscaledTime = useUnscaledTime;
		_Fn = OSAMath.GetLerpFunction(animationFunctionType);
		expandingStartTime = Time;
	}

	public void ForceFinish()
	{
		_ForcefullyFinished = true;
	}
}
