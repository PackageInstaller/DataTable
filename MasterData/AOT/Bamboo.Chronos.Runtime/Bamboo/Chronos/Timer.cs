using System;
using Bamboo.HeartBeat;

namespace Bamboo.Chronos;

public class Timer : IDisposable
{
	private readonly Beat _timeBeat;

	private readonly Beat _frameBeat;

	private EventDelay _timeDelay;

	private EventDelay _frameDelay;

	private EventLoop _timeLoop;

	private EventLoop _frameLoop;

	private EventTween _timeTween;

	private EventTween _frameTween;

	public Timer(Beat timeBeat, Beat frameBeat)
	{
		_timeBeat = timeBeat;
		_frameBeat = frameBeat;
	}

	public void Dispose()
	{
		if (_timeDelay != null && _timeBeat != null)
		{
			_timeBeat.Remove(_timeDelay.Update);
		}
		if (_frameDelay != null && _frameBeat != null)
		{
			_frameBeat.Remove(_frameDelay.Update);
		}
		if (_timeLoop != null && _timeBeat != null)
		{
			_timeBeat.Remove(_timeLoop.Update);
		}
		if (_frameLoop != null && _frameBeat != null)
		{
			_frameBeat.Remove(_frameLoop.Update);
		}
		if (_timeTween != null && _timeBeat != null)
		{
			_timeBeat.Remove(_timeTween.Update);
		}
		if (_frameTween != null && _frameBeat != null)
		{
			_frameBeat.Remove(_frameTween.Update);
		}
		_timeDelay = null;
		_frameDelay = null;
		_timeLoop = null;
		_frameLoop = null;
		_timeTween = null;
		_frameTween = null;
	}

	public Delayer DelayMs(int delayMs, Action action)
	{
		if (_timeDelay == null)
		{
			_timeDelay = new EventDelay();
			_timeBeat.Add(_timeDelay.Update);
		}
		return _timeDelay.Add(delayMs, action);
	}

	public Delayer DelayMs<T>(int delayMs, Action<T> action, T arg)
	{
		if (_timeDelay == null)
		{
			_timeDelay = new EventDelay();
			_timeBeat.Add(_timeDelay.Update);
		}
		return _timeDelay.Add(delayMs, action, arg);
	}

	public Delayer DelayMs<T1, T2>(int delayMs, Action<T1, T2> action, T1 arg1, T2 arg2)
	{
		if (_timeDelay == null)
		{
			_timeDelay = new EventDelay();
			_timeBeat.Add(_timeDelay.Update);
		}
		return _timeDelay.Add(delayMs, action, arg1, arg2);
	}

	public Delayer DelayMs<T1, T2, T3>(int delayMs, Action<T1, T2, T3> action, T1 arg1, T2 arg2, T3 arg3)
	{
		if (_timeDelay == null)
		{
			_timeDelay = new EventDelay();
			_timeBeat.Add(_timeDelay.Update);
		}
		return _timeDelay.Add(delayMs, action, arg1, arg2, arg3);
	}

	public Looper LoopMs(int delayMs, Action action)
	{
		if (_timeLoop == null)
		{
			_timeLoop = new EventLoop();
			_timeBeat.Add(_timeLoop.Update);
		}
		return _timeLoop.Add(delayMs, action);
	}

	public Looper LoopMs<T>(int delayMs, Action<T> action, T arg)
	{
		if (_timeLoop == null)
		{
			_timeLoop = new EventLoop();
			_timeBeat.Add(_timeLoop.Update);
		}
		return _timeLoop.Add(delayMs, action, arg);
	}

	public Looper LoopMs<T1, T2>(int delayMs, Action<T1, T2> action, T1 arg1, T2 arg2)
	{
		if (_timeLoop == null)
		{
			_timeLoop = new EventLoop();
			_timeBeat.Add(_timeLoop.Update);
		}
		return _timeLoop.Add(delayMs, action, arg1, arg2);
	}

