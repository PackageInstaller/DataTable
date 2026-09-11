using System.Collections.Generic;

namespace Capture.Runtime;

public class ComponentAccessor<T> where T : struct
{
	protected long versionTag;

	protected int count;

	protected ComponentList<T> components = new ComponentList<T>();

	protected Dictionary<long, int> versionMap = new Dictionary<long, int>(10);

	protected Dictionary<int, ComponentAccessorContext> statusMap = new Dictionary<int, ComponentAccessorContext>();

	protected Queue<long> componentPool = new Queue<long>();

	public int Count => count;

	public ComponentList<T> ComponentList => components;

	public ComponentAccessor()
	{
		versionTag = 0L;
		count = 0;
	}

	public long AllocComponent()
	{
		long num = -1L;
		if (componentPool.Count > 0)
		{
			num = componentPool.Dequeue();
			int key = versionMap[num];
			statusMap[key] = new ComponentAccessorContext
			{
				identify = num,
				status = ComponentStatus.USE
			};
		}
		else
		{
			int num2 = components.Count;
			components.Add(default(T));
			versionTag++;
			versionMap.Add(versionTag, num2);
			ComponentAccessorContext value = new ComponentAccessorContext
			{
				identify = versionTag,
				status = ComponentStatus.USE
			};
			if (statusMap.ContainsKey(num2))
			{
				statusMap[num2] = value;
			}
			else
			{
				statusMap.Add(num2, value);
			}
			num = versionTag;
		}
		count++;
		return num;
	}

	public void ModifyComponent(long identify, T com)
	{
		if (versionMap.TryGetValue(identify, out var value))
		{
			components[value] = com;
		}
	}

	public int GetComponentIndex(long identify)
	{
		int value = -1;
		versionMap.TryGetValue(identify, out value);
		return value;
	}

	public void ReleaseComponent(long identify)
	{
		if (versionMap.TryGetValue(identify, out var value) && statusMap[value].status != ComponentStatus.REMOVE)
		{
			statusMap[value] = new ComponentAccessorContext
			{
				identify = identify,
				status = ComponentStatus.REMOVE
			};
			components[value] = default(T);
			componentPool.Enqueue(identify);
			count--;
		}
	}

	public void MoveComponentPhase()
	{
		int num = components.Count - 1;
		for (int i = 0; i < components.Count; i++)
		{
			if (statusMap[i].status != ComponentStatus.REMOVE)
			{
				continue;
			}
			while (statusMap[num].status == ComponentStatus.REMOVE)
			{
				num--;
				if (num < 0)
				{
					break;
				}
			}
			if (num >= 0)
			{
				Swap(i, num);
				continue;
			}
			break;
		}
	}

	private void Swap(int ori, int tar)
	{
		ComponentAccessorContext value = statusMap[ori];
		ComponentAccessorContext value2 = statusMap[tar];
		statusMap[ori] = value2;
		statusMap[tar] = value;
		versionMap[value.identify] = tar;
		versionMap[value2.identify] = ori;
	}
}
