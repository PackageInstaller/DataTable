using System.Collections.Generic;
using System.Diagnostics;
using System.Threading;
using Unity;

namespace System.Collections.ObjectModel;

[Serializable]
[DebuggerDisplay("Count = {Count}")]
[DebuggerTypeProxy(typeof(DictionaryDebugView<, >))]
public class ReadOnlyDictionary<TKey, TValue> : IDictionary<TKey, TValue>, ICollection<KeyValuePair<TKey, TValue>>, IEnumerable<KeyValuePair<TKey, TValue>>, IEnumerable, IDictionary, ICollection, IReadOnlyDictionary<TKey, TValue>, IReadOnlyCollection<KeyValuePair<TKey, TValue>>
{
	[Serializable]
	private struct DictionaryEnumerator(IDictionary<TKey, TValue> dictionary) : IDictionaryEnumerator, IEnumerator
	{
		private readonly IDictionary<TKey, TValue> _dictionary = dictionary;

		private IEnumerator<KeyValuePair<TKey, TValue>> _enumerator = _dictionary.GetEnumerator();

		public DictionaryEntry Entry => new DictionaryEntry(_enumerator.Current.Key, _enumerator.Current.Value);

		public object Key => _enumerator.Current.Key;

		public object Value => _enumerator.Current.Value;

		public object Current => Entry;

		public bool MoveNext()
		{
			return _enumerator.MoveNext();
		}

		public void Reset()
		{
			_enumerator.Reset();
		}
	}

	[Serializable]
	[DebuggerDisplay("Count = {Count}")]
	[DebuggerTypeProxy(typeof(CollectionDebugView<>))]
	public sealed class KeyCollection : ICollection<TKey>, IEnumerable<TKey>, IEnumerable, ICollection, IReadOnlyCollection<TKey>
	{
		private readonly ICollection<TKey> _collection;

		[NonSerialized]
		private object _syncRoot;

		public int Count => _collection.Count;

		bool ICollection<TKey>.IsReadOnly => true;

		bool ICollection.IsSynchronized => false;

		object ICollection.SyncRoot
		{
			get
			{
				if (_syncRoot == null)
				{
					if (_collection is ICollection collection)
					{
						_syncRoot = collection.SyncRoot;
					}
					else
					{
						Interlocked.CompareExchange<object>(ref _syncRoot, new object(), (object)null);
					}
				}
				return _syncRoot;
			}
		}

		internal KeyCollection(ICollection<TKey> collection)
		{
			if (collection == null)
			{
				throw new ArgumentNullException("collection");
			}
			_collection = collection;
		}

		void ICollection<TKey>.Add(TKey item)
		{
			throw new NotSupportedException("Collection is read-only.");
		}

		void ICollection<TKey>.Clear()
		{
			throw new NotSupportedException("Collection is read-only.");
		}

		bool ICollection<TKey>.Contains(TKey item)
		{
			return _collection.Contains(item);
		}

		public void CopyTo(TKey[] array, int arrayIndex)
		{
			_collection.CopyTo(array, arrayIndex);
		}

		bool ICollection<TKey>.Remove(TKey item)
		{
			throw new NotSupportedException("Collection is read-only.");
		}

		public IEnumerator<TKey> GetEnumerator()
		{
			return _collection.GetEnumerator();
		}

		IEnumerator IEnumerable.GetEnumerator()
		{
			return ((IEnumerable)_collection).GetEnumerator();
		}

		void ICollection.CopyTo(Array array, int index)
		{
			ReadOnlyDictionaryHelpers.CopyToNonGenericICollectionHelper(_collection, array, index);
		}

		internal KeyCollection()
		{
			ThrowStub.ThrowNotSupportedException();
		}
	}

	[Serializable]
	[DebuggerTypeProxy(typeof(CollectionDebugView<>))]
	[DebuggerDisplay("Count = {Count}")]
	public sealed class ValueCollection : ICollection<TValue>, IEnumerable<TValue>, IEnumerable, ICollection, IReadOnlyCollection<TValue>
	{
		private readonly ICollection<TValue> _collection;

		[NonSerialized]
		private object _syncRoot;

		public int Count => _collection.Count;

