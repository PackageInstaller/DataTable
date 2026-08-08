using System;
using System.Collections.Generic;
using System.Text;

namespace P08Common.Collections;

[Serializable]
public sealed class SortedQueue<T> where T : IComparable<T>
{
	private T[] _array;

	private int _start;

	private int _end;

	public int count;

	private bool prioritizeOlderItems;

	private static T[] _EmptyArray = new T[0];

	private const int _StartingSize = 8;

	private const int _GrowFactor = 2;

	public int Count => count;

	public int Capacity
	{
		get
		{
			return _array.Length;
		}
		private set
		{
			if (value > 0)
			{
				T[] array = new T[value];
				if (_start < _end)
				{
					Array.Copy(_array, _start, array, 0, count);
				}
				else
				{
					Array.Copy(_array, _start, array, 0, _array.Length - _start);
					Array.Copy(_array, 0, array, _array.Length - _start, _end);
				}
				_array = array;
			}
			else
			{
				_array = _EmptyArray;
			}
			_start = 0;
			_end = Math.Min(count, value);
		}
	}

	public T this[int index] => _array[(_start + index) % _array.Length];

	public SortedQueue(bool prioritizeOlderItems = false)
	{
		_array = _EmptyArray;
		this.prioritizeOlderItems = prioritizeOlderItems;
	}

	public SortedQueue(int capacity, bool prioritizeOlderItems = false)
	{
		_array = new T[capacity];
		this.prioritizeOlderItems = prioritizeOlderItems;
	}

	public void Add(T value)
	{
		if (count == _array.Length)
		{
			Grow();
		}
		Insert(value, BinarySearch(value));
		_end = (_end + 1) % _array.Length;
		count++;
	}

	public void Add(FastList<T> list)
	{
		if (_array.Length - count < list.count)
		{
			Capacity = Max(8, _array.Length * 2, count + list.count);
		}
		for (int i = 0; i < list.count; i++)
		{
			T value = list[i];
			Insert(value, BinarySearch(value));
			_end = (_end + 1) % _array.Length;
			count++;
		}
	}

	private int Max(int a, int b, int c)
	{
		if (a <= b)
		{
			return Max(b, c);
		}
		return Max(a, c);
	}

	private int Max(int a, int b)
	{
		if (a > b)
		{
			return a;
		}
		return b;
	}

	public T Pop()
	{
		T result = _array[_start];
		_array[_start] = default(T);
		_start = (_start + 1) % _array.Length;
		count--;
		return result;
	}

	public T Peek()
	{
		if (count == 0)
		{
			throw new ArgumentOutOfRangeException();
		}
		return _array[_start];
	}

	public void Clear()
	{
		if (_start < _end)
		{
			Array.Clear(_array, _start, count);
		}
		else
		{
			Array.Clear(_array, _start, _array.Length - _start);
			Array.Clear(_array, 0, _end);
		}
		_start = 0;
		_end = 0;
		count = 0;
	}

	public void TrimExcess()
	{
		Capacity = count;
	}

	public int FindItemByKey(T value)
	{
		if (count == 0)
		{
			return -1;
		}
		int num = CheckSearch(BinarySearch(value), value);
		if (num != -1)
		{
			return Math.Abs(num - _start);
		}
		return -1;
	}

	public int FindItem(T item)
	{
		if (item == null)
		{
			for (int i = 0; i < count; i++)
			{
				if (this[i] == null)
				{
					return i;
				}
			}
		}
		else
		{
			for (int j = 0; j < count; j++)
			{
				if (this[j].Equals(item))
				{
					return j;
				}
			}
		}
		return -1;
	}

	public bool ContainsItemByKey(T item)
	{
		return FindItemByKey(item) != -1;
	}

	public bool ContainsItem(T item)
	{
		return FindItem(item) != -1;
	}

	public void Reverse()
	{
		Capacity = _array.Length;
		Array.Reverse((Array)_array);
	}

	public void ReverseAndTrim()
	{
		TrimExcess();
		Array.Reverse((Array)_array);
	}

	public T[] ToArray()
	{
		TrimExcess();
		return _array;
	}

	public bool TrueForAll(Predicate<T> match)
	{
		for (int i = 0; i < count; i++)
		{
			if (!match(this[i]))
			{
				return false;
			}
		}
		return true;
	}

	public override string ToString()
	{
		StringBuilder stringBuilder = new StringBuilder();
		for (int i = 0; i < count; i++)
		{
			stringBuilder.Append(this[i].ToString());
			stringBuilder.Append("   ");
		}
		return stringBuilder.ToString();
	}

