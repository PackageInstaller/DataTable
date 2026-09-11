using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Diagnostics;
using System.Runtime.CompilerServices;
using System.Runtime.Serialization;
using System.Threading;

namespace System.Collections.Concurrent;

[Serializable]
[DebuggerDisplay("Count = {Count}")]
[DebuggerTypeProxy(typeof(IDictionaryDebugView<, >))]
public class ConcurrentDictionary<TKey, TValue> : IDictionary<TKey, TValue>, ICollection<KeyValuePair<TKey, TValue>>, IEnumerable<KeyValuePair<TKey, TValue>>, IEnumerable, IDictionary, ICollection, IReadOnlyDictionary<TKey, TValue>, IReadOnlyCollection<KeyValuePair<TKey, TValue>>
{
	private sealed class Tables
	{
		internal readonly Node[] _buckets;

		internal readonly object[] _locks;

		internal volatile int[] _countPerLock;

		internal Tables(Node[] buckets, object[] locks, int[] countPerLock)
		{
			_buckets = buckets;
			_locks = locks;
			_countPerLock = countPerLock;
		}
	}

	[Serializable]
	private sealed class Node
	{
		internal readonly TKey _key;

		internal TValue _value;

		internal volatile Node _next;

		internal readonly int _hashcode;

		internal Node(TKey key, TValue value, int hashcode, Node next)
		{
			_key = key;
			_value = value;
			_next = next;
			_hashcode = hashcode;
		}
	}

	[Serializable]
	private sealed class DictionaryEnumerator : IDictionaryEnumerator, IEnumerator
	{
		private IEnumerator<KeyValuePair<TKey, TValue>> _enumerator;

		public DictionaryEntry Entry => new DictionaryEntry(_enumerator.Current.Key, _enumerator.Current.Value);

		public object Key => _enumerator.Current.Key;

		public object Value => _enumerator.Current.Value;

		public object Current => Entry;

		internal DictionaryEnumerator(ConcurrentDictionary<TKey, TValue> dictionary)
		{
			_enumerator = dictionary.GetEnumerator();
		}

		public bool MoveNext()
		{
			return _enumerator.MoveNext();
		}

		public void Reset()
		{
			_enumerator.Reset();
		}
	}

	[NonSerialized]
	private volatile Tables _tables;

	private IEqualityComparer<TKey> _comparer;

	[NonSerialized]
	private readonly bool _growLockArray;

	[NonSerialized]
	private int _budget;

	private KeyValuePair<TKey, TValue>[] _serializationArray;

	private int _serializationConcurrencyLevel;

	private int _serializationCapacity;

	private const int DefaultCapacity = 31;

	private const int MaxLockNumber = 1024;

	private static readonly bool s_isValueWriteAtomic = IsValueWriteAtomic();

	public TValue this[TKey key]
	{
		get
		{
			if (!TryGetValue(key, out var value))
			{
				ThrowKeyNotFoundException(key);
			}
			return value;
		}
		set
		{
			if (key == null)
			{
				ThrowKeyNullException();
			}
			TryAddInternal(key, _comparer.GetHashCode(key), value, updateIfExists: true, acquireLock: true, out var _);
		}
	}

	public int Count
	{
		get
		{
			int locksAcquired = 0;
			try
			{
				AcquireAllLocks(ref locksAcquired);
				return GetCountInternal();
			}
			finally
			{
				ReleaseLocks(0, locksAcquired);
			}
		}
	}

	public bool IsEmpty
	{
		get
		{
			int locksAcquired = 0;
			try
			{
				AcquireAllLocks(ref locksAcquired);
				for (int i = 0; i < _tables._countPerLock.Length; i++)
				{
					if (_tables._countPerLock[i] != 0)
					{
						return false;
					}
				}
			}
			finally
			{
				ReleaseLocks(0, locksAcquired);
			}
			return true;
		}
	}

	public ICollection<TKey> Keys => GetKeys();

	IEnumerable<TKey> IReadOnlyDictionary<TKey, TValue>.Keys => GetKeys();

	public ICollection<TValue> Values => GetValues();

	IEnumerable<TValue> IReadOnlyDictionary<TKey, TValue>.Values => GetValues();

