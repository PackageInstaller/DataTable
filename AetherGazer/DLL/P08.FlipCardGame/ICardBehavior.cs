using UnityEngine.EventSystems;

public interface ICardBehavior
{
	bool CanDrag { get; }

	bool CanClick { get; }

	void OnBeginDrag(Card card, PointerEventData eventData);

	void OnDrag(Card card, PointerEventData eventData);

	void OnEndDrag(Card card, PointerEventData eventData);

	void OnPointerEnter(Card card, PointerEventData eventData);

	void OnPointerExit(Card card, PointerEventData eventData);

	void OnPointerDown(Card card, PointerEventData eventData);

	void OnPointerUp(Card card, PointerEventData eventData);
}
