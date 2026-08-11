using System;
using System.Collections.Generic;
using JetBrains.Annotations;
using UnityEngine;

namespace Ase;

public class Timer
{
	private class TimerManager : MonoBehaviour
	{
		private List<Timer> _timers = new List<Timer>();

		private List<Timer> _timersToAdd = new List<Timer>();

		public void RegisterTimer(Timer timer)
		{
			_timersToAdd.Add(timer);
		}

		public void CancelAllTimers()
		{
			foreach (Timer timer in _timers)
			{
				timer.Cancel();
			}
			_timers = new List<Timer>();
			_timersToAdd = new List<Timer>();
		}

		public void PauseAllTimers()
		{
			foreach (Timer timer in _timers)
			{
				timer.Pause();
			}
		}

		public void ResumeAllTimers()
		{
			foreach (Timer timer in _timers)
			{
				timer.Resume();
			}
		}

		[UsedImplicitly]
		private void Update()
		{
			UpdateAllTimers();
		}

		private void UpdateAllTimers()
		{
			if (_timersToAdd.Count > 0)
			{
				_timers.AddRange(_timersToAdd);
				_timersToAdd.Clear();
			}
			foreach (Timer timer in _timers)
			{
				timer.Update();
			}
			_timers.RemoveAll((Timer t) => t.isDone);
		}
	}

	private static TimerManager _manager;

	private readonly Action _onComplete;

	private readonly Action<float> _onUpdate;

	private float _startTime;

	private float _lastUpdateTime;

	private float? _timeElapsedBeforeCancel;

	private float? _timeElapsedBeforePause;

	private readonly MonoBehaviour _autoDestroyOwner;

	private readonly bool _hasAutoDestroyOwner;

	public float duration { get; private set; }

	public bool isLooped { get; set; }

	public bool isCompleted { get; private set; }

	public bool usesRealTime { get; private set; }

	public bool isPaused => _timeElapsedBeforePause.HasValue;

	public bool isCancelled => _timeElapsedBeforeCancel.HasValue;

	public bool isDone
	{
		get
		{
			if (!isCompleted && !isCancelled)
			{
				return isOwnerDestroyed;
			}
			return true;
		}
	}

	private bool isOwnerDestroyed
	{
		get
		{
			if (_hasAutoDestroyOwner)
			{
				return _autoDestroyOwner == null;
			}
			return false;
		}
	}

	public static Timer Register(float duration, Action onComplete, Action<float> onUpdate = null, bool isLooped = false, bool useRealTime = false, MonoBehaviour autoDestroyOwner = null)
	{
		if (_manager == null)
		{
			TimerManager timerManager = UnityEngine.Object.FindObjectOfType<TimerManager>();
			if (timerManager != null)
			{
				_manager = timerManager;
			}
			else
			{
				_manager = new GameObject
				{
					name = "TimerManager"
				}.AddComponent<TimerManager>();
			}
		}
		Timer timer = new Timer(duration, onComplete, onUpdate, isLooped, useRealTime, autoDestroyOwner);
		_manager.RegisterTimer(timer);
		return timer;
	}

	public static void Cancel(Timer timer)
	{
		timer?.Cancel();
	}

	public static void Pause(Timer timer)
	{
		timer?.Pause();
	}

	public static void Resume(Timer timer)
	{
		timer?.Resume();
	}

	public static void CancelAllRegisteredTimers()
	{
		if (_manager != null)
		{
			_manager.CancelAllTimers();
		}
	}

	public static void PauseAllRegisteredTimers()
	{
		if (_manager != null)
		{
			_manager.PauseAllTimers();
		}
	}

	public static void ResumeAllRegisteredTimers()
	{
		if (_manager != null)
		{
			_manager.ResumeAllTimers();
		}
	}

	public void Cancel()
	{
		if (!isDone)
		{
			_timeElapsedBeforeCancel = GetTimeElapsed();
			_timeElapsedBeforePause = null;
		}
	}

	public void Pause()
	{
		if (!isPaused && !isDone)
		{
			_timeElapsedBeforePause = GetTimeElapsed();
		}
	}

	public void Resume()
	{
		if (isPaused && !isDone)
		{
			_timeElapsedBeforePause = null;
		}
	}

	public float GetTimeElapsed()
	{
		if (isCompleted || GetWorldTime() >= GetFireTime())
		{
			return duration;
		}
		return _timeElapsedBeforeCancel ?? _timeElapsedBeforePause ?? (GetWorldTime() - _startTime);
	}

	public float GetTimeRemaining()
	{
		return duration - GetTimeElapsed();
	}

	public float GetRatioComplete()
	{
		return GetTimeElapsed() / duration;
	}

	public float GetRatioRemaining()
	{
		return GetTimeRemaining() / duration;
	}

	private Timer(float duration, Action onComplete, Action<float> onUpdate, bool isLooped, bool usesRealTime, MonoBehaviour autoDestroyOwner)
	{
		this.duration = duration;
		_onComplete = onComplete;
		_onUpdate = onUpdate;
		this.isLooped = isLooped;
		this.usesRealTime = usesRealTime;
		_autoDestroyOwner = autoDestroyOwner;
		_hasAutoDestroyOwner = autoDestroyOwner != null;
		_startTime = GetWorldTime();
		_lastUpdateTime = _startTime;
	}

	private float GetWorldTime()
	{
		if (!usesRealTime)
		{
			return Time.time;
		}
		return Time.realtimeSinceStartup;
	}

	private float GetFireTime()
	{
		return _startTime + duration;
	}

	private float GetTimeDelta()
	{
		return GetWorldTime() - _lastUpdateTime;
	}

	private void Update()
	{
		if (isDone)
		{
			return;
		}
		if (isPaused)
		{
			_startTime += GetTimeDelta();
			_lastUpdateTime = GetWorldTime();
			return;
		}
		_lastUpdateTime = GetWorldTime();
		if (_onUpdate != null)
		{
			_onUpdate(GetTimeElapsed());
		}
		if (GetWorldTime() >= GetFireTime())
		{
			if (_onComplete != null)
			{
				_onComplete();
			}
			if (isLooped)
			{
				_startTime = GetWorldTime();
			}
			else
			{
				isCompleted = true;
			}
		}
	}
}
