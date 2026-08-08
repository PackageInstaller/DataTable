using System;
using UnityEngine.EventSystems;

public class ZumaShooterCol : EventTrigger
{
	private Action ClickCallback;

	private Action DragCallback;

	private Action DragEndCallback;

	public void SetClickCallBack(Action callback)
	{
		ClickCallback = callback;
	}

	public override void OnPointerClick(PointerEventData eventData)
	{
		if (ClickCallback != null)
		{
			ClickCallback();
		}
	}

	public void SetDragCallBack(Action callback)
	{
		DragCallback = callback;
	}

	public override void OnDrag(PointerEventData eventData)
	{
		if (DragCallback != null)
		{
			DragCallback();
		}
	}

	public void SetDragEndCallBack(Action callback)
	{
		DragEndCallback = callback;
	}

	public override void OnEndDrag(PointerEventData eventData)
	{
		if (DragEndCallback != null)
		{
			DragEndCallback();
		}
	}
}
