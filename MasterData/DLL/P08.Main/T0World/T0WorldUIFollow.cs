using System;
using UnityEngine;

namespace T0World;

[ExecuteAlways]
public class T0WorldUIFollow : MonoBehaviour
{
	public Transform origin;

	public Vector3 offset = Vector3.zero;

	[NonSerialized]
	public Canvas canvas;

	public static void UpdatePos(RectTransform ui, Vector3 offset, Transform origin, Camera cam)
	{
		if ((bool)ui && (bool)origin && (bool)cam)
		{
			Vector2 screenPoint = RectTransformUtility.WorldToScreenPoint(Camera.main, origin.position + offset);
			if (RectTransformUtility.ScreenPointToLocalPointInRectangle(ui.transform.parent as RectTransform, screenPoint, cam, out var localPoint))
			{
				ui.transform.localPosition = localPoint;
			}
		}
	}

	public void UpdatePos()
	{
		UpdatePos(base.transform as RectTransform, offset, origin, canvas ? canvas.worldCamera : null);
	}

	private void LateUpdate()
	{
		UpdatePos();
	}
}
