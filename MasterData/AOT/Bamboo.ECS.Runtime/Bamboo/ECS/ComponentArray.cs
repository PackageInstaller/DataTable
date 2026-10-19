using System;
using System.Runtime.CompilerServices;

namespace Bamboo.ECS;

internal class ComponentArray<T> : IComponentArray where T : class, IComponent
{
	private T[] _data;

	private int _count;

	public int Count => _count;

	public int Capacity => _data.Length;

	public ComponentArray(int initialCapacity = 16)
	{
		_data = new T[initialCapacity];
		_count = 0;
	}

	[MethodImpl((MethodImplOptions)256)]
	public ref T Get(int index)
	{
		if (index < 0 || index >= _count)
		{
			throw new IndexOutOfRangeException($"Index {index} is out of range [0, {_count})");
		}
		return ref _data[index];
	}

	[MethodImpl((MethodImplOptions)256)]
	internal ref T GetUnchecked(int index)
	{
		return ref _data[index];
	}

	[MethodImpl((MethodImplOptions)256)]
	public int Add(T component)
	{
		if (_count >= _data.Length)
		{
			Grow();
		}
		int count = _count;
		_data[count] = component;
		_count++;
		return count;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void RemoveAtSwapBack(int index)
	{
		if (index < 0 || index >= _count)
		{
			throw new IndexOutOfRangeException($"Index {index} is out of range [0, {_count})");
		}
		int num = _count - 1;
		if (index < num)
		{
			_data[index] = _data[num];
		}
		_data[num] = null;
		_count--;
	}

	public void Clear()
	{
		if (_count > 0)
		{
			Array.Clear(_data, 0, _count);
			_count = 0;
		}
	}

	private void Grow()
	{
		int newSize = _data.Length * 2;
		Array.Resize(ref _data, newSize);
	}

	public T[] GetData()
	{
		return _data;
	}

	object IComponentArray.GetObject(int index)
	{
		return Get(index);
	}

	void IComponentArray.AddObject(object component)
	{
		Add((T)component);
	}
}
