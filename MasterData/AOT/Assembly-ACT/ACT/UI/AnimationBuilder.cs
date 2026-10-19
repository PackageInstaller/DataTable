using System;
using System.Collections.Generic;
using System.Threading;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.Pool;

namespace ACT.UI;

public class AnimationBuilder
{
	public static readonly ObjectPool<AnimationBuilder> Pool = new ObjectPool<AnimationBuilder>(() => new AnimationBuilder(), null, (AnimationBuilder builder) =>
	{
		builder.Reset();
	});

	private string _name;

	private BetterAnimation _mono;

	private Animation _animation;

	private Action<AnimationBuilder> _onPlay;

	private Action<AnimationBuilder> _onAnimationPlay;

	private Action<AnimationBuilder> _onComplete;

	private Action<AnimationBuilder> _internalComplete;

	private float _delay;

	private int _loop = 1;

	private bool _isComplete;

	private bool _pause;

	private float _time;

	private CancellationTokenSource _cancellationTokenSource;

	private UniTask _task;

	public string Name => _name;

	private Dictionary<string, Action> _namedEvents { get; } = new Dictionary<string, Action>();

	private Dictionary<float, Action> _timeEvents { get; } = new Dictionary<float, Action>();

	private Dictionary<float, string> _namedEventsTime { get; } = new Dictionary<float, string>();

	public void Init(BetterAnimation mono, Animation animation, string name)
	{
		_name = name;
		_animation = animation;
		_mono = mono;
		_cancellationTokenSource = CancellationTokenSource.CreateLinkedTokenSource(mono.destroyCancellationToken);
		AnimationEvent[] events = _animation[_name].clip.events;
		foreach (AnimationEvent animationEvent in events)
		{
			_namedEventsTime[animationEvent.time] = animationEvent.stringParameter;
		}
		_animation[_name].speed = 1f;
	}

	private void Reset()
	{
		_name = null;
		_mono = null;
		_animation = null;
		_namedEvents.Clear();
		_timeEvents.Clear();
		_namedEventsTime.Clear();
		_onPlay = null;
		_onAnimationPlay = null;
		_onComplete = null;
		_internalComplete = null;
		_pause = false;
		_time = 0f;
		_loop = 1;
		_isComplete = false;
		_task = default;
	}

	public void InsertCallback(float time, Action callback)
	{
		_timeEvents.Add(time, callback);
	}

	public AnimationBuilder OnPlay(Action<AnimationBuilder> action)
	{
		_onPlay = (Action<AnimationBuilder>)Delegate.Combine(_onPlay, action);
		return this;
	}

	public AnimationBuilder OnAnimationPlay(Action<AnimationBuilder> action)
	{
		_onAnimationPlay = (Action<AnimationBuilder>)Delegate.Combine(_onAnimationPlay, action);
		return this;
	}

	public AnimationBuilder OnComplete(Action<AnimationBuilder> action)
	{
		_onComplete = (Action<AnimationBuilder>)Delegate.Combine(_onComplete, action);
		if (IsComplete() && (bool)_mono)
		{
			action?.Invoke(this);
		}
		return this;
	}

	public void OnInternalComplete(Action<AnimationBuilder> action)
	{
		_internalComplete = (Action<AnimationBuilder>)Delegate.Combine(_internalComplete, action);
		if (IsComplete())
		{
			action?.Invoke(this);
		}
	}

	public AnimationBuilder OnEvent(string evtName, Action action)
	{
		if (!_namedEvents.TryGetValue(evtName, out var _))
		{
			_namedEvents.Add(evtName, action);
		}
		else
		{
			Dictionary<string, Action> namedEvents = _namedEvents;
			namedEvents[evtName] = (Action)Delegate.Combine(namedEvents[evtName], action);
		}
		return this;
	}

	public AnimationBuilder ClearAllEvent()
	{
		_onPlay = null;
		_onComplete = null;
		_namedEvents.Clear();
		_timeEvents.Clear();
		return this;
	}

	public AnimationBuilder SetLoops(int loop)
	{
		_loop = loop;
		return this;
	}

	public AnimationBuilder SetDelay(float delay)
	{
		_delay = delay;
		return this;
	}

	public AnimationBuilder SetDelay(TimeSpan delay)
	{
		_delay = (float)delay.TotalSeconds;
		return this;
	}

	public void Complete()
	{
		if (!_isComplete)
		{
			_loop = 0;
			_delay = 0f;
			_isComplete = true;
			_mono.StopAllCoroutines();
			if (!_animation[_name].enabled)
			{
				_animation.Play(_name);
			}
			_animation[_name].time = _animation[_name].length;
			_animation.Sample();
			_animation.Stop();
			TriggerEvent(_time, _animation[_name].length + 0.01f);
			InvokeCompleteCallbacks();
		}
	}

