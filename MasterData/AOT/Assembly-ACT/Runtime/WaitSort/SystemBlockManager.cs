using System;
using System.Collections.Concurrent;
using ACT;
using ACT.Event;
using ACT.Game.Data;
using Fundamental;
using UnityEngine;

namespace Runtime.WaitSort;

public class SystemBlockManager : Singleton<SystemBlockManager>
{
	public Action<SystemStatus> OnBlockStatusChanged;

	public ConcurrentDictionary<(SystemType, int), SystemStatus> BlockStatus { get; } = new ConcurrentDictionary<(SystemType, int), SystemStatus>();

	public void Set(SystemStatus status)
	{
		SystemType mainID = (SystemType)status.MainID;
		if (BlockStatus.TryGetValue((mainID, status.SubID), out var value))
		{
			if (value.Disabled != status.Disabled)
			{
				value.Disabled = status.Disabled;
				OnBlockStatusChanged?.Invoke(value);
				DispatchBlockStatusChanged(value);
			}
		}
		else
		{
			BlockStatus.TryAdd((mainID, status.SubID), status);
		}
	}

	public bool IsBlocked(int mainId, int subId = 0)
	{
		return IsBlocked((SystemType)mainId, subId);
	}

	public bool IsBlocked(SystemType mainId, int subId = 0)
	{
		if (BlockStatus.TryGetValue((mainId, subId), out var value))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning($"检查{mainId.ToString()}/{subId}是否被禁用：{value.Disabled}");
			}
			return value.Disabled;
		}
		return false;
	}

	private void DispatchBlockStatusChanged(SystemStatus status)
	{
		SystemBlockStatusChangedEvt evt = Singleton<EventManager>.instance.GetEvt<SystemBlockStatusChangedEvt>();
		evt.status = status;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.System_BlockStatusChanged, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}
}
