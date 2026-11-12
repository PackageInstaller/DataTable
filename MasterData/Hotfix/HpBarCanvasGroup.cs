using UnityEngine;

[RequireComponent(typeof(CanvasGroup))]
public class HpBarCanvasGroup : MonoBehaviour, IAdventureHUD
{
	private float _duration;

	private CanvasGroup _canvasGroup;

	private float _targetAlaph;

	private float _originAlaph;

	private float _delay;

	private float _Change;

	private void Awake()
	{
		_canvasGroup = GetComponent<CanvasGroup>();
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
		_targetAlaph = 0f;
		_originAlaph = 0f;
		_delay = 0f;
		_Change = 0f;
		enabled = false;
	}

	public void SetTarget(float target, float duration, float delay)
	{
		if (duration <= 0f)
		{
			_canvasGroup.alpha = target;
			enabled = false;
			return;
		}
		_originAlaph = _canvasGroup.alpha;
		_delay = delay;
		_duration = duration;
		_targetAlaph = target;
		_Change = (_originAlaph - target) / duration;
		enabled = true;
	}

	public void HUDUpdate(float dt)
	{
		float num = dt;
		if (Mathf.Approximately(_duration, 0f))
		{
			_canvasGroup.alpha = _targetAlaph;
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
		_canvasGroup.alpha -= _Change * num;
	}
}
