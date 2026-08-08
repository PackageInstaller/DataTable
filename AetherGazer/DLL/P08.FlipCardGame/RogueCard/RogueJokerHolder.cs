using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

namespace RogueCard;

public class RogueJokerHolder : MonoBehaviour
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

	[HideInInspector]
	public List<RogueCard> cards;

	[HideInInspector]
	public List<GameObject> slots;

	private bool isCrossing;

	[SerializeField]
	private bool tweenCardReturn = true;

	[HideInInspector]
	public UnityEvent<int, int> SwapEvent;

	private bool isDrag;

	private void BeginDrag(RogueCard card)
	{
		selectedCard = card;
		isDrag = true;
	}

	public RogueCard GetCard(int index)
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

	public void Init()
	{
		cardsToSpawn = 0;
		rect = GetComponent<RectTransform>();
		cards = new List<RogueCard>();
		slots = new List<GameObject>();
	}

	public void OnDispose()
	{
		selectedCard = null;
		hoveredCard = null;
		if (cards != null)
		{
			for (int num = cards.Count - 1; num >= 0; num--)
			{
				if (cards[num] != null && cards[num].cardVisual != null)
				{
					Object.Destroy(cards[num].cardVisual.gameObject);
				}
				cards[num] = null;
			}
			cards.Clear();
		}
		if (slots != null)
		{
			for (int num2 = slots.Count - 1; num2 >= 0; num2--)
			{
				if (slots[num2] != null)
				{
					slots[num2].transform.SetParent(null, worldPositionStays: false);
					Object.Destroy(slots[num2]);
				}
				slots[num2] = null;
			}
			slots.Clear();
		}
		if (base.transform != null)
		{
			for (int num3 = base.transform.childCount - 1; num3 >= 0; num3--)
			{
				Transform child = base.transform.GetChild(num3);
				if (child != null)
				{
					child.SetParent(null, worldPositionStays: false);
					Object.Destroy(child.gameObject);
				}
			}
		}
		cardsToSpawn = 0;
	}

	public void ChangeJokerNum(int num)
	{
		if (cardsToSpawn == num)
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
					if (i < cards.Count)
					{
						cards[i].wasDragged = false;
					}
					continue;
				}
				GameObject gameObject = Object.Instantiate(slotPrefab, base.transform);
				RogueCard componentInChildren = gameObject.GetComponentInChildren<RogueCard>();
				componentInChildren.InstantiateVisual(3);
				cards.Add(componentInChildren);
				slots.Add(gameObject);
				slots[i].SetActive(value: true);
				componentInChildren.PointerEnterEvent.AddListener(CardPointerEnter);
				componentInChildren.PointerExitEvent.AddListener(CardPointerExit);
				componentInChildren.BeginDragEvent.AddListener(BeginDrag);
				componentInChildren.EndDragEvent.AddListener(EndDrag);
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
	}

	private void EndDrag(RogueCard card)
	{
		isDrag = false;
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
			RogueCardGameMain.Instance.RefreshJoker();
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
			if (cards[i].gameObject.activeSelf)
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
		Transform parent = selectedCard.transform.parent;
		Transform parent2 = cards[index].transform.parent;
		cards[index].transform.SetParent(parent);
		cards[index].transform.localPosition = Vector3.zero;
		selectedCard.transform.SetParent(parent2);
		Debug.Log($"RogueCard:SwapView{cards[index].ParentIndex()} and {selectedCard.ParentIndex()}");
		SwapEvent.Invoke(selectedCard.ParentIndex(), cards[index].ParentIndex());
		isCrossing = false;
		if (cards[index].cardVisual == null)
		{
			return;
		}
		foreach (RogueCard card in cards)
		{
			card.cardVisual.UpdateIndex(base.transform.childCount);
		}
	}

	public void ShowCard(RogueCardGameContext context)
	{
		if (isDrag)
		{
			return;
		}
		int handCount = context.jokerData.HandCount;
		ChangeJokerNum(handCount);
		for (int i = 0; i < cards.Count; i++)
		{
			RogueCard rogueCard = cards[i];
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
			}
			else
			{
				rogueCard.gameObject.SetActive(value: true);
				bool flag = false;
				if (!rogueCard.cardVisual.gameObject.activeSelf)
				{
					flag = true;
				}
				rogueCard.cardVisual.gameObject.SetActive(value: true);
				if (flag)
				{
					(rogueCard.cardVisual as VisualJokerCard).PlayAnimation("UI_Com_JokerCarditem_cx");
				}
			}
			rogueCard.ShowJokerData(context.jokerData.GetCardDataAtDisplayIndex(num));
			rogueCard.SetSelect(isSelect: false);
		}
		StartCoroutine(Frame());
		IEnumerator Frame()
		{
			yield return null;
			for (int j = 0; j < cards.Count; j++)
			{
				if (cards[j].cardVisual != null)
				{
					cards[j].cardVisual.UpdateIndex(base.transform.childCount);
				}
			}
		}
	}

	public void ResetAndRebuild()
	{
		OnDispose();
		Init();
	}
}
