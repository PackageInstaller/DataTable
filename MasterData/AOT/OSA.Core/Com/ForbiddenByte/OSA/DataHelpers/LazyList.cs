using System;
using System.Collections;
using System.Collections.Generic;

namespace Com.ForbiddenByte.OSA.DataHelpers;

public class LazyList<T> : IList, ICollection, IEnumerable
{
	public class EnumerableLazyList : IEnumerable<T>, IEnumerable
	{
		private LazyList<T> _LazyList;

		public EnumerableLazyList(LazyList<T> lazyList)
		{
			_LazyList = lazyList;
		}

		public IEnumerator<T> GetEnumerator()
		{
			return _LazyList.GetEnumeratorForExistingItems();
		}

		IEnumerator IEnumerable.GetEnumerator()
		{
			return GetEnumerator();
		}
	}

	private class IniniteNullList : IList<T>, ICollection<T>, IEnumerable<T>, IEnumerable
	{
		public T this[int index]
		{
			get
			{
				return default;
			}
			set
			{
			}
		}

		public int Count => -1;

		public bool IsReadOnly => true;

		public void Add(T item)
		{
		}

		public void Clear()
		{
		}

		public bool Contains(T item)
		{
			throw new NotImplementedException();
		}

		public void CopyTo(T[] array, int arrayIndex)
		{
		}

		public IEnumerator<T> GetEnumerator()
		{
			throw new NotImplementedException();
		}

		public int IndexOf(T item)
		{
			throw new NotImplementedException();
		}

		public void Insert(int index, T item)
		{
		}

		public bool Remove(T item)
		{
			throw new NotImplementedException();
		}

		public void RemoveAt(int index)
		{
		}

		IEnumerator IEnumerable.GetEnumerator()
		{
			throw new NotImplementedException();
		}
	}

	private Dictionary<int, T> _BackingMap;

	private List<int> _Keys = new List<int>();

	private Func<int, T> _NewValueCreator;

	private IniniteNullList _InfiniteNullList = new IniniteNullList();

	object IList.this[int key]
	{
		get
		{
			return this[key];
		}
		set
		{
			this[key] = (T)value;
		}
	}

	public T this[int key]
	{
		get
		{
			if (key >= Count)
			{
				throw new ArgumentOutOfRangeException("key", key, "must be less than Count=" + Count);
			}
			if (!TryGet(key, out var val))
			{
				val = _NewValueCreator(key);
				if (!_BackingMap.ContainsKey(key))
				{
					SetManuallyCreatedValueForFirstTime(key, val);
				}
			}
			return val;
		}
		set
		{
			SetOrUpdateManuallyCreatedValue(key, value);
		}
	}

	public int Count { get; private set; }

	public int ExistingCount => _Keys.Count;

	public EnumerableLazyList AsEnumerableForExistingItems => new EnumerableLazyList(this);

	bool IList.IsFixedSize => false;

	bool IList.IsReadOnly => false;

	bool ICollection.IsSynchronized => false;

	object ICollection.SyncRoot => this;

	public LazyList(Func<int, T> newValueCreator, int initialCount)
	{
		initialCount = ((initialCount > 0) ? initialCount : 0);
		_NewValueCreator = newValueCreator;
		InitWithNewCount(initialCount);
	}

	public void InitWithNewCount(int newCount)
	{
		int capacity = Math.Min(newCount, 1024);
		_BackingMap = new Dictionary<int, T>(capacity);
		_Keys = new List<int>(capacity);
		Count = newCount;
	}

	public void Add(int count)
	{
		Count += count;
	}

	public void InsertAtStart(int count)
	{
		InsertWhenKeyStartIdxKnown(0, 0, count);
	}

	public void Insert(int index, int count)
	{
		int num = _Keys.BinarySearch(index);
		if (num < 0)
		{
			num = ~num;
		}
		InsertWhenKeyStartIdxKnown(num, index, count);
	}

	private void InsertWhenKeyStartIdxKnown(int keyStartIdx, int index, int count)
	{
		int num = keyStartIdx - 1;
		for (int num2 = _Keys.Count - 1; num2 > num; num2--)
		{
			int num3 = _Keys[num2];
			int num4 = num3 + count;
			_Keys[num2] = num4;
			_BackingMap[num4] = _BackingMap[num3];
			_BackingMap.Remove(num3);
		}
		Count += count;
	}

	public void Clear()
	{
		_BackingMap.Clear();
		_Keys.Clear();
		Count = 0;
	}

	[Obsolete("Use Remove(int index, int count) below")]
	public void RemoveAt(int index)
	{
		Remove(index, 1);
	}

	public int Remove(T value)
	{
		foreach (KeyValuePair<int, T> item in _BackingMap)
		{
			if (item.Value.Equals(value))
			{
				Remove(item.Key, 1);
				return item.Key;
			}
		}
		return -1;
	}

