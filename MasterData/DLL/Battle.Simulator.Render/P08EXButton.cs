using System;
using UnityEngine;
using UnityEngine.EventSystems;

public class P08EXButton : MonoBehaviour, IPointerDownHandler, IEventSystemHandler, IPointerUpHandler
{
	public Action actionOnPointerDown;

	public Action actionOnPointerUp;

	public void OnPointerDown(PointerEventData eventData)
	{
		if (actionOnPointerDown != null)
		{
			actionOnPointerDown();
		}
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		if (actionOnPointerUp != null)
		{
			actionOnPointerUp();
		}
	}
}
