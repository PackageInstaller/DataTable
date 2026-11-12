using System;
using TrueSync;

public class AdventureTimeControlHandler
{
	public enum TimeScaleType
	{
		Normal,
		FreezeFrame
	}

	public bool isLogicTime;

	public FP timeScaleTo;

	public FP transitionIn;

	public FP duration;

	public FP transitionOut;

	public TimeScaleType timeScaleType;

	public FP elapsedTime;

	public Action onFinish;

	private bool _isFinish;

	public FP fullDuration => transitionIn + duration + transitionOut;

	public FP normalizedTime
	{
		get
		{
			FP fP = fullDuration;
			if (!(fP > FP.Zero))
			{
				return FP.One;
			}
			return TSMath.Clamp01(elapsedTime / fP);
		}
	}

	public FP timeScale { get; protected set; }

	public bool isFinish
	{
		get
		{
			return _isFinish;
		}
		internal set
		{
			_isFinish = value;
			if (_isFinish)
			{
				onFinish?.Invoke();
				onFinish = null;
			}
		}
	}

	public void SeekToTransitionIn()
	{
		elapsedTime = FP.Zero;
	}

	public void SeekToTransitionOut()
	{
		elapsedTime = transitionIn + duration;
	}

	public void Reset()
	{
		isLogicTime = false;
		timeScaleTo = FP.Zero;
		transitionIn = FP.Zero;
		duration = FP.Zero;
		transitionOut = FP.Zero;
		elapsedTime = FP.Zero;
		timeScale = FP.One;
		isFinish = false;
		onFinish = null;
	}

	public void Update(FP deltaTime)
	{
		if (!isFinish)
		{
			elapsedTime += deltaTime;
			if (elapsedTime >= fullDuration)
			{
				timeScale = FP.One;
				isFinish = true;
			}
			else if (elapsedTime >= transitionIn + duration)
			{
				FP t = (elapsedTime - (transitionIn + duration)) / transitionOut;
				timeScale = TSFloatEase.Easing(TSFloatEase.EaseType.EaseInCubic, timeScaleTo, FP.One, t);
			}
			else if (elapsedTime >= transitionIn)
			{
				timeScale = timeScaleTo;
			}
			else
			{
				FP t2 = elapsedTime / transitionIn;
				timeScale = TSFloatEase.Easing(TSFloatEase.EaseType.EaseOutCubic, FP.One, timeScaleTo, t2);
			}
		}
	}

	public void Stop()
	{
		if (!isFinish)
		{
			isFinish = true;
		}
	}
}
