using P08.Quiz;
using UnityEngine.EventSystems;

public class CardBoardCardBehavior : ICardBehavior
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
	}

	public void OnPointerExit(Card card, PointerEventData eventData)
	{
	}

	public void OnPointerDown(Card card, PointerEventData eventData)
	{
		if (MonoSingleton<BloodCardManager>.Instance.CurrentStatus == BloodCardEnum.GameStatus.PLAYERROUND && !MonoSingleton<BloodCardManager>.Instance.selfPlaceCardDone && MonoSingleton<BloodCardManager>.Instance.isDrawCardDone && MonoSingleton<BloodCardManager>.Instance.playingEffectDone && !MonoSingleton<BloodCardManager>.Instance.selfCantPutCard)
		{
			LuaHelper.CallFunction("InvokeClickCard", card.Data().id, card.belongs == BloodCardEnum.PlayerRole.ENEMY);
		}
	}

	public void OnPointerUp(Card card, PointerEventData eventData)
	{
	}
}
