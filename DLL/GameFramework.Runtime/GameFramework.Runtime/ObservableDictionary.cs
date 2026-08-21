using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.ComponentModel;
using System.Linq;

namespace GameFramework.Runtime;

[Serializable]
public class ObservableDictionary<TKey, TValue> : IDictionary<TKey, TValue>, ICollection<KeyValuePair<TKey, TValue>>, IEnumerable<KeyValuePair<TKey, TValue>>, IEnumerable, IDictionary, ICollection, INotifyCollectionChanged, INotifyPropertyChanged
{
	private static readonly PropertyChangedEventArgs CountEventArgs = new PropertyChangedEventArgs("Count");

	private static readonly PropertyChangedEventArgs IndexerEventArgs = new PropertyChangedEventArgs("Item[]");

	private static readonly PropertyChangedEventArgs KeysEventArgs = new PropertyChangedEventArgs("Keys");

	private static readonly PropertyChangedEventArgs ValuesEventArgs = new PropertyChangedEventArgs("Values");

	private readonly object propertyChangedLock = new object();

	private readonly object collectionChangedLock = new object();

	private PropertyChangedEventHandler propertyChanged;

	private NotifyCollectionChangedEventHandler collectionChanged;

	protected Dictionary<TKey, TValue> dictionary;

	public TValue this[TKey key]
	{
		get
		{
			if (!dictionary.ContainsKey(key))
			{
				return default(TValue);
			}
			return dictionary[key];
		}
		set
		{
			Insert(key, value, add: false);
		}
	}

	public ICollection<TKey> Keys => dictionary.Keys;

	public ICollection<TValue> Values => dictionary.Values;

	public int Count => dictionary.Count;

	public bool IsReadOnly => ((IDictionary)dictionary).IsReadOnly;

	object IDictionary.this[object key]
	{
		get
		{
			return ((IDictionary)dictionary)[key];
		}
		set
		{
			Insert((TKey)key, (TValue)value, add: false);
		}
	}

	ICollection IDictionary.Keys => ((IDictionary)dictionary).Keys;

	ICollection IDictionary.Values => ((IDictionary)dictionary).Values;

	bool IDictionary.IsFixedSize => ((IDictionary)dictionary).IsFixedSize;

	object ICollection.SyncRoot => ((ICollection)dictionary).SyncRoot;

	bool ICollection.IsSynchronized => ((ICollection)dictionary).IsSynchronized;

	public event PropertyChangedEventHandler PropertyChanged
	{
		add
		{
			lock (propertyChangedLock)
			{
				propertyChanged = (PropertyChangedEventHandler)Delegate.Combine(propertyChanged, value);
			}
		}
		remove
		{
			lock (propertyChangedLock)
			{
				propertyChanged = (PropertyChangedEventHandler)Delegate.Remove(propertyChanged, value);
			}
		}
	}

	public event NotifyCollectionChangedEventHandler CollectionChanged
	{
		add
		{
			lock (collectionChangedLock)
			{
				collectionChanged = (NotifyCollectionChangedEventHandler)Delegate.Combine(collectionChanged, value);
			}
		}
		remove
		{
			lock (collectionChangedLock)
			{
				collectionChanged = (NotifyCollectionChangedEventHandler)Delegate.Remove(collectionChanged, value);
			}
		}
	}

	public ObservableDictionary()
	{
		dictionary = new Dictionary<TKey, TValue>();
	}

	public ObservableDictionary(IDictionary<TKey, TValue> dictionary)
	{
		this.dictionary = new Dictionary<TKey, TValue>(dictionary);
	}

	public ObservableDictionary(IEqualityComparer<TKey> comparer)
	{
		dictionary = new Dictionary<TKey, TValue>(comparer);
	}

	public ObservableDictionary(int capacity)
	{
		dictionary = new Dictionary<TKey, TValue>(capacity);
	}

	public ObservableDictionary(IDictionary<TKey, TValue> dictionary, IEqualityComparer<TKey> comparer)
	{
		this.dictionary = new Dictionary<TKey, TValue>(dictionary, comparer);
	}

	public ObservableDictionary(int capacity, IEqualityComparer<TKey> comparer)
	{
		dictionary = new Dictionary<TKey, TValue>(capacity, comparer);
	}

	public void Add(TKey key, TValue value)
	{
		Insert(key, value, add: true);
	}

	public bool Remove(TKey key)
	{
		if (key == null)
		{
			throw new ArgumentNullException("key");
		}
		dictionary.TryGetValue(key, out var value);
		bool flag = dictionary.Remove(key);
		if (flag)
		{
			OnPropertyChanged(NotifyCollectionChangedAction.Remove);
			if (collectionChanged != null)
			{
				OnCollectionChanged(NotifyCollectionChangedAction.Remove, new KeyValuePair<TKey, TValue>(key, value));
			}
		}
		return flag;
	}

	public bool TryGetValue(TKey key, out TValue value)
	{
		return dictionary.TryGetValue(key, out value);
	}

	public bool ContainsKey(TKey key)
	{
		return dictionary.ContainsKey(key);
	}

	public void Add(KeyValuePair<TKey, TValue> item)
	{
		Insert(item.Key, item.Value, add: true);
	}

	public void Clear()
	{
		if (dictionary.Count > 0)
		{
			dictionary.Clear();
			OnPropertyChanged(NotifyCollectionChangedAction.Reset);
			if (collectionChanged != null)
			{
				OnCollectionChanged();
			}
		}
	}