	public AnimationBuilder Goto(float to)
	{
		_time = Mathf.Min(_animation[_name].length, to);
		_animation.Play(_name);
		_animation[_name].enabled = true;
		_animation[_name].time = _time;
		_animation.Sample();
		_animation.Stop();
		return this;
	}

	public void Pause()
	{
		_pause = true;
		_animation[_name].speed = 0f;
	}

	public void Continue()
	{
		_pause = false;
		_animation[_name].speed = 1f;
	}

	public void Stop()
	{
		_cancellationTokenSource.Cancel();
		_cancellationTokenSource.Dispose();
		_animation.Stop();
	}

	public AnimationBuilder Play()
	{
		if (_isComplete)
		{
			return this;
		}
		_task = PlayLoopAnimation(_cancellationTokenSource.Token);
		return this;
	}

	public AnimationBuilder PlayInQueue(string queueName)
	{
		AnimationQueueDriver.Default.PlayInQueue(queueName, this);
		return this;
	}

	public bool IsComplete()
	{
		return _isComplete;
	}

	public float Duration()
	{
		return _animation[_name].length;
	}

	public int DurationToMs()
	{
		return (int)(Duration() * 1000f);
	}

	public int ElapsedSeconds()
	{
		return (int)(_animation[_name].normalizedTime * Duration());
	}

	public int RemainSeconds()
	{
		return (int)(Duration() - (float)ElapsedSeconds());
	}

	public void SetSpeed(float speed)
	{
		_animation[_name].speed = speed;
	}

	public float GetSpeed()
	{
		return _animation[_name].speed;
	}

	public async UniTask AwaitComplete()
	{
		await _task;
	}

	private async UniTask PlayLoopAnimation(CancellationToken cancellationToken)
	{
		_onPlay?.Invoke(this);
		while (_delay > 0f && (bool)_animation)
		{
			_delay -= Time.deltaTime;
			await UniTask.Yield(cancellationToken);
		}
		if (cancellationToken.IsCancellationRequested)
		{
			return;
		}
		_onAnimationPlay?.Invoke(this);
		while (_loop != 0 && (bool)_animation)
		{
			if (_loop > 0)
			{
				if (!(await PlayAnimation(cancellationToken)))
				{
					break;
				}
				if (_loop > 0)
				{
					_loop--;
				}
			}
			else if (!(await PlayAnimation(cancellationToken)))
			{
				break;
			}
			if (cancellationToken.IsCancellationRequested)
			{
				return;
			}
		}
		if (!cancellationToken.IsCancellationRequested)
		{
			_isComplete = true;
			InvokeCompleteCallbacks();
		}
	}

	private void InvokeCompleteCallbacks()
	{
		if ((bool)_mono)
		{
			_onComplete?.Invoke(this);
			_internalComplete?.Invoke(this);
		}
	}

	private async UniTask<bool> PlayAnimation(CancellationToken cancellationToken)
	{
		if (!_animation || string.IsNullOrEmpty(_name))
		{
			return false;
		}
		_animation.Play(_name);
		AnimationState animationState = _animation[_name];
		if (animationState == null || !animationState.enabled)
		{
			return false;
		}
		animationState.time = _time;
		while ((bool)_animation)
		{
			animationState = _animation[_name];
			if (animationState == null || !animationState.enabled)
			{
				break;
			}
			float time = animationState.time;
			TriggerEvent(_time, time);
			_time = animationState.time;
			await UniTask.Yield(cancellationToken);
		}
		if (cancellationToken.IsCancellationRequested || !_animation)
		{
			return false;
		}
		animationState = _animation[_name];
		if (animationState == null)
		{
			return false;
		}
		TriggerEvent(_time, animationState.length + 0.01f);
		_time = 0f;
		return true;
	}

	private void TriggerEvent(float lastTime, float nextTime)
	{
		foreach (KeyValuePair<float, Action> timeEvent in _timeEvents)
		{
			float key = timeEvent.Key;
			if (key >= lastTime && key < nextTime)
			{
				timeEvent.Value?.Invoke();
			}
		}
		foreach (KeyValuePair<float, string> item in _namedEventsTime)
		{
			float key2 = item.Key;
			if (key2 >= lastTime && key2 < nextTime && _namedEvents.TryGetValue(item.Value, out var value))
			{
				value?.Invoke();
			}
		}
	}
}
