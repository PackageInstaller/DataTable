using System.Collections.Generic;
using System.Diagnostics;

namespace System.Collections.ObjectModel;

[Serializable]
[DebuggerTypeProxy(typeof(CollectionDebugView<>))]
[DebuggerDisplay("Count = {Count}")]
public abstract class KeyedCollection<TKey, TItem> : Collection<TItem>
{
	private readonly IEqualityComparer<TKey> comparer;

	private Dictionary<TKey, TItem> dict;

	private int keyCount;

	private readonly int threshold;

	private new List<TItem> Items => (List<TItem>)base.Items;

	public TItem this[TKey key]
	{
		get
		{
			if (TryGetValue(key, out var item))
			{
				return item;
			}
			throw new KeyNotFoundException(SR.Format("The given key '{0}' was not present in the dictionary.", key.ToString()));
		}
	}

	protected IDictionary<TKey, TItem> Dictionary => dict;

	protected KeyedCollection()
		: this((IEqualityComparer<TKey>)null, 0)
	{
	}

	protected KeyedCollection(IEqualityComparer<TKey> comparer)
		: this(comparer, 0)
	{
	}

	protected KeyedCollection(IEqualityComparer<TKey> comparer, int dictionaryCreationThreshold)
		: base((IList<TItem>)new List<TItem>())
	{
		if (comparer == null)
		{
			comparer = EqualityComparer<TKey>.Default;
		}
		if (dictionaryCreationThreshold == -1)
		{
			dictionaryCreationThreshold = int.MaxValue;
		}
		if (dictionaryCreationThreshold < -1)
		{
			throw new ArgumentOutOfRangeException("dictionaryCreationThreshold", "The specified threshold for creating dictionary is out of range.");
		}
		this.comparer = comparer;
		threshold = dictionaryCreationThreshold;
	}

	public bool Contains(TKey key)
	{
		if (key == null)
		{
			throw new ArgumentNullException("key");
		}
		if (dict != null)
		{
			return dict.ContainsKey(key);
		}
		foreach (TItem item in Items)
		{
			if (comparer.Equals(GetKeyForItem(item), key))
			{
				return true;
			}
		}
		return false;
	}

	public bool TryGetValue(TKey key, out TItem item)
	{
		if (key == null)
		{
			throw new ArgumentNullException("key");
		}
		if (dict != null)
		{
			return dict.TryGetValue(key, out item);
		}
		foreach (TItem item2 in Items)
		{
			TKey keyForItem = GetKeyForItem(item2);
			if (keyForItem != null && comparer.Equals(key, keyForItem))
			{
				item = item2;
				return true;
			}
		}
		item = default(TItem);
		return false;
	}

	protected override void ClearItems()
	{
		base.ClearItems();
		if (dict != null)
		{
			dict.Clear();
		}
		keyCount = 0;
	}

	protected abstract TKey GetKeyForItem(TItem item);

	protected override void InsertItem(int index, TItem item)
	{
		TKey keyForItem = GetKeyForItem(item);
		if (keyForItem != null)
		{
			AddKey(keyForItem, item);
		}
		base.InsertItem(index, item);
	}

	protected override void RemoveItem(int index)
	{
		TKey keyForItem = GetKeyForItem(Items[index]);
		if (keyForItem != null)
		{
			RemoveKey(keyForItem);
		}
		base.RemoveItem(index);
	}

	protected override void SetItem(int index, TItem item)
	{
		TKey keyForItem = GetKeyForItem(item);
		TKey keyForItem2 = GetKeyForItem(Items[index]);
		if (comparer.Equals(keyForItem2, keyForItem))
		{
			if (keyForItem != null && dict != null)
			{
				dict[keyForItem] = item;
			}
		}
		else
		{
			if (keyForItem != null)
			{
				AddKey(keyForItem, item);
			}
			if (keyForItem2 != null)
			{
				RemoveKey(keyForItem2);
			}
		}
		base.SetItem(index, item);
	}

	private void AddKey(TKey key, TItem item)
	{
		if (dict != null)
		{
			dict.Add(key, item);
			return;
		}
		if (keyCount == threshold)
		{
			CreateDictionary();
			dict.Add(key, item);
			return;
		}
		if (Contains(key))
		{
			throw new ArgumentException(SR.Format("An item with the same key has already been added. Key: {0}", key));
		}
		keyCount++;
	}

	private void CreateDictionary()
	{
		dict = new Dictionary<TKey, TItem>(comparer);
		foreach (TItem item in Items)
		{
			TKey keyForItem = GetKeyForItem(item);
			if (keyForItem != null)
			{
				dict.Add(keyForItem, item);
			}
		}
	}

	private void RemoveKey(TKey key)
	{
		if (dict != null)
		{
			dict.Remove(key);
		}
		else
		{
			keyCount--;
		}
	}
}
