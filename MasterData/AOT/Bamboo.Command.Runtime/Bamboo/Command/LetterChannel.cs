using System;
using System.Collections.Generic;

namespace Bamboo.Command;

internal class LetterChannel
{
	private EventStation _removePeeker;

	private readonly SortedDictionary<int, List<BasePeekInfo>> _orderPeekInfoMap = new SortedDictionary<int, List<BasePeekInfo>>();

	public SortedDictionary<int, List<BasePeekInfo>> OrderPeekInfoMap => _orderPeekInfoMap;

	public void Add(int order, EventStation peeker, Func<bool> action, bool isOnce)
	{
		_orderPeekInfoMap.TryGetValue(order, out var value);
		if (value == null)
		{
			value = new List<BasePeekInfo>();
			_orderPeekInfoMap[order] = value;
		}
		value.Add(new PeekInfo
		{
			Peeker = peeker,
			Action = action,
			IsOnce = isOnce
		});
	}

	public void Add<T>(int order, EventStation peeker, Func<T, bool> action, bool isOnce)
	{
		_orderPeekInfoMap.TryGetValue(order, out var value);
		if (value == null)
		{
			value = new List<BasePeekInfo>();
			_orderPeekInfoMap[order] = value;
		}
		value.Add(new PeekInfo<T>
		{
			Peeker = peeker,
			Action = action,
			IsOnce = isOnce
		});
	}

	public void Add<T1, T2>(int order, EventStation peeker, Func<T1, T2, bool> action, bool isOnce)
	{
		_orderPeekInfoMap.TryGetValue(order, out var value);
		if (value == null)
		{
			value = new List<BasePeekInfo>();
			_orderPeekInfoMap[order] = value;
		}
		value.Add(new PeekInfo<T1, T2>
		{
			Peeker = peeker,
			Action = action,
			IsOnce = isOnce
		});
	}

	public void Add<T1, T2, T3>(int order, EventStation peeker, Func<T1, T2, T3, bool> action, bool isOnce)
	{
		_orderPeekInfoMap.TryGetValue(order, out var value);
		if (value == null)
		{
			value = new List<BasePeekInfo>();
			_orderPeekInfoMap[order] = value;
		}
		value.Add(new PeekInfo<T1, T2, T3>
		{
			Peeker = peeker,
			Action = action,
			IsOnce = isOnce
		});
	}

	public void Remove(EventStation peeker, Func<bool> action)
	{
		foreach (KeyValuePair<int, List<BasePeekInfo>> item in _orderPeekInfoMap)
		{
			List<BasePeekInfo> value = item.Value;
			if (value == null || value.Count == 0)
			{
				continue;
			}
			for (int num = value.Count - 1; num >= 0; num--)
			{
				if (value[num].Peeker == peeker && value[num] is PeekInfo peekInfo && peekInfo.Action == action)
				{
					value.RemoveAt(num);
					return;
				}
			}
		}
	}

	public void Remove<T>(EventStation peeker, Func<T, bool> action)
	{
		foreach (KeyValuePair<int, List<BasePeekInfo>> item in _orderPeekInfoMap)
		{
			List<BasePeekInfo> value = item.Value;
			if (value == null || value.Count == 0)
			{
				continue;
			}
			for (int num = value.Count - 1; num >= 0; num--)
			{
				if (value[num].Peeker == peeker && value[num] is PeekInfo<T> peekInfo && peekInfo.Action == action)
				{
					value.RemoveAt(num);
					return;
				}
			}
		}
	}

	public void Remove<T1, T2>(EventStation peeker, Func<T1, T2, bool> action)
	{
		foreach (KeyValuePair<int, List<BasePeekInfo>> item in _orderPeekInfoMap)
		{
			List<BasePeekInfo> value = item.Value;
			if (value == null || value.Count == 0)
			{
				continue;
			}
			for (int num = value.Count - 1; num >= 0; num--)
			{
				if (value[num].Peeker == peeker && value[num] is PeekInfo<T1, T2> peekInfo && peekInfo.Action == action)
				{
					value.RemoveAt(num);
					return;
				}
			}
		}
	}

	public void Remove<T1, T2, T3>(EventStation peeker, Func<T1, T2, T3, bool> action)
	{
		foreach (KeyValuePair<int, List<BasePeekInfo>> item in _orderPeekInfoMap)
		{
			List<BasePeekInfo> value = item.Value;
			if (value == null || value.Count == 0)
			{
				continue;
			}
			for (int num = value.Count - 1; num >= 0; num--)
			{
				if (value[num].Peeker == peeker && value[num] is PeekInfo<T1, T2, T3> peekInfo && peekInfo.Action == action)
				{
					value.RemoveAt(num);
					return;
				}
			}
		}
	}

	public void Remove(EventStation peeker)
	{
		foreach (KeyValuePair<int, List<BasePeekInfo>> item in _orderPeekInfoMap)
		{
			List<BasePeekInfo> value = item.Value;
			if (value != null && value.Count != 0)
			{
				_removePeeker = peeker;
				value.RemoveAll(PredicateRemovePeeker);
			}
		}
		_removePeeker = null;
	}

	private bool PredicateRemovePeeker(BasePeekInfo peekInfo)
	{
		return peekInfo.Peeker == _removePeeker;
	}
}
