using System.Collections.Generic;

namespace UnityEngine.Experimental.Rendering.RenderGraphModule;

internal abstract class RenderGraphResourcePool<Type> : IRenderGraphResourcePool where Type : class
{
	private struct ResourceLogInfo
	{
		public string name;

		public long size;
	}

	protected Dictionary<int, SortedList<int, (Type resource, int frameIndex)>> m_ResourcePool = new Dictionary<int, SortedList<int, (Type, int)>>();

	protected List<int> m_RemoveList = new List<int>(32);

	private List<(int, Type)> m_FrameAllocatedResources = new List<(int, Type)>();

	protected static int s_CurrentFrameIndex;

	private const int kStaleResourceLifetime = 10;

	protected abstract void ReleaseInternalResource(Type res);

	protected abstract string GetResourceName(Type res);

	protected abstract long GetResourceSize(Type res);

	protected abstract string GetResourceTypeName();

	protected abstract int GetSortIndex(Type res);

	public void ReleaseResource(int hash, Type resource, int currentFrameIndex)
	{
		if (!m_ResourcePool.TryGetValue(hash, out SortedList<int, (Type, int)> value))
		{
			value = new SortedList<int, (Type, int)>();
			m_ResourcePool.Add(hash, value);
		}
		value.Add(GetSortIndex(resource), (resource, currentFrameIndex));
	}

	public bool TryGetResource(int hashCode, out Type resource)
	{
		if (m_ResourcePool.TryGetValue(hashCode, out SortedList<int, (Type, int)> value) && value.Count > 0)
		{
			resource = value.Values[value.Count - 1].Item1;
			value.RemoveAt(value.Count - 1);
			return true;
		}
		resource = null;
		return false;
	}

	public override void Cleanup()
	{
		foreach (KeyValuePair<int, SortedList<int, (Type, int)>> item in m_ResourcePool)
		{
			foreach (KeyValuePair<int, (Type, int)> item2 in item.Value)
			{
				ReleaseInternalResource(item2.Value.Item1);
			}
		}
	}

	public void RegisterFrameAllocation(int hash, Type value)
	{
		if (hash != -1)
		{
			m_FrameAllocatedResources.Add((hash, value));
		}
	}

	public void UnregisterFrameAllocation(int hash, Type value)
	{
		if (hash != -1)
		{
			m_FrameAllocatedResources.Remove((hash, value));
		}
	}

	public override void CheckFrameAllocation(bool onException, int frameIndex)
	{
		if (m_FrameAllocatedResources.Count != 0)
		{
			string text = "";
			if (!onException)
			{
				text = "RenderGraph: Not all resources of type " + GetResourceTypeName() + " were released. This can be caused by a resources being allocated but never read by any pass.";
			}
			foreach (var frameAllocatedResource in m_FrameAllocatedResources)
			{
				if (!onException)
				{
					text = text + "\n\t" + GetResourceName(frameAllocatedResource.Item2);
				}
				ReleaseResource(frameAllocatedResource.Item1, frameAllocatedResource.Item2, frameIndex);
			}
			Debug.LogWarning(text);
		}
		m_FrameAllocatedResources.Clear();
	}

	public override void LogResources(RenderGraphLogger logger)
	{
		List<ResourceLogInfo> list = new List<ResourceLogInfo>();
		foreach (KeyValuePair<int, SortedList<int, (Type, int)>> item in m_ResourcePool)
		{
			foreach (KeyValuePair<int, (Type, int)> item2 in item.Value)
			{
				list.Add(new ResourceLogInfo
				{
					name = GetResourceName(item2.Value.Item1),
					size = GetResourceSize(item2.Value.Item1)
				});
			}
		}
		logger.LogLine("== " + GetResourceTypeName() + " Resources ==");
		list.Sort((ResourceLogInfo a, ResourceLogInfo b) => (a.size < b.size) ? 1 : (-1));
		int num = 0;
		float num2 = 0f;
		foreach (ResourceLogInfo item3 in list)
		{
			float num3 = (float)item3.size / 1048576f;
			num2 += num3;
			logger.LogLine($"[{num++:D2}]\t[{num3:0.00} MB]\t{item3.name}");
		}
		logger.LogLine($"\nTotal Size [{num2:0.00}]");
	}

	protected static bool ShouldReleaseResource(int lastUsedFrameIndex, int currentFrameIndex)
	{
		return lastUsedFrameIndex + 10 < currentFrameIndex;
	}
}
