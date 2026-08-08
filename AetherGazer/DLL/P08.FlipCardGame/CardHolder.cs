using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using P08.Quiz;
using UnityEngine;
using UnityEngine.UI;

public abstract class CardHolder : MonoBehaviour
{
	[SerializeField]
	protected Card selectedCard;

	[SerializeField]
	protected Card hoveredCard;

	protected RectTransform rect;

	[Header("Spawn Settings")]
	public List<Card> cards;

	public bool isShake;

	protected bool isCrossing;

	[SerializeField]
	protected bool tweenCardReturn = true;

	protected BloodCardBoard board;

	[Header("游戏内信息")]
	public BloodCardEnum.PlayerRole playerRole;

	public BloodCardEnum.PlaceType place;

	protected virtual void Start()
	{
		rect = GetComponent<RectTransform>();
		board = MonoSingleton<BloodCardManager>.Instance.Board;
	}

	public virtual void UpdateCards()
	{
		int num = 0;
		cards = GetComponentsInChildren<Card>().ToList();
		foreach (Card card in cards)
		{
			card.AddEventListeners(card.PointerEnterEvent, CardPointerEnter, "CardHolder");
			card.AddEventListeners(card.PointerExitEvent, CardPointerExit, "CardHolder");
			card.AddEventListeners(card.BeginDragEvent, BeginDrag, "CardHolder");
			card.AddEventListeners(card.EndDragEvent, EndDrag, "CardHolder");
			card.name = num.ToString();
			if (playerRole == BloodCardEnum.PlayerRole.SELF)
			{
				if (place == BloodCardEnum.PlaceType.CHANGE)
				{
					card.SetCardBehavior(new ChangeCardBehavior());
				}
				else if (place == BloodCardEnum.PlaceType.DECK)
				{
					card.SetCardBehavior(new NoInteractionCardBehavior());
				}
				else
				{
					card.SetCardBehavior(new DefaultCardBehavior());
				}
				card.belongs = BloodCardEnum.PlayerRole.SELF;
			}
			else if (playerRole == BloodCardEnum.PlayerRole.SYSTEM)
			{
				card.SetCardBehavior(new NoInteractionCardBehavior());
				card.belongs = BloodCardEnum.PlayerRole.SYSTEM;
			}
			else
			{
				card.SetCardBehavior(new NoInteractionCardBehavior());
				card.belongs = BloodCardEnum.PlayerRole.ENEMY;
			}
			card.place = place;
			card.cardVisual.SetCardShaking(isShake);
			num++;
		}
		StartCoroutine(Frame());
		IEnumerator Frame()
		{
			yield return new WaitForSecondsRealtime(0.1f);
			for (int i = 0; i < cards.Count; i++)
			{
				if (cards[i].cardVisual != null)
				{
					if (cards[i].place == BloodCardEnum.PlaceType.DECK && cards[i].belongs == BloodCardEnum.PlayerRole.ENEMY)
					{
						cards[i].cardVisual.UpdateIndex(MonoSingleton<BloodCardManager>.Instance.Board.boardCardNum);
					}
					else if (cards[i].place == BloodCardEnum.PlaceType.DECK && cards[i].belongs == BloodCardEnum.PlayerRole.SELF)
					{
						cards[i].cardVisual.UpdateIndex(MonoSingleton<BloodCardManager>.Instance.Board.boardCardNum + MonoSingleton<BloodCardManager>.Instance.EnemyCardDeck.cards.Count);
					}
					else if (cards[i].place == BloodCardEnum.PlaceType.HAND && cards[i].belongs == BloodCardEnum.PlayerRole.ENEMY)
					{
						cards[i].cardVisual.UpdateIndex(MonoSingleton<BloodCardManager>.Instance.Board.boardCardNum + MonoSingleton<BloodCardManager>.Instance.EnemyCardDeck.cards.Count + MonoSingleton<BloodCardManager>.Instance.PlayerCardDeck.cards.Count);
					}
					else if (cards[i].place == BloodCardEnum.PlaceType.HAND && cards[i].belongs == BloodCardEnum.PlayerRole.SELF)
					{
						cards[i].cardVisual.UpdateIndex(MonoSingleton<BloodCardManager>.Instance.Board.boardCardNum + MonoSingleton<BloodCardManager>.Instance.EnemyCardDeck.cards.Count + MonoSingleton<BloodCardManager>.Instance.PlayerCardDeck.cards.Count + MonoSingleton<BloodCardManager>.Instance.EnemyCardHand.cards.Count);
					}
					else
					{
						cards[i].cardVisual.UpdateIndex(MonoSingleton<BloodCardManager>.Instance.Board.boardCardNum + MonoSingleton<BloodCardManager>.Instance.EnemyCardDeck.cards.Count + MonoSingleton<BloodCardManager>.Instance.PlayerCardDeck.cards.Count + MonoSingleton<BloodCardManager>.Instance.PlayerCardHand.cards.Count + MonoSingleton<BloodCardManager>.Instance.PlayerCardHand.cards.Count);
					}
				}
			}
			LayoutRebuilder.ForceRebuildLayoutImmediate(rect);
		}
	}

