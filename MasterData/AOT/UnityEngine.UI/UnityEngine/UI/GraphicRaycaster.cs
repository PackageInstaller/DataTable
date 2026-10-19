using System;
using System.Collections.Generic;
using UnityEngine.EventSystems;
using UnityEngine.Serialization;

namespace UnityEngine.UI;

[RequireComponent(typeof(Canvas))]
[AddComponentMenu("Event/Graphic Raycaster")]
public class GraphicRaycaster : BaseRaycaster
{
	public enum BlockingObjects
	{
		None,
		TwoD,
		ThreeD,
		All
	}

	protected const int kNoEventMaskSet = -1;

	[SerializeField]
	[FormerlySerializedAs("ignoreReversedGraphics")]
	private bool m_IgnoreReversedGraphics = true;

	[SerializeField]
	[FormerlySerializedAs("blockingObjects")]
	private BlockingObjects m_BlockingObjects;

	[SerializeField]
	protected LayerMask m_BlockingMask = -1;

	private Canvas m_Canvas;

	[NonSerialized]
	private List<Graphic> m_RaycastResults = new List<Graphic>();

	[NonSerialized]
	private static readonly List<Graphic> s_SortedGraphics = new List<Graphic>();

	public override int sortOrderPriority
	{
		get
		{
			if (canvas.renderMode == RenderMode.ScreenSpaceOverlay)
			{
				return canvas.sortingOrder;
			}
			return base.sortOrderPriority;
		}
	}

	public override int renderOrderPriority
	{
		get
		{
			if (canvas.renderMode == RenderMode.ScreenSpaceOverlay)
			{
				return canvas.rootCanvas.renderOrder;
			}
			return base.renderOrderPriority;
		}
	}

	public bool ignoreReversedGraphics
	{
		get
		{
			return m_IgnoreReversedGraphics;
		}
		set
		{
			m_IgnoreReversedGraphics = value;
		}
	}

	public BlockingObjects blockingObjects
	{
		get
		{
			return m_BlockingObjects;
		}
		set
		{
			m_BlockingObjects = value;
		}
	}

	public LayerMask blockingMask
	{
		get
		{
			return m_BlockingMask;
		}
		set
		{
			m_BlockingMask = value;
		}
	}

	private Canvas canvas
	{
		get
		{
			if (m_Canvas != null)
			{
				return m_Canvas;
			}
			m_Canvas = GetComponent<Canvas>();
			return m_Canvas;
		}
	}

	public override Camera eventCamera
	{
		get
		{
			Canvas canvas = this.canvas;
			RenderMode renderMode = canvas.renderMode;
			if (renderMode == RenderMode.ScreenSpaceOverlay || (renderMode == RenderMode.ScreenSpaceCamera && canvas.worldCamera == null))
			{
				return null;
			}
			return canvas.worldCamera ?? Camera.main;
		}
	}

	protected GraphicRaycaster()
	{
	}

