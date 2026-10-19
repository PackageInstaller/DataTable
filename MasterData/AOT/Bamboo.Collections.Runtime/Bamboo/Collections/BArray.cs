using System;
using Bamboo.Pool;

namespace Bamboo.Collections;

public class BArray<T>
{
	private readonly ArrayBinaryPool<T> _itemsPool;

	private bool _isRecycled;

	private int _version;

	private int _length;

	private int _size;

	public T[] _items;

	public bool IsRecycled => _isRecycled;

	public int Version => _version;

	public int Length
	{
		get
		{
			if (_isRecycled)
			{
				return 0;
			}
			return _length;
		}
	}

	public int Capacity
	{
		get
		{
			if (_isRecycled)
			{
				return 0;
			}
			return _size;
		}
	}

	public T this[int index]
	{
		get
		{
			if (_isRecycled)
			{
				return default;
			}
			if (index >= _length)
			{
				throw new ArgumentOutOfRangeException("index", index, string.Empty);
			}
			return _items[index];
		}
		set
		{
			if (!_isRecycled)
			{
				if (index >= _length)
				{
					throw new ArgumentOutOfRangeException("index", index, string.Empty);
				}
				_items[index] = value;
			}
		}
	}

	internal BArray(int length, ArrayBinaryPool<T> itemsPool)
	{
		_version = 1;
		_itemsPool = itemsPool;
		_length = length;
		_size = BinaryHelper.GetAlignSize(length);
		_items = _itemsPool.Get(_size);
	}

	internal void Renew(int length)
	{
		if (_isRecycled)
		{
			_isRecycled = false;
			_version++;
			_length = length;
			_size = BinaryHelper.GetAlignSize(length);
			_items = _itemsPool.Get(_size);
		}
	}

	internal void Recycle()
	{
		_isRecycled = true;
		_version++;
		_itemsPool.Recycle(_items);
		_items = null;
		_length = 0;
		_size = 0;
	}

	public void ResetLength(int length)
	{
		if (!_isRecycled)
		{
			_length = length;
			int size = _size;
			_size = BinaryHelper.GetAlignSize(length);
			if (_size != size)
			{
				T[] array = _itemsPool.Get(_size);
				Array.Copy(_items, 0, array, 0, Math.Min(_size, size));
				_itemsPool.Recycle(_items);
				_items = array;
			}
		}
	}

	public bool Contains(T item)
	{
		if (_isRecycled)
		{
			return false;
		}
		return IndexOf(item) >= 0;
	}

	public int IndexOf(T item)
	{
		if (_isRecycled)
		{
			return -1;
		}
		return Array.IndexOf(_items, item, 0, _length);
	}

	public void Add(T item)
	{
		if (!_isRecycled)
		{
			_length++;
			int size = _size;
			_size = BinaryHelper.GetAlignSize(_length);
			if (_size != size)
			{
				T[] array = _itemsPool.Get(_size);
				Array.Copy(_items, 0, array, 0, Math.Min(_size, size));
				_itemsPool.Recycle(_items);
				_items = array;
			}
			_items[_length - 1] = item;
		}
	}

	public void Remove(T item)
	{
		int num = IndexOf(item);
		if (num >= 0)
		{
			RemoveAt(num);
		}
	}

	public void RemoveAt(int index)
	{
		if (_isRecycled)
		{
			return;
		}
		if (index < 0 || index >= _length)
		{
			throw new ArgumentOutOfRangeException("index", index, string.Empty);
		}
		_length--;
		int size = _size;
		_size = BinaryHelper.GetAlignSize(_length);
		if (_size != size)
		{
			T[] array = _itemsPool.Get(_size);
			if (index > 0)
			{
				Array.Copy(_items, 0, array, 0, index);
			}
			if (index < _length)
			{
				Array.Copy(_items, index + 1, array, index, _length - index);
			}
			_itemsPool.Recycle(_items);
			_items = array;
		}
		else
		{
			if (index < _length)
			{
				Array.Copy(_items, index + 1, _items, index, _length - index);
			}
			_items[_length] = default;
		}
	}

	public void Clear()
	{
		if (!_isRecycled)
		{
			Array.Clear(_items, 0, _items.Length);
		}
	}
}
