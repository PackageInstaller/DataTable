namespace UnityEngine.Rendering;

public static class CommandBufferPool
{
	private static ObjectPool<CommandBuffer> s_BufferPool = new ObjectPool<CommandBuffer>(null, delegate(CommandBuffer x)
	{
		x.Clear();
	});

	public static CommandBuffer Get()
	{
		CommandBuffer commandBuffer = s_BufferPool.Get();
		commandBuffer.name = "";
		return commandBuffer;
	}

	public static CommandBuffer Get(string name)
	{
		CommandBuffer commandBuffer = s_BufferPool.Get();
		commandBuffer.name = name;
		return commandBuffer;
	}

	public static void Release(CommandBuffer buffer)
	{
		s_BufferPool.Release(buffer);
	}
}
