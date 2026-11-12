using UnityEngine;
using UnityEngine.UI;

[RequireComponent(typeof(RectTransform))]
public class HpBarRectTransform : MonoBehaviour, IAdventureHUD
{
	private float _duration;

	private RectTransform _rectTransform;

	private Vector2 _targetSize = Vector2.zero;

	private Vector2 _originSize = Vector2.zero;

	private float _delay;

	private Vector2 _Change = Vector2.zero;

	private LayoutGroup _parentLayoutGroup;

	private bool _forceRefreshLayout;

	private void Awake()
	{
		_rectTransform = GetComponent<RectTransform>();
		enabled = false;
	}

	private void OnEnable()
	{
		SceneSingleton<AdventureHUDController>.Instance?.AddHud(this);
	}

	private void OnDisable()
	{
		SceneSingleton<AdventureHUDController>.Instance?.RemoveHud(this);
	}

	public void Stop()
	{
		_duration = 0f;
		_targetSize = Vector2.zero;
		_originSize = Vector2.zero;
		_delay = 0f;
		_Change = Vector2.zero;
		enabled = false;
	}

	public void SetTarget(Vector2 target, float duration, float delay)
	{
		if (_rectTransform == null)
		{
			_rectTransform = GetComponent<RectTransform>();
			if (_rectTransform == null)
			{
				return;
			}
		}
		if (duration <= 0f)
		{
			_rectTransform.sizeDelta = target;
			enabled = false;
			return;
		}
		_originSize = _rectTransform.sizeDelta;
		_delay = delay;
		_duration = duration;
		_targetSize = target;
		_Change = new Vector2((_originSize.x - target.x) / duration, (_originSize.y - target.y) / duration);
		enabled = true;
		if (transform.parent != null)
		{
			_forceRefreshLayout = transform.parent.TryGetComponent<LayoutGroup>(out _parentLayoutGroup);
		}
	}

	public void HUDUpdate(float dt)
	{
		float num = dt;
		if (Mathf.Approximately(_duration, 0f))
		{
			_rectTransform.sizeDelta = _targetSize;
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
		_rectTransform.sizeDelta -= _Change * num;
		if (_forceRefreshLayout)
		{
			_parentLayoutGroup.CalculateLayoutInputHorizontal();
			_parentLayoutGroup.CalculateLayoutInputVertical();
			_parentLayoutGroup.SetLayoutHorizontal();
			_parentLayoutGroup.SetLayoutVertical();
		}
	}
}
