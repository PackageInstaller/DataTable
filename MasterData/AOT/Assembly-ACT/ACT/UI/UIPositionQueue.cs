using System;
using System.Collections.Generic;
using ACT.Model;
using ACT.Utility;
using UnityEngine;

namespace ACT.UI;

public class UIPositionQueue
{
	private readonly UIPositionQueueSetting _profile;

	private readonly List<HudCpQueueItem> _items;

	private HudCpQueueItem _activeItem;

	public UIPosition Position => _profile.Position;

	public UIPositionQueueSetting Profile => _profile;

	public bool HasActiveItem => _activeItem != null;

	public int PendingCount => _items.Count;

	public UIPositionQueue(UIPositionQueueSetting profile)
	{
		_profile = profile;
		_items = new List<HudCpQueueItem>();
	}

	public void PositionEnqueue(HudCpQueueItem item)
	{
		if (item != null)
		{
			item.EnqueueTime = Time.time;
			_items.Add(item);
			ResortKeepingActiveAtFront();
		}
	}

	public void PositionDequeue()
	{
		if (_activeItem != null)
		{
			_items.Remove(_activeItem);
			_activeItem = null;
		}
	}

	public bool HudCpCanOpen(Func<UIPositionQueue, bool> canOpenCondition)
	{
		if (canOpenCondition != null && !canOpenCondition(this))
		{
			return false;
		}
		if (HasActiveItem)
		{
			return false;
		}
		if (_items.Count == 0)
		{
			return false;
		}
		while (_items.Count > 0)
		{
			HudCpQueueItem hudCpQueueItem = _items[0];
			if (!(hudCpQueueItem.TimeoutSeconds > 0f) || !(Time.time - hudCpQueueItem.EnqueueTime >= hudCpQueueItem.TimeoutSeconds))
			{
				break;
			}
			_items.RemoveAt(0);
		}
		if (_items.Count == 0)
		{
			return false;
		}
		return true;
	}

	public HudCpQueueItem GetQueueHead()
	{
		return _items[0];
	}

	public void OnQueueHeadShow()
	{
		if (_activeItem == null && _items.Count != 0)
		{
			_activeItem = _items[0];
		}
	}

	public void ClearQueueByItems(HudComponentType type)
	{
		for (int num = _items.Count - 1; num >= 0; num--)
		{
			if (_items[num] != _activeItem && _items[num].HudComponentType == type)
			{
				_items.RemoveAt(num);
			}
		}
	}

	public bool RemovePendingItem(HudComponentType type, object data)
	{
		for (int num = _items.Count - 1; num >= 0; num--)
		{
			HudCpQueueItem hudCpQueueItem = _items[num];
			if (hudCpQueueItem != _activeItem && hudCpQueueItem.HudComponentType == type && hudCpQueueItem.HudComponentUIData == data)
			{
				_items.RemoveAt(num);
				return true;
			}
		}
		return false;
	}

	public void OnQueueHeadShowFail()
	{
		if (_activeItem != null)
		{
			_items.Remove(_activeItem);
			_activeItem = null;
		}
	}

	public bool HeadIgnorePriorityRulePerItem()
	{
		if (_items.Count == 0)
		{
			return false;
		}
		return _items[0].IgnorePriorityRule;
	}

	private void ResortKeepingActiveAtFront()
	{
		if (_items.Count > 1)
		{
			if (_activeItem == null)
			{
				_items.Sort(SortUtility.HudUIQueueItemPriority);
			}
			else if (!_items.Remove(_activeItem))
			{
				_activeItem = null;
				_items.Sort(SortUtility.HudUIQueueItemPriority);
			}
			else
			{
				_items.Sort(SortUtility.HudUIQueueItemPriority);
				_items.Insert(0, _activeItem);
			}
		}
	}
}
