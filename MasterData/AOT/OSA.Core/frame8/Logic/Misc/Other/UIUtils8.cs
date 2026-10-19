using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;
using frame8.Logic.Misc.Other.Extensions;

namespace frame8.Logic.Misc.Other;

public class UIUtils8
{
	public static UIUtils8 Instance { get; } = new UIUtils8();

	public Vector2 WorldToScreenPointForCanvas(Canvas canvas, Camera camera, Vector3 position)
	{
		return RectTransformUtility.WorldToScreenPoint((canvas.renderMode == RenderMode.ScreenSpaceOverlay) ? null : camera, position);
	}

	public Vector2? WorldToCanvasLocalPosition(Canvas canvas, RectTransform canvasRect, Camera camera, Vector3 position)
	{
		Camera cam = ((canvas.renderMode == RenderMode.ScreenSpaceOverlay) ? null : camera);
		Vector2 screenPoint = RectTransformUtility.WorldToScreenPoint(cam, position);
		if (!RectTransformUtility.ScreenPointToLocalPointInRectangle(canvasRect, screenPoint, cam, out var localPoint))
		{
			return null;
		}
		return localPoint;
	}

	public Vector2? ScreenPointToLocalPointInCanvas(Canvas canvas, RectTransform canvasRect, Camera camera, Vector2 screenPoint)
	{
		Camera cam = ((canvas.renderMode == RenderMode.ScreenSpaceOverlay) ? null : camera);
		if (!RectTransformUtility.ScreenPointToLocalPointInRectangle(canvasRect, screenPoint, cam, out var localPoint))
		{
			return null;
		}
		return localPoint;
	}

	public Vector3? ScreenPointToWorldPointInCanvas(Canvas canvas, RectTransform canvasRect, Camera camera, Vector2 screenPoint)
	{
		Camera cam = ((canvas.renderMode == RenderMode.ScreenSpaceOverlay) ? null : camera);
		if (!RectTransformUtility.ScreenPointToWorldPointInRectangle(canvasRect, screenPoint, cam, out var worldPoint))
		{
			return null;
		}
		return worldPoint;
	}

	public Vector2 ScreenPointToLocalPointInRectangle(RectTransform rt, PointerEventData pointerEventData)
	{
		RectTransformUtility.ScreenPointToLocalPointInRectangle(rt, pointerEventData.position, pointerEventData.pressEventCamera, out var localPoint);
		return localPoint;
	}

	public Vector2 GetWorldVectorBetweenCustomLocalPivots(RectTransform firstRT, Vector2 customPivotOnFirstRect01, RectTransform secondRT, Vector2 customPivotOnSecondRect01, Canvas canvas, RectTransform canvasRectTransform)
	{
		Vector2 vector = firstRT.ConvertPointNormalizedBySizeToLocalPoint(customPivotOnFirstRect01);
		Vector2 vector2 = secondRT.ConvertPointNormalizedBySizeToLocalPoint(customPivotOnSecondRect01);
		Vector3 vector3 = firstRT.TransformPoint(vector);
		return secondRT.TransformPoint(vector2) - vector3;
	}

	public void BringRectToAnchorsFor(Transform[] transforms)
	{
		foreach (Transform transform in transforms)
		{
			BringRectToAnchorsFor(transform);
		}
	}

	public void BringRectToAnchorsFor(Transform transform)
	{
		RectTransform rectTransform = transform as RectTransform;
		if (rectTransform != null)
		{
			Vector2 offsetMin = (rectTransform.offsetMax = Vector2.zero);
			rectTransform.offsetMin = offsetMin;
		}
	}

	public void BringAnchorsToRectFor(Transform[] transforms)
	{
		foreach (Transform transform in transforms)
		{
			BringAnchorsToRectFor(transform);
		}
	}

