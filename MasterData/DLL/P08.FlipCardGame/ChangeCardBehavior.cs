using P08.Quiz;
using UnityEngine;
using UnityEngine.EventSystems;

public class ChangeCardBehavior : ICardBehavior
{
	public bool CanDrag => false;

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
		card.PointerEnterEvent.Invoke(card);
		card.SetHovering(hovering: true);
	}

	public void OnPointerExit(Card card, PointerEventData eventData)
	{
		card.PointerExitEvent.Invoke(card);
		card.SetHovering(hovering: false);
	}

	public void OnPointerDown(Card card, PointerEventData eventData)
	{
		card.PointerDownEvent.Invoke(card);
		card.SetPointerDownTime(Time.time);
	}

	public void OnPointerUp(Card card, PointerEventData eventData)
	{
		if (!MonoSingleton<BloodCardManager>.Instance.isDecidedSuffer)
		{
			card.SetPointerDownTime(Time.time);
			card.PointerUpEvent.Invoke(card, card.GetPointerDownTime() - card.GetPointerDownTime() > 0.2f);
			card.SetSelected(!card.Selected());
			card.SelectEvent.Invoke(card, card.Selected());
			card.cardVisual.changeController.SetSelectedState(card.Selected() ? "true" : "false");
			AudioManager.Instance.Play("effect", BloodCardManager.CUE_NAME, "minigame_activity_3_10_card_click", useStream: false);
		}
	}
}
