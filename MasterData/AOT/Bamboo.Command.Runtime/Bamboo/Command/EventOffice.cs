using System;
using System.Collections.Generic;

namespace Bamboo.Command;

public class EventOffice
{
	private readonly EventStation _root;

	private readonly Dictionary<int, EventStation> _stationMap = new Dictionary<int, EventStation>();

	private readonly Dictionary<int, LetterChannel> _idChannelMap = new Dictionary<int, LetterChannel>();

	private readonly List<BasePeekInfo> _swapPeekInfos = new List<BasePeekInfo>();

	private readonly PeekInfoComparer _swapPeekInfoComparer = new PeekInfoComparer();

	private readonly PeekInfosCachePool _sendPeeksCachePool = new PeekInfosCachePool();

	public EventStation Root => _root;

	public EventOffice(int rootID)
	{
		_root = new EventStation(rootID, null, this, 0, 0);
		_stationMap.Add(rootID, _root);
	}

	public EventStation NewEventStation(int id, int parentID)
	{
		_stationMap.TryGetValue(parentID, out var value);
		if (value == null)
		{
			throw new Exception($"parent is null. parentName: {parentID}");
		}
		return NewEventStation(id, value);
	}

	public EventStation NewEventStation(int id, EventStation parent)
	{
		EventStation eventStation = new EventStation(id, parent, this, parent.Depth + 1, parent.ChildCount);
		_stationMap.Add(id, eventStation);
		return eventStation;
	}

	public EventStation GetEventStation(int id)
	{
		_stationMap.TryGetValue(id, out var value);
		return value;
	}

	internal void Send(EventStation sender, int id)
	{
		PeekInfosCache peekInfosCache = _sendPeeksCachePool.Get();
		_idChannelMap.TryGetValue(id, out var value);
		if (value == null)
		{
			return;
		}
		foreach (KeyValuePair<int, List<BasePeekInfo>> item in value.OrderPeekInfoMap)
		{
			List<BasePeekInfo> value2 = item.Value;
			if (value2.Count == 0)
			{
				continue;
			}
			if (value2.Count == 1)
			{
				if (value2[0].Peeker.IsActive)
				{
					peekInfosCache.Infos.Add(value2[0]);
				}
				continue;
			}
			_swapPeekInfos.Clear();
			foreach (BasePeekInfo item2 in value2)
			{
				if (item2.Peeker.IsActive)
				{
					_swapPeekInfos.Add(item2);
				}
			}
			if (_swapPeekInfos.Count == 0)
			{
				continue;
			}
			if (_swapPeekInfos.Count == 1)
			{
				peekInfosCache.Infos.Add(_swapPeekInfos[0]);
				continue;
			}
			_swapPeekInfoComparer.Init(sender);
			_swapPeekInfos.Sort(_swapPeekInfoComparer);
			foreach (BasePeekInfo swapPeekInfo in _swapPeekInfos)
			{
				peekInfosCache.Infos.Add(swapPeekInfo);
			}
		}
		foreach (BasePeekInfo info in peekInfosCache.Infos)
		{
			if (info is PeekInfo peekInfo)
			{
				if (peekInfo.Action != null && !peekInfo.Action())
				{
					break;
				}
				if (peekInfo.IsOnce)
				{
					value.Remove(peekInfo.Peeker, peekInfo.Action);
				}
			}
		}
		peekInfosCache.Recycle();
	}

	internal void Send<T>(EventStation sender, int id, T arg)
	{
		PeekInfosCache peekInfosCache = _sendPeeksCachePool.Get();
		_idChannelMap.TryGetValue(id, out var value);
		if (value == null)
		{
			return;
		}
		foreach (KeyValuePair<int, List<BasePeekInfo>> item in value.OrderPeekInfoMap)
		{
			List<BasePeekInfo> value2 = item.Value;
			if (value2.Count == 0)
			{
				continue;
			}
			if (value2.Count == 1)
			{
				if (value2[0].Peeker.IsActive)
				{
					peekInfosCache.Infos.Add(value2[0]);
				}
				continue;
			}
			_swapPeekInfos.Clear();
			foreach (BasePeekInfo item2 in value2)
			{
				if (item2.Peeker.IsActive)
				{
					_swapPeekInfos.Add(item2);
				}
			}
			if (_swapPeekInfos.Count == 0)
			{
				continue;
			}
			if (_swapPeekInfos.Count == 1)
			{
				peekInfosCache.Infos.Add(_swapPeekInfos[0]);
				continue;
			}
			_swapPeekInfoComparer.Init(sender);
			_swapPeekInfos.Sort(_swapPeekInfoComparer);
			foreach (BasePeekInfo swapPeekInfo in _swapPeekInfos)
			{
				peekInfosCache.Infos.Add(swapPeekInfo);
			}
		}
		foreach (BasePeekInfo info in peekInfosCache.Infos)
		{
			if (info is PeekInfo<T> peekInfo)
			{
				if (peekInfo.Action != null && !peekInfo.Action(arg))
				{
					return;
				}
				if (peekInfo.IsOnce)
				{
					value.Remove(peekInfo.Peeker, peekInfo.Action);
				}
			}
		}
		peekInfosCache.Recycle();
	}

