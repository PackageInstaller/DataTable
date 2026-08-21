using System.Diagnostics;
using System.Runtime.CompilerServices;
using System.Runtime.Serialization;
using System.Threading;

namespace System.Collections.Generic;

[Serializable]
[DebuggerTypeProxy(typeof(IDictionaryDebugView<, >))]
[DebuggerDisplay("Count = {Count}")]
public class Dictionary<TKey, TValue> : IDictionary<TKey, TValue>, ICollection<KeyValuePair<TKey, TValue>>, IEnumerable<KeyValuePair<TKey, TValue>>, IEnumerable, IDictionary, ICollection, IReadOnlyDictionary<TKey, TValue>, IReadOnlyCollection<KeyValuePair<TKey, TValue>>, ISerializable, IDeserializationCallback
{
	private struct Entry
	{
		public int hashCode;

		public int next;

		public TKey key;

		public TValue value;
	}

	[Serializable]
	public struct Enumerator : IEnumerator<KeyValuePair<TKey, TValue>>, IDisposable, IEnumerator, IDictionaryEnumerator
	{
		private Dictionary<TKey, TValue> _dictionary;

		private int _version;

		private int _index;

		private KeyValuePair<TKey, TValue> _current;

		private int _getEnumeratorRetType;

		internal const int DictEntry = 1;

		internal const int KeyValuePair = 2;

		public KeyValuePair<TKey, TValue> Current => _current;

		object IEnumerator.Current
		{
			get
			{
				if (_index == 0 || _index == _dictionary._count + 1)
				{
					ThrowHelper.ThrowInvalidOperationException_InvalidOperation_EnumOpCantHappen();
				}
				if (_getEnumeratorRetType == 1)
				{
					return new DictionaryEntry(_current.Key, _current.Value);
				}
				return new KeyValuePair<TKey, TValue>(_current.Key, _current.Value);
			}
		}

		DictionaryEntry IDictionaryEnumerator.Entry
		{
			get
			{
				if (_index == 0 || _index == _dictionary._count + 1)
				{
					ThrowHelper.ThrowInvalidOperationException_InvalidOperation_EnumOpCantHappen();
				}
				return new DictionaryEntry(_current.Key, _current.Value);
			}
		}

		object IDictionaryEnumerator.Key
		{
			get
			{
				if (_index == 0 || _index == _dictionary._count + 1)
				{
					ThrowHelper.ThrowInvalidOperationException_InvalidOperation_EnumOpCantHappen();
				}
				return _current.Key;
			}
		}

		object IDictionaryEnumerator.Value
		{
			get
			{
				if (_index == 0 || _index == _dictionary._count + 1)
				{
					ThrowHelper.ThrowInvalidOperationException_InvalidOperation_EnumOpCantHappen();
				}
				return _current.Value;
			}
		}

		internal Enumerator(Dictionary<TKey, TValue> dictionary, int getEnumeratorRetType)
		{
			_dictionary = dictionary;
			_version = dictionary._version;
			_index = 0;
			_getEnumeratorRetType = getEnumeratorRetType;
			_current = default(KeyValuePair<TKey, TValue>);
		}

		public bool MoveNext()
		{
			if (_version != _dictionary._version)
			{
				ThrowHelper.ThrowInvalidOperationException_InvalidOperation_EnumFailedVersion();
			}
			while ((uint)_index < (uint)_dictionary._count)
			{
				ref Entry reference = ref _dictionary._entries[_index++];
				if (reference.hashCode >= 0)
				{
					_current = new KeyValuePair<TKey, TValue>(reference.key, reference.value);
					return true;
				}
			}
			_index = _dictionary._count + 1;
			_current = default(KeyValuePair<TKey, TValue>);
			return false;
		}

		public void Dispose()
		{
		}

		void IEnumerator.Reset()
		{
			if (_version != _dictionary._version)
			{
				ThrowHelper.ThrowInvalidOperationException_InvalidOperation_EnumFailedVersion();
			}
			_index = 0;
			_current = default(KeyValuePair<TKey, TValue>);
		}
	}

	[Serializable]
	[DebuggerTypeProxy(typeof(DictionaryKeyCollectionDebugView<, >))]
	[DebuggerDisplay("Count = {Count}")]
	public sealed class KeyCollection : ICollection<TKey>, IEnumerable<TKey>, IEnumerable, ICollection, IReadOnlyCollection<TKey>
	{
		[Serializable]
		public struct Enumerator : IEnumerator<TKey>, IDisposable, IEnumerator
		{
			private Dictionary<TKey, TValue> _dictionary;

			private int _index;

			private int _version;

			private TKey _currentKey;

			public TKey Current => _currentKey;

			object IEnumerator.Current
			{
				get
				{
					if (_index == 0 || _index == _dictionary._count + 1)
					{
						ThrowHelper.ThrowInvalidOperationException_InvalidOperation_EnumOpCantHappen();
					}
					return _currentKey;
				}
			}

			internal Enumerator(Dictionary<TKey, TValue> dictionary)
			{
				_dictionary = dictionary;
				_version = dictionary._version;
				_index = 0;
				_currentKey = default(TKey);
			}

