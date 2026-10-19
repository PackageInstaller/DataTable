using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class CircleLayoutGroup : UIBehaviour
{
	[SerializeField]
	private float radius = 100f;

	[SerializeField]
	private float angleDelta = 30f;

	[SerializeField]
	private int startDirection;

	[SerializeField]
	private bool autoRefresh = true;

	[SerializeField]
	private bool controlChildSize = true;

	[SerializeField]
	private Vector2 childSize = Vector2.one * 100f;

	private int cacheChildCount;

	private new void Start()
	{
		cacheChildCount = transform.childCount;
		RefreshLayout();
	}

	private void Update()
	{
		if (autoRefresh && cacheChildCount != transform.childCount)
		{
			RefreshLayout();
			cacheChildCount = transform.childCount;
		}
	}

	public void RefreshLayout()
	{
		List<RectTransform> list = new List<RectTransform>();
		for (int i = 0; i < transform.childCount; i++)
		{
			Transform child = transform.GetChild(i);
			if (child.gameObject.activeSelf)
			{
				list.Add(child as RectTransform);
			}
		}
		float num = (float)(list.Count - 1) * angleDelta * 0.5f;
		for (int j = 0; j < list.Count; j++)
		{
			RectTransform rectTransform = list[j];
			float num2 = (0f - angleDelta) * (float)j + num + (float)startDirection;
			float x = radius * Mathf.Cos(num2 * MathF.PI / 180f);
			float y = radius * Mathf.Sin(num2 * MathF.PI / 180f);
			Vector2 anchoredPosition = rectTransform.anchoredPosition;
			anchoredPosition.x = x;
			anchoredPosition.y = y;
			rectTransform.anchoredPosition = anchoredPosition;
		}
	}

	public void SetAngleDelta(float newAngleDelta)
	{
		angleDelta = newAngleDelta;
	}
}
