using System;
using UnityEngine;

namespace Ase;

public class UIMapController : MonoBehaviour
{
	[SerializeField]
	private RectTransform mapRect;

	[SerializeField]
	private float scaleMin;

	[SerializeField]
	private float scaleMax;

	[SerializeField]
	private float scaleRate;

	[SerializeField]
	private float distanceThreshold;

	private Action<float> scaleAction;

	private Touch oldTouch1;

	private Touch oldTouch2;

	private void Update()
	{
		if (Input.GetKey(KeyCode.LeftArrow) || Input.GetKey(KeyCode.RightArrow))
		{
			float num = 0f;
			if (Input.GetKey(KeyCode.LeftArrow))
			{
				num = 50f;
			}
			if (Input.GetKey(KeyCode.RightArrow))
			{
				num = -50f;
			}
			float num2 = num / 100f * scaleRate;
			float num3 = Mathf.Clamp(mapRect.localScale.x + num2, scaleMin, scaleMax);
			mapRect.localScale = num3 * Vector2.one;
		}
	}

	private void ResetMapRect()
	{
		RectTransform component = mapRect.GetComponent<RectTransform>();
		component.pivot = new Vector2(0.5f, 0.5f);
		component.anchoredPosition = Vector2.zero;
	}
}
