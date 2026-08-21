using System;
using System.Text;

namespace P08Common.Collections;

public class RangeList<T> where T : IComparable<T>
{
	private T[] _array;

	private int _count;

	private static T[] _EmptyArray = new T[0];

	private const int _STARTING_SIZE = 16;

	private const int _GROW_FACTOR = 2;

	public int Count => _count;

	public int Capacity
	{
		get
		{
			return _array.Length;
		}
		private set
		{
			if (value == 0)
			{
				_array = _EmptyArray;
				return;
			}
			T[] array = new T[value];
			Array.Copy(_array, 0, array, 0, Math.Min(_count, value));
			_array = array;
		}
	}

	public T this[int index] => _array[index];

	public RangeList()
	{
		_array = _EmptyArray;
	}

	public RangeList(int capacity)
	{
		_array = new T[capacity * 2];
	}

	public void Add(T left, T right)
	{
		int num = left.CompareTo(right);
		if (num > 0 || num == 0)
		{
			return;
		}
		if (_count == 0)
		{
			if (_array.Length == 0)
			{
				Capacity = 16;
			}
			Insert(left, right, 0);
			return;
		}
		int num2 = BinarySearch(left, roundUp: false);
		int num3 = BinarySearch(right, roundUp: true);
		if (num2 % 2 == 0)
		{
			if (num3 == num2)
			{
				if (_count == Capacity)
				{
					Capacity = _count * 2;
				}
				Insert(left, right, num2);
			}
			else if (num3 % 2 == 0)
			{
				FullOverlap(left, right, num2, num3);
			}
			else if (num3 == num2 + 1)
			{
				_array[num2] = left;
			}
			else
			{
				LeftOverlap(left, num2, num3);
			}
		}
		else if (num3 != num2)
		{
			if (num3 == num2 + 1)
			{
				_array[num2] = right;
			}
			else if (num3 % 2 == 0)
			{
				RightOverlap(right, num2, num3);
			}
			else
			{
				Connect(num2, num3);
			}
		}
	}

	public bool QueryItem(T item)
	{
		return QueryItemIndex(item) >= 0;
	}

	public int QueryItemIndex(T item)
	{
		if (_count == 0)
		{
			return -1;
		}
		int num = BinarySearch(item, roundUp: false);
		if (num % 2 == 1)
		{
			return num - 1;
		}
		if (item.CompareTo(_array[num]) != 0)
		{
			return ~num;
		}
		return num;
	}

	public bool QueryItemBoundaries(T item, out T left, out T right)
	{
		int num = QueryItemIndex(item);
		if (num == -1)
		{
			left = default(T);
			right = default(T);
			return false;
		}
		if (num < 0)
		{
			num = ~num;
			if (num + 1 < _count)
			{
				left = _array[num];
				right = _array[num + 1];
			}
			else
			{
				left = default(T);
				right = default(T);
			}
			return false;
		}
		left = _array[num];
		right = _array[num + 1];
		return true;
	}

	public void Clear()
	{
		Array.Clear(_array, 0, _count);
		_count = 0;
	}

	public void TrimExcess()
	{
		Capacity = _count;
	}

	public void CopyTo(T[] array)
	{
		Array.Copy(_array, 0, array, 0, _count);
	}

	public void CopyTo(T[] array, int index)
	{
		Array.Copy(_array, 0, array, index, _count);
	}

	public bool Contains(T item)
	{
		if (item == null)
		{
			for (int i = 0; i < _count; i++)
			{
				if (_array[i] == null)
				{
					return true;
				}
			}
		}
		else
		{
			for (int j = 0; j < _count; j++)
			{
				if (_array[j].Equals(item))
				{
					return true;
				}
			}
		}
		return false;
	}

	public override string ToString()
	{
		StringBuilder stringBuilder = new StringBuilder();
		for (int i = 0; i < _count; i++)
		{
			if (i % 2 == 0)
			{
				stringBuilder.Append("(");
				stringBuilder.Append(this[i].ToString());
				stringBuilder.Append(", ");
			}
			else
			{
				stringBuilder.Append(this[i].ToString());
				stringBuilder.Append(")    ");
			}
		}
		return stringBuilder.ToString();
	}

	private void Insert(T left, T right, int index)
	{
		if (index != _count)
		{
			Array.Copy(_array, index, _array, index + 2, _count - index);
		}
		_array[index] = left;
		_array[index + 1] = right;
		_count += 2;
	}

	private void FullOverlap(T left, T right, int i, int j)
	{
		_array[i] = left;
		_array[i + 1] = right;
		int num = i + 2;
		int num2 = _count - j;
		int num3 = num + num2;
		Array.Copy(_array, j, _array, num, num2);
		Array.Clear(_array, num3, _count - num3);
		_count = num3;
	}

	private void LeftOverlap(T left, int i, int j)
	{
		_array[i] = left;
		int num = i + 1;
		int num2 = _count - j;
		int num3 = num + num2;
		Array.Copy(_array, j, _array, num, num2);
		Array.Clear(_array, num3, _count - num3);
		_count = num3;
	}

	private void RightOverlap(T right, int i, int j)
	{
		_array[i] = right;
		int num = i + 1;
		int num2 = _count - j;
		int num3 = num + num2;
		Array.Copy(_array, j, _array, num, num2);
		Array.Clear(_array, num3, _count - num3);
		_count = num3;
	}

	private void Connect(int i, int j)
	{
		int num = _count - j;
		int num2 = i + num;
		Array.Copy(_array, j, _array, i, num);
		Array.Clear(_array, num2, _count - num2);
		_count = num2;
	}

	private int BinarySearch(T value, bool roundUp)
	{
		int num = 0;
		int num2 = _count - 1;
		while (num <= num2)
		{
			int num3 = num + (num2 - num >> 1);
			int num4 = _array[num3].CompareTo(value);
			if (num4 == 0)
			{
				if (!roundUp)
				{
					return num3;
				}
				return num3 + 1;
			}
			if (num4 < 0)
			{
				num = num3 + 1;
			}
			else
			{
				num2 = num3 - 1;
			}
		}
		return num;
	}
}
