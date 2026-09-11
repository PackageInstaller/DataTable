using System.Collections.Generic;
using P08.Quiz;
using UnityEngine.EventSystems;

public class ShuffleHandBehavior : ICardBehavior
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
		bool flag = card.Selected();
		List<int> sufferCardIndexs = MonoSingleton<BloodCardManager>.Instance.sufferCardIndexs;
		if (flag && sufferCardIndexs.IndexOf(card.index) == -1)
		{
			sufferCardIndexs.Add(card.index);
		}
		else if (!flag && sufferCardIndexs.IndexOf(card.index) != -1)
		{
			sufferCardIndexs.Remove(card.index);
		}
	}
}