	private void Insert(T value, int index)
	{
		if (index != _end)
		{
			if (_start < _end)
			{
				Array.Copy(_array, index, _array, index + 1, count - index + _start);
			}
			else if (index < _end)
			{
				Array.Copy(_array, index, _array, index + 1, _end - index);
			}
			else
			{
				Array.Copy(_array, 0, _array, 1, _end);
				_array[0] = _array[_array.Length - 1];
				Array.Copy(_array, index, _array, index + 1, _array.Length - index - 1);
			}
		}
		_array[index] = value;
	}

	private void Grow()
	{
		Capacity = ((count == 0) ? 8 : (count * 2));
	}

	private int BinarySearch(T value)
	{
		int num = 0;
		int num2 = count - 1;
		while (num <= num2)
		{
			int num3 = num + (num2 - num >> 1);
			int num4 = (_start + num3) % _array.Length;
			int num5 = _array[num4].CompareTo(value);
			if (num5 == 0)
			{
				if (prioritizeOlderItems)
				{
					do
					{
						num4 = (num4 + 1) % _array.Length;
					}
					while (num4 != _end && _array[num4].CompareTo(value) == 0);
				}
				return num4;
			}
			if (num5 < 0)
			{
				num = num3 + 1;
			}
			else
			{
				num2 = num3 - 1;
			}
		}
		return (_start + num) % _array.Length;
	}

	private int CheckSearch(int i, T item)
	{
		if (_start < _end)
		{
			if (i < _start || i >= _end)
			{
				return -1;
			}
		}
		else if (i >= _end && i < _start)
		{
			return -1;
		}
		if (_array[i].Equals(item))
		{
			return i;
		}
		int num = i;
		while (_array[i].CompareTo(item) == 0 && i > 0)
		{
			if (_array[i--].Equals(item))
			{
				return i;
			}
		}
		while (_array[num].CompareTo(item) == 0 && i < _array.Length)
		{
			if (_array[num++].Equals(item))
			{
				return num;
			}
		}
		return -1;
	}
}
[Serializable]
public sealed class SortedQueue<TKey, TValue> where TKey : IComparable<TKey>
{
	private KeyValuePair<TKey, TValue>[] _array;

	private int _start;

	private int _end;

	private int _count;

	private bool prioritizeOlderItems;

	private static KeyValuePair<TKey, TValue>[] _EmptyArray = new KeyValuePair<TKey, TValue>[0];

	private const int _StartingSize = 8;

	private const int _GrowFactor = 2;

	public int Count => _count;

	public int Capacity
	{
		get
		{
			return _array.Length;
		}
		private set
		{
			if (value > 0)
			{
				KeyValuePair<TKey, TValue>[] array = new KeyValuePair<TKey, TValue>[value];
				if (_start < _end)
				{
					Array.Copy(_array, _start, array, 0, _count);
				}
				else
				{
					Array.Copy(_array, _start, array, 0, _array.Length - _start);
					Array.Copy(_array, 0, array, _array.Length - _start, _end);
				}
				_array = array;
			}
			else
			{
				_array = _EmptyArray;
			}
			_start = 0;
			_end = Math.Min(_count, value);
		}
	}

	public TKey NextKey => _array[_start].Key;

	public TValue this[int index] => _array[(_start + index) % _array.Length].Value;

	public SortedQueue(bool prioritizeOlderItems = false)
	{
		_array = _EmptyArray;
		this.prioritizeOlderItems = prioritizeOlderItems;
	}

	public SortedQueue(int capacity, bool prioritizeOlderItems = false)
	{
		_array = new KeyValuePair<TKey, TValue>[capacity];
		this.prioritizeOlderItems = prioritizeOlderItems;
	}

	public void Add(TKey key, TValue value)
	{
		if (_count == _array.Length)
		{
			Grow();
		}
		Insert(key, value, BinarySearch(key));
		_end = (_end + 1) % _array.Length;
		_count++;
	}

	public TValue Pop()
	{
		TValue value = _array[_start].Value;
		_array[_start] = default(KeyValuePair<TKey, TValue>);
		_start = (_start + 1) % _array.Length;
		_count--;
		return value;
	}

	public TValue Peek()
	{
		if (_count == 0)
		{
			throw new ArgumentOutOfRangeException();
		}
		return _array[_start].Value;
	}

	public TKey PeekKey()
	{
		if (_count == 0)
		{
			throw new ArgumentOutOfRangeException();
		}
		return _array[_start].Key;
	}

