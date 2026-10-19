using System;
using System.Collections;
using System.Collections.Generic;

namespace Bamboo.Collections;

public class BSortedMap<TKey, TValue> : IEnumerable<KeyValuePair<TKey, TValue>>, IEnumerable
{
	public struct Enumerator : IEnumerator<KeyValuePair<TKey, TValue>>, IEnumerator, IDisposable
	{
		private readonly BSortedMap<TKey, TValue> _map;

		private KeyValuePair<TKey, TValue> _current;

		private int _index;

		public KeyValuePair<TKey, TValue> Current => _current;

		object IEnumerator.Current => _current;

		public Enumerator(BSortedMap<TKey, TValue> map)
		{
			_map = map;
			_current = default;
			_index = 0;
			if (_map != null)
			{
				_map._iterateCount++;
			}
		}

		public void Dispose()
		{
			if (_map != null)
			{
				_map._iterateCount--;
				if (_map._iterateCount == 0)
				{
					_map.ExecuteOperateQueue();
				}
			}
		}

		public bool MoveNext()
		{
			if (_map == null)
			{
				return false;
			}
			if (_map.Count == 0)
			{
				return false;
			}
			int length = _map._keys.Length;
			for (int i = _index; i < length; i++)
			{
				if (_map._exists[i])
				{
					_current = new KeyValuePair<TKey, TValue>(_map._keys[i], _map._values[i]);
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
		Insert,
		Remove
	}

	internal struct OperateItem
	{
		public OperateType OperateType;

		public TKey Key;

		public TValue Value;
	}

	private const int MIN_LENGTH = 8;

	private readonly BArrayPool<bool> _existsPool;

	private readonly BArrayPool<TKey> _keysPool;

	private readonly BArrayPool<TValue> _valuesPool;

	private readonly BArrayPool<OperateItem> _operateItemsPool;

	private BArray<bool> _exists;

	private BArray<TKey> _keys;

	private BArray<TValue> _values;

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
			return _keys.Length;
		}
	}

	public TValue this[TKey key]
	{
		get
		{
			if (_isRecycled)
			{
				return default;
			}
			int num = FindEntry(key);
			if (num < 0)
			{
				throw new Exception($"{key} didn't exist.");
			}
			return _values[num];
		}
		set
		{
			if (!_isRecycled)
			{
				if (_iterateCount > 0)
				{
					InnerInsertToQueue(key, value);
				}
				else
				{
					Insert(key, value, add: false);
				}
			}
		}
	}

	internal BSortedMap(BArrayPool<bool> existsPool, BArrayPool<TKey> keysPool, BArrayPool<TValue> valuesPool, BArrayPool<OperateItem> operateItemsPool)
	{
		_version = 1;
		_existsPool = existsPool;
		_keysPool = keysPool;
		_valuesPool = valuesPool;
		_operateItemsPool = operateItemsPool;
		_exists = _existsPool.Get(8);
		_keys = _keysPool.Get(8);
		_values = _valuesPool.Get(8);
		_count = 0;
		_lastIndex = -1;
	}

	internal BSortedMap(int initNum, BArrayPool<bool> existsPool, BArrayPool<TKey> keysPool, BArrayPool<TValue> valuesPool, BArrayPool<OperateItem> operateItemsPool)
	{
		_version = 1;
		_existsPool = existsPool;
		_keysPool = keysPool;
		_valuesPool = valuesPool;
		_operateItemsPool = operateItemsPool;
		int length = Math.Max(8, initNum + (initNum >> 1));
		_exists = _existsPool.Get(length);
		_keys = _keysPool.Get(length);
		_values = _valuesPool.Get(length);
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
			_keys = _keysPool.Get(8);
			_values = _valuesPool.Get(8);
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
			_keys = _keysPool.Get(length);
			_values = _valuesPool.Get(length);
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
		_keysPool.Recycle(_keys);
		_keys = null;
		_valuesPool.Recycle(_values);
		_values = null;
	}

	public bool ContainsKey(TKey key)
	{
		if (_isRecycled)
		{
			return false;
		}
		return FindEntry(key) >= 0;
	}

	public bool ContainsValue(TValue value)
	{
		if (_isRecycled)
		{
			return false;
		}
		EqualityComparer<TValue> equalityComparer = EqualityComparer<TValue>.Default;
		for (int i = 0; i < _values.Length; i++)
		{
			if (_exists[i] && equalityComparer.Equals(_values[i], value))
			{
				return true;
			}
		}
		return false;
	}

	public void Add(TKey key, TValue value)
	{
		if (!_isRecycled)
		{
			if (_iterateCount > 0)
			{
				InnerAddToQueue(key, value);
			}
			else
			{
				Insert(key, value, add: true);
			}
		}
	}

	public bool Remove(TKey key)
	{
		if (_isRecycled)
		{
			return false;
		}
		if (_iterateCount > 0)
		{
			InnerRemoveToQueue(key);
			return false;
		}
		return InnerRemove(key);
	}

	public bool TryGetValue(TKey key, out TValue value)
	{
		if (_isRecycled)
		{
			value = default;
			return false;
		}
		int num = FindEntry(key);
		if (num < 0)
		{
			value = default;
			return false;
		}
		value = _values[num];
		return true;
	}

