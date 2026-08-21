using System.Collections.ObjectModel;
using System.Diagnostics;
using System.Runtime.CompilerServices;
using System.Threading;

namespace System.Collections.Generic;

[Serializable]
[DebuggerDisplay("Count = {Count}")]
[DebuggerTypeProxy(typeof(ICollectionDebugView<>))]
public class List<T> : IList<T>, ICollection<T>, IEnumerable<T>, IEnumerable, IList, ICollection, IReadOnlyList<T>, IReadOnlyCollection<T>
{
	[Serializable]
	public struct Enumerator : IEnumerator<T>, IDisposable, IEnumerator
	{
		private List<T> _list;

		private int _index;

		private int _version;

		private T _current;

		public T Current => _current;

		object IEnumerator.Current
		{
			get
			{
				if (_index == 0 || _index == _list._size + 1)
				{
					ThrowHelper.ThrowInvalidOperationException_InvalidOperation_EnumOpCantHappen();
				}
				return Current;
			}
		}

		internal Enumerator(List<T> list)
		{
			_list = list;
			_index = 0;
			_version = list._version;
			_current = default(T);
		}

		public void Dispose()
		{
		}

		public bool MoveNext()
		{
			List<T> list = _list;
			if (_version == list._version && (uint)_index < (uint)list._size)
			{
				_current = list._items[_index];
				_index++;
				return true;
			}
			return MoveNextRare();
		}

		private bool MoveNextRare()
		{
			if (_version != _list._version)
			{
				ThrowHelper.ThrowInvalidOperationException_InvalidOperation_EnumFailedVersion();
			}
			_index = _list._size + 1;
			_current = default(T);
			return false;
		}

		void IEnumerator.Reset()
		{
			if (_version != _list._version)
			{
				ThrowHelper.ThrowInvalidOperationException_InvalidOperation_EnumFailedVersion();
			}
			_index = 0;
			_current = default(T);
		}
	}

	private const int DefaultCapacity = 4;

	private T[] _items;

	private int _size;

	private int _version;

	[NonSerialized]
	private object _syncRoot;

	private static readonly T[] s_emptyArray = new T[0];

