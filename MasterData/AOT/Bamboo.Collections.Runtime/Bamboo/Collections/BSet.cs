using System;
using System.Collections;
using System.Collections.Generic;

namespace Bamboo.Collections;

public class BSet<T> : IEnumerable<T>, IEnumerable
{
	public struct Enumerator : IEnumerator<T>, IEnumerator, IDisposable
	{
		private readonly BSet<T> _set;

		private T _current;

		private int _index;

		public T Current => _current;

		object IEnumerator.Current => _current;

		public Enumerator(BSet<T> set)
		{
			_set = set;
			_current = default;
			_index = 0;
			if (_set != null)
			{
				_set._iterateCount++;
			}
		}

		public void Dispose()
		{
			if (_set != null)
			{
				_set._iterateCount--;
				if (_set._iterateCount == 0)
				{
					_set.ExecuteOperateQueue();
				}
			}
		}

		public bool MoveNext()
		{
			if (_set == null)
			{
				return false;
			}
			if (_set.Count == 0)
			{
				return false;
			}
			int length = _set._items.Length;
			for (int i = _index; i < length; i++)
			{
				if (_set._exists[i])
				{
					_current = _set._items[i];
					_index = i + 1;
					return true;
				}
			}
			return false;
		}

		public void Reset()
		{
			_index = 0;
			_current = default;
		}
	}

	internal enum OperateType
	{
		Add,
		Remove
	}

	internal struct OperateItem
	{
		public OperateType OperateType;

		public T Item;
	}

	private const int MIN_LENGTH = 8;

	private readonly BArrayPool<bool> _existsPool;

	private readonly BArrayPool<T> _itemsPool;

	private readonly BArrayPool<OperateItem> _operateItemsPool;

	private BArray<bool> _exists;

	private BArray<T> _items;

	private BArray<OperateItem> _operateItems;

	private int _iterateCount;

	private bool _isRecycled;

	private int _version;

	private int _count;

	private int _lastIndex;

	public bool IsRecycled => _isRecycled;

	public int Version => _version;

	public int Count
	{
		get
		{
			if (_isRecycled)
			{
				return 0;
			}
			return _count;
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
			return _items.Length;
		}
	}

	internal BSet(BArrayPool<bool> existsPool, BArrayPool<T> itemsPool, BArrayPool<OperateItem> operateItemsPool)
	{
		_version = 1;
		_existsPool = existsPool;
		_itemsPool = itemsPool;
		_operateItemsPool = operateItemsPool;
		_exists = _existsPool.Get(8);
		_items = _itemsPool.Get(8);
		_count = 0;
		_lastIndex = -1;
	}

	internal BSet(int initNum, BArrayPool<bool> existsPool, BArrayPool<T> itemsPool, BArrayPool<OperateItem> operateItemsPool)
	{
		_version = 1;
		_existsPool = existsPool;
		_itemsPool = itemsPool;
		_operateItemsPool = operateItemsPool;
		int length = Math.Max(8, initNum + (initNum >> 1));
		_exists = _existsPool.Get(length);
		_items = _itemsPool.Get(length);
		_count = 0;
		_lastIndex = -1;
	}

	internal void Renew()
	{
		if (_isRecycled)
		{
			_isRecycled = false;
			_version++;
			_exists = _existsPool.Get(8);
			_items = _itemsPool.Get(8);
			_count = 0;
			_lastIndex = -1;
		}
	}

	internal void Renew(int initNum)
	{
		if (_isRecycled)
		{
			_isRecycled = false;
			_version++;
			int length = Math.Max(8, initNum + (initNum >> 1));
			_exists = _existsPool.Get(length);
			_items = _itemsPool.Get(length);
			_count = 0;
			_lastIndex = -1;
		}
	}

	internal void Recycle()
	{
		if (_iterateCount > 0)
		{
			throw new Exception("Do not operate during iteration.");
		}
		_isRecycled = true;
		_version++;
		_existsPool.Recycle(_exists);
		_exists = null;
		_itemsPool.Recycle(_items);
		_items = null;
	}

	public bool Contains(T item)
	{
		if (_isRecycled)
		{
			return false;
		}
		EqualityComparer<T> equalityComparer = EqualityComparer<T>.Default;
		for (int i = 0; i < _items.Length; i++)
		{
			if (_exists[i] && equalityComparer.Equals(_items[i], item))
			{
				return true;
			}
		}
		return false;
	}

	public void Add(T item)
	{
		if (!_isRecycled)
		{
			if (_iterateCount > 0)
			{
				InnerAddToQueue(item);
			}
			else
			{
				InnerAdd(item);
			}
		}
	}

