using System.Collections.Generic;
using UnityEngine;

namespace T0World;

public class T0InteractionEventContext
{
	private int breakEventCount;

	public List<T0InterationBaseData> waitEventList;

	public List<T0InterationBaseData> interationEventList;

	public bool HasBreakEvent => breakEventCount > 0;

	public void AddWaitEvent(T0InterationBaseData eventData)
	{
		if (waitEventList == null)
		{
			waitEventList = new List<T0InterationBaseData>();
		}
		waitEventList.Add(eventData);
	}

	public void RunWaitEvent()
	{
		foreach (T0InterationBaseData waitEvent in waitEventList)
		{
			AddEvent(waitEvent);
		}
		if (waitEventList != null)
		{
			waitEventList.Clear();
		}
	}

	public int GetWaitEventCount()
	{
		if (waitEventList != null)
		{
			return waitEventList.Count;
		}
		return 0;
	}

	public void AddEvent(T0InterationBaseData eventData)
	{
		if (interationEventList == null)
		{
			interationEventList = new List<T0InterationBaseData>();
		}
		interationEventList.Add(eventData);
		if (eventData.GetStateEnum() == T0InterationTypeEnum.Break)
		{
			breakEventCount++;
		}
	}

	public void ClearEvent()
	{
		if (interationEventList != null)
		{
			interationEventList.Clear();
		}
		breakEventCount = 0;
	}

	public void DisposeTargetEvent(T0InterationBaseData eventData)
	{
		if (interationEventList != null && interationEventList.Remove(eventData) && eventData.GetStateEnum() == T0InterationTypeEnum.Break)
		{
			breakEventCount = Mathf.Max(0, breakEventCount - 1);
		}
	}

	public void DisposeAllEvent()
	{
		foreach (T0InterationBaseData interationEvent in interationEventList)
		{
			interationEvent.DisposeEvent();
		}
		ClearEvent();
	}

	public bool IsHaveEvent()
	{
		if (interationEventList != null && interationEventList.Count > 0)
		{
			return true;
		}
		return false;
	}

	public int GetTreeID()
	{
		if (interationEventList != null && interationEventList.Count > 0)
		{
			return interationEventList[0].treeID;
		}
		return -1;
	}

	public bool CheckIsHaveMustFinishEvent()
	{
		if (interationEventList != null && interationEventList.Count > 0)
		{
			foreach (T0InterationBaseData interationEvent in interationEventList)
			{
				if (interationEvent.isMustFinish)
				{
					return true;
				}
			}
		}
		return false;
	}

	public bool TryMarkBreakEventFinish()
	{
		if (!HasBreakEvent || interationEventList == null || interationEventList.Count == 0)
		{
			return false;
		}
		for (int i = 0; i < interationEventList.Count; i++)
		{
			T0InterationBaseData t0InterationBaseData = interationEventList[i];
			if (t0InterationBaseData.GetStateEnum() == T0InterationTypeEnum.Break)
			{
				t0InterationBaseData.IsFinish = true;
				return true;
			}
		}
		return false;
	}
}
