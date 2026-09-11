using System.Diagnostics;
using System.Globalization;
using System.Runtime.CompilerServices;
using System.Threading;

namespace System.Collections;

[Serializable]
[DebuggerTypeProxy(typeof(SortedListDebugView))]
[DebuggerDisplay("Count = {Count}")]
public class SortedList : IDictionary, ICollection, IEnumerable, ICloneable
{
	[Serializable]
	private class SyncSortedList : SortedList
	{
		private SortedList _list;

		private object _root;

		public override int Count
		{
			get
			{
				lock (_root)
				{
					return _list.Count;
				}
			}
		}

		public override object SyncRoot => _root;

		public override bool IsReadOnly => _list.IsReadOnly;

		public override bool IsFixedSize => _list.IsFixedSize;

		public override bool IsSynchronized => true;

		public override object this[object key]
		{
			get
			{
				lock (_root)
				{
					return _list[key];
				}
			}
			set
			{
				lock (_root)
				{
					_list[key] = value;
				}
			}
		}

		internal SyncSortedList(SortedList list)
		{
			_list = list;
			_root = list.SyncRoot;
		}

		public override void Add(object key, object value)
		{
			lock (_root)
			{
				_list.Add(key, value);
			}
		}

		public override void Clear()
		{
			lock (_root)
			{
				_list.Clear();
			}
		}

		public override object Clone()
		{
			lock (_root)
			{
				return _list.Clone();
			}
		}

		public override bool Contains(object key)
		{
			lock (_root)
			{
				return _list.Contains(key);
			}
		}

		public override bool ContainsKey(object key)
		{
			lock (_root)
			{
				return _list.ContainsKey(key);
			}
		}

		public override bool ContainsValue(object key)
		{
			lock (_root)
			{
				return _list.ContainsValue(key);
			}
		}

		public override void CopyTo(Array array, int index)
		{
			lock (_root)
			{
				_list.CopyTo(array, index);
			}
		}

		public override object GetByIndex(int index)
		{
			lock (_root)
			{
				return _list.GetByIndex(index);
			}
		}

		public override IDictionaryEnumerator GetEnumerator()
		{
			lock (_root)
			{
				return _list.GetEnumerator();
			}
		}

		public override object GetKey(int index)
		{
			lock (_root)
			{
				return _list.GetKey(index);
			}
		}

		public override IList GetKeyList()
		{
			lock (_root)
			{
				return _list.GetKeyList();
			}
		}

		public override IList GetValueList()
		{
			lock (_root)
			{
				return _list.GetValueList();
			}
		}

		public override int IndexOfKey(object key)
		{
			if (key == null)
			{
				throw new ArgumentNullException("key", "Key cannot be null.");
			}
			lock (_root)
			{
				return _list.IndexOfKey(key);
			}
		}

		public override int IndexOfValue(object value)
		{
			lock (_root)
			{
				return _list.IndexOfValue(value);
			}
		}

		public override void RemoveAt(int index)
		{
			lock (_root)
			{
				_list.RemoveAt(index);
			}
		}

		public override void Remove(object key)
		{
			lock (_root)
			{
				_list.Remove(key);
			}
		}
	}

	[Serializable]
	private class SortedListEnumerator : IDictionaryEnumerator, IEnumerator, ICloneable
	{
		private SortedList _sortedList;

		private object _key;

		private object _value;

		private int _index;

		private int _startIndex;

		private int _endIndex;

		private int _version;

		private bool _current;

		private int _getObjectRetType;

		public virtual object Key
		{
			get
			{
				if (_version != _sortedList.version)
				{
					throw new InvalidOperationException("Collection was modified; enumeration operation may not execute.");
				}
				if (!_current)
				{
					throw new InvalidOperationException("Enumeration has either not started or has already finished.");
				}
				return _key;
			}
		}

		public virtual DictionaryEntry Entry
		{
			get
			{
				if (_version != _sortedList.version)
				{
					throw new InvalidOperationException("Collection was modified; enumeration operation may not execute.");
				}
				if (!_current)
				{
					throw new InvalidOperationException("Enumeration has either not started or has already finished.");
				}
				return new DictionaryEntry(_key, _value);
			}
		}

		public virtual object Current
		{
			get
			{
				if (!_current)
				{
					throw new InvalidOperationException("Enumeration has either not started or has already finished.");
				}
				if (_getObjectRetType == 1)
				{
					return _key;
				}
				if (_getObjectRetType == 2)
				{
					return _value;
				}
				return new DictionaryEntry(_key, _value);
			}
		}

