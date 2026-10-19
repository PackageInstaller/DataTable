using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class ActGraphicRaycaster : GraphicRaycaster
{
	public bool isDisable;

	public bool draggReturn;

	public bool sameReturn;

	public RectTransform rectTransform;

	private Vector2 eventPos;

	[NonSerialized]
	private List<Graphic> m_RaycastResults = new List<Graphic>();

	private List<RaycastResult> tempresultAppendList = new List<RaycastResult>();

	private Camera eventCameraTemp;

	private Canvas canvas;

	public override Camera eventCamera => eventCameraTemp;

	public override void Raycast(PointerEventData eventData, List<RaycastResult> resultAppendList)
	{
		if (isDisable || (draggReturn && eventData.dragging))
		{
			return;
		}
		if (sameReturn)
		{
			if (!(eventPos != eventData.position))
			{
				resultAppendList.AddRange(tempresultAppendList);
				return;
			}
			eventPos = eventData.position;
		}
		if (!RectTransformUtility.RectangleContainsScreenPoint(rectTransform, eventData.position, eventCamera))
		{
			return;
		}
		IList<Graphic> raycastableGraphicsForCanvas = GraphicRegistry.GetRaycastableGraphicsForCanvas(canvas);
		if (raycastableGraphicsForCanvas == null || raycastableGraphicsForCanvas.Count == 0)
		{
			return;
		}
		Camera camera = eventCamera;
		int num = ((canvas.renderMode != RenderMode.ScreenSpaceOverlay && !(camera == null)) ? camera.targetDisplay : canvas.targetDisplay);
		Vector3 vector = RelativeMouseAtScaled(eventData.position);
		if (vector != Vector3.zero)
		{
			if ((int)vector.z != num)
			{
				return;
			}
		}
		else
		{
			vector = eventData.position;
		}
		Vector2 vector2;
		if (camera == null)
		{
			float num2 = Screen.width;
			float num3 = Screen.height;
			if (num > 0 && num < Display.displays.Length)
			{
				num2 = Display.displays[num].systemWidth;
				num3 = Display.displays[num].systemHeight;
			}
			vector2 = new Vector2(vector.x / num2, vector.y / num3);
		}
		else
		{
			vector2 = camera.ScreenToViewportPoint(vector);
		}
		if (vector2.x < 0f || vector2.x > 1f || vector2.y < 0f || vector2.y > 1f)
		{
			return;
		}
		float num4 = float.MaxValue;
		Ray ray = default;
		if (camera != null)
		{
			ray = camera.ScreenPointToRay(vector);
		}
		m_RaycastResults.Clear();
		Raycast(camera, vector, raycastableGraphicsForCanvas, m_RaycastResults);
		int count = m_RaycastResults.Count;
		for (int i = 0; i < count; i++)
		{
			GameObject gameObject = m_RaycastResults[i].gameObject;
			if (1 == 0)
			{
				continue;
			}
			float num5 = 0f;
			Transform transform = gameObject.transform;
			Vector3 forward = transform.forward;
			if (camera == null || canvas.renderMode == RenderMode.ScreenSpaceOverlay)
			{
				num5 = 0f;
			}
			else
			{
				num5 = Vector3.Dot(forward, transform.position - ray.origin) / Vector3.Dot(forward, ray.direction);
				if (num5 < 0f)
				{
					continue;
				}
			}
			if (!(num5 >= num4))
			{
				RaycastResult item = new RaycastResult
				{
					gameObject = gameObject,
					module = this,
					distance = num5,
					screenPosition = vector,
					displayIndex = num,
					index = resultAppendList.Count,
					depth = m_RaycastResults[i].depth,
					sortingLayer = canvas.sortingLayerID,
					sortingOrder = canvas.sortingOrder,
					worldPosition = ray.origin + ray.direction * num5,
					worldNormal = -forward
				};
				resultAppendList.Add(item);
			}
		}
		tempresultAppendList.Clear();
		tempresultAppendList.AddRange(resultAppendList);
	}

	private static void Raycast(Camera eventCamera, Vector2 pointerPosition, IList<Graphic> foundGraphics, List<Graphic> results)
	{
		int count = foundGraphics.Count;
		Graphic graphic = null;
		int num = -1;
		for (int i = 0; i < count; i++)
		{
			Graphic graphic2 = foundGraphics[i];
			if (graphic2.raycastTarget)
			{
				int depth = graphic2.depth;
				if (!graphic2.canvasRenderer.cull && depth != -1 && RectTransformUtility.RectangleContainsScreenPoint(graphic2.rectTransform, pointerPosition, eventCamera, graphic2.raycastPadding) && (!(eventCamera != null) || !(eventCamera.WorldToScreenPoint(graphic2.rectTransform.position).z > eventCamera.farClipPlane)) && graphic2.Raycast(pointerPosition, eventCamera) && depth > num)
				{
					num = depth;
					graphic = graphic2;
				}
			}
		}
		if (graphic != null)
		{
			results.Add(graphic);
		}
	}

	protected override void Awake()
	{
		base.Awake();
		eventCameraTemp = base.eventCamera;
		canvas = GetComponent<Canvas>();
	}

	public static Vector3 RelativeMouseAtScaled(Vector2 position)
	{
		if (Display.main.renderingWidth != Display.main.systemWidth || Display.main.renderingHeight != Display.main.systemHeight)
		{
			float num = (float)Display.main.systemWidth / (float)Display.main.systemHeight;
			Vector2 vector = new Vector2(Display.main.renderingWidth, Display.main.renderingHeight);
			Vector2 zero = Vector2.zero;
			if (Screen.fullScreen)
			{
				float num2 = (float)Screen.width / (float)Screen.height;
				if ((float)Display.main.systemHeight * num2 < (float)Display.main.systemWidth)
				{
					vector.x = (float)Display.main.renderingHeight * num;
					zero.x = (vector.x - (float)Display.main.renderingWidth) * 0.5f;
				}
				else
				{
					vector.y = (float)Display.main.renderingWidth / num;
					zero.y = (vector.y - (float)Display.main.renderingHeight) * 0.5f;
				}
			}
			Vector2 vector2 = vector - zero;
			if (position.y < 0f - zero.y || position.y > vector2.y || position.x < 0f - zero.x || position.x > vector2.x)
			{
				Vector2 vector3 = position;
				if (!Screen.fullScreen)
				{
					vector3.x -= (float)(Display.main.renderingWidth - Display.main.systemWidth) * 0.5f;
					vector3.y -= (float)(Display.main.renderingHeight - Display.main.systemHeight) * 0.5f;
				}
				else
				{
					vector3 += zero;
					vector3.x *= (float)Display.main.systemWidth / vector.x;
					vector3.y *= (float)Display.main.systemHeight / vector.y;
				}
				Vector3 result = Display.RelativeMouseAt(vector3);
				if (result.z != 0f)
				{
					return result;
				}
			}
			return new Vector3(position.x, position.y, 0f);
		}
		return Display.RelativeMouseAt(position);
	}
}
