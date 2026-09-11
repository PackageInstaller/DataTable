using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

namespace RogueCard;

public class RogueCardHolder : MonoBehaviour
{
	[HideInInspector]
	[SerializeField]
	private RogueCard selectedCard;

	[HideInInspector]
	[SerializeReference]
	private RogueCard hoveredCard;

	[SerializeField]
	private GameObject slotPrefab;

	private RectTransform rect;

	[Header("Spawn Settings")]
	private int cardsToSpawn;

	public List<RogueCard> cards;

	[HideInInspector]
	public List<GameObject> slots;

	private bool isCrossing;

	[SerializeField]
	private bool tweenCardReturn = true;

	[HideInInspector]
	public UnityEvent<int, int> SwapEvent;

	[HideInInspector]
	public int cardState;

	private void BeginDrag(RogueCard card)
	{
		if (!RogueCardGameMain.CheckDisableInput())
		{
			selectedCard = card;
		}
	}

	public void Init(int cardState = 0)
	{
		cardsToSpawn = 0;
		if (cards != null)
		{
			for (int num = cards.Count - 1; num >= 0; num--)
			{
				Object.Destroy(cards[num].cardVisual.gameObject);
				Object.Destroy(cards[num].gameObject);
				cards[num] = null;
			}
			cards.Clear();
		}
		if (slots != null)
		{
			for (int num2 = slots.Count - 1; num2 >= 0; num2--)
			{
				Object.Destroy(slots[num2]);
				slots[num2] = null;
			}
			slots.Clear();
		}
		cards = new List<RogueCard>();
		slots = new List<GameObject>();
		rect = GetComponent<RectTransform>();
		this.cardState = cardState;
	}

	public void OnDispose()
	{
		selectedCard = null;
		hoveredCard = null;
		if (cards != null)
		{
			for (int num = cards.Count - 1; num >= 0; num--)
			{
				Object.Destroy(cards[num].cardVisual.gameObject);
				Object.Destroy(cards[num].gameObject);
				cards[num] = null;
			}
			cards.Clear();
		}
		if (slots != null)
		{
			for (int num2 = slots.Count - 1; num2 >= 0; num2--)
			{
				Object.Destroy(slots[num2]);
				slots[num2] = null;
			}
			slots.Clear();
		}
	}

	private void SyncCardOrder()
	{
		if (cards != null && cards.Count > 0)
		{
			cards.Sort((RogueCard a, RogueCard b) => a.ParentIndex().CompareTo(b.ParentIndex()));
		}
	}

	public List<RogueCard> GetSelectedCards()
	{
		int[] selectIndexList = RogueCardGameMain.GameContext.GetSelectIndexList();
		List<RogueCard> list = new List<RogueCard>();
		for (int i = 0; i < selectIndexList.Length; i++)
		{
			list.Add(GetCardByIndex(selectIndexList[i]));
		}
		return list;
	}

	public RogueCard GetCardByIndex(int index)
	{
		for (int i = 0; i < cards.Count; i++)
		{
			if (cards[i].ParentIndex() == index)
			{
				return cards[i];
			}
		}
		return null;
	}

	public virtual void ChangeHandNum(int num, bool isAnimation = false)
	{
		if (cardsToSpawn == num && !isAnimation)
		{
			return;
		}
		if (cardsToSpawn < num)
		{
			for (int i = cardsToSpawn; i < num; i++)
			{
				if (slots.Count > i)
				{
					slots[i].SetActive(value: true);
					cards[i].cardVisual.SetActive(bActive: true);
					continue;
				}
				GameObject gameObject = Object.Instantiate(slotPrefab, base.transform);
				RogueCard componentInChildren = gameObject.GetComponentInChildren<RogueCard>();
				componentInChildren.InstantiateVisual(cardState);
				cards.Add(componentInChildren);
				slots.Add(gameObject);
				slots[i].SetActive(value: true);
				componentInChildren.PointerEnterEvent.AddListener(CardPointerEnter);
				componentInChildren.PointerExitEvent.AddListener(CardPointerExit);
				componentInChildren.BeginDragEvent.AddListener(BeginDrag);
				componentInChildren.EndDragEvent.AddListener(EndDrag);
				componentInChildren.holder = this;
			}
		}
		if (cardsToSpawn > num)
		{
			for (int j = num; j < cardsToSpawn; j++)
			{
				slots[j].SetActive(value: false);
			}
		}
		cardsToSpawn = num;
		if (rect != null)
		{
			LayoutRebuilder.ForceRebuildLayoutImmediate(rect);
		}
		if (isAnimation)
		{
			for (int k = 0; k < RogueCardGameMain.GameContext.globalAttrDic[AttributeType.HandMaxNum] && k < slots.Count; k++)
			{
				slots[k].SetActive(value: true);
			}
			for (int l = cardsToSpawn; l < RogueCardGameMain.GameContext.globalAttrDic[AttributeType.HandMaxNum] && l < cards.Count; l++)
			{
				cards[l].cardVisual.SetActive(bActive: false);
			}
		}
	}