	public bool Contains(KeyValuePair<TKey, TValue> item)
	{
		return dictionary.Contains(item);
	}

	public void CopyTo(KeyValuePair<TKey, TValue>[] array, int arrayIndex)
	{
		((ICollection)dictionary).CopyTo((Array)array, arrayIndex);
	}

	public bool Remove(KeyValuePair<TKey, TValue> item)
	{
		return Remove(item.Key);
	}

	public IEnumerator<KeyValuePair<TKey, TValue>> GetEnumerator()
	{
		return dictionary.GetEnumerator();
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return ((IEnumerable)dictionary).GetEnumerator();
	}

	public void AddRange(IDictionary<TKey, TValue> items)
	{
		if (items == null)
		{
			throw new ArgumentNullException("items");
		}
		if (items.Count <= 0)
		{
			return;
		}
		if (dictionary.Count > 0)
		{
			if (items.Keys.Any((TKey k) => dictionary.ContainsKey(k)))
			{
				throw new ArgumentException("An item with the same key has already been added.");
			}
			foreach (KeyValuePair<TKey, TValue> item in items)
			{
				((ICollection<KeyValuePair<TKey, TValue>>)dictionary).Add(item);
			}
		}
		else
		{
			dictionary = new Dictionary<TKey, TValue>(items);
		}
		OnPropertyChanged(NotifyCollectionChangedAction.Add);
		if (collectionChanged != null)
		{
			OnCollectionChanged(NotifyCollectionChangedAction.Add, items.ToArray());
		}
	}

	private void Insert(TKey key, TValue value, bool add)
	{
		if (key == null)
		{
			throw new ArgumentNullException("key");
		}
		if (dictionary.TryGetValue(key, out var value2))
		{
			if (add)
			{
				throw new ArgumentException("An item with the same key has already been added.");
			}
			if (!object.Equals(value2, value))
			{
				dictionary[key] = value;
				OnPropertyChanged(NotifyCollectionChangedAction.Replace);
				if (collectionChanged != null)
				{
					OnCollectionChanged(NotifyCollectionChangedAction.Replace, new KeyValuePair<TKey, TValue>(key, value), new KeyValuePair<TKey, TValue>(key, value2));
				}
			}
		}
		else
		{
			dictionary[key] = value;
			OnPropertyChanged(NotifyCollectionChangedAction.Add);
			if (collectionChanged != null)
			{
				OnCollectionChanged(NotifyCollectionChangedAction.Add, new KeyValuePair<TKey, TValue>(key, value));
			}
		}
	}

	private void OnPropertyChanged(NotifyCollectionChangedAction action)
	{
		switch (action)
		{
		case NotifyCollectionChangedAction.Add:
		case NotifyCollectionChangedAction.Remove:
		case NotifyCollectionChangedAction.Reset:
			OnPropertyChanged(CountEventArgs);
			OnPropertyChanged(IndexerEventArgs);
			OnPropertyChanged(KeysEventArgs);
			OnPropertyChanged(ValuesEventArgs);
			break;
		case NotifyCollectionChangedAction.Replace:
			OnPropertyChanged(IndexerEventArgs);
			OnPropertyChanged(ValuesEventArgs);
			break;
		default:
			OnPropertyChanged(CountEventArgs);
			OnPropertyChanged(IndexerEventArgs);
			OnPropertyChanged(KeysEventArgs);
			OnPropertyChanged(ValuesEventArgs);
			break;
		}
	}

	protected virtual void OnPropertyChanged(PropertyChangedEventArgs eventArgs)
	{
		if (propertyChanged != null)
		{
			propertyChanged(this, eventArgs);
		}
	}

	private void OnCollectionChanged()
	{
		if (collectionChanged != null)
		{
			collectionChanged(this, new NotifyCollectionChangedEventArgs(NotifyCollectionChangedAction.Reset));
		}
	}

	private void OnCollectionChanged(NotifyCollectionChangedAction action, KeyValuePair<TKey, TValue> changedItem)
	{
		if (collectionChanged != null)
		{
			collectionChanged(this, new NotifyCollectionChangedEventArgs(action, changedItem));
		}
	}

	private void OnCollectionChanged(NotifyCollectionChangedAction action, KeyValuePair<TKey, TValue> newItem, KeyValuePair<TKey, TValue> oldItem)
	{
		if (collectionChanged != null)
		{
			collectionChanged(this, new NotifyCollectionChangedEventArgs(action, newItem, oldItem));
		}
	}

	private void OnCollectionChanged(NotifyCollectionChangedAction action, IList newItems)
	{
		if (collectionChanged != null)
		{
			collectionChanged(this, new NotifyCollectionChangedEventArgs(action, newItems));
		}
	}

	bool IDictionary.Contains(object key)
	{
		return ((IDictionary)dictionary).Contains(key);
	}

	void IDictionary.Add(object key, object value)
	{
		Add((TKey)key, (TValue)value);
	}

	IDictionaryEnumerator IDictionary.GetEnumerator()
	{
		return ((IDictionary)dictionary).GetEnumerator();
	}

	void IDictionary.Remove(object key)
	{
		Remove((TKey)key);
	}

	void ICollection.CopyTo(Array array, int index)
	{
		((ICollection)dictionary).CopyTo(array, index);
	}
}