		bool ICollection<TValue>.IsReadOnly => true;

		bool ICollection.IsSynchronized => false;

		object ICollection.SyncRoot
		{
			get
			{
				if (_syncRoot == null)
				{
					if (_collection is ICollection collection)
					{
						_syncRoot = collection.SyncRoot;
					}
					else
					{
						Interlocked.CompareExchange<object>(ref _syncRoot, new object(), (object)null);
					}
				}
				return _syncRoot;
			}
		}

		internal ValueCollection(ICollection<TValue> collection)
		{
			if (collection == null)
			{
				throw new ArgumentNullException("collection");
			}
			_collection = collection;
		}

		void ICollection<TValue>.Add(TValue item)
		{
			throw new NotSupportedException("Collection is read-only.");
		}

		void ICollection<TValue>.Clear()
		{
			throw new NotSupportedException("Collection is read-only.");
		}

		bool ICollection<TValue>.Contains(TValue item)
		{
			return _collection.Contains(item);
		}

		public void CopyTo(TValue[] array, int arrayIndex)
		{
			_collection.CopyTo(array, arrayIndex);
		}

		bool ICollection<TValue>.Remove(TValue item)
		{
			throw new NotSupportedException("Collection is read-only.");
		}

		public IEnumerator<TValue> GetEnumerator()
		{
			return _collection.GetEnumerator();
		}

		IEnumerator IEnumerable.GetEnumerator()
		{
			return ((IEnumerable)_collection).GetEnumerator();
		}

		void ICollection.CopyTo(Array array, int index)
		{
			ReadOnlyDictionaryHelpers.CopyToNonGenericICollectionHelper(_collection, array, index);
		}

		internal ValueCollection()
		{
			ThrowStub.ThrowNotSupportedException();
		}
	}

	private readonly IDictionary<TKey, TValue> m_dictionary;

	[NonSerialized]
	private object _syncRoot;

	[NonSerialized]
	private KeyCollection _keys;

	[NonSerialized]
	private ValueCollection _values;

	public KeyCollection Keys
	{
		get
		{
			if (_keys == null)
			{
				_keys = new KeyCollection(m_dictionary.Keys);
			}
			return _keys;
		}
	}

	public ValueCollection Values
	{
		get
		{
			if (_values == null)
			{
				_values = new ValueCollection(m_dictionary.Values);
			}
			return _values;
		}
	}

	ICollection<TKey> IDictionary<TKey, TValue>.Keys => Keys;

	ICollection<TValue> IDictionary<TKey, TValue>.Values => Values;

	public TValue this[TKey key] => m_dictionary[key];

	TValue IDictionary<TKey, TValue>.this[TKey key]
	{
		get
		{
			return m_dictionary[key];
		}
		set
		{
			throw new NotSupportedException("Collection is read-only.");
		}
	}

	public int Count => m_dictionary.Count;

	bool ICollection<KeyValuePair<TKey, TValue>>.IsReadOnly => true;

	bool IDictionary.IsFixedSize => true;

	bool IDictionary.IsReadOnly => true;

	ICollection IDictionary.Keys => Keys;

	ICollection IDictionary.Values => Values;

	object IDictionary.this[object key]
	{
		get
		{
			if (IsCompatibleKey(key))
			{
				return this[(TKey)key];
			}
			return null;
		}
		set
		{
			throw new NotSupportedException("Collection is read-only.");
		}
	}

	bool ICollection.IsSynchronized => false;

	object ICollection.SyncRoot
	{
		get
		{
			if (_syncRoot == null)
			{
				if (m_dictionary is ICollection collection)
				{
					_syncRoot = collection.SyncRoot;
				}
				else
				{
					Interlocked.CompareExchange<object>(ref _syncRoot, new object(), (object)null);
				}
			}
			return _syncRoot;
		}
	}

	IEnumerable<TKey> IReadOnlyDictionary<TKey, TValue>.Keys => Keys;

	IEnumerable<TValue> IReadOnlyDictionary<TKey, TValue>.Values => Values;

	public ReadOnlyDictionary(IDictionary<TKey, TValue> dictionary)
	{
		if (dictionary == null)
		{
			throw new ArgumentNullException("dictionary");
		}
		m_dictionary = dictionary;
	}

