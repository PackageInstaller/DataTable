using UnityEngine;

namespace ACT.Battle;

public class TimeSpeedTimer
{
	private bool _isChanging;

	private float _targetSpeed = 1f;

	private float _duration;

	private float _timer;

	private float _easeTime;

	public TimeType Type { get; set; }

	public float TargetSpeed => _targetSpeed;

	public float Speed { get; private set; } = 1f;

	public bool LastFrameChanged { get; private set; }

	public bool IsChanging => _isChanging;

	public void Reset()
	{
		_isChanging = false;
		_timer = 0f;
		_targetSpeed = 1f;
		_duration = 0f;
		_easeTime = 0f;
		Speed = 1f;
		LastFrameChanged = false;
	}

	public void InitTimer(SystemTime.ConfigChangeGlobalSpeed change)
	{
		_isChanging = true;
		_timer = 0f;
		_targetSpeed = change.speed;
		_duration = Mathf.Max(0f, change.duration);
		_easeTime = Mathf.Clamp(change.easeTime, 0f, _duration * 0.5f);
	}

	public void InitTimer(float speed, float duration, float easeTime = 0f)
	{
		_isChanging = true;
		_timer = 0f;
		_targetSpeed = speed;
		_duration = duration;
		_easeTime = easeTime;
	}

	public void FixedUpdate(float delta)
	{
		LastFrameChanged = false;
		if (!_isChanging)
		{
			return;
		}
		_timer += delta;
		if (_duration < 0f)
		{
			Speed = ((_timer < _easeTime && _easeTime > 0f) ? Mathf.Lerp(1f, _targetSpeed, _timer / _easeTime) : _targetSpeed);
			LastFrameChanged = true;
		}
		else if (_timer >= _duration)
		{
			_isChanging = false;
			Speed = 1f;
			LastFrameChanged = true;
		}
		else if (_timer < _easeTime && _easeTime > 0f)
		{
			Speed = Mathf.Lerp(1f, _targetSpeed, _timer / _easeTime);
			LastFrameChanged = true;
		}
		else if (_timer <= _duration - _easeTime || _easeTime <= 0f)
		{
			if (Speed != _targetSpeed)
			{
				Speed = _targetSpeed;
				LastFrameChanged = true;
			}
		}
		else
		{
			float t = (_timer - (_duration - _easeTime)) / _easeTime;
			Speed = Mathf.Lerp(_targetSpeed, 1f, t);
			LastFrameChanged = true;
		}
	}
}