			public void Dispose()
			{
			}

			public bool MoveNext()
			{
				if (_version != _dictionary._version)
				{
					ThrowHelper.ThrowInvalidOperationException_InvalidOperation_EnumFailedVersion();
				}
				while ((uint)_index < (uint)_dictionary._count)
				{
					ref Entry reference = ref _dictionary._entries[_index++];
					if (reference.hashCode >= 0)
					{
						_currentKey = reference.key;
						return true;
					}
				}
				_index = _dictionary._count + 1;
				_currentKey = default(TKey);
				return false;
			}

			void IEnumerator.Reset()
			{
				if (_version != _dictionary._version)
				{
					ThrowHelper.ThrowInvalidOperationException_InvalidOperation_EnumFailedVersion();
				}
				_index = 0;
				_currentKey = default(TKey);
			}
		}

		private Dictionary<TKey, TValue> _dictionary;

		public int Count => _dictionary.Count;

		bool ICollection<TKey>.IsReadOnly => true;

		bool ICollection.IsSynchronized => false;

		object ICollection.SyncRoot => ((ICollection)_dictionary).SyncRoot;

		public KeyCollection(Dictionary<TKey, TValue> dictionary)
		{
			if (dictionary == null)
			{
				ThrowHelper.ThrowArgumentNullException(ExceptionArgument.dictionary);
			}
			_dictionary = dictionary;
		}

		public Enumerator GetEnumerator()
		{
			return new Enumerator(_dictionary);
		}

		public void CopyTo(TKey[] array, int index)
		{
			if (array == null)
			{
				ThrowHelper.ThrowArgumentNullException(ExceptionArgument.array);
			}
			if (index < 0 || index > array.Length)
			{
				ThrowHelper.ThrowIndexArgumentOutOfRange_NeedNonNegNumException();
			}
			if (array.Length - index < _dictionary.Count)
			{
				ThrowHelper.ThrowArgumentException(ExceptionResource.Arg_ArrayPlusOffTooSmall);
			}
			int count = _dictionary._count;
			Entry[] entries = _dictionary._entries;
			for (int i = 0; i < count; i++)
			{
				if (entries[i].hashCode >= 0)
				{
					array[index++] = entries[i].key;
				}
			}
		}

		void ICollection<TKey>.Add(TKey item)
		{
			ThrowHelper.ThrowNotSupportedException(ExceptionResource.NotSupported_KeyCollectionSet);
		}

		void ICollection<TKey>.Clear()
		{
			ThrowHelper.ThrowNotSupportedException(ExceptionResource.NotSupported_KeyCollectionSet);
		}

		bool ICollection<TKey>.Contains(TKey item)
		{
			return _dictionary.ContainsKey(item);
		}

		bool ICollection<TKey>.Remove(TKey item)
		{
			ThrowHelper.ThrowNotSupportedException(ExceptionResource.NotSupported_KeyCollectionSet);
			return false;
		}

		IEnumerator<TKey> IEnumerable<TKey>.GetEnumerator()
		{
			return new Enumerator(_dictionary);
		}

		IEnumerator IEnumerable.GetEnumerator()
		{
			return new Enumerator(_dictionary);
		}

		void ICollection.CopyTo(Array array, int index)
		{
			if (array == null)
			{
				ThrowHelper.ThrowArgumentNullException(ExceptionArgument.array);
			}
			if (array.Rank != 1)
			{
				ThrowHelper.ThrowArgumentException(ExceptionResource.Arg_RankMultiDimNotSupported);
			}
			if (array.GetLowerBound(0) != 0)
			{
				ThrowHelper.ThrowArgumentException(ExceptionResource.Arg_NonZeroLowerBound);
			}
			if ((uint)index > (uint)array.Length)
			{
				ThrowHelper.ThrowIndexArgumentOutOfRange_NeedNonNegNumException();
			}
			if (array.Length - index < _dictionary.Count)
			{
				ThrowHelper.ThrowArgumentException(ExceptionResource.Arg_ArrayPlusOffTooSmall);
			}
			if (array is TKey[] array2)
			{
				CopyTo(array2, index);
				return;
			}
			object[] array3 = array as object[];
			if (array3 == null)
			{
				ThrowHelper.ThrowArgumentException_Argument_InvalidArrayType();
			}
			int count = _dictionary._count;
			Entry[] entries = _dictionary._entries;
			try
			{
				for (int i = 0; i < count; i++)
				{
					if (entries[i].hashCode >= 0)
					{
						array3[index++] = entries[i].key;
					}
				}
			}
			catch (ArrayTypeMismatchException)
			{
				ThrowHelper.ThrowArgumentException_Argument_InvalidArrayType();
			}
		}
	}

	[Serializable]
	[DebuggerTypeProxy(typeof(DictionaryValueCollectionDebugView<, >))]
	[DebuggerDisplay("Count = {Count}")]
	public sealed class ValueCollection : ICollection<TValue>, IEnumerable<TValue>, IEnumerable, ICollection, IReadOnlyCollection<TValue>
	{
		[Serializable]
		public struct Enumerator : IEnumerator<TValue>, IDisposable, IEnumerator
		{
			private Dictionary<TKey, TValue> _dictionary;

