using System;
using System.Collections.Generic;
using UnityEngine.EventSystems;
using UnityEngine.InputSystem.Utilities;
using UnityEngine.Serialization;
using UnityEngine.UI;

namespace UnityEngine.InputSystem.UI;

[RequireComponent(typeof(Canvas))]
[AddComponentMenu("Event/Tracked Device Raycaster")]
public class TrackedDeviceRaycaster : BaseRaycaster
{
	private struct RaycastHitData(Graphic graphic, Vector3 worldHitPosition, Vector2 screenPosition, float distance)
	{
		public Graphic graphic { get; } = graphic;

		public Vector3 worldHitPosition { get; } = worldHitPosition;

		public Vector2 screenPosition { get; } = screenPosition;

		public float distance { get; } = distance;
	}

	[NonSerialized]
	private List<RaycastHitData> m_RaycastResultsCache = new List<RaycastHitData>();

	internal static InlinedArray<TrackedDeviceRaycaster> s_Instances;

	private static readonly List<RaycastHitData> s_SortedGraphics = new List<RaycastHitData>();

	[SerializeField]
	[FormerlySerializedAs("ignoreReversedGraphics")]
	private bool m_IgnoreReversedGraphics;

	[SerializeField]
	[FormerlySerializedAs("checkFor2DOcclusion")]
	private bool m_CheckFor2DOcclusion;

	[FormerlySerializedAs("checkFor3DOcclusion")]
	[SerializeField]
	private bool m_CheckFor3DOcclusion;

	[SerializeField]
	[Tooltip("Maximum distance (in 3D world space) that rays are traced to find a hit.")]
	private float m_MaxDistance = 1000f;

	[SerializeField]
	private LayerMask m_BlockingMask;

	[NonSerialized]
	private Canvas m_Canvas;

	public override Camera eventCamera
	{
		get
		{
			Canvas val = canvas;
			if (!((Object)(object)val != null))
			{
				return null;
			}
			return val.worldCamera;
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

	public bool checkFor3DOcclusion
	{
		get
		{
			return m_CheckFor3DOcclusion;
		}
		set
		{
			m_CheckFor3DOcclusion = value;
		}
	}

	public bool checkFor2DOcclusion
	{
		get
		{
			return m_CheckFor2DOcclusion;
		}
		set
		{
			m_CheckFor2DOcclusion = value;
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

	public float maxDistance
	{
		get
		{
			return m_MaxDistance;
		}
		set
		{
			m_MaxDistance = value;
		}
	}

	private Canvas canvas
	{
		get
		{
			if ((Object)(object)m_Canvas != null)
			{
				return m_Canvas;
			}
			m_Canvas = GetComponent<Canvas>();
			return m_Canvas;
		}
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		s_Instances.AppendWithCapacity(this);
	}

	protected override void OnDisable()
	{
		int num = s_Instances.IndexOfReference(this);
		if (num != -1)
		{
			s_Instances.RemoveAtByMovingTailWithCapacity(num);
		}
		base.OnDisable();
	}

	public override void Raycast(PointerEventData eventData, List<RaycastResult> resultAppendList)
	{
		if (eventData is ExtendedPointerEventData { pointerType: UIPointerType.Tracked } extendedPointerEventData)
		{
			PerformRaycast(extendedPointerEventData, resultAppendList);
		}
	}

	internal void PerformRaycast(ExtendedPointerEventData eventData, List<RaycastResult> resultAppendList)
	{
		//IL_007f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0084: Unknown result type (might be due to invalid IL or missing references)
		if ((Object)(object)canvas == null || eventCamera == null)
		{
			return;
		}
		Ray ray = new Ray(eventData.trackedDevicePosition, eventData.trackedDeviceOrientation * Vector3.forward);
		float distance = m_MaxDistance;
		RaycastHit val = default(RaycastHit);
		if (m_CheckFor3DOcclusion && Physics.Raycast(ray, ref val, distance, (int)m_BlockingMask))
		{
			distance = ((RaycastHit)(ref val)).distance;
		}
		if (m_CheckFor2DOcclusion)
		{
			float num = distance;
			RaycastHit2D rayIntersection = Physics2D.GetRayIntersection(ray, num, (int)m_BlockingMask);
			if ((Object)(object)((RaycastHit2D)(ref rayIntersection)).collider != null)
			{
				distance = ((RaycastHit2D)(ref rayIntersection)).distance;
			}
		}
		m_RaycastResultsCache.Clear();
		SortedRaycastGraphics(canvas, ray, m_RaycastResultsCache);
		for (int i = 0; i < m_RaycastResultsCache.Count; i++)
		{
			bool flag = true;
			RaycastHitData raycastHitData = m_RaycastResultsCache[i];
			GameObject gameObject = raycastHitData.graphic.gameObject;
			if (m_IgnoreReversedGraphics)
			{
				Vector3 direction = ray.direction;
				Vector3 rhs = gameObject.transform.rotation * Vector3.forward;
				flag = Vector3.Dot(direction, rhs) > 0f;
			}
			if (flag & (raycastHitData.distance < distance))
			{
				RaycastResult item = new RaycastResult
				{
					gameObject = gameObject,
					module = this,
					distance = raycastHitData.distance,
					index = resultAppendList.Count,
					depth = raycastHitData.graphic.depth,
					worldPosition = raycastHitData.worldHitPosition,
					screenPosition = raycastHitData.screenPosition
				};
				resultAppendList.Add(item);
			}
		}
	}

	private void SortedRaycastGraphics(Canvas canvas, Ray ray, List<RaycastHitData> results)
	{
		IList<Graphic> graphicsForCanvas = GraphicRegistry.GetGraphicsForCanvas(canvas);
		s_SortedGraphics.Clear();
		for (int i = 0; i < graphicsForCanvas.Count; i++)
		{
			Graphic graphic = graphicsForCanvas[i];
			if (graphic.depth != -1 && RayIntersectsRectTransform(graphic.rectTransform, ray, out var worldPosition, out var distance))
			{
				Vector2 vector = eventCamera.WorldToScreenPoint(worldPosition);
				if (graphic.Raycast(vector, eventCamera))
				{
					s_SortedGraphics.Add(new RaycastHitData(graphic, worldPosition, vector, distance));
				}
			}
		}
		s_SortedGraphics.Sort((RaycastHitData g1, RaycastHitData g2) => g2.graphic.depth.CompareTo(g1.graphic.depth));
		results.AddRange(s_SortedGraphics);
	}

	private static bool RayIntersectsRectTransform(RectTransform transform, Ray ray, out Vector3 worldPosition, out float distance)
	{
		Vector3[] array = new Vector3[4];
		transform.GetWorldCorners(array);
		if (new Plane(array[0], array[1], array[2]).Raycast(ray, out var enter))
		{
			Vector3 point = ray.GetPoint(enter);
			Vector3 rhs = array[3] - array[0];
			Vector3 rhs2 = array[1] - array[0];
			float num = Vector3.Dot(point - array[0], rhs);
			if (Vector3.Dot(point - array[0], rhs2) >= 0f && num >= 0f)
			{
				Vector3 rhs3 = array[1] - array[2];
				Vector3 rhs4 = array[3] - array[2];
				float num2 = Vector3.Dot(point - array[2], rhs3);
				float num3 = Vector3.Dot(point - array[2], rhs4);
				if (num2 >= 0f && num3 >= 0f)
				{
					worldPosition = point;
					distance = enter;
					return true;
				}
			}
		}
		worldPosition = Vector3.zero;
		distance = 0f;
		return false;
	}
}