	bool ICollection<KeyValuePair<TKey, TValue>>.IsReadOnly => false;

	bool IDictionary.IsFixedSize => false;

	bool IDictionary.IsReadOnly => false;

	ICollection IDictionary.Keys => GetKeys();

	ICollection IDictionary.Values => GetValues();

	object IDictionary.this[object key]
	{
		get
		{
			if (key == null)
			{
				ThrowKeyNullException();
			}
			if (key is TKey && TryGetValue((TKey)key, out var value))
			{
				return value;
			}
			return null;
		}
		set
		{
			if (key == null)
			{
				ThrowKeyNullException();
			}
			if (!(key is TKey))
			{
				throw new ArgumentException("The key was of an incorrect type for this dictionary.");
			}
			if (!(value is TValue))
			{
				throw new ArgumentException("The value was of an incorrect type for this dictionary.");
			}
			this[(TKey)key] = (TValue)value;
		}
	}

	bool ICollection.IsSynchronized => false;

	object ICollection.SyncRoot
	{
		get
		{
			throw new NotSupportedException("The SyncRoot property may not be used for the synchronization of concurrent collections.");
		}
	}

	private static int DefaultConcurrencyLevel => PlatformHelper.ProcessorCount;

	private static bool IsValueWriteAtomic()
	{
		Type typeFromHandle = typeof(TValue);
		if (!typeFromHandle.IsValueType)
		{
			return true;
		}
		switch (Type.GetTypeCode(typeFromHandle))
		{
		case TypeCode.Boolean:
		case TypeCode.Char:
		case TypeCode.SByte:
		case TypeCode.Byte:
		case TypeCode.Int16:
		case TypeCode.UInt16:
		case TypeCode.Int32:
		case TypeCode.UInt32:
		case TypeCode.Single:
			return true;
		case TypeCode.Int64:
		case TypeCode.UInt64:
		case TypeCode.Double:
			return IntPtr.Size == 8;
		default:
			return false;
		}
	}

	public ConcurrentDictionary()
		: this(DefaultConcurrencyLevel, 31, true, (IEqualityComparer<TKey>)null)
	{
	}

	public ConcurrentDictionary(int concurrencyLevel, int capacity)
		: this(concurrencyLevel, capacity, false, (IEqualityComparer<TKey>)null)
	{
	}

	public ConcurrentDictionary(IEnumerable<KeyValuePair<TKey, TValue>> collection)
		: this(collection, (IEqualityComparer<TKey>)null)
	{
	}

	public ConcurrentDictionary(IEqualityComparer<TKey> comparer)
		: this(DefaultConcurrencyLevel, 31, true, comparer)
	{
	}

	public ConcurrentDictionary(IEnumerable<KeyValuePair<TKey, TValue>> collection, IEqualityComparer<TKey> comparer)
		: this(comparer)
	{
		if (collection == null)
		{
			throw new ArgumentNullException("collection");
		}
		InitializeFromCollection(collection);
	}

	public ConcurrentDictionary(int concurrencyLevel, IEnumerable<KeyValuePair<TKey, TValue>> collection, IEqualityComparer<TKey> comparer)
		: this(concurrencyLevel, 31, false, comparer)
	{
		if (collection == null)
		{
			throw new ArgumentNullException("collection");
		}
		InitializeFromCollection(collection);
	}

	private void InitializeFromCollection(IEnumerable<KeyValuePair<TKey, TValue>> collection)
	{
		foreach (KeyValuePair<TKey, TValue> item in collection)
		{
			if (item.Key == null)
			{
				ThrowKeyNullException();
			}
			if (!TryAddInternal(item.Key, _comparer.GetHashCode(item.Key), item.Value, updateIfExists: false, acquireLock: false, out var _))
			{
				throw new ArgumentException("The source argument contains duplicate keys.");
			}
		}
		if (_budget == 0)
		{
			_budget = _tables._buckets.Length / _tables._locks.Length;
		}
	}

	public ConcurrentDictionary(int concurrencyLevel, int capacity, IEqualityComparer<TKey> comparer)
		: this(concurrencyLevel, capacity, false, comparer)
	{
	}

