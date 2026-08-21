using UnityEngine;
using UnityEngine.EventSystems;

public class ToHaveEmotePoint : MonoBehaviour, IPointerDownHandler, IEventSystemHandler, IPointerUpHandler, IPointerEnterHandler, IPointerExitHandler
{
	public bool isPointerDown;

	public bool isPointerUp;

	public bool isPointerEnter;

	public bool isPointerExit;

	public void OnPointerDown(PointerEventData eventData)
	{
		isPointerDown = true;
		isPointerUp = false;
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		isPointerDown = false;
		isPointerUp = true;
	}

	public void OnPointerEnter(PointerEventData eventData)
	{
		isPointerEnter = true;
		isPointerExit = false;
	}

	public void OnPointerExit(PointerEventData eventData)
	{
		isPointerEnter = false;
		isPointerExit = true;
	}
}