			private int _index;

			private int _version;

			private TValue _currentValue;

			public TValue Current => _currentValue;

			object IEnumerator.Current
			{
				get
				{
					if (_index == 0 || _index == _dictionary._count + 1)
					{
						ThrowHelper.ThrowInvalidOperationException_InvalidOperation_EnumOpCantHappen();
					}
					return _currentValue;
				}
			}

			internal Enumerator(Dictionary<TKey, TValue> dictionary)
			{
				_dictionary = dictionary;
				_version = dictionary._version;
				_index = 0;
				_currentValue = default(TValue);
			}

			public void Dispose()
			{
			}

			public bool MoveNext()
			{
				if (_version != _dictionary._version)
				{
					ThrowHelper.ThrowInvalidOperationException_InvalidOperation_EnumFailedVersion();
				}
				while ((uint)_index < (uint)_dictionary._count)
				{
					ref Entry reference = ref _dictionary._entries[_index++];
					if (reference.hashCode >= 0)
					{
						_currentValue = reference.value;
						return true;
					}
				}
				_index = _dictionary._count + 1;
				_currentValue = default(TValue);
				return false;
			}

			void IEnumerator.Reset()
			{
				if (_version != _dictionary._version)
				{
					ThrowHelper.ThrowInvalidOperationException_InvalidOperation_EnumFailedVersion();
				}
				_index = 0;
				_currentValue = default(TValue);
			}
		}

		private Dictionary<TKey, TValue> _dictionary;

		public int Count => _dictionary.Count;

		bool ICollection<TValue>.IsReadOnly => true;

		bool ICollection.IsSynchronized => false;

		object ICollection.SyncRoot => ((ICollection)_dictionary).SyncRoot;

		public ValueCollection(Dictionary<TKey, TValue> dictionary)
		{
			if (dictionary == null)
			{
				ThrowHelper.ThrowArgumentNullException(ExceptionArgument.dictionary);
			}
			_dictionary = dictionary;
		}

		public Enumerator GetEnumerator()
		{
			return new Enumerator(_dictionary);
		}

		public void CopyTo(TValue[] array, int index)
		{
			if (array == null)
			{
				ThrowHelper.ThrowArgumentNullException(ExceptionArgument.array);
			}
			if (index < 0 || index > array.Length)
			{
				ThrowHelper.ThrowIndexArgumentOutOfRange_NeedNonNegNumException();
			}
			if (array.Length - index < _dictionary.Count)
			{
				ThrowHelper.ThrowArgumentException(ExceptionResource.Arg_ArrayPlusOffTooSmall);
			}
			int count = _dictionary._count;
			Entry[] entries = _dictionary._entries;
			for (int i = 0; i < count; i++)
			{
				if (entries[i].hashCode >= 0)
				{
					array[index++] = entries[i].value;
				}
			}
		}

		void ICollection<TValue>.Add(TValue item)
		{
			ThrowHelper.ThrowNotSupportedException(ExceptionResource.NotSupported_ValueCollectionSet);
		}

		bool ICollection<TValue>.Remove(TValue item)
		{
			ThrowHelper.ThrowNotSupportedException(ExceptionResource.NotSupported_ValueCollectionSet);
			return false;
		}

		void ICollection<TValue>.Clear()
		{
			ThrowHelper.ThrowNotSupportedException(ExceptionResource.NotSupported_ValueCollectionSet);
		}

		bool ICollection<TValue>.Contains(TValue item)
		{
			return _dictionary.ContainsValue(item);
		}

		IEnumerator<TValue> IEnumerable<TValue>.GetEnumerator()
		{
			return new Enumerator(_dictionary);
		}

		IEnumerator IEnumerable.GetEnumerator()
		{
			return new Enumerator(_dictionary);
		}

		void ICollection.CopyTo(Array array, int index)
		{
			if (array == null)
			{
				ThrowHelper.ThrowArgumentNullException(ExceptionArgument.array);
			}
			if (array.Rank != 1)
			{
				ThrowHelper.ThrowArgumentException(ExceptionResource.Arg_RankMultiDimNotSupported);
			}
			if (array.GetLowerBound(0) != 0)
			{
				ThrowHelper.ThrowArgumentException(ExceptionResource.Arg_NonZeroLowerBound);
			}
			if ((uint)index > (uint)array.Length)
			{
				ThrowHelper.ThrowIndexArgumentOutOfRange_NeedNonNegNumException();
			}
			if (array.Length - index < _dictionary.Count)
			{
				ThrowHelper.ThrowArgumentException(ExceptionResource.Arg_ArrayPlusOffTooSmall);
			}
			if (array is TValue[] array2)
			{
				CopyTo(array2, index);
				return;
			}
			object[] array3 = array as object[];
			if (array3 == null)
			{
				ThrowHelper.ThrowArgumentException_Argument_InvalidArrayType();
			}
			int count = _dictionary._count;
			Entry[] entries = _dictionary._entries;
			try
			{
				for (int i = 0; i < count; i++)
				{
					if (entries[i].hashCode >= 0)
					{
						array3[index++] = entries[i].value;
					}
				}
			}
			catch (ArrayTypeMismatchException)
			{
				ThrowHelper.ThrowArgumentException_Argument_InvalidArrayType();
			}
		}
	}

