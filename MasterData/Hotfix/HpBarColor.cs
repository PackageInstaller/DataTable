using UnityEngine;
using UnityEngine.UI;

[RequireComponent(typeof(Image))]
public class HpBarColor : MonoBehaviour, IAdventureHUD
{
	private float _duration;

	private Image _image;

	private Color _targetColor = Color.white;

	private Color _originColor = Color.white;

	private float _delay;

	private Color _Change = Color.white;

	private void Awake()
	{
		_image = GetComponent<Image>();
		enabled = false;
	}

	public void Stop()
	{
		_duration = 0f;
		_targetColor = Color.black;
		_originColor = Color.black;
		_delay = 0f;
		_Change = Color.black;
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

	public void SetTarget(Color target, float duration, float delay)
	{
		if (_image == null)
		{
			_image = GetComponent<Image>();
		}
		if (duration <= 0f)
		{
			_image.color = target;
			enabled = false;
			return;
		}
		_originColor = _image.color;
		_delay = delay;
		_duration = duration;
		_targetColor = target;
		_Change = new Color((_image.color.r - target.r) / duration, (_image.color.g - target.g) / duration, (_image.color.b - target.b) / duration, (_image.color.a - target.a) / duration);
		enabled = true;
	}

	public void HUDUpdate(float dt)
	{
		float num = dt;
		if (Mathf.Approximately(_duration, 0f))
		{
			_image.color = _targetColor;
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
		_image.color -= _Change * num;
	}
}
