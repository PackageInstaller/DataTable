using System.Collections.Generic;
using ACT.UI.InputController;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;
using UnityEngine.UI;

namespace ACT.UI;

public class PassOnItemUIComponent : MonoBehaviour, IPointerClickHandler, IEventSystemHandler, IPointerDownHandler, IPointerUpHandler, IBeginDragHandler, IEndDragHandler, IDragHandler
{
	[Tooltip("向下传递事件")]
	public bool passEvent;

	public bool raycastAllItemUIComp;

	public UnityEvent<GameObject> onHitComponent;

	public UnityEvent onMiss;

	private List<RaycastResult> m_AllTargets;

	private GameObject m_FirstIItemDetail;

	private bool m_IsDrag;

	private void Start()
	{
		m_AllTargets = ListPool<RaycastResult>.Get();
	}

	private void OnDestroy()
	{
		ListPool<RaycastResult>.Release(m_AllTargets);
		m_AllTargets = null;
		m_FirstIItemDetail = null;
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		m_AllTargets.Clear();
		m_FirstIItemDetail = null;
		EventSystemHelper.Shared.RaycastAll(eventData, m_AllTargets);
		m_AllTargets.Reverse();
		for (int num = m_AllTargets.Count - 1; num >= 0; num--)
		{
			if (m_AllTargets[num].gameObject.GetComponent<IItemDetailRayCast>() != null)
			{
				if (m_FirstIItemDetail == null)
				{
					m_FirstIItemDetail = m_AllTargets[num].gameObject;
				}
				else if (!raycastAllItemUIComp)
				{
					m_AllTargets.Remove(m_AllTargets[num]);
				}
			}
		}
		m_AllTargets.Reverse();
		PassEvent(eventData, ExecuteEvents.pointerDownHandler);
	}

	public void OnPointerClick(PointerEventData eventData)
	{
		if (!m_IsDrag)
		{
			PassEvent(eventData, ExecuteEvents.pointerClickHandler);
			if (m_FirstIItemDetail == null)
			{
				onMiss?.Invoke();
			}
			else
			{
				onHitComponent?.Invoke(m_FirstIItemDetail);
			}
		}
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		PassEvent(eventData, ExecuteEvents.pointerUpHandler);
	}

	public void OnBeginDrag(PointerEventData eventData)
	{
		m_IsDrag = true;
		PassScrollRectEvent(eventData, 0);
	}

	public void OnEndDrag(PointerEventData eventData)
	{
		PassScrollRectEvent(eventData, 2);
		m_IsDrag = false;
	}

	public void OnDrag(PointerEventData eventData)
	{
		PassScrollRectEvent(eventData, 1);
	}

	public void PassEvent<T>(PointerEventData data, ExecuteEvents.EventFunction<T> function) where T : IEventSystemHandler
	{
		for (int i = 0; i < m_AllTargets.Count; i++)
		{
			if (passEvent && gameObject != m_AllTargets[i].gameObject)
			{
				ExecuteEvents.Execute(m_AllTargets[i].gameObject, data, function);
			}
		}
	}

	public void PassScrollRectEvent(PointerEventData data, int dragType)
	{
		foreach (RaycastResult allTarget in m_AllTargets)
		{
			if (allTarget.gameObject == gameObject)
			{
				continue;
			}
			ScrollRect componentInParent = allTarget.gameObject.GetComponentInParent<ScrollRect>();
			LoopScrollRectBase componentInParent2 = allTarget.gameObject.GetComponentInParent<LoopScrollRectBase>();
			if ((bool)componentInParent)
			{
				switch (dragType)
				{
				case 0:
					componentInParent.OnBeginDrag(data);
					break;
				case 1:
					componentInParent.OnDrag(data);
					break;
				case 2:
					componentInParent.OnEndDrag(data);
					break;
				}
			}
			if ((bool)componentInParent2)
			{
				switch (dragType)
				{
				case 0:
					componentInParent2.OnBeginDrag(data);
					break;
				case 1:
					componentInParent2.OnDrag(data);
					break;
				case 2:
					componentInParent2.OnEndDrag(data);
					break;
				}
			}
		}
	}
}