		public virtual object Value
		{
			get
			{
				if (_version != _sortedList.version)
				{
					throw new InvalidOperationException("Collection was modified; enumeration operation may not execute.");
				}
				if (!_current)
				{
					throw new InvalidOperationException("Enumeration has either not started or has already finished.");
				}
				return _value;
			}
		}

		internal SortedListEnumerator(SortedList sortedList, int index, int count, int getObjRetType)
		{
			_sortedList = sortedList;
			_index = index;
			_startIndex = index;
			_endIndex = index + count;
			_version = sortedList.version;
			_getObjectRetType = getObjRetType;
			_current = false;
		}

		public object Clone()
		{
			return MemberwiseClone();
		}

		public virtual bool MoveNext()
		{
			if (_version != _sortedList.version)
			{
				throw new InvalidOperationException("Collection was modified; enumeration operation may not execute.");
			}
			if (_index < _endIndex)
			{
				_key = _sortedList.keys[_index];
				_value = _sortedList.values[_index];
				_index++;
				_current = true;
				return true;
			}
			_key = null;
			_value = null;
			_current = false;
			return false;
		}

		public virtual void Reset()
		{
			if (_version != _sortedList.version)
			{
				throw new InvalidOperationException("Collection was modified; enumeration operation may not execute.");
			}
			_index = _startIndex;
			_current = false;
			_key = null;
			_value = null;
		}
	}

	[Serializable]
	[TypeForwardedFrom("mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089")]
	private class KeyList : IList, ICollection, IEnumerable
	{
		private SortedList sortedList;

		public virtual int Count => sortedList._size;

		public virtual bool IsReadOnly => true;

		public virtual bool IsFixedSize => true;

		public virtual bool IsSynchronized => sortedList.IsSynchronized;

		public virtual object SyncRoot => sortedList.SyncRoot;

		public virtual object this[int index]
		{
			get
			{
				return sortedList.GetKey(index);
			}
			set
			{
				throw new NotSupportedException("Mutating a key collection derived from a dictionary is not allowed.");
			}
		}

		internal KeyList(SortedList sortedList)
		{
			this.sortedList = sortedList;
		}

		public virtual int Add(object key)
		{
			throw new NotSupportedException("This operation is not supported on SortedList nested types because they require modifying the original SortedList.");
		}

		public virtual void Clear()
		{
			throw new NotSupportedException("This operation is not supported on SortedList nested types because they require modifying the original SortedList.");
		}

		public virtual bool Contains(object key)
		{
			return sortedList.Contains(key);
		}

		public virtual void CopyTo(Array array, int arrayIndex)
		{
			if (array != null && array.Rank != 1)
			{
				throw new ArgumentException("Only single dimensional arrays are supported for the requested action.", "array");
			}
			Array.Copy(sortedList.keys, 0, array, arrayIndex, sortedList.Count);
		}

		public virtual void Insert(int index, object value)
		{
			throw new NotSupportedException("This operation is not supported on SortedList nested types because they require modifying the original SortedList.");
		}

		public virtual IEnumerator GetEnumerator()
		{
			return new SortedListEnumerator(sortedList, 0, sortedList.Count, 1);
		}

		public virtual int IndexOf(object key)
		{
			if (key == null)
			{
				throw new ArgumentNullException("key", "Key cannot be null.");
			}
			int num = Array.BinarySearch(sortedList.keys, 0, sortedList.Count, key, sortedList.comparer);
			if (num >= 0)
			{
				return num;
			}
			return -1;
		}

		public virtual void Remove(object key)
		{
			throw new NotSupportedException("This operation is not supported on SortedList nested types because they require modifying the original SortedList.");
		}

		public virtual void RemoveAt(int index)
		{
			throw new NotSupportedException("This operation is not supported on SortedList nested types because they require modifying the original SortedList.");
		}
	}

	[Serializable]
	[TypeForwardedFrom("mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089")]
	private class ValueList : IList, ICollection, IEnumerable
	{
		private SortedList sortedList;

		public virtual int Count => sortedList._size;

		public virtual bool IsReadOnly => true;

		public virtual bool IsFixedSize => true;

		public virtual bool IsSynchronized => sortedList.IsSynchronized;

		public virtual object SyncRoot => sortedList.SyncRoot;

		public virtual object this[int index]
		{
			get
			{
				return sortedList.GetByIndex(index);
			}
			set
			{
				throw new NotSupportedException("This operation is not supported on SortedList nested types because they require modifying the original SortedList.");
			}
		}

