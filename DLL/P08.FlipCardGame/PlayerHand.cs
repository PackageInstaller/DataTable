using P08.Quiz;
using UnityEngine;

public class PlayerHand : CardHolder
{
	protected override void Start()
	{
		base.Start();
	}

	protected override void BeginDrag(Card card)
	{
		base.BeginDrag(card);
	}

	protected override void EndDrag(Card card)
	{
		base.EndDrag(card);
	}

	protected override void CardPointerEnter(Card card)
	{
		base.CardPointerEnter(card);
	}

	protected override void CardPointerExit(Card card)
	{
		base.CardPointerExit(card);
	}

	protected override void Update()
	{
		base.Update();
		if (Input.GetMouseButtonDown(1))
		{
			foreach (Card card in cards)
			{
				card.Deselect();
			}
		}
		if (selectedCard == null || isCrossing || !MonoSingleton<BloodCardManager>.Instance.playingEffectDone)
		{
			return;
		}
		for (int i = 0; i < cards.Count; i++)
		{
			if (selectedCard.transform.position.x > cards[i].transform.position.x && selectedCard.ParentIndex() < cards[i].ParentIndex())
			{
				Swap(i);
				break;
			}
			if (selectedCard.transform.position.x < cards[i].transform.position.x && selectedCard.ParentIndex() > cards[i].ParentIndex())
			{
				Swap(i);
				break;
			}
		}
	}

	protected override void Swap(int index)
	{
		base.Swap(index);
	}
}
