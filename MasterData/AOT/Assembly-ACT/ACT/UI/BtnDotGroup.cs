using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class BtnDotGroup : UIBehaviour
{
	[SerializeField]
	private CircleLayoutGroup circleLayoutGroup;

	[SerializeField]
	private float totalAngle = 72f;

	[SerializeField]
	private Transform dotRoot;

	[SerializeField]
	private GameObject dotPrefab;

	private List<BtnDot> _dots = new List<BtnDot>();

	private int _maxCount;

	private int _nowCount;

	public bool Active { get; private set; }

	public void Init(int maxCount, int nowCount)
	{
		maxCount = Mathf.Max(0, maxCount);
		nowCount = Mathf.Clamp(nowCount, 0, maxCount);
		if (maxCount <= 0)
		{
			UnInit();
			return;
		}
		if (Active && _maxCount == maxCount)
		{
			ApplyCountImmediately(nowCount);
			Show();
			return;
		}
		Active = true;
		_maxCount = maxCount;
		_nowCount = 0;
		ClearDots();
		Show();
		circleLayoutGroup.SetAngleDelta(totalAngle / (float)(maxCount + 1));
		for (int i = 0; i < _maxCount; i++)
		{
			BtnDot component = Object.Instantiate(dotPrefab, dotRoot).GetComponent<BtnDot>();
			_dots.Add(component);
		}
		circleLayoutGroup.RefreshLayout();
		ApplyCountImmediately(nowCount);
		Show();
	}

	public void UnInit()
	{
		Active = false;
		_maxCount = (_nowCount = 0);
		ClearDots();
		Hide();
	}

	public void Show()
	{
		gameObject.SetActive(value: true);
	}

	public void Hide()
	{
		gameObject.SetActive(value: false);
	}

	public void OnCountChange(int maxCount, int nowCount)
	{
		maxCount = Mathf.Max(0, maxCount);
		nowCount = Mathf.Clamp(nowCount, 0, maxCount);
		if (maxCount <= 0)
		{
			UnInit();
		}
		else if (!Active || _maxCount != maxCount || _dots.Count != maxCount)
		{
			Init(maxCount, nowCount);
		}
		else
		{
			if (_nowCount == nowCount)
			{
				return;
			}
			_nowCount = Mathf.Clamp(_nowCount, 0, _dots.Count);
			if (nowCount < _nowCount)
			{
				for (int i = nowCount; i < _nowCount; i++)
				{
					_dots[i].Hide();
				}
			}
			else
			{
				for (int j = _nowCount; j < nowCount; j++)
				{
					_dots[j].Show();
				}
			}
			_nowCount = nowCount;
		}
	}

	private void ApplyCountImmediately(int nowCount)
	{
		_nowCount = Mathf.Clamp(nowCount, 0, _maxCount);
		for (int i = 0; i < _dots.Count; i++)
		{
			if (i < _nowCount)
			{
				_dots[i].ShowImmediately();
			}
			else
			{
				_dots[i].HideImmediately();
			}
		}
	}

	private void ClearDots()
	{
		foreach (BtnDot dot in _dots)
		{
			if (dot != null)
			{
				dot.gameObject.SetActive(value: false);
				Object.Destroy(dot.gameObject);
			}
		}
		_dots.Clear();
	}
}
