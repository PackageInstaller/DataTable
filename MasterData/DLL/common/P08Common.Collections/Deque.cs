using System;
using System.Collections.Generic;
using System.Text;

namespace P08Common.Collections;

public sealed class Deque<T>
{
	private T[] _array;

	private int _start;

	private int _end;

	private int _count;

	private const int _StartingSize = 8;

	private const int _GrowFactor = 2;

	public int Count => _count;

	public int Capacity
	{
		get
		{
			return _array.Length;
		}
		set
		{
			if (value > 0)
			{
				T[] array = new T[value];
				if (_count > 0)
				{
					if (_start < _end)
					{
						Array.Copy(_array, _start, array, 0, _count);
					}
					else
					{
						Array.Copy(_array, _start, array, 0, _array.Length - _start);
						Array.Copy(_array, 0, array, _array.Length - _start, _end);
					}
				}
				_array = array;
			}
			else
			{
				_array = new T[0];
			}
			_start = 0;
			_end = Math.Min(_count, value);
		}
	}

	public T this[int index] => _array[(_start + index) % _array.Length];

	public Deque()
	{
		_array = new T[0];
	}

	public Deque(int capacity)
	{
		if (capacity < 0)
		{
			throw new ArgumentOutOfRangeException("Invalid array length.", "DeQue length must be >= 0");
		}
		_array = new T[capacity];
		_start = 0;
		_end = 0;
		_count = 0;
	}

	public void Clear()
	{
		if (Count > 0)
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
	}

	public void TrimExcess()
	{
		Capacity = _count;
	}

	public void AddRight(T item)
	{
		if (_count == _array.Length)
		{
			Capacity = ((_count == 0) ? 8 : (_count * 2));
		}
		_array[_end] = item;
		_end = (_end + 1) % _array.Length;
		_count++;
	}

	public void AddLeft(T item)
	{
		if (_count == _array.Length)
		{
			Capacity = ((_count == 0) ? 8 : (_count * 2));
		}
		_start = ((_start == 0) ? (_array.Length - 1) : (_start - 1));
		_array[_start] = item;
		_count++;
	}

	public void Add(T item, bool left)
	{
		if (left)
		{
			if (_count == _array.Length)
			{
				Capacity = ((_count == 0) ? 8 : (_count * 2));
			}
			_start = ((_start == 0) ? (_array.Length - 1) : (_start - 1));
			_array[_start] = item;
			_count++;
		}
		else
		{
			if (_count == _array.Length)
			{
				Capacity = ((_count == 0) ? 8 : (_count * 2));
			}
			_array[_end] = item;
			_end = (_end + 1) % _array.Length;
			_count++;
		}
	}

	public T PopRight()
	{
		_end = ((_end == 0) ? (_array.Length - 1) : (_end - 1));
		T result = _array[_end];
		_array[_end] = default(T);
		_count--;
		return result;
	}

	public T PopLeft()
	{
		T result = _array[_start];
		_array[_start] = default(T);
		_start = (_start + 1) % _array.Length;
		_count--;
		return result;
	}

	public T Pop(bool left)
	{
		if (left)
		{
			T result = _array[_start];
			_array[_start] = default(T);
			_start = (_start + 1) % _array.Length;
			_count--;
			return result;
		}
		_end = ((_end == 0) ? (_array.Length - 1) : (_end - 1));
		T result2 = _array[_end];
		_array[_end] = default(T);
		_count--;
		return result2;
	}

	public void Set(T item, int i, bool left)
	{
		if (left)
		{
			_array[(_start + i) % _array.Length] = item;
			return;
		}
		int num = _end - i - 1;
		if (num < 0)
		{
			_array[_array.Length + num] = item;
		}
		else
		{
			_array[num] = item;
		}
	}

	public T PeekRight()
	{
		if (_end != 0)
		{
			return _array[_end - 1];
		}
		return _array[_array.Length - 1];
	}

	public T PeekRight(int i)
	{
		int num = _end - i - 1;
		if (num >= 0)
		{
			return _array[num];
		}
		return _array[_array.Length + num];
	}

	public void SetRight(T item, int i)
	{
		int num = _end - i - 1;
		if (num < 0)
		{
			_array[_array.Length + num] = item;
		}
		else
		{
			_array[num] = item;
		}
	}

	public T PeekLeft()
	{
		return _array[_start];
	}

	public T PeekLeft(int i)
	{
		return _array[(_start + i) % _array.Length];
	}

	public void SetLeft(T item, int i)
	{
		_array[(_start + i) % _array.Length] = item;
	}

	public T Peek(bool left)
	{
		if (left)
		{
			return _array[_start];
		}
		if (_end != 0)
		{
			return _array[_end - 1];
		}
		return _array[_array.Length - 1];
	}

	public T Peek(int i, bool left)
	{
		if (left)
		{
			return _array[(_start + i) % _array.Length];
		}
		int num = _end - i - 1;
		if (num >= 0)
		{
			return _array[num];
		}
		return _array[_array.Length + num];
	}

	public int LeftIndexOf(T item)
	{
		EqualityComparer<T> equalityComparer = EqualityComparer<T>.Default;
		for (int i = 0; i < Count; i++)
		{
			if (equalityComparer.Equals(_array[(_start + i) % _array.Length], item))
			{
				return i;
			}
		}
		return -1;
	}

	public int RightIndexOf(T item)
	{
		EqualityComparer<T> equalityComparer = EqualityComparer<T>.Default;
		for (int i = 0; i < Count; i++)
		{
			int num = _end - i - 1;
			if (equalityComparer.Equals((num < 0) ? _array[_array.Length + num] : _array[num], item))
			{
				return i;
			}
		}
		return -1;
	}

	public int IndexOf(T item)
	{
		if (item == null)
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
			EqualityComparer<T> equalityComparer = EqualityComparer<T>.Default;
			for (int j = 0; j < _count; j++)
			{
				if (equalityComparer.Equals(this[j], item))
				{
					return j;
				}
			}
		}
		return -1;
	}

	public bool Contains(T item)
	{
		return IndexOf(item) >= 0;
	}

	public bool TrueForAll(Predicate<T> match)
	{
		for (int i = 0; i < _count; i++)
		{
			if (!match(this[i]))
			{
				return false;
			}
		}
		return true;
	}

	public T[] ToArray()
	{
		TrimExcess();
		return _array;
	}

	public override string ToString()
	{
		StringBuilder stringBuilder = new StringBuilder();
		for (int i = 0; i < _count; i++)
		{
			stringBuilder.Append(this[i].ToString());
			stringBuilder.Append("\n");
		}
		return stringBuilder.ToString();
	}
}
