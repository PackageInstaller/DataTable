using System.Diagnostics;

namespace System.Collections.Generic;

[DebuggerDisplay("Count = {Count}")]
internal class LowLevelList<T>
{
	private const int _defaultCapacity = 4;

	protected T[] _items;

	protected int _size;

	protected int _version;

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
				throw new ArgumentOutOfRangeException("value");
			}
			if (value != _items.Length)
			{
				if (value > 0)
				{
					T[] array = new T[value];
					Array.Copy(_items, 0, array, 0, _size);
					_items = array;
				}
				else
				{
					_items = s_emptyArray;
				}
			}
		}
	}

	public int Count => _size;

	public T this[int index]
	{
		get
		{
			if ((uint)index >= (uint)_size)
			{
				throw new ArgumentOutOfRangeException();
			}
			return _items[index];
		}
		set
		{
			if ((uint)index >= (uint)_size)
			{
				throw new ArgumentOutOfRangeException();
			}
			_items[index] = value;
			_version++;
		}
	}

	public LowLevelList()
	{
		_items = s_emptyArray;
	}

	public LowLevelList(int capacity)
	{
		if (capacity < 0)
		{
			throw new ArgumentOutOfRangeException("capacity");
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

	public void Add(T item)
	{
		if (_size == _items.Length)
		{
			EnsureCapacity(_size + 1);
		}
		_items[_size++] = item;
		_version++;
	}

	private void EnsureCapacity(int min)
	{
		if (_items.Length < min)
		{
			int num = ((_items.Length == 0) ? 4 : (_items.Length * 2));
			if (num < min)
			{
				num = min;
			}
			Capacity = num;
		}
	}

	public void AddRange(IEnumerable<T> collection)
	{
		InsertRange(_size, collection);
	}

	public void Clear()
	{
		if (_size > 0)
		{
			Array.Clear(_items, 0, _size);
			_size = 0;
		}
		_version++;
	}

	public bool Contains(T item)
	{
		if (item == null)
		{
			for (int i = 0; i < _size; i++)
			{
				if (_items[i] == null)
				{
					return true;
				}
			}
			return false;
		}
		if (IndexOf(item) >= 0)
		{
			return true;
		}
		return false;
	}

	public void CopyTo(T[] array, int arrayIndex)
	{
		Array.Copy(_items, 0, array, arrayIndex, _size);
	}

	public int IndexOf(T item)
	{
		return Array.IndexOf(_items, item, 0, _size);
	}

	public void Insert(int index, T item)
	{
		if ((uint)index > (uint)_size)
		{
			throw new ArgumentOutOfRangeException("index");
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

	public void InsertRange(int index, IEnumerable<T> collection)
	{
		if (collection == null)
		{
			throw new ArgumentNullException("collection");
		}
		if ((uint)index > (uint)_size)
		{
			throw new ArgumentOutOfRangeException("index");
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
					T[] array = new T[count];
					collection2.CopyTo(array, 0);
					Array.Copy(array, 0, _items, index, count);
				}
				_size += count;
			}
		}
		else
		{
			using IEnumerator<T> enumerator = collection.GetEnumerator();
			while (enumerator.MoveNext())
			{
				Insert(index++, enumerator.Current);
			}
		}
		_version++;
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

	public int RemoveAll(Predicate<T> match)
	{
		if (match == null)
		{
			throw new ArgumentNullException("match");
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
		Array.Clear(_items, i, _size - i);
		int result = _size - i;
		_size = i;
		_version++;
		return result;
	}

	public void RemoveAt(int index)
	{
		if ((uint)index >= (uint)_size)
		{
			throw new ArgumentOutOfRangeException("index");
		}
		_size--;
		if (index < _size)
		{
			Array.Copy(_items, index + 1, _items, index, _size - index);
		}
		_items[_size] = default(T);
		_version++;
	}

	public T[] ToArray()
	{
		T[] array = new T[_size];
		Array.Copy(_items, 0, array, 0, _size);
		return array;
	}
}