	public void Remove(int index, int count)
	{
		int num = index + count;
		int num2 = _Keys.BinarySearch(index);
		if (num2 < 0)
		{
			num2 = ~num2;
		}
		int i = num2;
		while (i < _Keys.Count)
		{
			int num3 = _Keys[i];
			if (num3 >= num)
			{
				break;
			}
			_Keys.RemoveAt(i);
			_BackingMap.Remove(num3);
		}
		for (; i < _Keys.Count; i++)
		{
			int num3 = _Keys[i];
			int num4 = num3 - count;
			_Keys[i] = num4;
			_BackingMap[num4] = _BackingMap[num3];
			_BackingMap.Remove(num3);
		}
		Count -= count;
	}

	private IEnumerator<T> GetEnumeratorForExistingItems()
	{
		int i = 0;
		while (i < _Keys.Count)
		{
			yield return _BackingMap[_Keys[i]];
			int num = i + 1;
			i = num;
		}
	}

	public bool TryGet(int index, out T val)
	{
		return _BackingMap.TryGetValue(index, out val);
	}

	public T GetUnchecked(int index)
	{
		return _BackingMap[index];
	}

	public void GetIndicesOfClosestExistingItems(int index, out int prevIndex, out int nextIndex)
	{
		if (index < 0)
		{
			throw new ArgumentOutOfRangeException("index", "can't be negative");
		}
		if (index == int.MaxValue)
		{
			throw new ArgumentOutOfRangeException("index", "can't be int.MaxValue");
		}
		int num = _Keys.BinarySearch(index);
		bool flag = num >= 0;
		if (!flag)
		{
			num = ~num;
			if (num > 0)
			{
				prevIndex = _Keys[num - 1];
			}
		}
		int num2 = num - 1;
		int num3;
		if (num != 0)
		{
			num3 = ((!flag) ? num : (num + 1));
		}
		else
		{
			num3 = num + 1;
		}
		if (num2 >= 0 && num2 < _Keys.Count)
		{
			prevIndex = _Keys[num2];
		}
		else
		{
			prevIndex = -1;
		}
		if (num3 >= 0 && num3 < _Keys.Count)
		{
			nextIndex = _Keys[num3];
		}
		else
		{
			nextIndex = -1;
		}
	}

	public void SetOrUpdateManuallyCreatedValue(int index, T val)
	{
		if (index < 0 || index >= Count)
		{
			throw new ArgumentOutOfRangeException("index", index, "Must be >=0 and less than Count(" + Count + ")");
		}
		if (_BackingMap.ContainsKey(index))
		{
			_BackingMap[index] = val;
		}
		else
		{
			SetManuallyCreatedValueForFirstTime(index, val);
		}
	}

	public bool UncacheValue(int index)
	{
		if (index < 0 || index >= Count)
		{
			throw new ArgumentOutOfRangeException("index", index, "Must be >=0 and less than Count(" + Count + ")");
		}
		if (!_BackingMap.Remove(index))
		{
			return false;
		}
		int num = _Keys.BinarySearch(index);
		if (num < 0)
		{
			throw new InvalidOperationException("Internal bug: Key index " + num + " for key " + index + ", but the value was found in the backing map. Count=" + Count);
		}
		_Keys.RemoveAt(num);
		return true;
	}

	public void AllocateNullSlots(int startingIndex, int valuesReadCount)
	{
		SetOrUpdateManuallyCreatedValues(startingIndex, _InfiniteNullList, 0, valuesReadCount);
	}

	public void SetOrUpdateManuallyCreatedValues(int startingIndex, IList<T> values, int valsReadIndex, int valsReadCount)
	{
		int num = _Keys.BinarySearch(startingIndex);
		if (num < 0)
		{
			num = ~num;
		}
		for (int i = 0; i < valsReadCount; i++)
		{
			int num2 = startingIndex + i;
			_BackingMap[num2] = values[valsReadIndex + i];
			int num3 = num + i;
			if (num3 == _Keys.Count || _Keys[num3] != num2)
			{
				_Keys.Insert(num3, num2);
			}
		}
	}

	private void SetManuallyCreatedValueForFirstTime(int index, T val)
	{
		_BackingMap.Add(index, val);
		_Keys.Insert(~_Keys.BinarySearch(index), index);
	}

	int IList.Add(object value)
	{
		int count = Count;
		((IList)this).Insert(count, value);
		return count;
	}

	void IList.Clear()
	{
		Clear();
	}

	bool IList.Contains(object value)
	{
		return IndexOf(value) != -1;
	}

	int IList.IndexOf(object value)
	{
		return IndexOf(value);
	}

	void IList.Insert(int index, object value)
	{
		AllocateNullSlots(index, 1);
		SetOrUpdateManuallyCreatedValue(index, (T)value);
	}

	void IList.Remove(object value)
	{
		int num = IndexOf(value);
		if (num != -1)
		{
			Remove(num, 1);
		}
	}

	void IList.RemoveAt(int index)
	{
		Remove(index, 1);
	}

	void ICollection.CopyTo(Array array, int index)
	{
		for (int i = 0; i < Count; i++)
		{
			array.SetValue(this[i], index + i);
		}
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		for (int i = 0; i < Count; i++)
		{
			yield return this[i];
		}
	}

	private int IndexOf(object value)
	{
		foreach (KeyValuePair<int, T> item in _BackingMap)
		{
			if ((object)item.Value == value)
			{
				return item.Key;
			}
		}
		return -1;
	}
}