	public bool ContainsKey(TKey key)
	{
		return m_dictionary.ContainsKey(key);
	}

	public bool TryGetValue(TKey key, out TValue value)
	{
		return m_dictionary.TryGetValue(key, out value);
	}

	void IDictionary<TKey, TValue>.Add(TKey key, TValue value)
	{
		throw new NotSupportedException("Collection is read-only.");
	}

	bool IDictionary<TKey, TValue>.Remove(TKey key)
	{
		throw new NotSupportedException("Collection is read-only.");
	}

	bool ICollection<KeyValuePair<TKey, TValue>>.Contains(KeyValuePair<TKey, TValue> item)
	{
		return m_dictionary.Contains(item);
	}

	void ICollection<KeyValuePair<TKey, TValue>>.CopyTo(KeyValuePair<TKey, TValue>[] array, int arrayIndex)
	{
		m_dictionary.CopyTo(array, arrayIndex);
	}

	void ICollection<KeyValuePair<TKey, TValue>>.Add(KeyValuePair<TKey, TValue> item)
	{
		throw new NotSupportedException("Collection is read-only.");
	}

	void ICollection<KeyValuePair<TKey, TValue>>.Clear()
	{
		throw new NotSupportedException("Collection is read-only.");
	}

	bool ICollection<KeyValuePair<TKey, TValue>>.Remove(KeyValuePair<TKey, TValue> item)
	{
		throw new NotSupportedException("Collection is read-only.");
	}

	public IEnumerator<KeyValuePair<TKey, TValue>> GetEnumerator()
	{
		return m_dictionary.GetEnumerator();
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return ((IEnumerable)m_dictionary).GetEnumerator();
	}

	private static bool IsCompatibleKey(object key)
	{
		if (key == null)
		{
			throw new ArgumentNullException("key");
		}
		return key is TKey;
	}

	void IDictionary.Add(object key, object value)
	{
		throw new NotSupportedException("Collection is read-only.");
	}

	void IDictionary.Clear()
	{
		throw new NotSupportedException("Collection is read-only.");
	}

	bool IDictionary.Contains(object key)
	{
		if (IsCompatibleKey(key))
		{
			return ContainsKey((TKey)key);
		}
		return false;
	}

	IDictionaryEnumerator IDictionary.GetEnumerator()
	{
		if (m_dictionary is IDictionary dictionary)
		{
			return dictionary.GetEnumerator();
		}
		return new DictionaryEnumerator(m_dictionary);
	}

	void IDictionary.Remove(object key)
	{
		throw new NotSupportedException("Collection is read-only.");
	}

	void ICollection.CopyTo(Array array, int index)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (array.Rank != 1)
		{
			throw new ArgumentException("Only single dimensional arrays are supported for the requested action.");
		}
		if (array.GetLowerBound(0) != 0)
		{
			throw new ArgumentException("The lower bound of target array must be zero.");
		}
		if (index < 0 || index > array.Length)
		{
			throw new ArgumentOutOfRangeException("index", "Non-negative number required.");
		}
		if (array.Length - index < Count)
		{
			throw new ArgumentException("Destination array is not long enough to copy all the items in the collection. Check array index and length.");
		}
		if (array is KeyValuePair<TKey, TValue>[] array2)
		{
			m_dictionary.CopyTo(array2, index);
			return;
		}
		if (array is DictionaryEntry[] array3)
		{
			{
				foreach (KeyValuePair<TKey, TValue> item in m_dictionary)
				{
					array3[index++] = new DictionaryEntry(item.Key, item.Value);
				}
				return;
			}
		}
		if (!(array is object[] array4))
		{
			throw new ArgumentException("Target array type is not compatible with the type of items in the collection.");
		}
		try
		{
			foreach (KeyValuePair<TKey, TValue> item2 in m_dictionary)
			{
				array4[index++] = new KeyValuePair<TKey, TValue>(item2.Key, item2.Value);
			}
		}
		catch (ArrayTypeMismatchException)
		{
			throw new ArgumentException("Target array type is not compatible with the type of items in the collection.");
		}
	}
}