	public void BringAnchorsToRectFor(Transform transform)
	{
		RectTransform rectTransform = transform as RectTransform;
		if (!(transform != null))
		{
			return;
		}
		RectTransform rectTransform2 = rectTransform.parent as RectTransform;
		if (rectTransform2 == null)
		{
			rectTransform.anchorMin = Vector2.zero;
			rectTransform.anchorMax = Vector2.one;
		}
		else
		{
			Rect rect = rectTransform.rect;
			Rect rect2 = rectTransform2.rect;
			Vector2 bottomLeftCornerDisplacementFromParentBottomLeftCorner = rectTransform.GetBottomLeftCornerDisplacementFromParentBottomLeftCorner();
			if (rect2.width > 0f && rect2.height > 0f)
			{
				rectTransform.anchorMin = new Vector2(Mathf.Clamp01(bottomLeftCornerDisplacementFromParentBottomLeftCorner.x / rect2.width), Mathf.Clamp01(bottomLeftCornerDisplacementFromParentBottomLeftCorner.y / rect2.height));
				rectTransform.anchorMax = new Vector2(Mathf.Clamp01((bottomLeftCornerDisplacementFromParentBottomLeftCorner.x + rect.width) / rect2.width), Mathf.Clamp01((bottomLeftCornerDisplacementFromParentBottomLeftCorner.y + rect.height) / rect2.height));
			}
		}
		Vector2 offsetMin = (rectTransform.offsetMax = Vector2.zero);
		rectTransform.offsetMin = offsetMin;
	}

	public void GrowSizeDirectionally(RectTransform rectTransform, RectTransform.Edge edge, float amount)
	{
		Vector2 size = rectTransform.rect.size;
		bool flag = edge == RectTransform.Edge.Right;
		bool flag2 = flag || edge == RectTransform.Edge.Left;
		bool flag3 = edge == RectTransform.Edge.Top;
		rectTransform.SetSizeWithCurrentAnchors((!flag2) ? RectTransform.Axis.Vertical : RectTransform.Axis.Horizontal, flag2 ? (size.x + amount) : (size.y + amount));
		Vector3 zero = Vector3.zero;
		if (flag2)
		{
			if (flag)
			{
				zero.x += amount / 2f;
			}
			else
			{
				zero.x -= amount / 2f;
			}
		}
		else if (flag3)
		{
			zero.y += amount / 2f;
		}
		else
		{
			zero.y -= amount / 2f;
		}
		rectTransform.localPosition += zero;
	}

	public UIVertex[] GetCharQuadVertsInObjectSpaceUnscaledByCanvas(Text textComp, int charIndex)
	{
		UIVertex[] array = null;
		string text = textComp.text;
		if (charIndex < text.Length)
		{
			TextGenerator cachedTextGenerator = textComp.cachedTextGenerator;
			int num = 4;
			int num2 = charIndex * num;
			if (num2 < cachedTextGenerator.vertexCount)
			{
				array = new UIVertex[4];
				int num3 = -1;
				IList<UIVertex> verts = cachedTextGenerator.verts;
				array[++num3] = verts[num2 + num3];
				array[++num3] = verts[num2 + num3];
				array[++num3] = verts[num2 + num3];
				array[++num3] = verts[num2 + num3];
			}
		}
		return array;
	}

	public void GetUITextCharQuadVertsPositionsInObjectSpaceScaledByCanvas(Text textComp, int charIndex, out Vector3[] positions)
	{
		UIVertex[] charQuadVertsInObjectSpaceUnscaledByCanvas = GetCharQuadVertsInObjectSpaceUnscaledByCanvas(textComp, charIndex);
		if (charQuadVertsInObjectSpaceUnscaledByCanvas == null)
		{
			positions = null;
			return;
		}
		positions = new Vector3[charQuadVertsInObjectSpaceUnscaledByCanvas.Length];
		float scaleFactor = textComp.canvas.scaleFactor;
		for (int i = 0; i < positions.Length; i++)
		{
			positions[i] = charQuadVertsInObjectSpaceUnscaledByCanvas[i].position / scaleFactor;
		}
	}