	public void Clear()
	{
		if (_start < _end)
		{
			Array.Clear(_array, _start, _count);
		}
		else
		{
			Array.Clear(_array, _start, _array.Length - _start);
			Array.Clear(_array, 0, _end);
		}
		_start = 0;
		_end = 0;
		_count = 0;
	}

	public void TrimExcess()
	{
		Capacity = _count;
	}

	public int FindKey(TKey key)
	{
		if (_count == 0)
		{
			return -1;
		}
		int num = BinarySearch(key);
		if (!_array[num].Key.Equals(key))
		{
			return -1;
		}
		return Math.Abs(num - _start);
	}

	public int FindValue(TValue value)
	{
		if (value == null)
		{
			for (int i = 0; i < _count; i++)
			{
				if (this[i] == null)
				{
					return i;
				}
			}
		}
		else
		{
			for (int j = 0; j < _count; j++)
			{
				if (this[j].Equals(value))
				{
					return j;
				}
			}
		}
		return -1;
	}

	public bool ContainsKey(TKey key)
	{
		return FindKey(key) != -1;
	}

	public bool ContainsValue(TValue item)
	{
		return FindValue(item) != -1;
	}

	public int FindValueByKey(TKey key, TValue value)
	{
		if (_count == 0)
		{
			return -1;
		}
		int num = CheckSearch(BinarySearch(key), value);
		if (num != -1)
		{
			return Math.Abs(num - _start);
		}
		return -1;
	}

	public bool ContainsValueByKey(TKey key, TValue value)
	{
		return FindValueByKey(key, value) != -1;
	}

	public void Reverse()
	{
		Capacity = _array.Length;
		Array.Reverse((Array)_array);
	}

	public void ReverseAndTrim()
	{
		TrimExcess();
		Array.Reverse((Array)_array);
	}

	public KeyValuePair<TKey, TValue>[] ToArray()
	{
		TrimExcess();
		return _array;
	}

	public bool TrueForAll(Predicate<KeyValuePair<TKey, TValue>> match)
	{
		for (int i = 0; i < _count; i++)
		{
			if (!match(_array[(_start + i) % _array.Length]))
			{
				return false;
			}
		}
		return true;
	}

	public override string ToString()
	{
		StringBuilder stringBuilder = new StringBuilder();
		for (int i = 0; i < _count; i++)
		{
			stringBuilder.Append(this[i].ToString());
			stringBuilder.Append("   ");
		}
		return stringBuilder.ToString();
	}

	private void Insert(TKey key, TValue value, int index)
	{
		if (index != _end)
		{
			if (_start < _end)
			{
				Array.Copy(_array, index, _array, index + 1, _count - index + _start);
			}
			else if (index < _end)
			{
				Array.Copy(_array, index, _array, index + 1, _end - index);
			}
			else
			{
				Array.Copy(_array, 0, _array, 1, _end);
				_array[0] = _array[_array.Length - 1];
				Array.Copy(_array, index, _array, index + 1, _array.Length - index - 1);
			}
		}
		_array[index] = new KeyValuePair<TKey, TValue>(key, value);
	}

	private void Grow()
	{
		Capacity = ((_count == 0) ? 8 : (_count * 2));
	}

	private int BinarySearch(TKey key)
	{
		int num = 0;
		int num2 = _count - 1;
		while (num <= num2)
		{
			int num3 = num + (num2 - num >> 1);
			int num4 = (_start + num3) % _array.Length;
			int num5 = _array[num4].Key.CompareTo(key);
			if (num5 == 0)
			{
				if (prioritizeOlderItems)
				{
					do
					{
						num4 = (num4 + 1) % _array.Length;
					}
					while (num4 != _end && _array[num4].Key.CompareTo(key) == 0);
				}
				return num4;
			}
			if (num5 < 0)
			{
				num = num3 + 1;
			}
			else
			{
				num2 = num3 - 1;
			}
		}
		return (_start + num) % _array.Length;
	}

	private int CheckSearch(int i, TValue value)
	{
		if (_start < _end)
		{
			if (i < _start || i >= _end)
			{
				return -1;
			}
		}
		else if (i >= _end && i < _start)
		{
			return -1;
		}
		if (_array[i].Value.Equals(value))
		{
			return i;
		}
		int num = i;
		while (_array[i].Key.Equals(_array[i--].Key) && i >= 0)
		{
			if (_array[i].Value.Equals(value))
			{
				return i;
			}
		}
		while (_array[num].Key.Equals(_array[num++].Key) && num < _array.Length)
		{
			if (_array[num].Value.Equals(value))
			{
				return num;
			}
		}
		return -1;
	}
}
