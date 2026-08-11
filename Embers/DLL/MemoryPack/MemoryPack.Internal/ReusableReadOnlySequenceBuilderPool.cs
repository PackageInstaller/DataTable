using System.Collections.Concurrent;

namespace MemoryPack.Internal;

internal static class ReusableReadOnlySequenceBuilderPool
{
	private static readonly ConcurrentQueue<ReusableReadOnlySequenceBuilder> queue = new ConcurrentQueue<ReusableReadOnlySequenceBuilder>();

	public static ReusableReadOnlySequenceBuilder Rent()
	{
		if (queue.TryDequeue(out ReusableReadOnlySequenceBuilder result))
		{
			return result;
		}
		return new ReusableReadOnlySequenceBuilder();
	}

	public static void Return(ReusableReadOnlySequenceBuilder builder)
	{
		builder.Reset();
		queue.Enqueue(builder);
	}
}
