using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;

namespace Unity.VisualScripting;

public abstract class NonNullableCollection<T> : Collection<T>
{
	protected override void InsertItem(int index, T item)
	{
		if (item == null)
		{
			throw new ArgumentNullException("item");
		}
		base.InsertItem(index, item);
	}

	protected override void SetItem(int index, T item)
	{
		if (item == null)
		{
			throw new ArgumentNullException("item");
		}
		base.SetItem(index, item);
	}

	public void AddRange(IEnumerable<T> collection)
	{
		foreach (T item in collection)
		{
			Add(item);
		}
	}
}
