using System.Reflection;

namespace System.Collections.Generic;

[DefaultMember("Item")]
internal struct ArrayBuilder<T>
{
	private T[] _array;

	private int _count;

	public ArrayBuilder(int capacity)
	{
		this = default(ArrayBuilder<T>);
		if (capacity > 0)
		{
			_array = new T[capacity];
		}
	}

	public T[] ToArray()
	{
		if (_count == 0)
		{
			return Array.Empty<T>();
		}
		T[] array = _array;
		if (_count < array.Length)
		{
			array = new T[_count];
			Array.Copy(_array, 0, array, 0, _count);
		}
		return array;
	}

	public void UncheckedAdd(T item)
	{
		_array[_count++] = item;
	}
}