	public void Clear()
	{
		if (!_isRecycled)
		{
			if (_iterateCount > 0)
			{
				throw new Exception("Do not operate during iteration.");
			}
			_keys.Clear();
			_values.Clear();
			_exists.Clear();
			_count = 0;
			_lastIndex = -1;
		}
	}

	public void Compress()
	{
		if (!_isRecycled)
		{
			if (_iterateCount > 0)
			{
				throw new Exception("Do not operate during iteration.");
			}
			InnerCompress();
			int length = Math.Max(8, _count + (_count >> 1));
			_keys.ResetLength(length);
			_values.ResetLength(length);
			_exists.ResetLength(length);
		}
	}

	private void InnerCompress()
	{
		if (_count == 0)
		{
			_lastIndex = -1;
			return;
		}
		int num = 0;
		int length = _keys.Length;
		for (int i = 0; i < length; i++)
		{
			if (_exists[i])
			{
				_exists[i] = false;
				_exists[num] = true;
				if (i != num)
				{
					_keys[num] = _keys[i];
					_keys[i] = default;
					_values[num] = _values[i];
					_values[i] = default;
				}
				num++;
			}
		}
		_lastIndex = num;
	}

	private int FindEntry(TKey key)
	{
		EqualityComparer<TKey> equalityComparer = EqualityComparer<TKey>.Default;
		for (int i = 0; i < _keys.Length; i++)
		{
			if (_exists[i] && equalityComparer.Equals(_keys[i], key))
			{
				return i;
			}
		}
		return -1;
	}

	private void Insert(TKey key, TValue value, bool add)
	{
		EqualityComparer<TKey> equalityComparer = EqualityComparer<TKey>.Default;
		for (int i = 0; i < _keys.Length; i++)
		{
			if (_exists[i] && equalityComparer.Equals(_keys[i], key))
			{
				if (add)
				{
					throw new Exception($"{key} already exists.");
				}
				_values[i] = value;
				return;
			}
		}
		_count++;
		int num = _keys.Length;
		if (_count + (_count >> 1) > num)
		{
			num *= 2;
			_keys.ResetLength(num);
			_values.ResetLength(num);
			_exists.ResetLength(num);
		}
		for (int j = _lastIndex + 1; j < num; j++)
		{
			if (!_exists[j])
			{
				_exists[j] = true;
				_keys[j] = key;
				_values[j] = value;
				_lastIndex = j;
				return;
			}
		}
		InnerCompress();
		for (int k = _lastIndex + 1; k < num; k++)
		{
			if (!_exists[k])
			{
				_exists[k] = true;
				_keys[k] = key;
				_values[k] = value;
				_lastIndex = k;
				return;
			}
		}
		throw new Exception("Impossible Exception." + $" _count : {_count}" + $" _keys.Length : {_keys.Length}" + $" _keys.Capacity : {_keys.Capacity}" + $" _lastIndex : {_lastIndex}");
	}

	private bool InnerRemove(TKey key)
	{
		EqualityComparer<TKey> equalityComparer = EqualityComparer<TKey>.Default;
		for (int i = 0; i < _keys.Length; i++)
		{
			if (_exists[i] && equalityComparer.Equals(_keys[i], key))
			{
				_keys[i] = default;
				_values[i] = default;
				_exists[i] = false;
				_count--;
				return true;
			}
		}
		return false;
	}

	private void InnerAddToQueue(TKey key, TValue value)
	{
		if (_operateItems == null)
		{
			_operateItems = _operateItemsPool.Get(1);
			_operateItems[0] = new OperateItem
			{
				OperateType = OperateType.Add,
				Key = key,
				Value = value
			};
		}
		else
		{
			int length = _operateItems.Length;
			_operateItems.ResetLength(length + 1);
			_operateItems[length] = new OperateItem
			{
				OperateType = OperateType.Add,
				Key = key,
				Value = value
			};
		}
	}

	private void InnerInsertToQueue(TKey key, TValue value)
	{
		if (_operateItems == null)
		{
			_operateItems = _operateItemsPool.Get(1);
			_operateItems[0] = new OperateItem
			{
				OperateType = OperateType.Insert,
				Key = key,
				Value = value
			};
		}
		else
		{
			int length = _operateItems.Length;
			_operateItems.ResetLength(length + 1);
			_operateItems[length] = new OperateItem
			{
				OperateType = OperateType.Insert,
				Key = key,
				Value = value
			};
		}
	}

	private void InnerRemoveToQueue(TKey key)
	{
		if (_operateItems == null)
		{
			_operateItems = _operateItemsPool.Get(1);
			_operateItems[0] = new OperateItem
			{
				OperateType = OperateType.Remove,
				Key = key
			};
		}
		else
		{
			int length = _operateItems.Length;
			_operateItems.ResetLength(length + 1);
			_operateItems[length] = new OperateItem
			{
				OperateType = OperateType.Remove,
				Key = key
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
				Insert(_operateItems[i].Key, _operateItems[i].Value, add: true);
				break;
			case OperateType.Insert:
				Insert(_operateItems[i].Key, _operateItems[i].Value, add: false);
				break;
			case OperateType.Remove:
				InnerRemove(_operateItems[i].Key);
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

	IEnumerator<KeyValuePair<TKey, TValue>> IEnumerable<KeyValuePair<TKey, TValue>>.GetEnumerator()
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