	internal ConcurrentDictionary(int concurrencyLevel, int capacity, bool growLockArray, IEqualityComparer<TKey> comparer)
	{
		if (concurrencyLevel < 1)
		{
			throw new ArgumentOutOfRangeException("concurrencyLevel", "The concurrencyLevel argument must be positive.");
		}
		if (capacity < 0)
		{
			throw new ArgumentOutOfRangeException("capacity", "The capacity argument must be greater than or equal to zero.");
		}
		if (capacity < concurrencyLevel)
		{
			capacity = concurrencyLevel;
		}
		object[] array = new object[concurrencyLevel];
		for (int i = 0; i < array.Length; i++)
		{
			array[i] = new object();
		}
		int[] countPerLock = new int[array.Length];
		Node[] array2 = new Node[capacity];
		_tables = new Tables(array2, array, countPerLock);
		_comparer = comparer ?? EqualityComparer<TKey>.Default;
		_growLockArray = growLockArray;
		_budget = array2.Length / array.Length;
	}

	public bool TryAdd(TKey key, TValue value)
	{
		if (key == null)
		{
			ThrowKeyNullException();
		}
		TValue resultingValue;
		return TryAddInternal(key, _comparer.GetHashCode(key), value, updateIfExists: false, acquireLock: true, out resultingValue);
	}

	public bool ContainsKey(TKey key)
	{
		if (key == null)
		{
			ThrowKeyNullException();
		}
		TValue value;
		return TryGetValue(key, out value);
	}

	public bool TryRemove(TKey key, out TValue value)
	{
		if (key == null)
		{
			ThrowKeyNullException();
		}
		return TryRemoveInternal(key, out value, matchValue: false, default(TValue));
	}

	private bool TryRemoveInternal(TKey key, out TValue value, bool matchValue, TValue oldValue)
	{
		int hashCode = _comparer.GetHashCode(key);
		while (true)
		{
			Tables tables = _tables;
			GetBucketAndLockNo(hashCode, out var bucketNo, out var lockNo, tables._buckets.Length, tables._locks.Length);
			lock (tables._locks[lockNo])
			{
				if (tables != _tables)
				{
					continue;
				}
				Node node = null;
				for (Node node2 = tables._buckets[bucketNo]; node2 != null; node2 = node2._next)
				{
					if (hashCode == node2._hashcode && _comparer.Equals(node2._key, key))
					{
						if (matchValue && !EqualityComparer<TValue>.Default.Equals(oldValue, node2._value))
						{
							value = default(TValue);
							return false;
						}
						if (node == null)
						{
							Volatile.Write(ref tables._buckets[bucketNo], node2._next);
						}
						else
						{
							node._next = node2._next;
						}
						value = node2._value;
						tables._countPerLock[lockNo]--;
						return true;
					}
					node = node2;
				}
				break;
			}
		}
		value = default(TValue);
		return false;
	}

	public bool TryGetValue(TKey key, out TValue value)
	{
		if (key == null)
		{
			ThrowKeyNullException();
		}
		return TryGetValueInternal(key, _comparer.GetHashCode(key), out value);
	}

	private bool TryGetValueInternal(TKey key, int hashcode, out TValue value)
	{
		Tables tables = _tables;
		int bucket = GetBucket(hashcode, tables._buckets.Length);
		for (Node node = Volatile.Read(ref tables._buckets[bucket]); node != null; node = node._next)
		{
			if (hashcode == node._hashcode && _comparer.Equals(node._key, key))
			{
				value = node._value;
				return true;
			}
		}
		value = default(TValue);
		return false;
	}

	public bool TryUpdate(TKey key, TValue newValue, TValue comparisonValue)
	{
		if (key == null)
		{
			ThrowKeyNullException();
		}
		return TryUpdateInternal(key, _comparer.GetHashCode(key), newValue, comparisonValue);
	}