	internal void Send<T1, T2>(EventStation sender, int id, T1 arg1, T2 arg2)
	{
		PeekInfosCache peekInfosCache = _sendPeeksCachePool.Get();
		_idChannelMap.TryGetValue(id, out var value);
		if (value == null)
		{
			return;
		}
		foreach (KeyValuePair<int, List<BasePeekInfo>> item in value.OrderPeekInfoMap)
		{
			List<BasePeekInfo> value2 = item.Value;
			if (value2.Count == 0)
			{
				continue;
			}
			if (value2.Count == 1)
			{
				if (value2[0].Peeker.IsActive)
				{
					peekInfosCache.Infos.Add(value2[0]);
				}
				continue;
			}
			_swapPeekInfos.Clear();
			foreach (BasePeekInfo item2 in value2)
			{
				if (item2.Peeker.IsActive)
				{
					_swapPeekInfos.Add(item2);
				}
			}
			if (_swapPeekInfos.Count == 0)
			{
				continue;
			}
			if (_swapPeekInfos.Count == 1)
			{
				peekInfosCache.Infos.Add(_swapPeekInfos[0]);
				continue;
			}
			_swapPeekInfoComparer.Init(sender);
			_swapPeekInfos.Sort(_swapPeekInfoComparer);
			foreach (BasePeekInfo swapPeekInfo in _swapPeekInfos)
			{
				peekInfosCache.Infos.Add(swapPeekInfo);
			}
		}
		foreach (BasePeekInfo info in peekInfosCache.Infos)
		{
			if (info is PeekInfo<T1, T2> peekInfo)
			{
				if (peekInfo.Action != null && !peekInfo.Action(arg1, arg2))
				{
					return;
				}
				if (peekInfo.IsOnce)
				{
					value.Remove(peekInfo.Peeker, peekInfo.Action);
				}
			}
		}
		peekInfosCache.Recycle();
	}

	internal void Send<T1, T2, T3>(EventStation sender, int id, T1 arg1, T2 arg2, T3 arg3)
	{
		PeekInfosCache peekInfosCache = _sendPeeksCachePool.Get();
		_idChannelMap.TryGetValue(id, out var value);
		if (value == null)
		{
			return;
		}
		foreach (KeyValuePair<int, List<BasePeekInfo>> item in value.OrderPeekInfoMap)
		{
			List<BasePeekInfo> value2 = item.Value;
			if (value2.Count == 0)
			{
				continue;
			}
			if (value2.Count == 1)
			{
				if (value2[0].Peeker.IsActive)
				{
					peekInfosCache.Infos.Add(value2[0]);
				}
				continue;
			}
			_swapPeekInfos.Clear();
			foreach (BasePeekInfo item2 in value2)
			{
				if (item2.Peeker.IsActive)
				{
					_swapPeekInfos.Add(item2);
				}
			}
			if (_swapPeekInfos.Count == 0)
			{
				continue;
			}
			if (_swapPeekInfos.Count == 1)
			{
				peekInfosCache.Infos.Add(_swapPeekInfos[0]);
				continue;
			}
			_swapPeekInfoComparer.Init(sender);
			_swapPeekInfos.Sort(_swapPeekInfoComparer);
			foreach (BasePeekInfo swapPeekInfo in _swapPeekInfos)
			{
				peekInfosCache.Infos.Add(swapPeekInfo);
			}
		}
		foreach (BasePeekInfo info in peekInfosCache.Infos)
		{
			if (info is PeekInfo<T1, T2, T3> peekInfo)
			{
				if (peekInfo.Action != null && !peekInfo.Action(arg1, arg2, arg3))
				{
					return;
				}
				if (peekInfo.IsOnce)
				{
					value.Remove(peekInfo.Peeker, peekInfo.Action);
				}
			}
		}
		peekInfosCache.Recycle();
	}

	internal void AddPeek(int id, int order, EventStation peeker, Func<bool> action, bool isOnce)
	{
		_idChannelMap.TryGetValue(id, out var value);
		if (value == null)
		{
			value = new LetterChannel();
			_idChannelMap[id] = value;
		}
		value.Add(order, peeker, action, isOnce);
	}

	internal void AddPeek<T>(int id, int order, EventStation peeker, Func<T, bool> action, bool isOnce)
	{
		_idChannelMap.TryGetValue(id, out var value);
		if (value == null)
		{
			value = new LetterChannel();
			_idChannelMap[id] = value;
		}
		value.Add(order, peeker, action, isOnce);
	}

	internal void AddPeek<T1, T2>(int id, int order, EventStation peeker, Func<T1, T2, bool> action, bool isOnce)
	{
		_idChannelMap.TryGetValue(id, out var value);
		if (value == null)
		{
			value = new LetterChannel();
			_idChannelMap[id] = value;
		}
		value.Add(order, peeker, action, isOnce);
	}

	internal void AddPeek<T1, T2, T3>(int id, int order, EventStation peeker, Func<T1, T2, T3, bool> action, bool isOnce)
	{
		_idChannelMap.TryGetValue(id, out var value);
		if (value == null)
		{
			value = new LetterChannel();
			_idChannelMap[id] = value;
		}
		value.Add(order, peeker, action, isOnce);
	}

	internal void RemovePeek(int id, EventStation peeker, Func<bool> action)
	{
		_idChannelMap.TryGetValue(id, out var value);
		value?.Remove(peeker, action);
	}

	internal void RemovePeek<T>(int id, EventStation peeker, Func<T, bool> action)
	{
		_idChannelMap.TryGetValue(id, out var value);
		value?.Remove(peeker, action);
	}

	internal void RemovePeek<T1, T2>(int id, EventStation peeker, Func<T1, T2, bool> action)
	{
		_idChannelMap.TryGetValue(id, out var value);
		value?.Remove(peeker, action);
	}

	internal void RemovePeek<T1, T2, T3>(int id, EventStation peeker, Func<T1, T2, T3, bool> action)
	{
		_idChannelMap.TryGetValue(id, out var value);
		value?.Remove(peeker, action);
	}

	internal void RemovePeek(EventStation peeker)
	{
		foreach (KeyValuePair<int, LetterChannel> item in _idChannelMap)
		{
			item.Value?.Remove(peeker);
		}
	}
}
