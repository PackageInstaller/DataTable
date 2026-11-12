using TMPro;
using UnityEngine;

[RequireComponent(typeof(TextMeshProUGUI))]
public class HpBarValue : MonoBehaviour, IAdventureHUD
{
	private float _duration;

	private TextMeshProUGUI _text;

	private int _targetValue;

	private float _curValue;

	private float _delay;

	private float _change;

	private void Awake()
	{
		_text = GetComponent<TextMeshProUGUI>();
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
		_targetValue = 0;
		_curValue = 0f;
		_delay = 0f;
		_change = 0f;
		enabled = false;
	}

	public void SetTarget(int target, int cur, float duration, float delay)
	{
		if (_text == null)
		{
			Stop();
			return;
		}
		if (duration <= 0f)
		{
			_text.SetText(target.ToString());
			enabled = false;
			return;
		}
		_text.SetText(_curValue.ToString());
		_delay = delay;
		_duration = duration;
		_targetValue = target;
		_curValue = cur;
		_change = ((float)_targetValue - _curValue) / duration;
		enabled = true;
	}

	public void HUDUpdate(float dt)
	{
		float deltaTime = Time.deltaTime;
		if (Mathf.Approximately(_duration, 0f))
		{
			_text.SetText(_targetValue.ToString());
			enabled = false;
			return;
		}
		if (_delay > deltaTime)
		{
			_delay -= deltaTime;
			return;
		}
		deltaTime -= _delay;
		_delay = 0f;
		if (deltaTime > _duration)
		{
			deltaTime = _duration;
			_duration = 0f;
		}
		else
		{
			_duration -= deltaTime;
		}
		_curValue -= _change * deltaTime;
		_text.SetText(((int)_curValue).ToString());
	}
}
