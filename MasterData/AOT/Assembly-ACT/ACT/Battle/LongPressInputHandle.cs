using System;

namespace ACT.Battle;

internal class LongPressInputHandle : ILongPressInputHandle
{
	private Action _endTimeCallback;

	private Action<float> _onUpdateCallback;

	private Action _onReleaseCallback;

	private float _currentTime;

	private float _requiredTime;

	private int _repeatTimes;

	private float _repeatTimeInterval;

	public string ActionPath { get; private set; }

	public float CurrentPressTime => _currentTime;

	public float TotalRequiredPressTime => _requiredTime;

	public bool IsValid()
	{
		if (_endTimeCallback != null || _onUpdateCallback != null || _onReleaseCallback != null)
		{
			return _requiredTime > 0f;
		}
		return false;
	}

	public bool CanRepeat()
	{
		return _repeatTimes != 0;
	}

	public void Tick(float deltaTime)
	{
		_currentTime += deltaTime;
		_onUpdateCallback?.Invoke(_currentTime / _requiredTime);
	}

	public bool TimeIsReach()
	{
		return _currentTime >= _requiredTime;
	}

	public void NotifyReach()
	{
		_endTimeCallback?.Invoke();
	}

	public void Clear()
	{
		_onReleaseCallback?.Invoke();
		_onReleaseCallback = null;
		_endTimeCallback = null;
		_onUpdateCallback = null;
		_repeatTimeInterval = 0f;
		_currentTime = 0f;
		_requiredTime = 0f;
		_repeatTimeInterval = 0f;
	}

	public void Reset(string actionPath, Action callback, float requiredPressTime, int repeatTimes, float repeatTimeInterval, Action<float> onUpdateCallback, Action onReleaseCallback)
	{
		ActionPath = actionPath;
		_endTimeCallback = (Action)Delegate.Combine(_endTimeCallback, callback);
		_onUpdateCallback = (Action<float>)Delegate.Combine(_onUpdateCallback, onUpdateCallback);
		_onReleaseCallback = (Action)Delegate.Combine(_onReleaseCallback, onReleaseCallback);
		_requiredTime = requiredPressTime;
		_currentTime = 0f;
		_repeatTimeInterval = repeatTimeInterval;
		_repeatTimes = repeatTimes;
	}

	public void CountDown()
	{
		_currentTime -= _requiredTime;
		_requiredTime = _repeatTimeInterval;
		if (_repeatTimes > 0)
		{
			_repeatTimes--;
		}
	}
}
