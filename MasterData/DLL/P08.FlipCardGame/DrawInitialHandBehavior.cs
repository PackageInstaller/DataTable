using UnityEngine.EventSystems;

public class DrawInitialHandBehavior : ICardBehavior
{
	public bool CanDrag => true;

	public bool CanClick => true;

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