	public Vector3[] GetCharQuadVertsPositionsInObjectSpaceScaledByCanvas(Text textComp, int charIndex)
	{
		GetUITextCharQuadVertsPositionsInObjectSpaceScaledByCanvas(textComp, charIndex, out var positions);
		return positions;
	}

	public Vector3[] GetCharQuadVertsPositionsInWorldSpaceScaledByCanvas(Text textComp, int charIndex)
	{
		Vector3[] charQuadVertsPositionsInObjectSpaceScaledByCanvas = GetCharQuadVertsPositionsInObjectSpaceScaledByCanvas(textComp, charIndex);
		if (charQuadVertsPositionsInObjectSpaceScaledByCanvas != null)
		{
			int num = 0;
			Transform transform = textComp.transform;
			charQuadVertsPositionsInObjectSpaceScaledByCanvas[num] = transform.TransformPoint(charQuadVertsPositionsInObjectSpaceScaledByCanvas[num++]);
			charQuadVertsPositionsInObjectSpaceScaledByCanvas[num] = transform.TransformPoint(charQuadVertsPositionsInObjectSpaceScaledByCanvas[num++]);
			charQuadVertsPositionsInObjectSpaceScaledByCanvas[num] = transform.TransformPoint(charQuadVertsPositionsInObjectSpaceScaledByCanvas[num++]);
			charQuadVertsPositionsInObjectSpaceScaledByCanvas[num] = transform.TransformPoint(charQuadVertsPositionsInObjectSpaceScaledByCanvas[num++]);
		}
		return charQuadVertsPositionsInObjectSpaceScaledByCanvas;
	}

	public Vector3? GetCharQuadCenterPositionInObjectSpaceScaledByCanvas(Text textComp, int charIndex)
	{
		Vector3? result = null;
		Vector3[] charQuadVertsPositionsInObjectSpaceScaledByCanvas = GetCharQuadVertsPositionsInObjectSpaceScaledByCanvas(textComp, charIndex);
		if (charQuadVertsPositionsInObjectSpaceScaledByCanvas != null)
		{
			result = (charQuadVertsPositionsInObjectSpaceScaledByCanvas[0] + charQuadVertsPositionsInObjectSpaceScaledByCanvas[1] + charQuadVertsPositionsInObjectSpaceScaledByCanvas[2] + charQuadVertsPositionsInObjectSpaceScaledByCanvas[3]) / 4f;
		}
		return result;
	}

	public Vector3? GetCharQuadCenterPositionInWorldSpaceScaledByCanvas(Text textComp, int charIndex)
	{
		Vector3? result = null;
		Vector3[] charQuadVertsPositionsInWorldSpaceScaledByCanvas = GetCharQuadVertsPositionsInWorldSpaceScaledByCanvas(textComp, charIndex);
		if (charQuadVertsPositionsInWorldSpaceScaledByCanvas != null)
		{
			result = (charQuadVertsPositionsInWorldSpaceScaledByCanvas[0] + charQuadVertsPositionsInWorldSpaceScaledByCanvas[1] + charQuadVertsPositionsInWorldSpaceScaledByCanvas[2] + charQuadVertsPositionsInWorldSpaceScaledByCanvas[3]) / 4f;
		}
		return result;
	}

	public Vector3? GetCharQuadCenterLeftPositionInWorldSpaceScaledByCanvas(Text textComp, int charIndex)
	{
		Vector3? result = null;
		Vector3[] charQuadVertsPositionsInWorldSpaceScaledByCanvas = GetCharQuadVertsPositionsInWorldSpaceScaledByCanvas(textComp, charIndex);
		if (charQuadVertsPositionsInWorldSpaceScaledByCanvas != null)
		{
			result = (charQuadVertsPositionsInWorldSpaceScaledByCanvas[0] + charQuadVertsPositionsInWorldSpaceScaledByCanvas[3]) / 2f;
		}
		return result;
	}
}
