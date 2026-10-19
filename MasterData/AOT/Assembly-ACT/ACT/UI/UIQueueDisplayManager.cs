using System.Collections.Generic;
using ACT.Model;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class UIQueueDisplayManager
{
	private readonly Dictionary<UIPosition, UIPositionQueue> _queues;

	private readonly Dictionary<UIPosition, UIPositionQueueSetting> _settings;

	private bool _priorityEnabled;

	private UIPosition _priorityPosition;

	public Dictionary<UIPosition, UIPositionQueue> queues => _queues;

	public Dictionary<UIPosition, UIPositionQueueSetting> settings => _settings;

	public bool queueHasActiveItem { get; private set; }

	public UIQueueDisplayManager(List<UIPositionQueueSetting> settings = null)
	{
		_queues = new Dictionary<UIPosition, UIPositionQueue>();
		_settings = new Dictionary<UIPosition, UIPositionQueueSetting>();
		if (settings == null)
		{
			settings = new List<UIPositionQueueSetting>
			{
				new UIPositionQueueSetting(UIPosition.Top),
				new UIPositionQueueSetting(UIPosition.UpperMiddle),
				new UIPositionQueueSetting(UIPosition.Center),
				new UIPositionQueueSetting(UIPosition.LowerMiddle),
				new UIPositionQueueSetting(UIPosition.MiddleBottom),
				new UIPositionQueueSetting(UIPosition.LeftTop),
				new UIPositionQueueSetting(UIPosition.LeftBottom)
			};
		}
		foreach (UIPositionQueueSetting setting in settings)
		{
			_settings[setting.Position] = setting;
			_queues[setting.Position] = new UIPositionQueue(setting);
		}
	}

	public UIPositionQueueSetting GetSetting(UIPosition pos)
	{
		return _settings[pos];
	}

	public UIPositionQueue GetQueue(UIPosition pos)
	{
		return _queues[pos];
	}

	public void EnablePriority(UIPosition priorityPosition)
	{
		_priorityEnabled = true;
		_priorityPosition = priorityPosition;
	}

	public void DisablePriority()
	{
		_priorityEnabled = false;
	}

	public void EnqueueHudCp(HudCpQueueItem item)
	{
		UIPositionQueue value;
		if (item == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("Hud入队元素为空");
			}
		}
		else if (!_queues.TryGetValue(item.Position, out value))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"找不到该分区的UI队列：{item.Position}");
			}
		}
		else
		{
			value.PositionEnqueue(item);
		}
	}

	public void ClearQueueItemsByCpType(UIPosition position, HudComponentType type)
	{
		if (_queues.TryGetValue(position, out var value))
		{
			value.ClearQueueByItems(type);
		}
	}

	public bool RemovePendingQueueItem(UIPosition position, HudComponentType type, object data)
	{
		if (!_queues.TryGetValue(position, out var value))
		{
			return false;
		}
		return value.RemovePendingItem(type, data);
	}

	public void DequeueHudCp(UIPosition position)
	{
		if (_queues.TryGetValue(position, out var value))
		{
			value.PositionDequeue();
		}
	}

	public bool CanStart(UIPositionQueue positionQueue)
	{
		if (Singleton<SystemUnlockManager>.instance.SystemUnlockUiEvtHasContent())
		{
			return false;
		}
		if (!_priorityEnabled)
		{
			return true;
		}
		if (positionQueue.Profile.IgnorePriorityRule)
		{
			return true;
		}
		if (positionQueue.HeadIgnorePriorityRulePerItem())
		{
			return true;
		}
		if (positionQueue.Position == _priorityPosition)
		{
			return true;
		}
		if (_queues.TryGetValue(_priorityPosition, out var value) && (value.HasActiveItem || value.PendingCount > 0))
		{
			return false;
		}
		return true;
	}
}
