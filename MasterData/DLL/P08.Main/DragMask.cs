using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

public class DragMask : MonoBehaviour, IPointerClickHandler, IEventSystemHandler, IPointerDownHandler, IPointerUpHandler, IScrollHandler, IBeginDragHandler, IEndDragHandler, IDragHandler
{
	public enum HandlerType
	{
		pointerClickHandler = 1,
		pointerDownHandler,
		pointerUpHandler,
		beginDragHandler,
		endDragHandler,
		dragHandler,
		scrollHandler
	}

	private bool isPassEvent;

	private bool isPassClick = true;

	private bool isPassDrag = true;

	private bool isPassClickInDrag;

	private bool isInDrag;

	private bool startDrag;

	private int dict = -1;

	private bool hasPassedEvent;

	private GameObject curDragObject;

	public bool IsPassEvent
	{
		get
		{
			return isPassEvent;
		}
		set
		{
			isPassEvent = value;
		}
	}

	public bool IsPassClick
	{
		get
		{
			return isPassClick;
		}
		set
		{
			isPassClick = value;
		}
	}

	public bool IsPassDrag
	{
		get
		{
			return isPassDrag;
		}
		set
		{
			isPassDrag = value;
		}
	}

	public bool IsPassClickInDrag
	{
		get
		{
			return isPassClickInDrag;
		}
		set
		{
			isPassClickInDrag = value;
		}
	}

	public void OnPointerClick(PointerEventData eventData)
	{
		if (IsPassClick)
		{
			if (IsPassClickInDrag)
			{
				Pass(eventData, ExecuteEvents.pointerClickHandler, HandlerType.pointerClickHandler);
			}
			else if (!isInDrag)
			{
				Pass(eventData, ExecuteEvents.pointerClickHandler, HandlerType.pointerClickHandler);
			}
		}
	}

	public void OnPointerDown(PointerEventData eventData)
	{
	}

	public void OnPointerUp(PointerEventData eventData)
	{
	}

	public void OnScroll(PointerEventData eventData)
	{
		if (IsPassDrag)
		{
			Pass(eventData, ExecuteEvents.scrollHandler, HandlerType.scrollHandler);
		}
	}

	public void OnBeginDrag(PointerEventData eventData)
	{
		isInDrag = true;
		if (IsPassDrag)
		{
			startDrag = true;
			Pass(eventData, ExecuteEvents.beginDragHandler, HandlerType.beginDragHandler);
		}
	}

	public void OnEndDrag(PointerEventData eventData)
	{
		isInDrag = false;
		if (IsPassDrag)
		{
			Pass(eventData, ExecuteEvents.endDragHandler, HandlerType.endDragHandler);
		}
	}

	public void OnDrag(PointerEventData eventData)
	{
		if (!IsPassDrag)
		{
			return;
		}
		if (startDrag)
		{
			float num = Mathf.Abs(eventData.delta.x);
			float num2 = Mathf.Abs(eventData.delta.y);
			if (num != 0f || num2 != 0f)
			{
				startDrag = false;
				dict = ((!(num >= num2)) ? 1 : 0);
			}
		}
		Pass(eventData, ExecuteEvents.dragHandler, HandlerType.dragHandler);
	}

	public void Pass<T>(PointerEventData data, ExecuteEvents.EventFunction<T> function, HandlerType handler) where T : IEventSystemHandler
	{
		if (hasPassedEvent)
		{
			return;
		}
		hasPassedEvent = true;
		List<RaycastResult> list = new List<RaycastResult>();
		EventSystem.current.RaycastAll(data, list);
		GameObject gameObject = data.pointerCurrentRaycast.gameObject;
		switch (handler)
		{
		case HandlerType.beginDragHandler:
		{
			for (int k = 0; k < list.Count && (!(gameObject != list[k].gameObject) || !ExecuteEvents.Execute(list[k].gameObject, data, function)); k++)
			{
			}
			break;
		}
		case HandlerType.dragHandler:
			if (curDragObject == null)
			{
				for (int j = 0; j < list.Count; j++)
				{
					if (gameObject != list[j].gameObject)
					{
						DragHelper component = list[j].gameObject.GetComponent<DragHelper>();
						if (dict != -1 && (bool)component && ((dict == 0 && component.AcceptDragX) || (dict == 1 && component.AcceptDragY)))
						{
							curDragObject = list[j].gameObject;
							ExecuteEvents.Execute(curDragObject, data, ExecuteEvents.beginDragHandler);
						}
					}
				}
			}
			if (curDragObject != null && !ExecuteEvents.Execute(curDragObject, data, function))
			{
			}
			break;
		case HandlerType.endDragHandler:
			if (curDragObject != null)
			{
				ExecuteEvents.Execute(curDragObject, data, function);
				curDragObject = null;
				dict = -1;
			}
			break;
		default:
		{
			for (int i = 0; i < list.Count && (!(gameObject != list[i].gameObject) || !ExecuteEvents.Execute(list[i].gameObject, data, function)); i++)
			{
			}
			break;
		}
		}
		list.Clear();
		hasPassedEvent = false;
	}
}
