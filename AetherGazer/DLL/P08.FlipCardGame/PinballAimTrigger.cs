using System;
using UnityEngine;
using UnityEngine.EventSystems;

public class PinballAimTrigger : EventTrigger
{
	private Action<Vector3> clickCallback;

	private Action<Vector3> dragBeginCallback;

	private Action<Vector3> dragCallback;

	private Action<Vector3> dragEndCallback;

	private Action pressDownCallback;

	private Action pressUpCallback;

	private bool isDrag;

	public void SetClickCallBack(Action<Vector3> callback)
	{
		clickCallback = callback;
	}

	public void SetDragBeginCallBack(Action<Vector3> callback)
	{
		dragBeginCallback = callback;
	}

	public void SetDragCallBack(Action<Vector3> callback)
	{
		dragCallback = callback;
	}

	public void SetDragEndCallBack(Action<Vector3> callback)
	{
		dragEndCallback = callback;
	}

	public void SetPressDownCallBack(Action callback)
	{
		pressDownCallback = callback;
	}

	public void SetPressUpCallBack(Action callback)
	{
		pressUpCallback = callback;
	}

	public override void OnPointerClick(PointerEventData eventData)
	{
		if (clickCallback != null && !isDrag)
		{
			clickCallback(eventData.pointerCurrentRaycast.worldPosition);
		}
	}

	public override void OnBeginDrag(PointerEventData eventData)
	{
		isDrag = true;
		if (dragBeginCallback != null)
		{
			dragBeginCallback(eventData.pointerCurrentRaycast.worldPosition);
		}
	}

	public override void OnDrag(PointerEventData eventData)
	{
		if (dragCallback != null)
		{
			dragCallback(eventData.pointerCurrentRaycast.worldPosition);
		}
	}

	public override void OnEndDrag(PointerEventData eventData)
	{
		isDrag = false;
		if (dragEndCallback != null)
		{
			dragEndCallback(eventData.pointerCurrentRaycast.worldPosition);
		}
	}

	public override void OnPointerDown(PointerEventData eventData)
	{
		if (pressDownCallback != null)
		{
			pressDownCallback();
		}
	}

	public override void OnPointerUp(PointerEventData eventData)
	{
		if (pressUpCallback != null)
		{
			pressUpCallback();
		}
	}
}
