using System.Runtime.CompilerServices;

namespace System.Collections.Generic;

internal struct LargeArrayBuilder<T>
{
	private readonly int _maxCapacity;

	private T[] _first;

	private ArrayBuilder<T[]> _buffers;

	private T[] _current;

	private int _index;

	private int _count;

	public LargeArrayBuilder(bool initialize)
		: this(int.MaxValue)
	{
	}

	public LargeArrayBuilder(int maxCapacity)
	{
		this = default(LargeArrayBuilder<T>);
		_first = (_current = Array.Empty<T>());
		_maxCapacity = maxCapacity;
	}

	public void AddRange(IEnumerable<T> items)
	{
		using IEnumerator<T> enumerator = items.GetEnumerator();
		T[] destination = _current;
		int index = _index;
		while (enumerator.MoveNext())
		{
			T current = enumerator.Current;
			if ((uint)index >= (uint)destination.Length)
			{
				AddWithBufferAllocation(current, ref destination, ref index);
			}
			else
			{
				destination[index] = current;
			}
			index++;
		}
		_count += index - _index;
		_index = index;
	}

	[MethodImpl((MethodImplOptions)8)]
	private void AddWithBufferAllocation(T item, ref T[] destination, ref int index)
	{
		_count += index - _index;
		_index = index;
		AllocateBuffer();
		destination = _current;
		index = _index;
		_current[index] = item;
	}

	public void CopyTo(T[] array, int arrayIndex, int count)
	{
		int num = 0;
		while (count > 0)
		{
			T[] buffer = GetBuffer(num);
			int num2 = Math.Min(count, buffer.Length);
			Array.Copy(buffer, 0, array, arrayIndex, num2);
			count -= num2;
			arrayIndex += num2;
			num++;
		}
	}

	public T[] GetBuffer(int index)
	{
		if (index != 0)
		{
			if (index > _buffers.Count)
			{
				return _current;
			}
			return _buffers[index - 1];
		}
		return _first;
	}

	public T[] ToArray()
	{
		if (TryMove(out var array))
		{
			return array;
		}
		array = new T[_count];
		CopyTo(array, 0, _count);
		return array;
	}

	public bool TryMove(out T[] array)
	{
		array = _first;
		return _count == _first.Length;
	}

	private void AllocateBuffer()
	{
		if ((uint)_count < 8u)
		{
			int num = Math.Min((_count == 0) ? 4 : (_count * 2), _maxCapacity);
			_current = new T[num];
			Array.Copy(_first, 0, _current, 0, _count);
			_first = _current;
			return;
		}
		int num2;
		if (_count == 8)
		{
			num2 = 8;
		}
		else
		{
			_buffers.Add(_current);
			num2 = Math.Min(_count, _maxCapacity - _count);
		}
		_current = new T[num2];
		_index = 0;
	}
}