	protected virtual void BeginDrag(Card card)
	{
		selectedCard = card;
	}

	protected virtual void EndDrag(Card card)
	{
		if (selectedCard == null)
		{
			return;
		}
		Card cardTemp = selectedCard;
		LeanTween.moveLocal(selectedCard.gameObject, selectedCard.selected ? new Vector3(0f, 0f, 0f) : Vector3.zero, tweenCardReturn ? 0.15f : 0f).setOnComplete((Action)delegate
		{
			if (cardTemp.place == BloodCardEnum.PlaceType.HAND)
			{
				cardTemp.SetCardSize("big");
			}
		});
		selectedCard = null;
	}

	protected virtual void CardPointerEnter(Card card)
	{
		hoveredCard = card;
	}

	protected virtual void CardPointerExit(Card card)
	{
		hoveredCard = null;
	}

	protected virtual void Update()
	{
	}

	protected virtual void Swap(int index)
	{
		isCrossing = true;
		Transform parent = selectedCard.transform.parent;
		Transform parent2 = cards[index].transform.parent;
		cards[index].transform.SetParent(parent);
		cards[index].transform.localPosition = (cards[index].selected ? new Vector3(0f, cards[index].selectionOffset, 0f) : Vector3.zero);
		selectedCard.transform.SetParent(parent2);
		isCrossing = false;
		if (cards[index].cardVisual == null)
		{
			return;
		}
		bool flag = cards[index].ParentIndex() > selectedCard.ParentIndex();
		cards[index].cardVisual.Swap((!flag) ? 1 : (-1));
		foreach (Card card in cards)
		{
			if (card.cardVisual != null)
			{
				if (card.place == BloodCardEnum.PlaceType.DECK && card.belongs == BloodCardEnum.PlayerRole.ENEMY)
				{
					card.cardVisual.UpdateIndex(MonoSingleton<BloodCardManager>.Instance.Board.boardCardNum);
				}
				else if (card.place == BloodCardEnum.PlaceType.DECK && card.belongs == BloodCardEnum.PlayerRole.SELF)
				{
					card.cardVisual.UpdateIndex(MonoSingleton<BloodCardManager>.Instance.Board.boardCardNum + MonoSingleton<BloodCardManager>.Instance.EnemyCardDeck.cards.Count);
				}
				else if (card.place == BloodCardEnum.PlaceType.HAND && card.belongs == BloodCardEnum.PlayerRole.ENEMY)
				{
					card.cardVisual.UpdateIndex(MonoSingleton<BloodCardManager>.Instance.Board.boardCardNum + MonoSingleton<BloodCardManager>.Instance.EnemyCardDeck.cards.Count + MonoSingleton<BloodCardManager>.Instance.PlayerCardDeck.cards.Count);
				}
				else if (card.place == BloodCardEnum.PlaceType.HAND && card.belongs == BloodCardEnum.PlayerRole.SELF)
				{
					card.cardVisual.UpdateIndex(MonoSingleton<BloodCardManager>.Instance.Board.boardCardNum + MonoSingleton<BloodCardManager>.Instance.EnemyCardDeck.cards.Count + MonoSingleton<BloodCardManager>.Instance.PlayerCardDeck.cards.Count + MonoSingleton<BloodCardManager>.Instance.EnemyCardHand.cards.Count);
				}
				else
				{
					card.cardVisual.UpdateIndex(MonoSingleton<BloodCardManager>.Instance.Board.boardCardNum + MonoSingleton<BloodCardManager>.Instance.EnemyCardDeck.cards.Count + MonoSingleton<BloodCardManager>.Instance.PlayerCardDeck.cards.Count + MonoSingleton<BloodCardManager>.Instance.PlayerCardHand.cards.Count + MonoSingleton<BloodCardManager>.Instance.PlayerCardHand.cards.Count);
				}
			}
		}
	}

	public void OnDestroy()
	{
		StopAllCoroutines();
	}
}
