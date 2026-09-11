using System;
using UnityEngine;

namespace Dorm.UI;

[ExecuteAlways]
public class UIFollow : MonoBehaviour
{
	public Transform origin;

	[NonSerialized]
	public Canvas canvas;

	private void Awake()
	{
		canvas = GetComponentInParent<Canvas>();
	}

	public static void UpdatePos(RectTransform ui, Transform origin, Camera cam)
	{
		if ((bool)ui && (bool)origin && (bool)cam)
		{
			Vector2 screenPoint = RectTransformUtility.WorldToScreenPoint(Camera.main, origin.position);
			if (RectTransformUtility.ScreenPointToLocalPointInRectangle(ui.transform.parent as RectTransform, screenPoint, cam, out var localPoint))
			{
				ui.transform.localPosition = localPoint;
			}
		}
	}

	public void UpdatePos()
	{
		UpdatePos(base.transform as RectTransform, origin, canvas ? canvas.worldCamera : null);
	}

	private void LateUpdate()
	{
		UpdatePos();
	}
}
