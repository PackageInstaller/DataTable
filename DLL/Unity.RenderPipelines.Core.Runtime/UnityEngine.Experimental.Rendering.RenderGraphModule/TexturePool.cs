using System.Collections.Generic;
using UnityEngine.Profiling;
using UnityEngine.Rendering;

namespace UnityEngine.Experimental.Rendering.RenderGraphModule;

internal class TexturePool : RenderGraphResourcePool<RTHandle>
{
	protected override void ReleaseInternalResource(RTHandle res)
	{
		res.Release();
	}

	protected override string GetResourceName(RTHandle res)
	{
		return res.rt.name;
	}

	protected override long GetResourceSize(RTHandle res)
	{
		return Profiler.GetRuntimeMemorySizeLong(res.rt);
	}

	protected override string GetResourceTypeName()
	{
		return "Texture";
	}

	protected override int GetSortIndex(RTHandle res)
	{
		return res.GetInstanceID();
	}

	public override void PurgeUnusedResources(int currentFrameIndex)
	{
		RenderGraphResourcePool<RTHandle>.s_CurrentFrameIndex = currentFrameIndex;
		m_RemoveList.Clear();
		foreach (KeyValuePair<int, SortedList<int, (RTHandle, int)>> item in m_ResourcePool)
		{
			SortedList<int, (RTHandle, int)> value = item.Value;
			IList<int> keys = value.Keys;
			IList<(RTHandle, int)> values = value.Values;
			for (int i = 0; i < value.Count; i++)
			{
				(RTHandle, int) tuple = values[i];
				if (RenderGraphResourcePool<RTHandle>.ShouldReleaseResource(tuple.Item2, RenderGraphResourcePool<RTHandle>.s_CurrentFrameIndex))
				{
					tuple.Item1.Release();
					m_RemoveList.Add(keys[i]);
				}
			}
			foreach (int remove in m_RemoveList)
			{
				value.Remove(remove);
			}
		}
	}
}