		internal ValueList(SortedList sortedList)
		{
			this.sortedList = sortedList;
		}

		public virtual int Add(object key)
		{
			throw new NotSupportedException("This operation is not supported on SortedList nested types because they require modifying the original SortedList.");
		}

		public virtual void Clear()
		{
			throw new NotSupportedException("This operation is not supported on SortedList nested types because they require modifying the original SortedList.");
		}

		public virtual bool Contains(object value)
		{
			return sortedList.ContainsValue(value);
		}

		public virtual void CopyTo(Array array, int arrayIndex)
		{
			if (array != null && array.Rank != 1)
			{
				throw new ArgumentException("Only single dimensional arrays are supported for the requested action.", "array");
			}
			Array.Copy(sortedList.values, 0, array, arrayIndex, sortedList.Count);
		}

		public virtual void Insert(int index, object value)
		{
			throw new NotSupportedException("This operation is not supported on SortedList nested types because they require modifying the original SortedList.");
		}

		public virtual IEnumerator GetEnumerator()
		{
			return new SortedListEnumerator(sortedList, 0, sortedList.Count, 2);
		}

		public virtual int IndexOf(object value)
		{
			return Array.IndexOf(sortedList.values, value, 0, sortedList.Count);
		}

		public virtual void Remove(object value)
		{
			throw new NotSupportedException("This operation is not supported on SortedList nested types because they require modifying the original SortedList.");
		}

		public virtual void RemoveAt(int index)
		{
			throw new NotSupportedException("This operation is not supported on SortedList nested types because they require modifying the original SortedList.");
		}
	}

	internal class SortedListDebugView
	{
	}

	private object[] keys;

	private object[] values;

	private int _size;

	private int version;

	private IComparer comparer;

	private KeyList keyList;

	private ValueList valueList;

	[NonSerialized]
	private object _syncRoot;

	public virtual int Capacity
	{
		set
		{
			if (value < Count)
			{
				throw new ArgumentOutOfRangeException("value", "capacity was less than the current size.");
			}
			if (value == keys.Length)
			{
				return;
			}
			if (value > 0)
			{
				object[] destinationArray = new object[value];
				object[] destinationArray2 = new object[value];
				if (_size > 0)
				{
					Array.Copy(keys, 0, destinationArray, 0, _size);
					Array.Copy(values, 0, destinationArray2, 0, _size);
				}
				keys = destinationArray;
				values = destinationArray2;
			}
			else
			{
				keys = Array.Empty<object>();
				values = Array.Empty<object>();
			}
		}
	}

	public virtual int Count => _size;

	public virtual ICollection Keys => GetKeyList();

	public virtual ICollection Values => GetValueList();

	public virtual bool IsReadOnly => false;

	public virtual bool IsFixedSize => false;

	public virtual bool IsSynchronized => false;

	public virtual object SyncRoot
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

	public virtual object this[object key]
	{
		get
		{
			int num = IndexOfKey(key);
			if (num >= 0)
			{
				return values[num];
			}
			return null;
		}
		set
		{
			if (key == null)
			{
				throw new ArgumentNullException("key", "Key cannot be null.");
			}
			int num = Array.BinarySearch(keys, 0, _size, key, comparer);
			if (num >= 0)
			{
				values[num] = value;
				version++;
			}
			else
			{
				Insert(~num, key, value);
			}
		}
	}

	public SortedList()
	{
		Init();
	}

	private void Init()
	{
		keys = Array.Empty<object>();
		values = Array.Empty<object>();
		_size = 0;
		comparer = new Comparer(CultureInfo.CurrentCulture);
	}

	public SortedList(int initialCapacity)
	{
		if (initialCapacity < 0)
		{
			throw new ArgumentOutOfRangeException("initialCapacity", "Non-negative number required.");
		}
		keys = new object[initialCapacity];
		values = new object[initialCapacity];
		comparer = new Comparer(CultureInfo.CurrentCulture);
	}

	public SortedList(IComparer comparer)
		: this()
	{
		if (comparer != null)
		{
			this.comparer = comparer;
		}
	}

	public virtual void Add(object key, object value)
	{
		if (key == null)
		{
			throw new ArgumentNullException("key", "Key cannot be null.");
		}
		int num = Array.BinarySearch(keys, 0, _size, key, comparer);
		if (num >= 0)
		{
			throw new ArgumentException(SR.Format("Item has already been added. Key in dictionary: '{0}'  Key being added: '{1}'", GetKey(num), key));
		}
		Insert(~num, key, value);
	}

