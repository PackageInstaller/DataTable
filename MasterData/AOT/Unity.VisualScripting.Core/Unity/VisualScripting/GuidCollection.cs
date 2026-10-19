using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.ObjectModel;

namespace Unity.VisualScripting;

public class GuidCollection<T> : KeyedCollection<Guid, T>, IKeyedCollection<Guid, T>, ICollection<T>, IEnumerable<T>, IEnumerable where T : IIdentifiable
{
	protected override Guid GetKeyForItem(T item)
	{
		return item.guid;
	}

	protected override void InsertItem(int index, T item)
	{
		Ensure.That("item").IsNotNull(item);
		base.InsertItem(index, item);
	}

	protected override void SetItem(int index, T item)
	{
		Ensure.That("item").IsNotNull(item);
		base.SetItem(index, item);
	}

	public new bool TryGetValue(Guid key, out T value)
	{
		if (Dictionary == null)
		{
			value = default;
			return false;
		}
		return Dictionary.TryGetValue(key, out value);
	}

	T IKeyedCollection<Guid, T>.get_Item(Guid key)
	{
		return base[key];
	}

	bool IKeyedCollection<Guid, T>.Contains(Guid key)
	{
		return Contains(key);
	}

	bool IKeyedCollection<Guid, T>.Remove(Guid key)
	{
		return Remove(key);
	}
}
