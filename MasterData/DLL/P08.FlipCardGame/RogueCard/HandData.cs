using System;
using System.Collections.Generic;
using System.Linq;

namespace RogueCard;

public class HandData<T> where T : class, IComparable<T>
{
	private int sortState;

	public List<T> handCards = new List<T>();

	public List<int> cardOrder = new List<int>();

	public LinkedList<int> selectedCardIndex = new LinkedList<int>();

	private T forceSelect_;

	public T forceSelect
	{
		get
		{
			return forceSelect_;
		}
		set
		{
			forceSelect_ = value;
		}
	}

	public int HandCount => handCards.Count;

	public void SelectCard(int index)
	{
		int num = 0;
		if (forceSelect != null)
		{
			for (int i = 0; i < cardOrder.Count; i++)
			{
				int index2 = cardOrder[i];
				if (handCards[index2] == forceSelect && index == i)
				{
					LuaHelper.CallFunction("ShowTips", "ROGUE_CARD_FORCED_SELECTION");
					return;
				}
			}
			num = 1;
		}
		if (selectedCardIndex.Contains(index))
		{
			selectedCardIndex.Remove(index);
		}
		else if (selectedCardIndex.Count >= RogueCardGameMain.GameContext.globalAttrDic[AttributeType.PlayMaxNum] - num)
		{
			LuaHelper.CallFunction("ShowTips", "ROGUE_CARD_MAX_NUM");
		}
		else
		{
			selectedCardIndex.AddLast(index);
		}
	}

	public void DeSelect()
	{
		selectedCardIndex.Clear();
	}

	public int[] GetSelectIndexList()
	{
		if (forceSelect != null)
		{
			for (int i = 0; i < cardOrder.Count; i++)
			{
				int index = cardOrder[i];
				if (handCards[index] == forceSelect)
				{
					return new int[1] { i }.Concat(selectedCardIndex.ToArray()).ToArray();
				}
			}
		}
		return selectedCardIndex.ToArray();
	}

	public int[] GetUnselectIndexList()
	{
		int[] array = new int[HandCount - selectedCardIndex.Count - ((forceSelect != null) ? 1 : 0)];
		int num = 0;
		for (int i = 0; i < cardOrder.Count; i++)
		{
			int index = cardOrder[i];
			if (!selectedCardIndex.Contains(i) && handCards[index] != forceSelect)
			{
				array[num] = i;
				num++;
			}
		}
		Array.Sort(array);
		return array;
	}

	public void AddCardToHand(T cardData)
	{
		handCards.Add(cardData);
		cardOrder.Add(handCards.Count - 1);
	}

	public void SwapCardPositions(int displayIndex1, int displayIndex2)
	{
		if (displayIndex1 >= 0 && displayIndex2 >= 0 && displayIndex1 < cardOrder.Count && displayIndex2 < cardOrder.Count)
		{
			int value = cardOrder[displayIndex1];
			cardOrder[displayIndex1] = cardOrder[displayIndex2];
			cardOrder[displayIndex2] = value;
			LinkedListNode<int> linkedListNode = null;
			LinkedListNode<int> linkedListNode2 = null;
			if (selectedCardIndex.Contains(displayIndex1))
			{
				linkedListNode = selectedCardIndex.Find(displayIndex1);
			}
			if (selectedCardIndex.Contains(displayIndex2))
			{
				linkedListNode2 = selectedCardIndex.Find(displayIndex2);
			}
			if (linkedListNode != null && linkedListNode2 != null)
			{
				selectedCardIndex.AddAfter(linkedListNode, displayIndex2);
				selectedCardIndex.AddAfter(linkedListNode2, displayIndex1);
				selectedCardIndex.Remove(linkedListNode);
				selectedCardIndex.Remove(linkedListNode2);
			}
			else if (linkedListNode != null)
			{
				selectedCardIndex.AddAfter(linkedListNode, displayIndex2);
				selectedCardIndex.Remove(linkedListNode);
			}
			else if (linkedListNode2 != null)
			{
				selectedCardIndex.AddAfter(linkedListNode2, displayIndex1);
				selectedCardIndex.Remove(linkedListNode2);
			}
		}
	}

	public List<T> PlaySelectedCard(List<T> cardList)
	{
		List<T> list = new List<T>();
		for (int num = cardList.Count - 1; num >= 0; num--)
		{
			list.Add(RemoveCard(cardList[num]));
		}
		return list;
	}

	public T RemoveCard(T data)
	{
		if (handCards.Contains(data))
		{
			int num = handCards.IndexOf(data);
			int num2 = cardOrder.IndexOf(num);
			if (forceSelect == data)
			{
				forceSelect = null;
			}
			if (selectedCardIndex.Contains(num2))
			{
				selectedCardIndex.Remove(num2);
			}
			for (LinkedListNode<int> linkedListNode = selectedCardIndex.First; linkedListNode != null; linkedListNode = linkedListNode.Next)
			{
				if (linkedListNode.Value > num2)
				{
					linkedListNode.Value--;
				}
			}
			handCards.RemoveAt(num);
			cardOrder.RemoveAt(num2);
			for (int i = 0; i < cardOrder.Count; i++)
			{
				if (cardOrder[i] >= num)
				{
					cardOrder[i]--;
				}
			}
			return data;
		}
		return null;
	}

	public void ClearCard()
	{
		handCards.Clear();
		cardOrder.Clear();
	}

	public T GetCardDataAtDisplayIndex(int displayIndex)
	{
		if (displayIndex < 0 || displayIndex >= cardOrder.Count)
		{
			return null;
		}
		int index = cardOrder[displayIndex];
		return handCards[index];
	}

	public int GetDataIndex(T data)
	{
		int num = handCards.IndexOf(data);
		for (int i = 0; i < cardOrder.Count; i++)
		{
			if (cardOrder[i] == num)
			{
				return i;
			}
		}
		return 0;
	}

	public List<T> GetOrderedHandData()
	{
		List<T> list = new List<T>();
		foreach (int item in cardOrder)
		{
			list.Add(handCards[item]);
		}
		return list;
	}

	public void SortCard()
	{
		bool flag = false;
		for (int i = 0; i < cardOrder.Count; i++)
		{
			for (int j = 0; j < cardOrder.Count - i - 1; j++)
			{
				if (handCards[cardOrder[j]].CompareTo(handCards[cardOrder[j + 1]]) > 0)
				{
					SwapCardPositions(j, j + 1);
					flag = true;
				}
			}
			if (!flag)
			{
				break;
			}
		}
	}
}