	public bool Remove(T item)
	{
		if (_isRecycled)
		{
			return false;
		}
		if (_iterateCount > 0)
		{
			InnerRemoveToQueue(item);
			return false;
		}
		return InnerRemove(item);
	}

	public void RemoveAt(int index)
	{
		if (!_isRecycled)
		{
			if (_iterateCount > 0)
			{
				throw new Exception("Do not operate during iteration.");
			}
			_items[index] = default;
			_exists[index] = false;
			_count--;
		}
	}

	public void Clear()
	{
		if (!_isRecycled)
		{
			if (_iterateCount > 0)
			{
				throw new Exception("Do not operate during iteration.");
			}
			_items.Clear();
			_exists.Clear();
			_count = 0;
			_lastIndex = -1;
		}
	}

	public void Compress()
	{
		if (_isRecycled)
		{
			return;
		}
		if (_iterateCount > 0)
		{
			throw new Exception("Do not operate during iteration.");
		}
		if (_count == 0)
		{
			_lastIndex = -1;
		}
		else
		{
			int num = 0;
			int length = _items.Length;
			for (int i = 0; i < length; i++)
			{
				if (_exists[i])
				{
					_exists[i] = false;
					_exists[num] = true;
					if (i != num)
					{
						_items[num] = _items[i];
						_items[i] = default;
					}
					num++;
				}
			}
			_lastIndex = num;
		}
		int length2 = Math.Max(8, _count + (_count >> 1));
		_items.ResetLength(length2);
		_exists.ResetLength(length2);
	}

	private void InnerAdd(T item)
	{
		_count++;
		int num = _items.Length;
		if (_count + (_count >> 1) > num)
		{
			num *= 2;
			_items.ResetLength(num);
			_exists.ResetLength(num);
		}
		int num2 = _lastIndex + 1;
		for (int i = num2; i < num; i++)
		{
			if (!_exists[i])
			{
				_exists[i] = true;
				_items[i] = item;
				_lastIndex = i;
				return;
			}
		}
		for (int j = 0; j < num2; j++)
		{
			if (!_exists[j])
			{
				_exists[j] = true;
				_items[j] = item;
				_lastIndex = j;
				return;
			}
		}
		throw new Exception("Impossible Exception." + $" _count : {_count}" + $" _items.Length : {_items.Length}" + $" _items.Capacity : {_items.Capacity}" + $" _lastIndex : {_lastIndex}");
	}

	private bool InnerRemove(T item)
	{
		int num = _items.IndexOf(item);
		if (num < 0)
		{
			return false;
		}
		_items[num] = default;
		_exists[num] = false;
		_count--;
		return true;
	}

	private void InnerAddToQueue(T item)
	{
		if (_operateItems == null)
		{
			_operateItems = _operateItemsPool.Get(1);
			_operateItems[0] = new OperateItem
			{
				OperateType = OperateType.Add,
				Item = item
			};
		}
		else
		{
			int length = _operateItems.Length;
			_operateItems.ResetLength(length + 1);
			_operateItems[length] = new OperateItem
			{
				OperateType = OperateType.Add,
				Item = item
			};
		}
	}

	private void InnerRemoveToQueue(T item)
	{
		if (_operateItems == null)
		{
			_operateItems = _operateItemsPool.Get(1);
			_operateItems[0] = new OperateItem
			{
				OperateType = OperateType.Remove,
				Item = item
			};
		}
		else
		{
			int length = _operateItems.Length;
			_operateItems.ResetLength(length + 1);
			_operateItems[length] = new OperateItem
			{
				OperateType = OperateType.Remove,
				Item = item
			};
		}
	}

	private void ExecuteOperateQueue()
	{
		if (_operateItems == null)
		{
			return;
		}
		if (_isRecycled)
		{
			_operateItemsPool.Recycle(_operateItems);
			_operateItems = null;
			return;
		}
		int length = _operateItems.Length;
		for (int i = 0; i < length; i++)
		{
			switch (_operateItems[i].OperateType)
			{
			case OperateType.Add:
				InnerAdd(_operateItems[i].Item);
				break;
			case OperateType.Remove:
				InnerRemove(_operateItems[i].Item);
				break;
			}
		}
		_operateItemsPool.Recycle(_operateItems);
		_operateItems = null;
	}

	public Enumerator GetEnumerator()
	{
		if (_isRecycled)
		{
			return new Enumerator(null);
		}
		return new Enumerator(this);
	}

	IEnumerator<T> IEnumerable<T>.GetEnumerator()
	{
		if (_isRecycled)
		{
			return new Enumerator(null);
		}
		return new Enumerator(this);
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		if (_isRecycled)
		{
			return new Enumerator(null);
		}
		return new Enumerator(this);
	}
}