	private int[] _buckets;

	private Entry[] _entries;

	private int _count;

	private int _freeList;

	private int _freeCount;

	private int _version;

	private IEqualityComparer<TKey> _comparer;

	private KeyCollection _keys;

	private ValueCollection _values;

	private object _syncRoot;

	private const string VersionName = "Version";

	private const string HashSizeName = "HashSize";

	private const string KeyValuePairsName = "KeyValuePairs";

	private const string ComparerName = "Comparer";

	public IEqualityComparer<TKey> Comparer
	{
		get
		{
			if (_comparer != null)
			{
				return _comparer;
			}
			return EqualityComparer<TKey>.Default;
		}
	}

	public int Count => _count - _freeCount;

	public KeyCollection Keys
	{
		get
		{
			if (_keys == null)
			{
				_keys = new KeyCollection(this);
			}
			return _keys;
		}
	}

	ICollection<TKey> IDictionary<TKey, TValue>.Keys
	{
		get
		{
			if (_keys == null)
			{
				_keys = new KeyCollection(this);
			}
			return _keys;
		}
	}

	IEnumerable<TKey> IReadOnlyDictionary<TKey, TValue>.Keys
	{
		get
		{
			if (_keys == null)
			{
				_keys = new KeyCollection(this);
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
				_values = new ValueCollection(this);
			}
			return _values;
		}
	}

	ICollection<TValue> IDictionary<TKey, TValue>.Values
	{
		get
		{
			if (_values == null)
			{
				_values = new ValueCollection(this);
			}
			return _values;
		}
	}

	IEnumerable<TValue> IReadOnlyDictionary<TKey, TValue>.Values
	{
		get
		{
			if (_values == null)
			{
				_values = new ValueCollection(this);
			}
			return _values;
		}
	}

	public TValue this[TKey key]
	{
		get
		{
			int num = FindEntry(key);
			if (num >= 0)
			{
				return _entries[num].value;
			}
			ThrowHelper.ThrowKeyNotFoundException(key);
			return default(TValue);
		}
		set
		{
			TryInsert(key, value, InsertionBehavior.OverwriteExisting);
		}
	}

	bool ICollection<KeyValuePair<TKey, TValue>>.IsReadOnly => false;

	bool ICollection.IsSynchronized => false;

	object ICollection.SyncRoot
	{
		get
		{
			if (_syncRoot == null)
			{
				Interlocked.CompareExchange<object>(ref _syncRoot, new object(), (object)null);
			}
			return _syncRoot;
		}
	}

	bool IDictionary.IsFixedSize => false;

	bool IDictionary.IsReadOnly => false;

	ICollection IDictionary.Keys => Keys;

	ICollection IDictionary.Values => Values;

	object IDictionary.this[object key]
	{
		get
		{
			if (IsCompatibleKey(key))
			{
				int num = FindEntry((TKey)key);
				if (num >= 0)
				{
					return _entries[num].value;
				}
			}
			return null;
		}
		set
		{
			if (key == null)
			{
				ThrowHelper.ThrowArgumentNullException(ExceptionArgument.key);
			}
			ThrowHelper.IfNullAndNullsAreIllegalThenThrow<TValue>(value, ExceptionArgument.value);
			try
			{
				TKey key2 = (TKey)key;
				try
				{
					this[key2] = (TValue)value;
				}
				catch (InvalidCastException)
				{
					ThrowHelper.ThrowWrongValueTypeArgumentException(value, typeof(TValue));
				}
			}
			catch (InvalidCastException)
			{
				ThrowHelper.ThrowWrongKeyTypeArgumentException(key, typeof(TKey));
			}
		}
	}

	public Dictionary()
		: this(0, (IEqualityComparer<TKey>)null)
	{
	}

	public Dictionary(int capacity)
		: this(capacity, (IEqualityComparer<TKey>)null)
	{
	}

	public Dictionary(IEqualityComparer<TKey> comparer)
		: this(0, comparer)
	{
	}