	public Looper LoopMs<T1, T2, T3>(int delayMs, Action<T1, T2, T3> action, T1 arg1, T2 arg2, T3 arg3)
	{
		if (_timeLoop == null)
		{
			_timeLoop = new EventLoop();
			_timeBeat.Add(_timeLoop.Update);
		}
		return _timeLoop.Add(delayMs, action, arg1, arg2, arg3);
	}

	public Tweener TweenMs(int durationMs, Action<int> onUpdate, Action<bool> onComplete)
	{
		if (_timeTween == null)
		{
			_timeTween = new EventTween();
			_timeBeat.Add(_timeTween.Update);
		}
		return _timeTween.Add(durationMs, onUpdate, onComplete);
	}

	public Tweener TweenMs<T>(int durationMs, Action<T, int> onUpdate, Action<T, bool> onComplete, T arg)
	{
		if (_timeTween == null)
		{
			_timeTween = new EventTween();
			_timeBeat.Add(_timeTween.Update);
		}
		return _timeTween.Add(durationMs, onUpdate, onComplete, arg);
	}

	public Tweener TweenMs<T1, T2>(int durationMs, Action<T1, T2, int> onUpdate, Action<T1, T2, bool> onComplete, T1 arg1, T2 arg2)
	{
		if (_timeTween == null)
		{
			_timeTween = new EventTween();
			_timeBeat.Add(_timeTween.Update);
		}
		return _timeTween.Add(durationMs, onUpdate, onComplete, arg1, arg2);
	}

	public Tweener TweenMs<T1, T2, T3>(int durationMs, Action<T1, T2, T3, int> onUpdate, Action<T1, T2, T3, bool> onComplete, T1 arg1, T2 arg2, T3 arg3)
	{
		if (_timeTween == null)
		{
			_timeTween = new EventTween();
			_timeBeat.Add(_timeTween.Update);
		}
		return _timeTween.Add(durationMs, onUpdate, onComplete, arg1, arg2, arg3);
	}

	public Delayer DelayFrame(int frame, Action action)
	{
		if (_frameDelay == null)
		{
			_frameDelay = new EventDelay();
			_frameBeat.Add(_frameDelay.Update);
		}
		return _frameDelay.Add(frame, action);
	}

	public Delayer DelayFrame<T>(int frame, Action<T> action, T arg)
	{
		if (_frameDelay == null)
		{
			_frameDelay = new EventDelay();
			_frameBeat.Add(_frameDelay.Update);
		}
		return _frameDelay.Add(frame, action, arg);
	}

	public Delayer DelayFrame<T1, T2>(int frame, Action<T1, T2> action, T1 arg1, T2 arg2)
	{
		if (_frameDelay == null)
		{
			_frameDelay = new EventDelay();
			_frameBeat.Add(_frameDelay.Update);
		}
		return _frameDelay.Add(frame, action, arg1, arg2);
	}

	public Delayer DelayFrame<T1, T2, T3>(int frame, Action<T1, T2, T3> action, T1 arg1, T2 arg2, T3 arg3)
	{
		if (_frameDelay == null)
		{
			_frameDelay = new EventDelay();
			_frameBeat.Add(_frameDelay.Update);
		}
		return _frameDelay.Add(frame, action, arg1, arg2, arg3);
	}

	public Looper LoopFrame(int frame, Action action)
	{
		if (_frameLoop == null)
		{
			_frameLoop = new EventLoop();
			_frameBeat.Add(_frameLoop.Update);
		}
		return _frameLoop.Add(frame, action);
	}

	public Looper LoopFrame<T>(int frame, Action<T> action, T arg)
	{
		if (_frameLoop == null)
		{
			_frameLoop = new EventLoop();
			_frameBeat.Add(_frameLoop.Update);
		}
		return _frameLoop.Add(frame, action, arg);
	}

