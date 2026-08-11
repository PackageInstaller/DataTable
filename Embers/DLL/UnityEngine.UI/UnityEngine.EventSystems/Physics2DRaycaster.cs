using System.Collections.Generic;
using UnityEngine.Rendering;
using UnityEngine.Tilemaps;
using UnityEngine.U2D;
using UnityEngine.UI;

namespace UnityEngine.EventSystems;

[RequireComponent(typeof(Camera))]
[AddComponentMenu("Event/Physics 2D Raycaster")]
public class Physics2DRaycaster : PhysicsRaycaster
{
	private RaycastHit2D[] m_Hits;

	protected Physics2DRaycaster()
	{
	}

	public override void Raycast(PointerEventData eventData, List<RaycastResult> resultAppendList)
	{
		Ray ray = default(Ray);
		float distanceToClipPlane = 0f;
		int eventDisplayIndex = 0;
		if (!ComputeRayAndDistance(eventData, ref ray, ref eventDisplayIndex, ref distanceToClipPlane))
		{
			return;
		}
		int num = 0;
		if (base.maxRayIntersections == 0)
		{
			if (ReflectionMethodsCache.Singleton.getRayIntersectionAll == null)
			{
				return;
			}
			m_Hits = ReflectionMethodsCache.Singleton.getRayIntersectionAll(ray, distanceToClipPlane, base.finalEventMask);
			num = m_Hits.Length;
		}
		else
		{
			if (ReflectionMethodsCache.Singleton.getRayIntersectionAllNonAlloc == null)
			{
				return;
			}
			if (m_LastMaxRayIntersections != m_MaxRayIntersections)
			{
				m_Hits = (RaycastHit2D[])(object)new RaycastHit2D[base.maxRayIntersections];
				m_LastMaxRayIntersections = m_MaxRayIntersections;
			}
			num = ReflectionMethodsCache.Singleton.getRayIntersectionAllNonAlloc(ray, m_Hits, distanceToClipPlane, base.finalEventMask);
		}
		if (num == 0)
		{
			return;
		}
		int i = 0;
		for (int num2 = num; i < num2; i++)
		{
			Renderer renderer = null;
			Renderer component = ((Component)(object)((RaycastHit2D)(ref m_Hits[i])).collider).gameObject.GetComponent<Renderer>();
			if (component != null)
			{
				if (component is SpriteRenderer)
				{
					renderer = component;
				}
				if (component is TilemapRenderer)
				{
					renderer = component;
				}
				if (component is SpriteShapeRenderer)
				{
					renderer = component;
				}
			}
			RaycastResult item = new RaycastResult
			{
				gameObject = ((Component)(object)((RaycastHit2D)(ref m_Hits[i])).collider).gameObject,
				module = this,
				distance = Vector3.Distance(eventCamera.transform.position, ((RaycastHit2D)(ref m_Hits[i])).point),
				worldPosition = ((RaycastHit2D)(ref m_Hits[i])).point,
				worldNormal = ((RaycastHit2D)(ref m_Hits[i])).normal,
				screenPosition = eventData.position,
				displayIndex = eventDisplayIndex,
				index = resultAppendList.Count,
				sortingGroupID = ((renderer != null) ? renderer.sortingGroupID : SortingGroup.invalidSortingGroupID),
				sortingGroupOrder = ((renderer != null) ? renderer.sortingGroupOrder : 0),
				sortingLayer = ((renderer != null) ? renderer.sortingLayerID : 0),
				sortingOrder = ((renderer != null) ? renderer.sortingOrder : 0)
			};
			if (item.sortingGroupID != SortingGroup.invalidSortingGroupID)
			{
				SortingGroup sortingGroupByIndex = SortingGroup.GetSortingGroupByIndex(renderer.sortingGroupID);
				if ((object)sortingGroupByIndex != null)
				{
					item.distance = Vector3.Dot(ray.direction, sortingGroupByIndex.transform.position - ray.origin);
					item.sortingLayer = sortingGroupByIndex.sortingLayerID;
					item.sortingOrder = sortingGroupByIndex.sortingOrder;
				}
			}
			resultAppendList.Add(item);
		}
	}
}
