using System.Diagnostics;

namespace UnityEngine.Experimental.Rendering.RenderGraphModule;

[DebuggerDisplay("ComputeBuffer ({handle.index})")]
public struct ComputeBufferHandle
{
	private static ComputeBufferHandle s_NullHandle;

	internal ResourceHandle handle;

	public static ComputeBufferHandle nullHandle => s_NullHandle;

	internal ComputeBufferHandle(int handle, bool shared = false)
	{
		this.handle = new ResourceHandle(handle, RenderGraphResourceType.ComputeBuffer, shared);
	}

	public static implicit operator ComputeBuffer(ComputeBufferHandle buffer)
	{
		if (!buffer.IsValid())
		{
			return null;
		}
		return RenderGraphResourceRegistry.current.GetComputeBuffer(in buffer);
	}

	public bool IsValid()
	{
		return handle.IsValid();
	}
}
