using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

public class UIPassClickEvent : MonoBehaviour, IPointerClickHandler, IEventSystemHandler, IPointerDownHandler, IPointerUpHandler
{
	private bool hasPassedEvent;

	public void OnPointerClick(PointerEventData eventData)
	{
		Psss(eventData, ExecuteEvents.pointerClickHandler);
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		Psss(eventData, ExecuteEvents.pointerDownHandler);
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		Psss(eventData, ExecuteEvents.pointerUpHandler);
	}

	public void Psss<T>(PointerEventData data, ExecuteEvents.EventFunction<T> function) where T : IEventSystemHandler
	{
		if (hasPassedEvent)
		{
			return;
		}
		hasPassedEvent = true;
		List<RaycastResult> list = new List<RaycastResult>();
		EventSystem.current.RaycastAll(data, list);
		GameObject gameObject = data.pointerCurrentRaycast.gameObject;
		for (int i = 0; i < list.Count; i++)
		{
			if (gameObject != list[i].gameObject)
			{
				GameObject eventHandler = list[i].gameObject;
				if (ExecuteEvents.pointerDownHandler.Equals(function))
				{
					eventHandler = ExecuteEvents.GetEventHandler<IPointerDownHandler>(eventHandler);
				}
				else if (ExecuteEvents.pointerUpHandler.Equals(function))
				{
					eventHandler = ExecuteEvents.GetEventHandler<IPointerUpHandler>(eventHandler);
				}
				else if (ExecuteEvents.pointerClickHandler.Equals(function))
				{
					eventHandler = ExecuteEvents.GetEventHandler<IPointerClickHandler>(eventHandler);
				}
				if (ExecuteEvents.Execute(eventHandler, data, function))
				{
					break;
				}
			}
		}
		list.Clear();
		hasPassedEvent = false;
	}
}
