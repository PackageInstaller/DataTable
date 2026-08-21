using System;
using System.Collections.Generic;
using UnityEngine.UI;

namespace UnityEngine.EventSystems;

[AddComponentMenu("Event/Physics Raycaster")]
[RequireComponent(typeof(Camera))]
public class PhysicsRaycaster : BaseRaycaster
{
	private class RaycastHitComparer : IComparer<RaycastHit>
	{
		public static RaycastHitComparer instance = new RaycastHitComparer();

		public int Compare(RaycastHit x, RaycastHit y)
		{
			return ((RaycastHit)(ref x)).distance.CompareTo(((RaycastHit)(ref y)).distance);
		}
	}

	protected const int kNoEventMaskSet = -1;

	protected Camera m_EventCamera;

	[SerializeField]
	protected LayerMask m_EventMask = -1;

	[SerializeField]
	protected int m_MaxRayIntersections;

	protected int m_LastMaxRayIntersections;

	private RaycastHit[] m_Hits;

	public override Camera eventCamera
	{
		get
		{
			if (m_EventCamera == null)
			{
				m_EventCamera = GetComponent<Camera>();
			}
			return m_EventCamera ?? Camera.main;
		}
	}

	public virtual int depth
	{
		get
		{
			if (!(eventCamera != null))
			{
				return 16777215;
			}
			return (int)eventCamera.depth;
		}
	}

	public int finalEventMask
	{
		get
		{
			if (!(eventCamera != null))
			{
				return -1;
			}
			return eventCamera.cullingMask & (int)m_EventMask;
		}
	}

	public LayerMask eventMask
	{
		get
		{
			return m_EventMask;
		}
		set
		{
			m_EventMask = value;
		}
	}

	public int maxRayIntersections
	{
		get
		{
			return m_MaxRayIntersections;
		}
		set
		{
			m_MaxRayIntersections = value;
		}
	}

	protected PhysicsRaycaster()
	{
	}

	protected bool ComputeRayAndDistance(PointerEventData eventData, ref Ray ray, ref int eventDisplayIndex, ref float distanceToClipPlane)
	{
		if (eventCamera == null)
		{
			return false;
		}
		Vector3 vector = MultipleDisplayUtilities.RelativeMouseAtScaled(eventData.position);
		if (vector != Vector3.zero)
		{
			eventDisplayIndex = (int)vector.z;
			if (eventDisplayIndex != eventCamera.targetDisplay)
			{
				return false;
			}
		}
		else
		{
			vector = eventData.position;
		}
		if (!eventCamera.pixelRect.Contains(vector))
		{
			return false;
		}
		ray = eventCamera.ScreenPointToRay(vector);
		float z = ray.direction.z;
		distanceToClipPlane = (Mathf.Approximately(0f, z) ? float.PositiveInfinity : Mathf.Abs((eventCamera.farClipPlane - eventCamera.nearClipPlane) / z));
		return true;
	}

	public override void Raycast(PointerEventData eventData, List<RaycastResult> resultAppendList)
	{
		Ray ray = default(Ray);
		int eventDisplayIndex = 0;
		float distanceToClipPlane = 0f;
		if (!ComputeRayAndDistance(eventData, ref ray, ref eventDisplayIndex, ref distanceToClipPlane))
		{
			return;
		}
		int num = 0;
		if (m_MaxRayIntersections == 0)
		{
			if (ReflectionMethodsCache.Singleton.raycast3DAll == null)
			{
				return;
			}
			m_Hits = ReflectionMethodsCache.Singleton.raycast3DAll(ray, distanceToClipPlane, finalEventMask);
			num = m_Hits.Length;
		}
		else
		{
			if (ReflectionMethodsCache.Singleton.getRaycastNonAlloc == null)
			{
				return;
			}
			if (m_LastMaxRayIntersections != m_MaxRayIntersections)
			{
				m_Hits = (RaycastHit[])(object)new RaycastHit[m_MaxRayIntersections];
				m_LastMaxRayIntersections = m_MaxRayIntersections;
			}
			num = ReflectionMethodsCache.Singleton.getRaycastNonAlloc(ray, m_Hits, distanceToClipPlane, finalEventMask);
		}
		if (num != 0)
		{
			if (num > 1)
			{
				Array.Sort(m_Hits, 0, num, RaycastHitComparer.instance);
			}
			int i = 0;
			for (int num2 = num; i < num2; i++)
			{
				RaycastResult item = new RaycastResult
				{
					gameObject = ((Component)(object)((RaycastHit)(ref m_Hits[i])).collider).gameObject,
					module = this,
					distance = ((RaycastHit)(ref m_Hits[i])).distance,
					worldPosition = ((RaycastHit)(ref m_Hits[i])).point,
					worldNormal = ((RaycastHit)(ref m_Hits[i])).normal,
					screenPosition = eventData.position,
					displayIndex = eventDisplayIndex,
					index = resultAppendList.Count,
					sortingLayer = 0,
					sortingOrder = 0
				};
				resultAppendList.Add(item);
			}
		}
	}
}