	public int Capacity
	{
		get
		{
			return _items.Length;
		}
		set
		{
			if (value < _size)
			{
				ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.value, ExceptionResource.ArgumentOutOfRange_SmallCapacity);
			}
			if (value == _items.Length)
			{
				return;
			}
			if (value > 0)
			{
				T[] array = new T[value];
				if (_size > 0)
				{
					Array.Copy(_items, 0, array, 0, _size);
				}
				_items = array;
			}
			else
			{
				_items = s_emptyArray;
			}
		}
	}

	public int Count => _size;

	bool IList.IsFixedSize => false;

	bool ICollection<T>.IsReadOnly => false;

	bool IList.IsReadOnly => false;

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

	public T this[int index]
	{
		get
		{
			if ((uint)index >= (uint)_size)
			{
				ThrowHelper.ThrowArgumentOutOfRange_IndexException();
			}
			return _items[index];
		}
		set
		{
			if ((uint)index >= (uint)_size)
			{
				ThrowHelper.ThrowArgumentOutOfRange_IndexException();
			}
			_items[index] = value;
			_version++;
		}
	}

	object IList.this[int index]
	{
		get
		{
			return this[index];
		}
		set
		{
			ThrowHelper.IfNullAndNullsAreIllegalThenThrow<T>(value, ExceptionArgument.value);
			try
			{
				this[index] = (T)value;
			}
			catch (InvalidCastException)
			{
				ThrowHelper.ThrowWrongValueTypeArgumentException(value, typeof(T));
			}
		}
	}

	public List()
	{
		_items = s_emptyArray;
	}

	public List(int capacity)
	{
		if (capacity < 0)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.capacity, ExceptionResource.ArgumentOutOfRange_NeedNonNegNum);
		}
		if (capacity == 0)
		{
			_items = s_emptyArray;
		}
		else
		{
			_items = new T[capacity];
		}
	}

	public List(IEnumerable<T> collection)
	{
		if (collection == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.collection);
		}
		if (collection is ICollection<T> { Count: var count } collection2)
		{
			if (count == 0)
			{
				_items = s_emptyArray;
				return;
			}
			_items = new T[count];
			collection2.CopyTo(_items, 0);
			_size = count;
		}
		else
		{
			_size = 0;
			_items = s_emptyArray;
			AddEnumerable(collection);
		}
	}

	private static bool IsCompatibleObject(object value)
	{
		if (!(value is T))
		{
			if (value == null)
			{
				return default(T) == null;
			}
			return false;
		}
		return true;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Add(T item)
	{
		_version++;
		T[] items = _items;
		int size = _size;
		if ((uint)size < (uint)items.Length)
		{
			_size = size + 1;
			items[size] = item;
		}
		else
		{
			AddWithResize(item);
		}
	}

	[MethodImpl((MethodImplOptions)8)]
	private void AddWithResize(T item)
	{
		int size = _size;
		EnsureCapacity(size + 1);
		_size = size + 1;
		_items[size] = item;
	}

	int IList.Add(object item)
	{
		ThrowHelper.IfNullAndNullsAreIllegalThenThrow<T>(item, ExceptionArgument.item);
		try
		{
			Add((T)item);
		}
		catch (InvalidCastException)
		{
			ThrowHelper.ThrowWrongValueTypeArgumentException(item, typeof(T));
		}
		return Count - 1;
	}

	public void AddRange(IEnumerable<T> collection)
	{
		InsertRange(_size, collection);
	}

	public ReadOnlyCollection<T> AsReadOnly()
	{
		return new ReadOnlyCollection<T>(this);
	}

	public int BinarySearch(int index, int count, T item, IComparer<T> comparer)
	{
		if (index < 0)
		{
			ThrowHelper.ThrowIndexArgumentOutOfRange_NeedNonNegNumException();
		}
		if (count < 0)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.count, ExceptionResource.ArgumentOutOfRange_NeedNonNegNum);
		}
		if (_size - index < count)
		{
			ThrowHelper.ThrowArgumentException(ExceptionResource.Argument_InvalidOffLen);
		}
		return Array.BinarySearch(_items, index, count, item, comparer);
	}

	public int BinarySearch(T item)
	{
		return BinarySearch(0, Count, item, null);
	}

	public int BinarySearch(T item, IComparer<T> comparer)
	{
		return BinarySearch(0, Count, item, comparer);
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Clear()
	{
		_version++;
		if (RuntimeHelpers.IsReferenceOrContainsReferences<T>())
		{
			int size = _size;
			_size = 0;
			if (size > 0)
			{
				Array.Clear(_items, 0, size);
			}
		}
		else
		{
			_size = 0;
		}
	}

	public bool Contains(T item)
	{
		if (_size != 0)
		{
			return IndexOf(item) != -1;
		}
		return false;
	}

	bool IList.Contains(object item)
	{
		if (IsCompatibleObject(item))
		{
			return Contains((T)item);
		}
		return false;
	}

	public List<TOutput> ConvertAll<TOutput>(Converter<T, TOutput> converter)
	{
		if (converter == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.converter);
		}
		List<TOutput> list = new List<TOutput>(_size);
		for (int i = 0; i < _size; i++)
		{
			list._items[i] = converter(_items[i]);
		}
		list._size = _size;
		return list;
	}

	public void CopyTo(T[] array)
	{
		CopyTo(array, 0);
	}

	void ICollection.CopyTo(Array array, int arrayIndex)
	{
		if (array != null && array.Rank != 1)
		{
			ThrowHelper.ThrowArgumentException(ExceptionResource.Arg_RankMultiDimNotSupported);
		}
		try
		{
			Array.Copy(_items, 0, array, arrayIndex, _size);
		}
		catch (ArrayTypeMismatchException)
		{
			ThrowHelper.ThrowArgumentException_Argument_InvalidArrayType();
		}
	}

	public void CopyTo(int index, T[] array, int arrayIndex, int count)
	{
		if (_size - index < count)
		{
			ThrowHelper.ThrowArgumentException(ExceptionResource.Argument_InvalidOffLen);
		}
		Array.Copy(_items, index, array, arrayIndex, count);
	}

	public void CopyTo(T[] array, int arrayIndex)
	{
		Array.Copy(_items, 0, array, arrayIndex, _size);
	}

	private void EnsureCapacity(int min)
	{
		if (_items.Length < min)
		{
			int num = ((_items.Length == 0) ? 4 : (_items.Length * 2));
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
	}

	public bool Exists(Predicate<T> match)
	{
		return FindIndex(match) != -1;
	}

	public T Find(Predicate<T> match)
	{
		if (match == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.match);
		}
		for (int i = 0; i < _size; i++)
		{
			if (match(_items[i]))
			{
				return _items[i];
			}
		}
		return default(T);
	}

	public List<T> FindAll(Predicate<T> match)
	{
		if (match == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.match);
		}
		List<T> list = new List<T>();
		for (int i = 0; i < _size; i++)
		{
			if (match(_items[i]))
			{
				list.Add(_items[i]);
			}
		}
		return list;
	}

	public int FindIndex(Predicate<T> match)
	{
		return FindIndex(0, _size, match);
	}

	public int FindIndex(int startIndex, Predicate<T> match)
	{
		return FindIndex(startIndex, _size - startIndex, match);
	}

	public int FindIndex(int startIndex, int count, Predicate<T> match)
	{
		if ((uint)startIndex > (uint)_size)
		{
			ThrowHelper.ThrowStartIndexArgumentOutOfRange_ArgumentOutOfRange_Index();
		}
		if (count < 0 || startIndex > _size - count)
		{
			ThrowHelper.ThrowCountArgumentOutOfRange_ArgumentOutOfRange_Count();
		}
		if (match == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.match);
		}
		int num = startIndex + count;
		for (int i = startIndex; i < num; i++)
		{
			if (match(_items[i]))
			{
				return i;
			}
		}
		return -1;
	}

	public T FindLast(Predicate<T> match)
	{
		if (match == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.match);
		}
		for (int num = _size - 1; num >= 0; num--)
		{
			if (match(_items[num]))
			{
				return _items[num];
			}
		}
		return default(T);
	}

	public int FindLastIndex(Predicate<T> match)
	{
		return FindLastIndex(_size - 1, _size, match);
	}

	public int FindLastIndex(int startIndex, Predicate<T> match)
	{
		return FindLastIndex(startIndex, startIndex + 1, match);
	}

	public int FindLastIndex(int startIndex, int count, Predicate<T> match)
	{
		if (match == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.match);
		}
		if (_size == 0)
		{
			if (startIndex != -1)
			{
				ThrowHelper.ThrowStartIndexArgumentOutOfRange_ArgumentOutOfRange_Index();
			}
		}
		else if ((uint)startIndex >= (uint)_size)
		{
			ThrowHelper.ThrowStartIndexArgumentOutOfRange_ArgumentOutOfRange_Index();
		}
		if (count < 0 || startIndex - count + 1 < 0)
		{
			ThrowHelper.ThrowCountArgumentOutOfRange_ArgumentOutOfRange_Count();
		}
		int num = startIndex - count;
		for (int num2 = startIndex; num2 > num; num2--)
		{
			if (match(_items[num2]))
			{
				return num2;
			}
		}
		return -1;
	}

	public void ForEach(Action<T> action)
	{
		if (action == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.action);
		}
		int version = _version;
		for (int i = 0; i < _size; i++)
		{
			if (version != _version)
			{
				break;
			}
			action(_items[i]);
		}
		if (version != _version)
		{
			ThrowHelper.ThrowInvalidOperationException_InvalidOperation_EnumFailedVersion();
		}
	}

	public Enumerator GetEnumerator()
	{
		return new Enumerator(this);
	}

	IEnumerator<T> IEnumerable<T>.GetEnumerator()
	{
		return new Enumerator(this);
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return new Enumerator(this);
	}

	public List<T> GetRange(int index, int count)
	{
		if (index < 0)
		{
			ThrowHelper.ThrowIndexArgumentOutOfRange_NeedNonNegNumException();
		}
		if (count < 0)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.count, ExceptionResource.ArgumentOutOfRange_NeedNonNegNum);
		}
		if (_size - index < count)
		{
			ThrowHelper.ThrowArgumentException(ExceptionResource.Argument_InvalidOffLen);
		}
		List<T> list = new List<T>(count);
		Array.Copy(_items, index, list._items, 0, count);
		list._size = count;
		return list;
	}

	public int IndexOf(T item)
	{
		return Array.IndexOf(_items, item, 0, _size);
	}

	int IList.IndexOf(object item)
	{
		if (IsCompatibleObject(item))
		{
			return IndexOf((T)item);
		}
		return -1;
	}

	public int IndexOf(T item, int index)
	{
		if (index > _size)
		{
			ThrowHelper.ThrowArgumentOutOfRange_IndexException();
		}
		return Array.IndexOf(_items, item, index, _size - index);
	}

	public int IndexOf(T item, int index, int count)
	{
		if (index > _size)
		{
			ThrowHelper.ThrowArgumentOutOfRange_IndexException();
		}
		if (count < 0 || index > _size - count)
		{
			ThrowHelper.ThrowCountArgumentOutOfRange_ArgumentOutOfRange_Count();
		}
		return Array.IndexOf(_items, item, index, count);
	}

	public void Insert(int index, T item)
	{
		if ((uint)index > (uint)_size)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.index, ExceptionResource.ArgumentOutOfRange_ListInsert);
		}
		if (_size == _items.Length)
		{
			EnsureCapacity(_size + 1);
		}
		if (index < _size)
		{
			Array.Copy(_items, index, _items, index + 1, _size - index);
		}
		_items[index] = item;
		_size++;
		_version++;
	}

	void IList.Insert(int index, object item)
	{
		ThrowHelper.IfNullAndNullsAreIllegalThenThrow<T>(item, ExceptionArgument.item);
		try
		{
			Insert(index, (T)item);
		}
		catch (InvalidCastException)
		{
			ThrowHelper.ThrowWrongValueTypeArgumentException(item, typeof(T));
		}
	}

	public void InsertRange(int index, IEnumerable<T> collection)
	{
		if (collection == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.collection);
		}
		if ((uint)index > (uint)_size)
		{
			ThrowHelper.ThrowArgumentOutOfRange_IndexException();
		}
		if (collection is ICollection<T> { Count: var count } collection2)
		{
			if (count > 0)
			{
				EnsureCapacity(_size + count);
				if (index < _size)
				{
					Array.Copy(_items, index, _items, index + count, _size - index);
				}
				if (this == collection2)
				{
					Array.Copy(_items, 0, _items, index, index);
					Array.Copy(_items, index + count, _items, index * 2, _size - index);
				}
				else
				{
					collection2.CopyTo(_items, index);
				}
				_size += count;
			}
		}
		else if (index < _size)
		{
			using IEnumerator<T> enumerator = collection.GetEnumerator();
			while (enumerator.MoveNext())
			{
				Insert(index++, enumerator.Current);
			}
		}
		else
		{
			AddEnumerable(collection);
		}
		_version++;
	}

	public int LastIndexOf(T item)
	{
		if (_size == 0)
		{
			return -1;
		}
		return LastIndexOf(item, _size - 1, _size);
	}

	public int LastIndexOf(T item, int index)
	{
		if (index >= _size)
		{
			ThrowHelper.ThrowArgumentOutOfRange_IndexException();
		}
		return LastIndexOf(item, index, index + 1);
	}

	public int LastIndexOf(T item, int index, int count)
	{
		if (Count != 0 && index < 0)
		{
			ThrowHelper.ThrowIndexArgumentOutOfRange_NeedNonNegNumException();
		}
		if (Count != 0 && count < 0)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.count, ExceptionResource.ArgumentOutOfRange_NeedNonNegNum);
		}
		if (_size == 0)
		{
			return -1;
		}
		if (index >= _size)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.index, ExceptionResource.ArgumentOutOfRange_BiggerThanCollection);
		}
		if (count > index + 1)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.count, ExceptionResource.ArgumentOutOfRange_BiggerThanCollection);
		}
		return Array.LastIndexOf(_items, item, index, count);
	}

	public bool Remove(T item)
	{
		int num = IndexOf(item);
		if (num >= 0)
		{
			RemoveAt(num);
			return true;
		}
		return false;
	}

	void IList.Remove(object item)
	{
		if (IsCompatibleObject(item))
		{
			Remove((T)item);
		}
	}

	public int RemoveAll(Predicate<T> match)
	{
		if (match == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.match);
		}
		int i;
		for (i = 0; i < _size && !match(_items[i]); i++)
		{
		}
		if (i >= _size)
		{
			return 0;
		}
		int j = i + 1;
		while (j < _size)
		{
			for (; j < _size && match(_items[j]); j++)
			{
			}
			if (j < _size)
			{
				_items[i++] = _items[j++];
			}
		}
		if (RuntimeHelpers.IsReferenceOrContainsReferences<T>())
		{
			Array.Clear(_items, i, _size - i);
		}
		int result = _size - i;
		_size = i;
		_version++;
		return result;
	}

	public void RemoveAt(int index)
	{
		if ((uint)index >= (uint)_size)
		{
			ThrowHelper.ThrowArgumentOutOfRange_IndexException();
		}
		_size--;
		if (index < _size)
		{
			Array.Copy(_items, index + 1, _items, index, _size - index);
		}
		if (RuntimeHelpers.IsReferenceOrContainsReferences<T>())
		{
			_items[_size] = default(T);
		}
		_version++;
	}

	public void RemoveRange(int index, int count)
	{
		if (index < 0)
		{
			ThrowHelper.ThrowIndexArgumentOutOfRange_NeedNonNegNumException();
		}
		if (count < 0)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.count, ExceptionResource.ArgumentOutOfRange_NeedNonNegNum);
		}
		if (_size - index < count)
		{
			ThrowHelper.ThrowArgumentException(ExceptionResource.Argument_InvalidOffLen);
		}
		if (count > 0)
		{
			_ = _size;
			_size -= count;
			if (index < _size)
			{
				Array.Copy(_items, index + count, _items, index, _size - index);
			}
			_version++;
			if (RuntimeHelpers.IsReferenceOrContainsReferences<T>())
			{
				Array.Clear(_items, _size, count);
			}
		}
	}

	public void Reverse()
	{
		Reverse(0, Count);
	}

	public void Reverse(int index, int count)
	{
		if (index < 0)
		{
			ThrowHelper.ThrowIndexArgumentOutOfRange_NeedNonNegNumException();
		}
		if (count < 0)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.count, ExceptionResource.ArgumentOutOfRange_NeedNonNegNum);
		}
		if (_size - index < count)
		{
			ThrowHelper.ThrowArgumentException(ExceptionResource.Argument_InvalidOffLen);
		}
		if (count > 1)
		{
			Array.Reverse(_items, index, count);
		}
		_version++;
	}

	public void Sort()
	{
		Sort(0, Count, null);
	}

	public void Sort(IComparer<T> comparer)
	{
		Sort(0, Count, comparer);
	}

	public void Sort(int index, int count, IComparer<T> comparer)
	{
		if (index < 0)
		{
			ThrowHelper.ThrowIndexArgumentOutOfRange_NeedNonNegNumException();
		}
		if (count < 0)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.count, ExceptionResource.ArgumentOutOfRange_NeedNonNegNum);
		}
		if (_size - index < count)
		{
			ThrowHelper.ThrowArgumentException(ExceptionResource.Argument_InvalidOffLen);
		}
		if (count > 1)
		{
			Array.Sort(_items, index, count, comparer);
		}
		_version++;
	}

	public void Sort(Comparison<T> comparison)
	{
		if (comparison == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.comparison);
		}
		if (_size > 1)
		{
			ArraySortHelper<T>.Sort(_items, 0, _size, comparison);
		}
		_version++;
	}

	public T[] ToArray()
	{
		if (_size == 0)
		{
			return s_emptyArray;
		}
		T[] array = new T[_size];
		Array.Copy(_items, 0, array, 0, _size);
		return array;
	}

	public void TrimExcess()
	{
		int num = (int)((double)_items.Length * 0.9);
		if (_size < num)
		{
			Capacity = _size;
		}
	}

	public bool TrueForAll(Predicate<T> match)
	{
		if (match == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.match);
		}
		for (int i = 0; i < _size; i++)
		{
			if (!match(_items[i]))
			{
				return false;
			}
		}
		return true;
	}

	private void AddEnumerable(IEnumerable<T> enumerable)
	{
		_version++;
		foreach (T item in enumerable)
		{
			if (_size == _items.Length)
			{
				EnsureCapacity(_size + 1);
			}
			_items[_size++] = item;
		}
	}
}
