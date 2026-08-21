using System.Collections.Concurrent;

namespace MemoryPack;

public static class MemoryPackReaderOptionalStatePool
{
	private static readonly ConcurrentQueue<MemoryPackReaderOptionalState> queue = new ConcurrentQueue<MemoryPackReaderOptionalState>();

	public static MemoryPackReaderOptionalState Rent(MemoryPackSerializerOptions? options)
	{
		if (!queue.TryDequeue(out MemoryPackReaderOptionalState result))
		{
			result = new MemoryPackReaderOptionalState();
		}
		result.Init(options);
		return result;
	}

	internal static void Return(MemoryPackReaderOptionalState state)
	{
		state.Reset();
		queue.Enqueue(state);
	}
}
