using System.Collections.Generic;
using ACT.UI.InputController;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class UIPassEvent : MonoEmptyForRaycast, IPointerDownHandler, IEventSystemHandler, IPointerUpHandler, IPointerClickHandler, IDragHandler, IBeginDragHandler, IEndDragHandler
{
	public int passCount = 1;

	public bool pointerDown = true;

	public bool pointerUp = true;

	public bool pointerClick = true;

	public void OnPointerDown(PointerEventData eventData)
	{
		if (pointerDown)
		{
			PassEvent(eventData, ExecuteEvents.pointerDownHandler);
		}
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		if (pointerUp)
		{
			PassEvent(eventData, ExecuteEvents.pointerUpHandler);
		}
	}

	public void OnPointerClick(PointerEventData eventData)
	{
		if (pointerClick)
		{
			PassEvent(eventData, ExecuteEvents.pointerClickHandler);
		}
	}

	public void OnDrag(PointerEventData eventData)
	{
	}

	public void OnBeginDrag(PointerEventData eventData)
	{
	}

	public void OnEndDrag(PointerEventData eventData)
	{
	}

	public void PassEvent<T>(PointerEventData data, ExecuteEvents.EventFunction<T> function) where T : IEventSystemHandler
	{
		List<RaycastResult> list = new List<RaycastResult>();
		EventSystemHelper.Shared.RaycastAll(data, list);
		GameObject gameObject = data.pointerCurrentRaycast.gameObject;
		int num = 0;
		for (int i = 0; i < list.Count; i++)
		{
			if (gameObject != list[i].gameObject && CanReceiveEvent(list[i].gameObject, out var selectableObject))
			{
				if (num >= passCount)
				{
					break;
				}
				ExecuteEvents.Execute(selectableObject, data, function);
				num++;
			}
		}
	}

	private bool CanReceiveEvent(GameObject gameObject, out GameObject selectableObject)
	{
		if (gameObject.GetComponent<PassOnItemUIComponent>() != null || gameObject.GetComponent<MaskableGraphic>() == null)
		{
			selectableObject = null;
			return false;
		}
		selectableObject = gameObject.GetComponentInParent<Selectable>()?.gameObject;
		return selectableObject;
	}
}
