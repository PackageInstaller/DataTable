using System.Collections.Generic;

namespace PathFinding2D.Runtime.Models;

public class PriorityQueue<T> where T : class
{
	private readonly List<PriorityItem<T>> items = new List<PriorityItem<T>>();

	private readonly Dictionary<T, int> itemIndices = new Dictionary<T, int>();

	public int Count => items.Count;

	public void Clear()
	{
		items.Clear();
		itemIndices.Clear();
	}

	public void Enqueue(T item, float priority)
	{
		items.Add(new PriorityItem<T>(item, priority));
		itemIndices[item] = items.Count - 1;
		HeapifyUp(items.Count - 1);
	}

	public T Dequeue()
	{
		if (items.Count == 0)
		{
			return null;
		}
		T item = items[0].Item;
		itemIndices.Remove(item);
		if (items.Count > 1)
		{
			List<PriorityItem<T>> list = items;
			List<PriorityItem<T>> list2 = items;
			list[0] = list2[list2.Count - 1];
			itemIndices[items[0].Item] = 0;
			items.RemoveAt(items.Count - 1);
			HeapifyDown(0);
		}
		else
		{
			items.Clear();
		}
		return item;
	}

	public bool Contains(T item)
	{
		return itemIndices.ContainsKey(item);
	}

	public void UpdatePriority(T item, float newPriority)
	{
		if (itemIndices.TryGetValue(item, out var value))
		{
			float priority = items[value].Priority;
			items[value].Priority = newPriority;
			if (newPriority < priority)
			{
				HeapifyUp(value);
			}
			else
			{
				HeapifyDown(value);
			}
		}
	}

	private void HeapifyUp(int index)
	{
		while (index > 0)
		{
			int num = (index - 1) / 2;
			if (!(items[num].Priority <= items[index].Priority))
			{
				Swap(index, num);
				index = num;
				continue;
			}
			break;
		}
	}

	private void HeapifyDown(int index)
	{
		while (true)
		{
			int num = 2 * index + 1;
			int num2 = 2 * index + 2;
			int num3 = index;
			if (num < items.Count && items[num].Priority < items[num3].Priority)
			{
				num3 = num;
			}
			if (num2 < items.Count && items[num2].Priority < items[num3].Priority)
			{
				num3 = num2;
			}
			if (num3 != index)
			{
				Swap(index, num3);
				index = num3;
				continue;
			}
			break;
		}
	}

	private void Swap(int index1, int index2)
	{
		List<PriorityItem<T>> list = items;
		List<PriorityItem<T>> list2 = items;
		PriorityItem<T> priorityItem = items[index2];
		PriorityItem<T> priorityItem2 = items[index1];
		PriorityItem<T> priorityItem3 = (list[index1] = priorityItem);
		priorityItem3 = (list2[index2] = priorityItem2);
		itemIndices[items[index1].Item] = index1;
		itemIndices[items[index2].Item] = index2;
	}
}
