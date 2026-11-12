using UnityEngine;

public class HpBarRotation : MonoBehaviour, IAdventureHUD
{
	private float _duration;

	private float _rotateValue;

	private float _delay;

	private float _change;

	private void Awake()
	{
		enabled = false;
	}

	private void OnEnable()
	{
		SceneSingleton<AdventureHUDController>.Instance.AddHud(this);
	}

	private void OnDisable()
	{
		SceneSingleton<AdventureHUDController>.Instance?.RemoveHud(this);
	}

	public void Stop()
	{
		_duration = 0f;
		_rotateValue = 0f;
		_delay = 0f;
		_change = 0f;
		enabled = false;
	}

	public void SetTarget(float target, float cur, float duration, float delay)
	{
		if (duration <= 0f)
		{
			transform.localEulerAngles = Vector3.forward * target;
			enabled = false;
			return;
		}
		transform.localEulerAngles = Vector3.forward * cur;
		_delay = delay;
		_duration = duration;
		_rotateValue = target;
		_change = (target - cur) / duration;
		enabled = true;
	}

	public void HUDUpdate(float dt)
	{
		float num = dt;
		if (Mathf.Approximately(_duration, 0f))
		{
			transform.localEulerAngles = Vector3.forward * _rotateValue;
			enabled = false;
			return;
		}
		if (_delay > num)
		{
			_delay -= num;
			return;
		}
		num -= _delay;
		_delay = 0f;
		if (num > _duration)
		{
			num = _duration;
			_duration = 0f;
		}
		else
		{
			_duration -= num;
		}
		transform.Rotate(Vector3.forward * _change * num);
	}
}
