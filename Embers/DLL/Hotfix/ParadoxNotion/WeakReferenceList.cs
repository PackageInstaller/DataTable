using System;
using System.Collections.Generic;

namespace ParadoxNotion;

public class WeakReferenceList<T> where T : class
{
	private List<WeakReference<T>> list;

	public int Count => list.Count;

	public T this[int i]
	{
		get
		{
			list[i].TryGetTarget(out var target);
			return target;
		}
		set
		{
			list[i].SetTarget(value);
		}
	}

	public WeakReferenceList()
	{
		list = new List<WeakReference<T>>();
	}

	public WeakReferenceList(int capacity)
	{
		list = new List<WeakReference<T>>(capacity);
	}

	public void Add(T item)
	{
		list.Add(new WeakReference<T>(item));
	}

	public void Remove(T item)
	{
		int count = list.Count;
		while (count-- > 0)
		{
			WeakReference<T> weakReference = list[count];
			if (weakReference.TryGetTarget(out var target) && target == item)
			{
				list.Remove(weakReference);
			}
		}
	}

	public bool Contains(T item, out int index)
	{
		for (int i = 0; i < list.Count; i++)
		{
			if (list[i].TryGetTarget(out var target) && target == item)
			{
				index = i;
				return true;
			}
		}
		index = -1;
		return false;
	}

	public void Clear()
	{
		list.Clear();
	}

	public List<T> ToReferenceList()
	{
		List<T> list = new List<T>();
		for (int i = 0; i < this.list.Count; i++)
		{
			if (this.list[i].TryGetTarget(out var target))
			{
				list.Add(target);
			}
		}
		return list;
	}

	public static implicit operator WeakReferenceList<T>(List<T> value)
	{
		WeakReferenceList<T> weakReferenceList = new WeakReferenceList<T>(value.Count);
		for (int i = 0; i < value.Count; i++)
		{
			weakReferenceList.Add(value[i]);
		}
		return weakReferenceList;
	}
}