	private bool TryUpdateInternal(TKey key, int hashcode, TValue newValue, TValue comparisonValue)
	{
		IEqualityComparer<TValue> equalityComparer = EqualityComparer<TValue>.Default;
		while (true)
		{
			Tables tables = _tables;
			GetBucketAndLockNo(hashcode, out var bucketNo, out var lockNo, tables._buckets.Length, tables._locks.Length);
			lock (tables._locks[lockNo])
			{
				if (tables != _tables)
				{
					continue;
				}
				Node node = null;
				for (Node node2 = tables._buckets[bucketNo]; node2 != null; node2 = node2._next)
				{
					if (hashcode == node2._hashcode && _comparer.Equals(node2._key, key))
					{
						if (equalityComparer.Equals(node2._value, comparisonValue))
						{
							if (s_isValueWriteAtomic)
							{
								node2._value = newValue;
							}
							else
							{
								Node node3 = new Node(node2._key, newValue, hashcode, node2._next);
								if (node == null)
								{
									Volatile.Write(ref tables._buckets[bucketNo], node3);
								}
								else
								{
									node._next = node3;
								}
							}
							return true;
						}
						return false;
					}
					node = node2;
				}
				return false;
			}
		}
	}

	public void Clear()
	{
		int locksAcquired = 0;
		try
		{
			AcquireAllLocks(ref locksAcquired);
			Tables tables = (_tables = new Tables(new Node[31], _tables._locks, new int[_tables._countPerLock.Length]));
			_budget = Math.Max(1, tables._buckets.Length / tables._locks.Length);
		}
		finally
		{
			ReleaseLocks(0, locksAcquired);
		}
	}