	private void EndDrag(RogueCard card)
	{
		if (!(selectedCard == null))
		{
			if (selectedCard.gameObject.activeInHierarchy)
			{
				LeanTween.moveLocal(selectedCard.gameObject, Vector3.zero, tweenCardReturn ? 0.15f : 0f).setEase(LeanTweenType.easeOutBack);
			}
			else
			{
				selectedCard.transform.localPosition = Vector3.zero;
			}
			rect.sizeDelta += Vector2.right;
			rect.sizeDelta -= Vector2.right;
			selectedCard = null;
		}
	}

	private void CardPointerEnter(RogueCard card)
	{
		hoveredCard = card;
	}

	private void CardPointerExit(RogueCard card)
	{
		hoveredCard = null;
	}

	private void Update()
	{
		if (selectedCard == null || isCrossing)
		{
			return;
		}
		for (int i = 0; i < cards.Count; i++)
		{
			if (cards[i].gameObject.activeInHierarchy && !(cards[i] == selectedCard))
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
	}

	public void Swap(int index)
	{
		isCrossing = true;
		RogueCard rogueCard = cards[index];
		int index2 = selectedCard.ParentIndex();
		Transform parent = selectedCard.transform.parent;
		Transform parent2 = rogueCard.transform.parent;
		rogueCard.transform.SetParent(parent);
		rogueCard.transform.localPosition = Vector3.zero;
		selectedCard.transform.SetParent(parent2);
		SwapEvent.Invoke(selectedCard.ParentIndex(), rogueCard.ParentIndex());
		isCrossing = false;
		if (rogueCard.cardVisual != null)
		{
			rogueCard.cardVisual.SmoothMoveToSlot(slots[index2].transform as RectTransform, 0.05f);
		}
		SyncCardOrder();
		foreach (RogueCard card in cards)
		{
			if (card.cardVisual != null)
			{
				card.cardVisual.UpdateIndex(base.transform.childCount);
			}
		}
	}

	public void ShowCard(HandData<RogueCardData> handData)
	{
		SyncCardOrder();
		int handCount = handData.HandCount;
		ChangeHandNum(handCount);
		for (int i = 0; i < cards.Count; i++)
		{
			RogueCard rogueCard = cards[i];
			int num = rogueCard.ParentIndex() % cards.Count;
			if (num == -1)
			{
				rogueCard.gameObject.SetActive(value: false);
				rogueCard.cardVisual.gameObject.SetActive(value: false);
				continue;
			}
			if (num >= handCount)
			{
				rogueCard.gameObject.SetActive(value: false);
				rogueCard.cardVisual.gameObject.SetActive(value: false);
			}
			else
			{
				rogueCard.gameObject.SetActive(value: true);
				rogueCard.cardVisual.gameObject.SetActive(value: true);
			}
			rogueCard.ShowCardData(handData.GetCardDataAtDisplayIndex(num));
			bool flag = false;
			int[] selectIndexList = handData.GetSelectIndexList();
			for (int j = 0; j < selectIndexList.Length; j++)
			{
				if (selectIndexList[j] == num)
				{
					flag = true;
					break;
				}
			}
			rogueCard.SetSelect(flag);
		}
		for (int k = 0; k < cards.Count; k++)
		{
			if (cards[k].cardVisual != null)
			{
				cards[k].cardVisual.UpdateIndex(base.transform.childCount);
			}
		}
	}

	public void ShowCardWithoutSelect(HandData<RogueCardData> handData)
	{
		SyncCardOrder();
		int handCount = handData.HandCount;
		ChangeHandNum(handCount);
		for (int i = 0; i < cards.Count; i++)
		{
			RogueCard rogueCard = cards[i];
			int num = rogueCard.ParentIndex() % cards.Count;
			if (num == -1)
			{
				rogueCard.gameObject.SetActive(value: false);
				rogueCard.cardVisual.gameObject.SetActive(value: false);
				continue;
			}
			if (num >= handCount)
			{
				rogueCard.gameObject.SetActive(value: false);
				rogueCard.cardVisual.gameObject.SetActive(value: false);
			}
			else
			{
				rogueCard.gameObject.SetActive(value: true);
				rogueCard.cardVisual.gameObject.SetActive(value: true);
			}
			rogueCard.ShowCardData(handData.GetCardDataAtDisplayIndex(num));
			rogueCard.SetSelect(isSelect: false);
		}
		for (int j = 0; j < cards.Count; j++)
		{
			if (cards[j].cardVisual != null)
			{
				cards[j].cardVisual.UpdateIndex(base.transform.childCount);
			}
		}
	}

	public void HideAllCards()
	{
		for (int i = 0; i < cards.Count; i++)
		{
			if (cards[i].cardVisual != null)
			{
				cards[i].cardVisual.gameObject.SetActive(value: false);
			}
		}
	}

	public void ShowPartialCards(HandData<RogueCardData> handData, List<int> revealedIndices)
	{
		SyncCardOrder();
		int handCount = handData.HandCount;
		ChangeHandNum(handCount);
		for (int i = 0; i < cards.Count; i++)
		{
			if (cards[i] != null)
			{
				cards[i].gameObject.SetActive(value: false);
				if (cards[i].cardVisual != null)
				{
					cards[i].cardVisual.gameObject.SetActive(value: false);
				}
			}
		}
		foreach (int revealedIndex in revealedIndices)
		{
			if (revealedIndex < 0 || revealedIndex >= cards.Count || !(cards[revealedIndex] != null))
			{
				continue;
			}
			RogueCard rogueCard = cards[revealedIndex];
			rogueCard.gameObject.SetActive(value: true);
			if (rogueCard.cardVisual != null)
			{
				rogueCard.cardVisual.gameObject.SetActive(value: true);
			}
			rogueCard.ShowCardData(handData.GetCardDataAtDisplayIndex(revealedIndex));
			bool flag = false;
			int[] selectIndexList = handData.GetSelectIndexList();
			for (int j = 0; j < selectIndexList.Length; j++)
			{
				if (selectIndexList[j] == revealedIndex)
				{
					flag = true;
					break;
				}
			}
			rogueCard.SetSelect(flag);
			if (rogueCard.cardVisual != null)
			{
				rogueCard.cardVisual.UpdateIndex(base.transform.childCount);
			}
		}
	}

	public void ShowCardWithAnimation(HandData<RogueCardData> handData, bool animateNewCards = false)
	{
		SyncCardOrder();
		int handCount = handData.HandCount;
		ChangeHandNum(handCount);
		List<int> list = new List<int>();
		if (animateNewCards)
		{
			for (int i = 0; i < cards.Count; i++)
			{
				if (cards[i].gameObject.activeSelf && !cards[i].isHovering && !cards[i].isDragging && cards[i].ParentIndex() >= 0)
				{
					list.Add(cards[i].ParentIndex());
				}
			}
		}
		for (int j = 0; j < cards.Count; j++)
		{
			RogueCard rogueCard = cards[j];
			int num = rogueCard.ParentIndex();
			if (num == -1)
			{
				rogueCard.gameObject.SetActive(value: false);
				rogueCard.cardVisual.gameObject.SetActive(value: false);
				continue;
			}
			if (num >= handCount)
			{
				rogueCard.gameObject.SetActive(value: false);
				rogueCard.cardVisual.gameObject.SetActive(value: false);
				continue;
			}
			rogueCard.gameObject.SetActive(value: true);
			rogueCard.cardVisual.gameObject.SetActive(value: true);
			rogueCard.ShowCardData(handData.GetCardDataAtDisplayIndex(num));
			bool flag = false;
			int[] selectIndexList = handData.GetSelectIndexList();
			for (int k = 0; k < selectIndexList.Length; k++)
			{
				if (selectIndexList[k] == num)
				{
					flag = true;
					break;
				}
			}
			rogueCard.SetSelect(flag);
		}
		for (int l = 0; l < cards.Count; l++)
		{
			if (cards[l].cardVisual != null)
			{
				cards[l].cardVisual.UpdateIndex(base.transform.childCount);
			}
		}
	}

	public void ResetAndRebuild()
	{
		OnDispose();
		Init();
	}
}
