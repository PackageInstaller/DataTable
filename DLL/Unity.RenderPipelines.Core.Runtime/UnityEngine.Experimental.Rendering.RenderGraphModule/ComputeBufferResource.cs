using System;
using System.Diagnostics;

namespace UnityEngine.Experimental.Rendering.RenderGraphModule;

[DebuggerDisplay("ComputeBufferResource ({desc.name})")]
internal class ComputeBufferResource : RenderGraphResource<ComputeBufferDesc, ComputeBuffer>
{
	public override string GetName()
	{
		if (imported)
		{
			return "ImportedComputeBuffer";
		}
		return desc.name;
	}

	public override void CreatePooledGraphicsResource()
	{
		int hashCode = desc.GetHashCode();
		if (graphicsResource != null)
		{
			throw new InvalidOperationException($"Trying to create an already created resource ({GetName()}). Resource was probably declared for writing more than once in the same pass.");
		}
		ComputeBufferPool obj = m_Pool as ComputeBufferPool;
		if (!obj.TryGetResource(hashCode, out graphicsResource))
		{
			CreateGraphicsResource();
		}
		cachedHash = hashCode;
		obj.RegisterFrameAllocation(cachedHash, graphicsResource);
	}

	public override void ReleasePooledGraphicsResource(int frameIndex)
	{
		if (graphicsResource == null)
		{
			throw new InvalidOperationException("Tried to release a resource (" + GetName() + ") that was never created. Check that there is at least one pass writing to it first.");
		}
		if (m_Pool is ComputeBufferPool computeBufferPool)
		{
			computeBufferPool.ReleaseResource(cachedHash, graphicsResource, frameIndex);
			computeBufferPool.UnregisterFrameAllocation(cachedHash, graphicsResource);
		}
		Reset(null);
	}

	public override void CreateGraphicsResource(string name = "")
	{
		graphicsResource = new ComputeBuffer(desc.count, desc.stride, desc.type);
		graphicsResource.name = ((name == "") ? $"RenderGraphComputeBuffer_{desc.count}_{desc.stride}_{desc.type}" : name);
	}

	public override void ReleaseGraphicsResource()
	{
		if (graphicsResource != null)
		{
			graphicsResource.Release();
		}
		base.ReleaseGraphicsResource();
	}

	public override void LogCreation(RenderGraphLogger logger)
	{
		logger.LogLine("Created ComputeBuffer: " + desc.name);
	}

	public override void LogRelease(RenderGraphLogger logger)
	{
		logger.LogLine("Released ComputeBuffer: " + desc.name);
	}
}
