using System;
using System.Collections;
using System.Collections.Generic;

namespace Unity.VisualScripting;

public class MergedKeyedCollection<TKey, TItem> : IMergedCollection<TItem>, ICollection<TItem>, IEnumerable<TItem>, IEnumerable
{
	public struct Enumerator : IEnumerator<TItem>, IEnumerator, IDisposable
	{
		private Dictionary<Type, IKeyedCollection<TKey, TItem>>.Enumerator collectionsEnumerator;

		private TItem currentItem;

		private IKeyedCollection<TKey, TItem> currentCollection;

		private int indexInCurrentCollection;

		private bool exceeded;

		public TItem Current => currentItem;

		object IEnumerator.Current
		{
			get
			{
				if (exceeded)
				{
					throw new InvalidOperationException();
				}
				return Current;
			}
		}

		public Enumerator(MergedKeyedCollection<TKey, TItem> merged)
		{
			this = default;
			collectionsEnumerator = merged.collections.GetEnumerator();
		}

		public void Dispose()
		{
		}

		public bool MoveNext()
		{
			if (currentCollection == null)
			{
				if (!collectionsEnumerator.MoveNext())
				{
					currentItem = default;
					exceeded = true;
					return false;
				}
				currentCollection = collectionsEnumerator.Current.Value;
				if (currentCollection == null)
				{
					throw new InvalidOperationException("Merged sub collection is null.");
				}
			}
			if (indexInCurrentCollection < currentCollection.Count)
			{
				currentItem = currentCollection[indexInCurrentCollection];
				indexInCurrentCollection++;
				return true;
			}
			while (collectionsEnumerator.MoveNext())
			{
				currentCollection = collectionsEnumerator.Current.Value;
				indexInCurrentCollection = 0;
				if (currentCollection == null)
				{
					throw new InvalidOperationException("Merged sub collection is null.");
				}
				if (indexInCurrentCollection < currentCollection.Count)
				{
					currentItem = currentCollection[indexInCurrentCollection];
					indexInCurrentCollection++;
					return true;
				}
			}
			currentItem = default;
			exceeded = true;
			return false;
		}

		void IEnumerator.Reset()
		{
			throw new InvalidOperationException();
		}
	}

	protected readonly Dictionary<Type, IKeyedCollection<TKey, TItem>> collections;

	protected readonly Dictionary<Type, IKeyedCollection<TKey, TItem>> collectionsLookup;

	public TItem this[TKey key]
	{
		get
		{
			if (key == null)
			{
				throw new ArgumentNullException("key");
			}
			foreach (KeyValuePair<Type, IKeyedCollection<TKey, TItem>> collection in collections)
			{
				if (collection.Value.Contains(key))
				{
					return collection.Value[key];
				}
			}
			throw new KeyNotFoundException();
		}
	}

	public int Count
	{
		get
		{
			int num = 0;
			foreach (KeyValuePair<Type, IKeyedCollection<TKey, TItem>> collection in collections)
			{
				num += collection.Value.Count;
			}
			return num;
		}
	}

	public bool IsReadOnly => false;

	public MergedKeyedCollection()
	{
		collections = new Dictionary<Type, IKeyedCollection<TKey, TItem>>();
		collectionsLookup = new Dictionary<Type, IKeyedCollection<TKey, TItem>>();
	}

	public bool Includes<TSubItem>() where TSubItem : TItem
	{
		return Includes(typeof(TSubItem));
	}

	public bool Includes(Type elementType)
	{
		return GetCollectionForType(elementType, throwOnFail: false) != null;
	}

	public IKeyedCollection<TKey, TSubItem> ForType<TSubItem>() where TSubItem : TItem
	{
		return ((VariantKeyedCollection<TItem, TSubItem, TKey>)GetCollectionForType(typeof(TSubItem))).implementation;
	}

	public virtual void Include<TSubItem>(IKeyedCollection<TKey, TSubItem> collection) where TSubItem : TItem
	{
		Type typeFromHandle = typeof(TSubItem);
		VariantKeyedCollection<TItem, TSubItem, TKey> value = new VariantKeyedCollection<TItem, TSubItem, TKey>(collection);
		collections.Add(typeFromHandle, value);
		collectionsLookup.Add(typeFromHandle, value);
	}

	protected IKeyedCollection<TKey, TItem> GetCollectionForItem(TItem item)
	{
		Ensure.That("item").IsNotNull(item);
		return GetCollectionForType(item.GetType());
	}

	protected IKeyedCollection<TKey, TItem> GetCollectionForType(Type type, bool throwOnFail = true)
	{
		Ensure.That("type").IsNotNull(type);
		if (collectionsLookup.TryGetValue(type, out var value))
		{
			return value;
		}
		foreach (KeyValuePair<Type, IKeyedCollection<TKey, TItem>> collection in collections)
		{
			if (collection.Key.IsAssignableFrom(type))
			{
				value = collection.Value;
				collectionsLookup.Add(type, value);
				return value;
			}
		}
		if (throwOnFail)
		{
			throw new InvalidOperationException($"No sub-collection available for type '{type}'.");
		}
		return null;
	}

	protected IKeyedCollection<TKey, TItem> GetCollectionForKey(TKey key, bool throwOnFail = true)
	{
		foreach (KeyValuePair<Type, IKeyedCollection<TKey, TItem>> collection in collections)
		{
			if (collection.Value.Contains(key))
			{
				return collection.Value;
			}
		}
		if (throwOnFail)
		{
			throw new InvalidOperationException($"No sub-collection available for key '{key}'.");
		}
		return null;
	}

	public bool TryGetValue(TKey key, out TItem value)
	{
		IKeyedCollection<TKey, TItem> collectionForKey = GetCollectionForKey(key, throwOnFail: false);
		value = default;
		return collectionForKey?.TryGetValue(key, out value) ?? false;
	}

	public virtual void Add(TItem item)
	{
		GetCollectionForItem(item).Add(item);
	}

	public void Clear()
	{
		foreach (IKeyedCollection<TKey, TItem> value in collections.Values)
		{
			value.Clear();
		}
	}

	public bool Contains(TItem item)
	{
		return GetCollectionForItem(item).Contains(item);
	}

	public bool Remove(TItem item)
	{
		return GetCollectionForItem(item).Remove(item);
	}

	public void CopyTo(TItem[] array, int arrayIndex)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (arrayIndex < 0)
		{
			throw new ArgumentOutOfRangeException("arrayIndex");
		}
		if (array.Length - arrayIndex < Count)
		{
			throw new ArgumentException();
		}
		int num = 0;
		foreach (IKeyedCollection<TKey, TItem> value in collections.Values)
		{
			value.CopyTo(array, arrayIndex + num);
			num += value.Count;
		}
	}

	public bool Contains(TKey key)
	{
		return GetCollectionForKey(key, throwOnFail: false) != null;
	}

	public bool Remove(TKey key)
	{
		return GetCollectionForKey(key).Remove(key);
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}

	IEnumerator<TItem> IEnumerable<TItem>.GetEnumerator()
	{
		return GetEnumerator();
	}

	public Enumerator GetEnumerator()
	{
		return new Enumerator(this);
	}
}