	public virtual void Clear()
	{
		version++;
		Array.Clear(keys, 0, _size);
		Array.Clear(values, 0, _size);
		_size = 0;
	}

	public virtual object Clone()
	{
		SortedList sortedList = new SortedList(_size);
		Array.Copy(keys, 0, sortedList.keys, 0, _size);
		Array.Copy(values, 0, sortedList.values, 0, _size);
		sortedList._size = _size;
		sortedList.version = version;
		sortedList.comparer = comparer;
		return sortedList;
	}

	public virtual bool Contains(object key)
	{
		return IndexOfKey(key) >= 0;
	}

	public virtual bool ContainsKey(object key)
	{
		return IndexOfKey(key) >= 0;
	}

	public virtual bool ContainsValue(object value)
	{
		return IndexOfValue(value) >= 0;
	}

	public virtual void CopyTo(Array array, int arrayIndex)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array", "Array cannot be null.");
		}
		if (array.Rank != 1)
		{
			throw new ArgumentException("Only single dimensional arrays are supported for the requested action.", "array");
		}
		if (arrayIndex < 0)
		{
			throw new ArgumentOutOfRangeException("arrayIndex", "Non-negative number required.");
		}
		if (array.Length - arrayIndex < Count)
		{
			throw new ArgumentException("Destination array is not long enough to copy all the items in the collection. Check array index and length.");
		}
		for (int i = 0; i < Count; i++)
		{
			DictionaryEntry dictionaryEntry = new DictionaryEntry(keys[i], values[i]);
			array.SetValue(dictionaryEntry, i + arrayIndex);
		}
	}

	private void EnsureCapacity(int min)
	{
		int num = ((keys.Length == 0) ? 16 : (keys.Length * 2));
		if ((uint)num > 2146435071u)
		{
			num = 2146435071;
		}
		if (num < min)
		{
			num = min;
		}
		Capacity = num;
	}

	public virtual object GetByIndex(int index)
	{
		if (index < 0 || index >= Count)
		{
			throw new ArgumentOutOfRangeException("index", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		return values[index];
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return new SortedListEnumerator(this, 0, _size, 3);
	}

	public virtual IDictionaryEnumerator GetEnumerator()
	{
		return new SortedListEnumerator(this, 0, _size, 3);
	}

	public virtual object GetKey(int index)
	{
		if (index < 0 || index >= Count)
		{
			throw new ArgumentOutOfRangeException("index", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		return keys[index];
	}

	public virtual IList GetKeyList()
	{
		if (keyList == null)
		{
			keyList = new KeyList(this);
		}
		return keyList;
	}

	public virtual IList GetValueList()
	{
		if (valueList == null)
		{
			valueList = new ValueList(this);
		}
		return valueList;
	}

	public virtual int IndexOfKey(object key)
	{
		if (key == null)
		{
			throw new ArgumentNullException("key", "Key cannot be null.");
		}
		int num = Array.BinarySearch(keys, 0, _size, key, comparer);
		if (num < 0)
		{
			return -1;
		}
		return num;
	}

	public virtual int IndexOfValue(object value)
	{
		return Array.IndexOf(values, value, 0, _size);
	}

	private void Insert(int index, object key, object value)
	{
		if (_size == keys.Length)
		{
			EnsureCapacity(_size + 1);
		}
		if (index < _size)
		{
			Array.Copy(keys, index, keys, index + 1, _size - index);
			Array.Copy(values, index, values, index + 1, _size - index);
		}
		keys[index] = key;
		values[index] = value;
		_size++;
		version++;
	}

	public virtual void RemoveAt(int index)
	{
		if (index < 0 || index >= Count)
		{
			throw new ArgumentOutOfRangeException("index", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		_size--;
		if (index < _size)
		{
			Array.Copy(keys, index + 1, keys, index, _size - index);
			Array.Copy(values, index + 1, values, index, _size - index);
		}
		keys[_size] = null;
		values[_size] = null;
		version++;
	}

	public virtual void Remove(object key)
	{
		int num = IndexOfKey(key);
		if (num >= 0)
		{
			RemoveAt(num);
		}
	}

	public static SortedList Synchronized(SortedList list)
	{
		if (list == null)
		{
			throw new ArgumentNullException("list");
		}
		return new SyncSortedList(list);
	}
}
