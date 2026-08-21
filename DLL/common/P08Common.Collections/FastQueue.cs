using System;
using System.Collections.Generic;
using System.Text;

namespace P08Common.Collections;

[Serializable]
public sealed class FastQueue<T>
{
	private T[] _array;

	private int _start;

	private int _end;

	private int _count;

	private const int _StartingSize = 8;

	private const int _GrowFactor = 2;

	private static T[] _emptyArray = new T[0];

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
				_array = _emptyArray;
			}
			_start = 0;
			_end = Math.Min(_count, value);
		}
	}

	public T this[int index] => _array[(_start + index) % _array.Length];

	public FastQueue()
	{
		_array = _emptyArray;
	}

	public FastQueue(int capacity)
	{
		if (capacity < 0)
		{
			throw new ArgumentOutOfRangeException("capacity", "Queue length must be >= 0");
		}
		_array = new T[capacity];
		_start = 0;
		_end = 0;
		_count = 0;
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

	public void Add(T item)
	{
		if (_count == _array.Length)
		{
			Capacity = ((_count == 0) ? 8 : (_count * 2));
		}
		_array[_end] = item;
		_end = (_end + 1) % _array.Length;
		_count++;
	}

	public T Pop()
	{
		T result = _array[_start];
		_array[_start] = default(T);
		_start = (_start + 1) % _array.Length;
		_count--;
		return result;
	}

	public T Peek()
	{
		return _array[_start];
	}

	public bool Contains(T item)
	{
		int num = _start;
		int count = _count;
		EqualityComparer<T> equalityComparer = EqualityComparer<T>.Default;
		if (item == null)
		{
			while (count-- > 0)
			{
				if (item == null && _array[num] == null)
				{
					return true;
				}
				num = (num + 1) % _array.Length;
			}
		}
		else
		{
			while (count-- > 0)
			{
				if (_array[num] != null && equalityComparer.Equals(_array[num], item))
				{
					return true;
				}
				num = (num + 1) % _array.Length;
			}
		}
		return false;
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
			stringBuilder.Append("   ");
		}
		return stringBuilder.ToString();
	}
}