	public Dictionary(int capacity, IEqualityComparer<TKey> comparer)
	{
		if (capacity < 0)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.capacity);
		}
		if (capacity > 0)
		{
			Initialize(capacity);
		}
		if (comparer != EqualityComparer<TKey>.Default)
		{
			_comparer = comparer;
		}
	}

	public Dictionary(IDictionary<TKey, TValue> dictionary)
		: this(dictionary, (IEqualityComparer<TKey>)null)
	{
	}

	public Dictionary(IDictionary<TKey, TValue> dictionary, IEqualityComparer<TKey> comparer)
		: this(dictionary?.Count ?? 0, comparer)
	{
		if (dictionary == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.dictionary);
		}
		if (dictionary.GetType() == typeof(Dictionary<TKey, TValue>))
		{
			Dictionary<TKey, TValue> obj = (Dictionary<TKey, TValue>)dictionary;
			int count = obj._count;
			Entry[] entries = obj._entries;
			for (int i = 0; i < count; i++)
			{
				if (entries[i].hashCode >= 0)
				{
					Add(entries[i].key, entries[i].value);
				}
			}
			return;
		}
		foreach (KeyValuePair<TKey, TValue> item in dictionary)
		{
			Add(item.Key, item.Value);
		}
	}

	public Dictionary(IEnumerable<KeyValuePair<TKey, TValue>> collection)
		: this(collection, (IEqualityComparer<TKey>)null)
	{
	}

	public Dictionary(IEnumerable<KeyValuePair<TKey, TValue>> collection, IEqualityComparer<TKey> comparer)
		: this((collection as ICollection<KeyValuePair<TKey, TValue>>)?.Count ?? 0, comparer)
	{
		if (collection == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.collection);
		}
		foreach (KeyValuePair<TKey, TValue> item in collection)
		{
			Add(item.Key, item.Value);
		}
	}

	protected Dictionary(SerializationInfo info, StreamingContext context)
	{
		HashHelpers.SerializationInfoTable.Add(this, info);
	}

	public void Add(TKey key, TValue value)
	{
		TryInsert(key, value, InsertionBehavior.ThrowOnExisting);
	}

	void ICollection<KeyValuePair<TKey, TValue>>.Add(KeyValuePair<TKey, TValue> keyValuePair)
	{
		Add(keyValuePair.Key, keyValuePair.Value);
	}

	bool ICollection<KeyValuePair<TKey, TValue>>.Contains(KeyValuePair<TKey, TValue> keyValuePair)
	{
		int num = FindEntry(keyValuePair.Key);
		if (num >= 0 && EqualityComparer<TValue>.Default.Equals(_entries[num].value, keyValuePair.Value))
		{
			return true;
		}
		return false;
	}

	bool ICollection<KeyValuePair<TKey, TValue>>.Remove(KeyValuePair<TKey, TValue> keyValuePair)
	{
		int num = FindEntry(keyValuePair.Key);
		if (num >= 0 && EqualityComparer<TValue>.Default.Equals(_entries[num].value, keyValuePair.Value))
		{
			Remove(keyValuePair.Key);
			return true;
		}
		return false;
	}

	public void Clear()
	{
		int count = _count;
		if (count > 0)
		{
			Array.Clear(_buckets, 0, _buckets.Length);
			_count = 0;
			_freeList = -1;
			_freeCount = 0;
			Array.Clear(_entries, 0, count);
		}
		_version++;
	}

	public bool ContainsKey(TKey key)
	{
		return FindEntry(key) >= 0;
	}

	public bool ContainsValue(TValue value)
	{
		Entry[] entries = _entries;
		if (value == null)
		{
			for (int i = 0; i < _count; i++)
			{
				if (entries[i].hashCode >= 0 && entries[i].value == null)
				{
					return true;
				}
			}
		}
		else if (default(TValue) != null)
		{
			for (int j = 0; j < _count; j++)
			{
				if (entries[j].hashCode >= 0 && EqualityComparer<TValue>.Default.Equals(entries[j].value, value))
				{
					return true;
				}
			}
		}
		else
		{
			EqualityComparer<TValue> equalityComparer = EqualityComparer<TValue>.Default;
			for (int k = 0; k < _count; k++)
			{
				if (entries[k].hashCode >= 0 && equalityComparer.Equals(entries[k].value, value))
				{
					return true;
				}
			}
		}
		return false;
	}

	private void CopyTo(KeyValuePair<TKey, TValue>[] array, int index)
	{
		if (array == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.array);
		}
		if ((uint)index > (uint)array.Length)
		{
			ThrowHelper.ThrowIndexArgumentOutOfRange_NeedNonNegNumException();
		}
		if (array.Length - index < Count)
		{
			ThrowHelper.ThrowArgumentException(ExceptionResource.Arg_ArrayPlusOffTooSmall);
		}
		int count = _count;
		Entry[] entries = _entries;
		for (int i = 0; i < count; i++)
		{
			if (entries[i].hashCode >= 0)
			{
				array[index++] = new KeyValuePair<TKey, TValue>(entries[i].key, entries[i].value);
			}
		}
	}

	public Enumerator GetEnumerator()
	{
		return new Enumerator(this, 2);
	}

	IEnumerator<KeyValuePair<TKey, TValue>> IEnumerable<KeyValuePair<TKey, TValue>>.GetEnumerator()
	{
		return new Enumerator(this, 2);
	}

	public virtual void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.info);
		}
		info.AddValue("Version", _version);
		info.AddValue("Comparer", _comparer ?? EqualityComparer<TKey>.Default, typeof(IEqualityComparer<TKey>));
		info.AddValue("HashSize", (_buckets != null) ? _buckets.Length : 0);
		if (_buckets != null)
		{
			KeyValuePair<TKey, TValue>[] array = new KeyValuePair<TKey, TValue>[Count];
			CopyTo(array, 0);
			info.AddValue("KeyValuePairs", array, typeof(KeyValuePair<TKey, TValue>[]));
		}
	}

	private int FindEntry(TKey key)
	{
		if (key == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.key);
		}
		int num = -1;
		int[] buckets = _buckets;
		Entry[] entries = _entries;
		int num2 = 0;
		if (buckets != null)
		{
			IEqualityComparer<TKey> comparer = _comparer;
			if (comparer == null)
			{
				int num3 = key.GetHashCode() & 0x7FFFFFFF;
				num = buckets[num3 % buckets.Length] - 1;
				if (default(TKey) != null)
				{
					while ((uint)num < (uint)entries.Length && (entries[num].hashCode != num3 || !EqualityComparer<TKey>.Default.Equals(entries[num].key, key)))
					{
						num = entries[num].next;
						if (num2 >= entries.Length)
						{
							ThrowHelper.ThrowInvalidOperationException_ConcurrentOperationsNotSupported();
						}
						num2++;
					}
				}
				else
				{
					EqualityComparer<TKey> equalityComparer = EqualityComparer<TKey>.Default;
					while ((uint)num < (uint)entries.Length && (entries[num].hashCode != num3 || !equalityComparer.Equals(entries[num].key, key)))
					{
						num = entries[num].next;
						if (num2 >= entries.Length)
						{
							ThrowHelper.ThrowInvalidOperationException_ConcurrentOperationsNotSupported();
						}
						num2++;
					}
				}
			}
			else
			{
				int num4 = comparer.GetHashCode(key) & 0x7FFFFFFF;
				num = buckets[num4 % buckets.Length] - 1;
				while ((uint)num < (uint)entries.Length && (entries[num].hashCode != num4 || !comparer.Equals(entries[num].key, key)))
				{
					num = entries[num].next;
					if (num2 >= entries.Length)
					{
						ThrowHelper.ThrowInvalidOperationException_ConcurrentOperationsNotSupported();
					}
					num2++;
				}
			}
		}
		return num;
	}

	private int Initialize(int capacity)
	{
		int prime = HashHelpers.GetPrime(capacity);
		_freeList = -1;
		_buckets = new int[prime];
		_entries = new Entry[prime];
		return prime;
	}

	private bool TryInsert(TKey key, TValue value, InsertionBehavior behavior)
	{
		if (key == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.key);
		}
		_version++;
		if (_buckets == null)
		{
			Initialize(0);
		}
		Entry[] entries = _entries;
		IEqualityComparer<TKey> comparer = _comparer;
		int num = (comparer?.GetHashCode(key) ?? key.GetHashCode()) & 0x7FFFFFFF;
		int num2 = 0;
		ref int reference = ref _buckets[num % _buckets.Length];
		int num3 = reference - 1;
		if (comparer == null)
		{
			if (default(TKey) != null)
			{
				while ((uint)num3 < (uint)entries.Length)
				{
					if (entries[num3].hashCode == num && EqualityComparer<TKey>.Default.Equals(entries[num3].key, key))
					{
						switch (behavior)
						{
						case InsertionBehavior.OverwriteExisting:
							entries[num3].value = value;
							return true;
						case InsertionBehavior.ThrowOnExisting:
							ThrowHelper.ThrowAddingDuplicateWithKeyArgumentException(key);
							break;
						}
						return false;
					}
					num3 = entries[num3].next;
					if (num2 >= entries.Length)
					{
						ThrowHelper.ThrowInvalidOperationException_ConcurrentOperationsNotSupported();
					}
					num2++;
				}
			}
			else
			{
				EqualityComparer<TKey> equalityComparer = EqualityComparer<TKey>.Default;
				while ((uint)num3 < (uint)entries.Length)
				{
					if (entries[num3].hashCode == num && equalityComparer.Equals(entries[num3].key, key))
					{
						switch (behavior)
						{
						case InsertionBehavior.OverwriteExisting:
							entries[num3].value = value;
							return true;
						case InsertionBehavior.ThrowOnExisting:
							ThrowHelper.ThrowAddingDuplicateWithKeyArgumentException(key);
							break;
						}
						return false;
					}
					num3 = entries[num3].next;
					if (num2 >= entries.Length)
					{
						ThrowHelper.ThrowInvalidOperationException_ConcurrentOperationsNotSupported();
					}
					num2++;
				}
			}
		}
		else
		{
			while ((uint)num3 < (uint)entries.Length)
			{
				if (entries[num3].hashCode == num && comparer.Equals(entries[num3].key, key))
				{
					switch (behavior)
					{
					case InsertionBehavior.OverwriteExisting:
						entries[num3].value = value;
						return true;
					case InsertionBehavior.ThrowOnExisting:
						ThrowHelper.ThrowAddingDuplicateWithKeyArgumentException(key);
						break;
					}
					return false;
				}
				num3 = entries[num3].next;
				if (num2 >= entries.Length)
				{
					ThrowHelper.ThrowInvalidOperationException_ConcurrentOperationsNotSupported();
				}
				num2++;
			}
		}
		bool flag = false;
		bool flag2 = false;
		int num4;
		if (_freeCount > 0)
		{
			num4 = _freeList;
			flag2 = true;
			_freeCount--;
		}
		else
		{
			int count = _count;
			if (count == entries.Length)
			{
				Resize();
				flag = true;
			}
			num4 = count;
			_count = count + 1;
			entries = _entries;
		}
		ref int reference2 = ref flag ? ref _buckets[num % _buckets.Length] : ref reference;
		ref Entry reference3 = ref entries[num4];
		if (flag2)
		{
			_freeList = reference3.next;
		}
		reference3.hashCode = num;
		reference3.next = reference2 - 1;
		reference3.key = key;
		reference3.value = value;
		reference2 = num4 + 1;
		return true;
	}

	public virtual void OnDeserialization(object sender)
	{
		HashHelpers.SerializationInfoTable.TryGetValue(this, out var value);
		if (value == null)
		{
			return;
		}
		int @int = value.GetInt32("Version");
		int int2 = value.GetInt32("HashSize");
		_comparer = (IEqualityComparer<TKey>)value.GetValue("Comparer", typeof(IEqualityComparer<TKey>));
		if (int2 != 0)
		{
			Initialize(int2);
			KeyValuePair<TKey, TValue>[] array = (KeyValuePair<TKey, TValue>[])value.GetValue("KeyValuePairs", typeof(KeyValuePair<TKey, TValue>[]));
			if (array == null)
			{
				ThrowHelper.ThrowSerializationException(ExceptionResource.Serialization_MissingKeys);
			}
			for (int i = 0; i < array.Length; i++)
			{
				if (array[i].Key == null)
				{
					ThrowHelper.ThrowSerializationException(ExceptionResource.Serialization_NullKey);
				}
				Add(array[i].Key, array[i].Value);
			}
		}
		else
		{
			_buckets = null;
		}
		_version = @int;
		HashHelpers.SerializationInfoTable.Remove(this);
	}

	private void Resize()
	{
		Resize(HashHelpers.ExpandPrime(_count), forceNewHashCodes: false);
	}

	private void Resize(int newSize, bool forceNewHashCodes)
	{
		int[] array = new int[newSize];
		Entry[] array2 = new Entry[newSize];
		int count = _count;
		Array.Copy(_entries, 0, array2, 0, count);
		if ((default(TKey) == null) & forceNewHashCodes)
		{
			for (int i = 0; i < count; i++)
			{
				if (array2[i].hashCode >= 0)
				{
					array2[i].hashCode = array2[i].key.GetHashCode() & 0x7FFFFFFF;
				}
			}
		}
		for (int j = 0; j < count; j++)
		{
			if (array2[j].hashCode >= 0)
			{
				int num = array2[j].hashCode % newSize;
				array2[j].next = array[num] - 1;
				array[num] = j + 1;
			}
		}
		_buckets = array;
		_entries = array2;
	}

	public bool Remove(TKey key)
	{
		if (key == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.key);
		}
		if (_buckets != null)
		{
			int num = (_comparer?.GetHashCode(key) ?? key.GetHashCode()) & 0x7FFFFFFF;
			int num2 = num % _buckets.Length;
			int num3 = -1;
			int num4 = _buckets[num2] - 1;
			while (num4 >= 0)
			{
				ref Entry reference = ref _entries[num4];
				if (reference.hashCode == num && (_comparer?.Equals(reference.key, key) ?? EqualityComparer<TKey>.Default.Equals(reference.key, key)))
				{
					if (num3 < 0)
					{
						_buckets[num2] = reference.next + 1;
					}
					else
					{
						_entries[num3].next = reference.next;
					}
					reference.hashCode = -1;
					reference.next = _freeList;
					if (RuntimeHelpers.IsReferenceOrContainsReferences<TKey>())
					{
						reference.key = default(TKey);
					}
					if (RuntimeHelpers.IsReferenceOrContainsReferences<TValue>())
					{
						reference.value = default(TValue);
					}
					_freeList = num4;
					_freeCount++;
					_version++;
					return true;
				}
				num3 = num4;
				num4 = reference.next;
			}
		}
		return false;
	}

	public bool Remove(TKey key, out TValue value)
	{
		if (key == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.key);
		}
		if (_buckets != null)
		{
			int num = (_comparer?.GetHashCode(key) ?? key.GetHashCode()) & 0x7FFFFFFF;
			int num2 = num % _buckets.Length;
			int num3 = -1;
			int num4 = _buckets[num2] - 1;
			while (num4 >= 0)
			{
				ref Entry reference = ref _entries[num4];
				if (reference.hashCode == num && (_comparer?.Equals(reference.key, key) ?? EqualityComparer<TKey>.Default.Equals(reference.key, key)))
				{
					if (num3 < 0)
					{
						_buckets[num2] = reference.next + 1;
					}
					else
					{
						_entries[num3].next = reference.next;
					}
					value = reference.value;
					reference.hashCode = -1;
					reference.next = _freeList;
					if (RuntimeHelpers.IsReferenceOrContainsReferences<TKey>())
					{
						reference.key = default(TKey);
					}
					if (RuntimeHelpers.IsReferenceOrContainsReferences<TValue>())
					{
						reference.value = default(TValue);
					}
					_freeList = num4;
					_freeCount++;
					_version++;
					return true;
				}
				num3 = num4;
				num4 = reference.next;
			}
		}
		value = default(TValue);
		return false;
	}

	public bool TryGetValue(TKey key, out TValue value)
	{
		int num = FindEntry(key);
		if (num >= 0)
		{
			value = _entries[num].value;
			return true;
		}
		value = default(TValue);
		return false;
	}

	public bool TryAdd(TKey key, TValue value)
	{
		return TryInsert(key, value, InsertionBehavior.None);
	}

	void ICollection<KeyValuePair<TKey, TValue>>.CopyTo(KeyValuePair<TKey, TValue>[] array, int index)
	{
		CopyTo(array, index);
	}

	void ICollection.CopyTo(Array array, int index)
	{
		if (array == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.array);
		}
		if (array.Rank != 1)
		{
			ThrowHelper.ThrowArgumentException(ExceptionResource.Arg_RankMultiDimNotSupported);
		}
		if (array.GetLowerBound(0) != 0)
		{
			ThrowHelper.ThrowArgumentException(ExceptionResource.Arg_NonZeroLowerBound);
		}
		if ((uint)index > (uint)array.Length)
		{
			ThrowHelper.ThrowIndexArgumentOutOfRange_NeedNonNegNumException();
		}
		if (array.Length - index < Count)
		{
			ThrowHelper.ThrowArgumentException(ExceptionResource.Arg_ArrayPlusOffTooSmall);
		}
		if (array is KeyValuePair<TKey, TValue>[] array2)
		{
			CopyTo(array2, index);
			return;
		}
		if (array is DictionaryEntry[] array3)
		{
			Entry[] entries = _entries;
			for (int i = 0; i < _count; i++)
			{
				if (entries[i].hashCode >= 0)
				{
					array3[index++] = new DictionaryEntry(entries[i].key, entries[i].value);
				}
			}
			return;
		}
		object[] array4 = array as object[];
		if (array4 == null)
		{
			ThrowHelper.ThrowArgumentException_Argument_InvalidArrayType();
		}
		try
		{
			int count = _count;
			Entry[] entries2 = _entries;
			for (int j = 0; j < count; j++)
			{
				if (entries2[j].hashCode >= 0)
				{
					array4[index++] = new KeyValuePair<TKey, TValue>(entries2[j].key, entries2[j].value);
				}
			}
		}
		catch (ArrayTypeMismatchException)
		{
			ThrowHelper.ThrowArgumentException_Argument_InvalidArrayType();
		}
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return new Enumerator(this, 2);
	}

	public int EnsureCapacity(int capacity)
	{
		if (capacity < 0)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.capacity);
		}
		int num = ((_entries != null) ? _entries.Length : 0);
		if (num >= capacity)
		{
			return num;
		}
		if (_buckets == null)
		{
			return Initialize(capacity);
		}
		int prime = HashHelpers.GetPrime(capacity);
		Resize(prime, forceNewHashCodes: false);
		return prime;
	}

	public void TrimExcess()
	{
		TrimExcess(Count);
	}

	public void TrimExcess(int capacity)
	{
		if (capacity < Count)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.capacity);
		}
		int prime = HashHelpers.GetPrime(capacity);
		Entry[] entries = _entries;
		int num = ((entries != null) ? entries.Length : 0);
		if (prime >= num)
		{
			return;
		}
		int count = _count;
		Initialize(prime);
		Entry[] entries2 = _entries;
		int[] buckets = _buckets;
		int num2 = 0;
		for (int i = 0; i < count; i++)
		{
			int hashCode = entries[i].hashCode;
			if (hashCode >= 0)
			{
				ref Entry reference = ref entries2[num2];
				reference = entries[i];
				int num3 = hashCode % prime;
				reference.next = buckets[num3] - 1;
				buckets[num3] = num2 + 1;
				num2++;
			}
		}
		_count = num2;
		_freeCount = 0;
	}

	private static bool IsCompatibleKey(object key)
	{
		if (key == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.key);
		}
		return key is TKey;
	}

	void IDictionary.Add(object key, object value)
	{
		if (key == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.key);
		}
		ThrowHelper.IfNullAndNullsAreIllegalThenThrow<TValue>(value, ExceptionArgument.value);
		try
		{
			TKey key2 = (TKey)key;
			try
			{
				Add(key2, (TValue)value);
			}
			catch (InvalidCastException)
			{
				ThrowHelper.ThrowWrongValueTypeArgumentException(value, typeof(TValue));
			}
		}
		catch (InvalidCastException)
		{
			ThrowHelper.ThrowWrongKeyTypeArgumentException(key, typeof(TKey));
		}
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
		return new Enumerator(this, 1);
	}

	void IDictionary.Remove(object key)
	{
		if (IsCompatibleKey(key))
		{
			Remove((TKey)key);
		}
	}
}
