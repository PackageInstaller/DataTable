using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

public class UIPassEvent : MonoBehaviour, IPointerClickHandler, IEventSystemHandler, IPointerDownHandler, IPointerUpHandler, IScrollHandler, IBeginDragHandler, IEndDragHandler, IDragHandler
{
	public bool isPassEvent;

	public bool isPassClick = true;

	public bool isPassDrag;

	public bool isPassClickInDrag = true;

	private bool isInDrag;

	private bool hasPassedEvent;

	public void OnPointerClick(PointerEventData eventData)
	{
		if (isPassClick)
		{
			if (isPassClickInDrag)
			{
				Psss(eventData, ExecuteEvents.pointerClickHandler);
			}
			else if (!isInDrag)
			{
				Psss(eventData, ExecuteEvents.pointerClickHandler);
			}
		}
	}

	public void OnPointerDown(PointerEventData eventData)
	{
	}

	public void OnPointerUp(PointerEventData eventData)
	{
	}

	public void OnBeginDrag(PointerEventData eventData)
	{
		isInDrag = true;
		if (isPassDrag)
		{
			Psss(eventData, ExecuteEvents.beginDragHandler);
		}
	}

	public void OnEndDrag(PointerEventData eventData)
	{
		isInDrag = false;
		if (isPassDrag)
		{
			Psss(eventData, ExecuteEvents.endDragHandler);
		}
	}

	public void OnDrag(PointerEventData eventData)
	{
		if (isPassDrag)
		{
			Psss(eventData, ExecuteEvents.dragHandler);
		}
	}

	public void OnScroll(PointerEventData eventData)
	{
		if (isPassDrag)
		{
			Psss(eventData, ExecuteEvents.scrollHandler);
		}
	}

	public void Psss<T>(PointerEventData data, ExecuteEvents.EventFunction<T> function) where T : IEventSystemHandler
	{
		if (!hasPassedEvent)
		{
			hasPassedEvent = true;
			List<RaycastResult> list = new List<RaycastResult>();
			EventSystem.current.RaycastAll(data, list);
			GameObject gameObject = data.pointerCurrentRaycast.gameObject;
			for (int i = 0; i < list.Count && (!(gameObject != list[i].gameObject) || !ExecuteEvents.Execute(list[i].gameObject, data, function)); i++)
			{
			}
			list.Clear();
			hasPassedEvent = false;
		}
	}
}
