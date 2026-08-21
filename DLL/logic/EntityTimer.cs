using System.Collections.Generic;
using Entitas;

public class EntityTimer : IComponent, IComponentReset
{
	public List<EntityTimerStruct> entityTimers;

	private List<int> pendingDeathArray;

	public int Add(EntityTimerStruct timerStruct)
	{
		if (entityTimers == null)
		{
			entityTimers = FrameListPool<EntityTimerStruct>.Claim();
		}
		entityTimers.Add(timerStruct);
		return entityTimers.Count - 1;
	}

	public void AddPendingRemoveArray(int id)
	{
		if (pendingDeathArray == null)
		{
			pendingDeathArray = FrameListPool<int>.Claim();
		}
		if (!pendingDeathArray.Contains(id))
		{
			pendingDeathArray.Add(id);
		}
	}

	public bool IsInPendingRemoveArray(int id)
	{
		if (pendingDeathArray == null)
		{
			pendingDeathArray = FrameListPool<int>.Claim();
		}
		return pendingDeathArray.Contains(id);
	}

	public void ReleasePendingRemoveArray()
	{
		if (pendingDeathArray != null)
		{
			for (int i = 0; i < pendingDeathArray.Count; i++)
			{
				Remove(pendingDeathArray[i]);
			}
			pendingDeathArray.Clear();
		}
	}

	private int Remove(int id)
	{
		int num = -1;
		for (int i = 0; i < entityTimers.Count; i++)
		{
			if (entityTimers[i].id == id)
			{
				num = i;
				break;
			}
		}
		if (num >= 0)
		{
			entityTimers.RemoveAt(num);
		}
		return num;
	}

	public void RemoveAllTimerByName(int name)
	{
		if (entityTimers == null)
		{
			return;
		}
		List<int> list = FrameListPool<int>.Claim();
		for (int i = 0; i < entityTimers.Count; i++)
		{
			if (entityTimers[i].name == name)
			{
				list.Add(entityTimers[i].id);
			}
		}
		for (int j = 0; j < list.Count; j++)
		{
			entityTimers.RemoveAt(list[j]);
		}
		FrameListPool<int>.Release(list);
	}

	public int GetFirstIDByName(int name)
	{
		int result = -1;
		if (entityTimers == null)
		{
			return result;
		}
		for (int i = 0; i < entityTimers.Count; i++)
		{
			if (entityTimers[i].name == name && !IsInPendingRemoveArray(entityTimers[i].id))
			{
				result = entityTimers[i].id;
				break;
			}
		}
		return result;
	}

	internal bool ReleaseTimerIfPossible()
	{
		List<int> list = FrameListPool<int>.Claim();
		for (int i = 0; i < entityTimers.Count; i++)
		{
			if (entityTimers[i].duringTime <= 0)
			{
				list.Add(entityTimers[i].id);
			}
		}
		for (int j = 0; j < list.Count; j++)
		{
			Remove(list[j]);
		}
		FrameListPool<int>.Release(list);
		return entityTimers.Count == 0;
	}

	public void Reset(Entity entity)
	{
		if (pendingDeathArray != null)
		{
			FrameListPool<int>.Release(pendingDeathArray);
			pendingDeathArray = null;
		}
		if (entityTimers != null)
		{
			FrameListPool<EntityTimerStruct>.Release(entityTimers);
			entityTimers = null;
		}
	}
}
