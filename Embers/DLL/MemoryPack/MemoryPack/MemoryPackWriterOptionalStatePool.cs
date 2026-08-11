using System.Collections.Concurrent;

namespace MemoryPack;

public static class MemoryPackWriterOptionalStatePool
{
	private static readonly ConcurrentQueue<MemoryPackWriterOptionalState> queue = new ConcurrentQueue<MemoryPackWriterOptionalState>();

	public static MemoryPackWriterOptionalState Rent(MemoryPackSerializerOptions? options)
	{
		if (!queue.TryDequeue(out MemoryPackWriterOptionalState result))
		{
			result = new MemoryPackWriterOptionalState();
		}
		result.Init(options);
		return result;
	}

	internal static void Return(MemoryPackWriterOptionalState state)
	{
		state.Reset();
		queue.Enqueue(state);
	}
}
