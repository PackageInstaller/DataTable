using System;
using System.Collections;
using System.Collections.Generic;

namespace Bamboo.Collections;

public class BList<T> : IEnumerable<T>, IEnumerable
{
	public struct Enumerator : IEnumerator<T>, IEnumerator, IDisposable
	{
		private readonly BList<T> _list;

		private T _current;

		private int _index;

		public T Current => _current;

		object IEnumerator.Current => _current;

		public Enumerator(BList<T> list)
		{
			_list = list;
			_current = default;
			_index = 0;
			if (_list != null)
			{
				_list._iterateCount++;
			}
		}

		public void Dispose()
		{
			if (_list != null)
			{
				_list._iterateCount--;
				if (_list._iterateCount == 0)
				{
					_list.ExecuteOperateQueue();
				}
			}
		}

		public bool MoveNext()
		{
			if (_list == null)
			{
				return false;
			}
			if (_list.Count == 0)
			{
				return false;
			}
			if (_index >= _list._count)
			{
				return false;
			}
			_current = _list._items[_index++];
			return true;
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

	private readonly BArrayPool<T> _itemsPool;

	private readonly BArrayPool<OperateItem> _operateItemsPool;

	private BArray<T> _items;

	private BArray<OperateItem> _operateItems;

	private int _iterateCount;

	private bool _isRecycled;

	private int _version;

	private int _count;

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

	public T this[int index]
	{
		get
		{
			if (_isRecycled)
			{
				return default;
			}
			if (index >= _count)
			{
				throw new ArgumentOutOfRangeException("index", index, string.Empty);
			}
			return _items[index];
		}
		set
		{
			if (!_isRecycled)
			{
				if (index >= _count)
				{
					throw new ArgumentOutOfRangeException("index", index, string.Empty);
				}
				_items[index] = value;
			}
		}
	}

	internal BList(BArrayPool<T> itemsPool, BArrayPool<OperateItem> operateItemsPool)
	{
		_version = 1;
		_itemsPool = itemsPool;
		_operateItemsPool = operateItemsPool;
		_items = _itemsPool.Get(8);
		_count = 0;
	}

	internal BList(int initNum, BArrayPool<T> itemsPool, BArrayPool<OperateItem> operateItemsPool)
	{
		_version = 1;
		_itemsPool = itemsPool;
		_operateItemsPool = operateItemsPool;
		int length = Math.Max(8, initNum + (initNum >> 1));
		_items = _itemsPool.Get(length);
		_count = 0;
	}

	internal void Renew()
	{
		if (_isRecycled)
		{
			_isRecycled = false;
			_version++;
			_items = _itemsPool.Get(8);
			_count = 0;
		}
	}

	internal void Renew(int initNum)
	{
		if (_isRecycled)
		{
			_isRecycled = false;
			_version++;
			int length = Math.Max(8, initNum);
			_items = _itemsPool.Get(length);
			_count = 0;
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
		for (int i = 0; i < _count; i++)
		{
			if (equalityComparer.Equals(_items[i], item))
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
			if (index >= _count)
			{
				throw new ArgumentOutOfRangeException("index", index, string.Empty);
			}
			_items.RemoveAt(index);
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
			_count = 0;
		}
	}

	private void InnerAdd(T item)
	{
		_count++;
		int length = _items.Length;
		if (_count > length)
		{
			length *= 2;
			_items.ResetLength(length);
		}
		_items[_count - 1] = item;
	}

	private bool InnerRemove(T item)
	{
		int num = _items.IndexOf(item);
		if (num < 0 || num >= _count)
		{
			return false;
		}
		_items.RemoveAt(num);
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
