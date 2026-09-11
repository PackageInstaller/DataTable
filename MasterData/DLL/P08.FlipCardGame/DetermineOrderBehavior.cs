using UnityEngine.EventSystems;

public class DetermineOrderBehavior : ICardBehavior
{
	public bool CanDrag => false;

	public bool CanClick => false;

	public void OnBeginDrag(Card card, PointerEventData eventData)
	{
	}

	public void OnDrag(Card card, PointerEventData eventData)
	{
	}

	public void OnEndDrag(Card card, PointerEventData eventData)
	{
	}

	public void OnPointerEnter(Card card, PointerEventData eventData)
	{
	}

	public void OnPointerExit(Card card, PointerEventData eventData)
	{
	}

	public void OnPointerDown(Card card, PointerEventData eventData)
	{
	}

	public void OnPointerUp(Card card, PointerEventData eventData)
	{
	}
}
