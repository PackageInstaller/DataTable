using System.Collections.Generic;

namespace UnityEngine.Experimental.Rendering.RenderGraphModule;

internal class ComputeBufferPool : RenderGraphResourcePool<ComputeBuffer>
{
	protected override void ReleaseInternalResource(ComputeBuffer res)
	{
		res.Release();
	}

	protected override string GetResourceName(ComputeBuffer res)
	{
		return "ComputeBufferNameNotAvailable";
	}

	protected override long GetResourceSize(ComputeBuffer res)
	{
		return res.count * res.stride;
	}

	protected override string GetResourceTypeName()
	{
		return "ComputeBuffer";
	}

	protected override int GetSortIndex(ComputeBuffer res)
	{
		return res.GetHashCode();
	}

	public override void PurgeUnusedResources(int currentFrameIndex)
	{
		RenderGraphResourcePool<ComputeBuffer>.s_CurrentFrameIndex = currentFrameIndex;
		m_RemoveList.Clear();
		foreach (KeyValuePair<int, SortedList<int, (ComputeBuffer, int)>> item in m_ResourcePool)
		{
			SortedList<int, (ComputeBuffer, int)> value = item.Value;
			IList<int> keys = value.Keys;
			IList<(ComputeBuffer, int)> values = value.Values;
			for (int i = 0; i < value.Count; i++)
			{
				(ComputeBuffer, int) tuple = values[i];
				if (RenderGraphResourcePool<ComputeBuffer>.ShouldReleaseResource(tuple.Item2, RenderGraphResourcePool<ComputeBuffer>.s_CurrentFrameIndex))
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