	void ICollection<KeyValuePair<TKey, TValue>>.CopyTo(KeyValuePair<TKey, TValue>[] array, int index)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (index < 0)
		{
			throw new ArgumentOutOfRangeException("index", "The index argument is less than zero.");
		}
		int locksAcquired = 0;
		try
		{
			AcquireAllLocks(ref locksAcquired);
			int num = 0;
			for (int i = 0; i < _tables._locks.Length; i++)
			{
				if (num < 0)
				{
					break;
				}
				num += _tables._countPerLock[i];
			}
			if (array.Length - num < index || num < 0)
			{
				throw new ArgumentException("The index is equal to or greater than the length of the array, or the number of elements in the dictionary is greater than the available space from index to the end of the destination array.");
			}
			CopyToPairs(array, index);
		}
		finally
		{
			ReleaseLocks(0, locksAcquired);
		}
	}

	public KeyValuePair<TKey, TValue>[] ToArray()
	{
		int locksAcquired = 0;
		checked
		{
			try
			{
				AcquireAllLocks(ref locksAcquired);
				int num = 0;
				for (int i = 0; i < _tables._locks.Length; i++)
				{
					num += _tables._countPerLock[i];
				}
				if (num == 0)
				{
					return Array.Empty<KeyValuePair<TKey, TValue>>();
				}
				KeyValuePair<TKey, TValue>[] array = new KeyValuePair<TKey, TValue>[num];
				CopyToPairs(array, 0);
				return array;
			}
			finally
			{
				ReleaseLocks(0, locksAcquired);
			}
		}
	}

	private void CopyToPairs(KeyValuePair<TKey, TValue>[] array, int index)
	{
		Node[] buckets = _tables._buckets;
		for (int i = 0; i < buckets.Length; i++)
		{
			for (Node node = buckets[i]; node != null; node = node._next)
			{
				array[index] = new KeyValuePair<TKey, TValue>(node._key, node._value);
				index++;
			}
		}
	}

	private void CopyToEntries(DictionaryEntry[] array, int index)
	{
		Node[] buckets = _tables._buckets;
		for (int i = 0; i < buckets.Length; i++)
		{
			for (Node node = buckets[i]; node != null; node = node._next)
			{
				array[index] = new DictionaryEntry(node._key, node._value);
				index++;
			}
		}
	}

	private void CopyToObjects(object[] array, int index)
	{
		Node[] buckets = _tables._buckets;
		for (int i = 0; i < buckets.Length; i++)
		{
			for (Node node = buckets[i]; node != null; node = node._next)
			{
				array[index] = new KeyValuePair<TKey, TValue>(node._key, node._value);
				index++;
			}
		}
	}

	public IEnumerator<KeyValuePair<TKey, TValue>> GetEnumerator()
	{
		Node[] buckets = _tables._buckets;
		for (int i = 0; i < buckets.Length; i++)
		{
			for (Node current = Volatile.Read(ref buckets[i]); current != null; current = current._next)
			{
				yield return new KeyValuePair<TKey, TValue>(current._key, current._value);
			}
		}
	}

	private bool TryAddInternal(TKey key, int hashcode, TValue value, bool updateIfExists, bool acquireLock, out TValue resultingValue)
	{
		checked
		{
			Tables tables;
			bool flag;
			while (true)
			{
				tables = _tables;
				GetBucketAndLockNo(hashcode, out var bucketNo, out var lockNo, tables._buckets.Length, tables._locks.Length);
				flag = false;
				bool lockTaken = false;
				try
				{
					if (acquireLock)
					{
						Monitor.Enter(tables._locks[lockNo], ref lockTaken);
					}
					if (tables != _tables)
					{
						continue;
					}
					Node node = null;
					for (Node node2 = tables._buckets[bucketNo]; node2 != null; node2 = node2._next)
					{
						if (hashcode == node2._hashcode && _comparer.Equals(node2._key, key))
						{
							if (updateIfExists)
							{
								if (s_isValueWriteAtomic)
								{
									node2._value = value;
								}
								else
								{
									Node node3 = new Node(node2._key, value, hashcode, node2._next);
									if (node == null)
									{
										Volatile.Write(ref tables._buckets[bucketNo], node3);
									}
									else
									{
										node._next = node3;
									}
								}
								resultingValue = value;
							}
							else
							{
								resultingValue = node2._value;
							}
							return false;
						}
						node = node2;
					}
					Volatile.Write(ref tables._buckets[bucketNo], new Node(key, value, hashcode, tables._buckets[bucketNo]));
					tables._countPerLock[lockNo]++;
					if (tables._countPerLock[lockNo] > _budget)
					{
						flag = true;
					}
					break;
				}
				finally
				{
					if (lockTaken)
					{
						Monitor.Exit(tables._locks[lockNo]);
					}
				}
			}
			if (flag)
			{
				GrowTable(tables);
			}
			resultingValue = value;
			return true;
		}
	}

	[MethodImpl((MethodImplOptions)8)]
	private static void ThrowKeyNotFoundException(object key)
	{
		throw new KeyNotFoundException(SR.Format("The given key '{0}' was not present in the dictionary.", key.ToString()));
	}

	[MethodImpl((MethodImplOptions)8)]
	private static void ThrowKeyNullException()
	{
		throw new ArgumentNullException("key");
	}

	private int GetCountInternal()
	{
		int num = 0;
		for (int i = 0; i < _tables._countPerLock.Length; i++)
		{
			num += _tables._countPerLock[i];
		}
		return num;
	}

	public TValue GetOrAdd(TKey key, Func<TKey, TValue> valueFactory)
	{
		if (key == null)
		{
			ThrowKeyNullException();
		}
		if (valueFactory == null)
		{
			throw new ArgumentNullException("valueFactory");
		}
		int hashCode = _comparer.GetHashCode(key);
		if (!TryGetValueInternal(key, hashCode, out var value))
		{
			TryAddInternal(key, hashCode, valueFactory(key), updateIfExists: false, acquireLock: true, out value);
		}
		return value;
	}

	public TValue GetOrAdd<TArg>(TKey key, Func<TKey, TArg, TValue> valueFactory, TArg factoryArgument)
	{
		if (key == null)
		{
			ThrowKeyNullException();
		}
		if (valueFactory == null)
		{
			throw new ArgumentNullException("valueFactory");
		}
		int hashCode = _comparer.GetHashCode(key);
		if (!TryGetValueInternal(key, hashCode, out var value))
		{
			TryAddInternal(key, hashCode, valueFactory(key, factoryArgument), updateIfExists: false, acquireLock: true, out value);
		}
		return value;
	}

	public TValue GetOrAdd(TKey key, TValue value)
	{
		if (key == null)
		{
			ThrowKeyNullException();
		}
		int hashCode = _comparer.GetHashCode(key);
		if (!TryGetValueInternal(key, hashCode, out var value2))
		{
			TryAddInternal(key, hashCode, value, updateIfExists: false, acquireLock: true, out value2);
		}
		return value2;
	}

	public TValue AddOrUpdate<TArg>(TKey key, Func<TKey, TArg, TValue> addValueFactory, Func<TKey, TValue, TArg, TValue> updateValueFactory, TArg factoryArgument)
	{
		if (key == null)
		{
			ThrowKeyNullException();
		}
		if (addValueFactory == null)
		{
			throw new ArgumentNullException("addValueFactory");
		}
		if (updateValueFactory == null)
		{
			throw new ArgumentNullException("updateValueFactory");
		}
		int hashCode = _comparer.GetHashCode(key);
		TValue resultingValue;
		while (true)
		{
			if (TryGetValueInternal(key, hashCode, out var value))
			{
				TValue val = updateValueFactory(key, value, factoryArgument);
				if (TryUpdateInternal(key, hashCode, val, value))
				{
					return val;
				}
			}
			else if (TryAddInternal(key, hashCode, addValueFactory(key, factoryArgument), updateIfExists: false, acquireLock: true, out resultingValue))
			{
				break;
			}
		}
		return resultingValue;
	}

	public TValue AddOrUpdate(TKey key, Func<TKey, TValue> addValueFactory, Func<TKey, TValue, TValue> updateValueFactory)
	{
		if (key == null)
		{
			ThrowKeyNullException();
		}
		if (addValueFactory == null)
		{
			throw new ArgumentNullException("addValueFactory");
		}
		if (updateValueFactory == null)
		{
			throw new ArgumentNullException("updateValueFactory");
		}
		int hashCode = _comparer.GetHashCode(key);
		TValue resultingValue;
		while (true)
		{
			if (TryGetValueInternal(key, hashCode, out var value))
			{
				TValue val = updateValueFactory(key, value);
				if (TryUpdateInternal(key, hashCode, val, value))
				{
					return val;
				}
			}
			else if (TryAddInternal(key, hashCode, addValueFactory(key), updateIfExists: false, acquireLock: true, out resultingValue))
			{
				break;
			}
		}
		return resultingValue;
	}

	public TValue AddOrUpdate(TKey key, TValue addValue, Func<TKey, TValue, TValue> updateValueFactory)
	{
		if (key == null)
		{
			ThrowKeyNullException();
		}
		if (updateValueFactory == null)
		{
			throw new ArgumentNullException("updateValueFactory");
		}
		int hashCode = _comparer.GetHashCode(key);
		TValue resultingValue;
		while (true)
		{
			if (TryGetValueInternal(key, hashCode, out var value))
			{
				TValue val = updateValueFactory(key, value);
				if (TryUpdateInternal(key, hashCode, val, value))
				{
					return val;
				}
			}
			else if (TryAddInternal(key, hashCode, addValue, updateIfExists: false, acquireLock: true, out resultingValue))
			{
				break;
			}
		}
		return resultingValue;
	}

	void IDictionary<TKey, TValue>.Add(TKey key, TValue value)
	{
		if (!TryAdd(key, value))
		{
			throw new ArgumentException("The key already existed in the dictionary.");
		}
	}

	bool IDictionary<TKey, TValue>.Remove(TKey key)
	{
		TValue value;
		return TryRemove(key, out value);
	}

	void ICollection<KeyValuePair<TKey, TValue>>.Add(KeyValuePair<TKey, TValue> keyValuePair)
	{
		((IDictionary<TKey, TValue>)this).Add(keyValuePair.Key, keyValuePair.Value);
	}

	bool ICollection<KeyValuePair<TKey, TValue>>.Contains(KeyValuePair<TKey, TValue> keyValuePair)
	{
		if (!TryGetValue(keyValuePair.Key, out var value))
		{
			return false;
		}
		return EqualityComparer<TValue>.Default.Equals(value, keyValuePair.Value);
	}

	bool ICollection<KeyValuePair<TKey, TValue>>.Remove(KeyValuePair<TKey, TValue> keyValuePair)
	{
		if (keyValuePair.Key == null)
		{
			throw new ArgumentNullException("keyValuePair", "TKey is a reference type and item.Key is null.");
		}
		TValue value;
		return TryRemoveInternal(keyValuePair.Key, out value, matchValue: true, keyValuePair.Value);
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}

	void IDictionary.Add(object key, object value)
	{
		if (key == null)
		{
			ThrowKeyNullException();
		}
		if (!(key is TKey))
		{
			throw new ArgumentException("The key was of an incorrect type for this dictionary.");
		}
		TValue value2;
		try
		{
			value2 = (TValue)value;
		}
		catch (InvalidCastException)
		{
			throw new ArgumentException("The value was of an incorrect type for this dictionary.");
		}
		((IDictionary<TKey, TValue>)this).Add((TKey)key, value2);
	}

	bool IDictionary.Contains(object key)
	{
		if (key == null)
		{
			ThrowKeyNullException();
		}
		if (key is TKey)
		{
			return ContainsKey((TKey)key);
		}
		return false;
	}

	IDictionaryEnumerator IDictionary.GetEnumerator()
	{
		return new DictionaryEnumerator(this);
	}

	void IDictionary.Remove(object key)
	{
		if (key == null)
		{
			ThrowKeyNullException();
		}
		if (key is TKey)
		{
			TryRemove((TKey)key, out var _);
		}
	}

	void ICollection.CopyTo(Array array, int index)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (index < 0)
		{
			throw new ArgumentOutOfRangeException("index", "The index argument is less than zero.");
		}
		int locksAcquired = 0;
		try
		{
			AcquireAllLocks(ref locksAcquired);
			Tables tables = _tables;
			int num = 0;
			for (int i = 0; i < tables._locks.Length; i++)
			{
				if (num < 0)
				{
					break;
				}
				num += tables._countPerLock[i];
			}
			if (array.Length - num < index || num < 0)
			{
				throw new ArgumentException("The index is equal to or greater than the length of the array, or the number of elements in the dictionary is greater than the available space from index to the end of the destination array.");
			}
			if (array is KeyValuePair<TKey, TValue>[] array2)
			{
				CopyToPairs(array2, index);
				return;
			}
			if (array is DictionaryEntry[] array3)
			{
				CopyToEntries(array3, index);
				return;
			}
			if (array is object[] array4)
			{
				CopyToObjects(array4, index);
				return;
			}
			throw new ArgumentException("The array is multidimensional, or the type parameter for the set cannot be cast automatically to the type of the destination array.", "array");
		}
		finally
		{
			ReleaseLocks(0, locksAcquired);
		}
	}

	private void GrowTable(Tables tables)
	{
		int locksAcquired = 0;
		try
		{
			AcquireLocks(0, 1, ref locksAcquired);
			if (tables != _tables)
			{
				return;
			}
			long num = 0L;
			for (int i = 0; i < tables._countPerLock.Length; i++)
			{
				num += tables._countPerLock[i];
			}
			if (num < tables._buckets.Length / 4)
			{
				_budget = 2 * _budget;
				if (_budget < 0)
				{
					_budget = int.MaxValue;
				}
				return;
			}
			int j = 0;
			bool flag = false;
			try
			{
				for (j = checked(tables._buckets.Length * 2 + 1); j % 3 == 0 || j % 5 == 0 || j % 7 == 0; j = checked(j + 2))
				{
				}
				if (j > 2146435071)
				{
					flag = true;
				}
			}
			catch (OverflowException)
			{
				flag = true;
			}
			if (flag)
			{
				j = 2146435071;
				_budget = int.MaxValue;
			}
			AcquireLocks(1, tables._locks.Length, ref locksAcquired);
			object[] array = tables._locks;
			if (_growLockArray && tables._locks.Length < 1024)
			{
				array = new object[tables._locks.Length * 2];
				Array.Copy(tables._locks, 0, array, 0, tables._locks.Length);
				for (int k = tables._locks.Length; k < array.Length; k++)
				{
					array[k] = new object();
				}
			}
			Node[] array2 = new Node[j];
			int[] array3 = new int[array.Length];
			for (int l = 0; l < tables._buckets.Length; l++)
			{
				Node node = tables._buckets[l];
				checked
				{
					while (node != null)
					{
						Node next = node._next;
						GetBucketAndLockNo(node._hashcode, out var bucketNo, out var lockNo, array2.Length, array.Length);
						array2[bucketNo] = new Node(node._key, node._value, node._hashcode, array2[bucketNo]);
						array3[lockNo]++;
						node = next;
					}
				}
			}
			_budget = Math.Max(1, array2.Length / array.Length);
			_tables = new Tables(array2, array, array3);
		}
		finally
		{
			ReleaseLocks(0, locksAcquired);
		}
	}

	private static int GetBucket(int hashcode, int bucketCount)
	{
		return (hashcode & 0x7FFFFFFF) % bucketCount;
	}

	private static void GetBucketAndLockNo(int hashcode, out int bucketNo, out int lockNo, int bucketCount, int lockCount)
	{
		bucketNo = (hashcode & 0x7FFFFFFF) % bucketCount;
		lockNo = bucketNo % lockCount;
	}

	private void AcquireAllLocks(ref int locksAcquired)
	{
		if (CDSCollectionETWBCLProvider.Log.IsEnabled())
		{
			CDSCollectionETWBCLProvider.Log.ConcurrentDictionary_AcquiringAllLocks(_tables._buckets.Length);
		}
		AcquireLocks(0, 1, ref locksAcquired);
		AcquireLocks(1, _tables._locks.Length, ref locksAcquired);
	}

	private void AcquireLocks(int fromInclusive, int toExclusive, ref int locksAcquired)
	{
		object[] locks = _tables._locks;
		for (int i = fromInclusive; i < toExclusive; i++)
		{
			bool lockTaken = false;
			try
			{
				Monitor.Enter(locks[i], ref lockTaken);
			}
			finally
			{
				if (lockTaken)
				{
					locksAcquired++;
				}
			}
		}
	}

	private void ReleaseLocks(int fromInclusive, int toExclusive)
	{
		for (int i = fromInclusive; i < toExclusive; i++)
		{
			Monitor.Exit(_tables._locks[i]);
		}
	}

	private ReadOnlyCollection<TKey> GetKeys()
	{
		int locksAcquired = 0;
		try
		{
			AcquireAllLocks(ref locksAcquired);
			int countInternal = GetCountInternal();
			if (countInternal < 0)
			{
				throw new OutOfMemoryException();
			}
			List<TKey> list = new List<TKey>(countInternal);
			for (int i = 0; i < _tables._buckets.Length; i++)
			{
				for (Node node = _tables._buckets[i]; node != null; node = node._next)
				{
					list.Add(node._key);
				}
			}
			return new ReadOnlyCollection<TKey>(list);
		}
		finally
		{
			ReleaseLocks(0, locksAcquired);
		}
	}

	private ReadOnlyCollection<TValue> GetValues()
	{
		int locksAcquired = 0;
		try
		{
			AcquireAllLocks(ref locksAcquired);
			int countInternal = GetCountInternal();
			if (countInternal < 0)
			{
				throw new OutOfMemoryException();
			}
			List<TValue> list = new List<TValue>(countInternal);
			for (int i = 0; i < _tables._buckets.Length; i++)
			{
				for (Node node = _tables._buckets[i]; node != null; node = node._next)
				{
					list.Add(node._value);
				}
			}
			return new ReadOnlyCollection<TValue>(list);
		}
		finally
		{
			ReleaseLocks(0, locksAcquired);
		}
	}

	[OnSerializing]
	private void OnSerializing(StreamingContext context)
	{
		Tables tables = _tables;
		_serializationArray = ToArray();
		_serializationConcurrencyLevel = tables._locks.Length;
		_serializationCapacity = tables._buckets.Length;
	}

	[OnSerialized]
	private void OnSerialized(StreamingContext context)
	{
		_serializationArray = null;
	}

	[OnDeserialized]
	private void OnDeserialized(StreamingContext context)
	{
		KeyValuePair<TKey, TValue>[] serializationArray = _serializationArray;
		Node[] buckets = new Node[_serializationCapacity];
		int[] countPerLock = new int[_serializationConcurrencyLevel];
		object[] array = new object[_serializationConcurrencyLevel];
		for (int i = 0; i < array.Length; i++)
		{
			array[i] = new object();
		}
		_tables = new Tables(buckets, array, countPerLock);
		InitializeFromCollection(serializationArray);
		_serializationArray = null;
	}
}