	public override void Raycast(PointerEventData eventData, List<RaycastResult> resultAppendList)
	{
		if (canvas == null)
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
		Vector3 relativeMousePositionForRaycast = MultipleDisplayUtilities.GetRelativeMousePositionForRaycast(eventData);
		if ((int)relativeMousePositionForRaycast.z != num)
		{
			return;
		}
		Vector2 vector;
		if (camera == null)
		{
			float num2 = Screen.width;
			float num3 = Screen.height;
			if (num > 0 && num < Display.displays.Length)
			{
				num2 = Display.displays[num].renderingWidth;
				num3 = Display.displays[num].renderingHeight;
			}
			vector = new Vector2(relativeMousePositionForRaycast.x / num2, relativeMousePositionForRaycast.y / num3);
		}
		else
		{
			vector = camera.ScreenToViewportPoint(relativeMousePositionForRaycast);
		}
		if (vector.x < 0f || vector.x > 1f || vector.y < 0f || vector.y > 1f)
		{
			return;
		}
		float num4 = float.MaxValue;
		Ray r = default;
		if (camera != null)
		{
			r = camera.ScreenPointToRay(relativeMousePositionForRaycast);
		}
		if (canvas.renderMode != RenderMode.ScreenSpaceOverlay && blockingObjects != BlockingObjects.None)
		{
			float f = 100f;
			if (camera != null)
			{
				float z = r.direction.z;
				f = (Mathf.Approximately(0f, z) ? float.PositiveInfinity : Mathf.Abs((camera.farClipPlane - camera.nearClipPlane) / z));
			}
			if ((blockingObjects == BlockingObjects.ThreeD || blockingObjects == BlockingObjects.All) && ReflectionMethodsCache.Singleton.raycast3D != null && ReflectionMethodsCache.Singleton.raycast3D(r, out var hit, f, m_BlockingMask))
			{
				num4 = hit.distance;
			}
			if ((blockingObjects == BlockingObjects.TwoD || blockingObjects == BlockingObjects.All) && ReflectionMethodsCache.Singleton.raycast2D != null)
			{
				RaycastHit2D[] array = ReflectionMethodsCache.Singleton.getRayIntersectionAll(r, f, m_BlockingMask);
				if (array.Length != 0)
				{
					num4 = array[0].distance;
				}
			}
		}
		m_RaycastResults.Clear();
		Raycast(canvas, camera, relativeMousePositionForRaycast, raycastableGraphicsForCanvas, m_RaycastResults);
		int count = m_RaycastResults.Count;
		for (int i = 0; i < count; i++)
		{
			GameObject gameObject = m_RaycastResults[i].gameObject;
			bool flag = true;
			if (ignoreReversedGraphics)
			{
				if (camera == null)
				{
					Vector3 rhs = gameObject.transform.rotation * Vector3.forward;
					flag = Vector3.Dot(Vector3.forward, rhs) > 0f;
				}
				else
				{
					Vector3 vector2 = camera.transform.rotation * Vector3.forward * camera.nearClipPlane;
					flag = Vector3.Dot(gameObject.transform.position - camera.transform.position - vector2, gameObject.transform.forward) >= 0f;
				}
			}
			if (!flag)
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
				num5 = Vector3.Dot(forward, transform.position - r.origin) / Vector3.Dot(forward, r.direction);
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
					screenPosition = relativeMousePositionForRaycast,
					displayIndex = num,
					index = resultAppendList.Count,
					depth = m_RaycastResults[i].depth,
					sortingLayer = canvas.sortingLayerID,
					sortingOrder = canvas.sortingOrder,
					worldPosition = r.origin + r.direction * num5,
					worldNormal = -forward
				};
				resultAppendList.Add(item);
			}
		}
	}

	private static void Raycast(Canvas canvas, Camera eventCamera, Vector2 pointerPosition, IList<Graphic> foundGraphics, List<Graphic> results)
	{
		int count = foundGraphics.Count;
		for (int i = 0; i < count; i++)
		{
			Graphic graphic = foundGraphics[i];
			if (graphic.raycastTarget && !graphic.canvasRenderer.cull && graphic.depth != -1 && RectTransformUtility.RectangleContainsScreenPoint(graphic.rectTransform, pointerPosition, eventCamera, graphic.raycastPadding) && (!(eventCamera != null) || !(eventCamera.WorldToScreenPoint(graphic.rectTransform.position).z > eventCamera.farClipPlane)) && graphic.Raycast(pointerPosition, eventCamera))
			{
				s_SortedGraphics.Add(graphic);
			}
		}
		s_SortedGraphics.Sort((Graphic g1, Graphic g2) => g2.depth.CompareTo(g1.depth));
		count = s_SortedGraphics.Count;
		for (int num = 0; num < count; num++)
		{
			results.Add(s_SortedGraphics[num]);
		}
		s_SortedGraphics.Clear();
	}
}
