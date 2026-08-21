using System.Collections.Concurrent;

namespace MemoryPack.Internal;

public static class ReusableLinkedArrayBufferWriterPool
{
	private static readonly ConcurrentQueue<ReusableLinkedArrayBufferWriter> queue = new ConcurrentQueue<ReusableLinkedArrayBufferWriter>();

	public static ReusableLinkedArrayBufferWriter Rent()
	{
		if (queue.TryDequeue(out ReusableLinkedArrayBufferWriter result))
		{
			return result;
		}
		return new ReusableLinkedArrayBufferWriter(useFirstBuffer: false, pinned: false);
	}

	public static void Return(ReusableLinkedArrayBufferWriter writer)
	{
		writer.Reset();
		queue.Enqueue(writer);
	}
}