	public Looper LoopFrame<T1, T2>(int frame, Action<T1, T2> action, T1 arg1, T2 arg2)
	{
		if (_frameLoop == null)
		{
			_frameLoop = new EventLoop();
			_frameBeat.Add(_frameLoop.Update);
		}
		return _frameLoop.Add(frame, action, arg1, arg2);
	}

	public Looper LoopFrame<T1, T2, T3>(int frame, Action<T1, T2, T3> action, T1 arg1, T2 arg2, T3 arg3)
	{
		if (_frameLoop == null)
		{
			_frameLoop = new EventLoop();
			_frameBeat.Add(_frameLoop.Update);
		}
		return _frameLoop.Add(frame, action, arg1, arg2, arg3);
	}

	public Tweener TweenFrame(int durationMs, Action<int> onUpdate, Action<bool> onComplete)
	{
		if (_frameTween != null)
		{
			_frameTween = new EventTween();
			_frameBeat.Add(_frameTween.Update);
		}
		return _frameTween.Add(durationMs, onUpdate, onComplete);
	}

	public Tweener TweenFrame<T>(int durationMs, Action<T, int> onUpdate, Action<T, bool> onComplete, T arg)
	{
		if (_frameTween != null)
		{
			_frameTween = new EventTween();
			_frameBeat.Add(_frameTween.Update);
		}
		return _frameTween.Add(durationMs, onUpdate, onComplete, arg);
	}

	public Tweener TweenFrame<T1, T2>(int durationMs, Action<T1, T2, int> onUpdate, Action<T1, T2, bool> onComplete, T1 arg1, T2 arg2)
	{
		if (_frameTween != null)
		{
			_frameTween = new EventTween();
			_frameBeat.Add(_frameTween.Update);
		}
		return _frameTween.Add(durationMs, onUpdate, onComplete, arg1, arg2);
	}

	public Tweener TweenFrame<T1, T2, T3>(int durationMs, Action<T1, T2, T3, int> onUpdate, Action<T1, T2, T3, bool> onComplete, T1 arg1, T2 arg2, T3 arg3)
	{
		if (_frameTween != null)
		{
			_frameTween = new EventTween();
			_frameBeat.Add(_frameTween.Update);
		}
		return _frameTween.Add(durationMs, onUpdate, onComplete, arg1, arg2, arg3);
	}

	public void CancelAll()
	{
		if (_timeDelay != null)
		{
			_timeDelay.CancelAll();
		}
		if (_frameDelay != null)
		{
			_frameDelay.CancelAll();
		}
		if (_timeLoop != null)
		{
			_timeLoop.CancelAll();
		}
		if (_frameLoop != null)
		{
			_frameLoop.CancelAll();
		}
		if (_timeTween != null)
		{
			_timeTween.CancelAll();
		}
		if (_frameTween != null)
		{
			_frameTween.CancelAll();
		}
	}

	public void PauseAll()
	{
		if (_timeDelay != null)
		{
			_timeDelay.PauseAll();
		}
		if (_frameDelay != null)
		{
			_frameDelay.PauseAll();
		}
		if (_timeLoop != null)
		{
			_timeLoop.PauseAll();
		}
		if (_frameLoop != null)
		{
			_frameLoop.PauseAll();
		}
		if (_timeTween != null)
		{
			_timeTween.PauseAll();
		}
		if (_frameTween != null)
		{
			_frameTween.PauseAll();
		}
	}

	public void ResumeAll()
	{
		if (_timeDelay != null)
		{
			_timeDelay.ResumeAll();
		}
		if (_frameDelay != null)
		{
			_frameDelay.ResumeAll();
		}
		if (_timeLoop != null)
		{
			_timeLoop.ResumeAll();
		}
		if (_frameLoop != null)
		{
			_frameLoop.ResumeAll();
		}
		if (_timeTween != null)
		{
			_timeTween.ResumeAll();
		}
		if (_frameTween != null)
		{
			_frameTween.ResumeAll();
		}
	}
}
