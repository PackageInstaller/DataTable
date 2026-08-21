using System;
using System.Buffers;

namespace MessagePack;

internal static class Utilities
{
	internal delegate void GetWriterBytesAction<TArg>(ref MessagePackWriter writer, TArg argument);

	internal const bool IsMono = true;

	internal static byte[] GetWriterBytes<TArg>(TArg arg, GetWriterBytesAction<TArg> action, SequencePool pool)
	{
		using SequencePool.Rental rental = pool.Rent();
		MessagePackWriter writer = new MessagePackWriter(rental.Value);
		action(ref writer, arg);
		writer.Flush();
		return rental.Value.AsReadOnlySequence.ToArray<byte>();
	}

	internal static Memory<T> GetMemoryCheckResult<T>(this IBufferWriter<T> bufferWriter, int size = 0)
	{
		Memory<T> memory = bufferWriter.GetMemory(size);
		if (memory.IsEmpty)
		{
			throw new InvalidOperationException("The underlying IBufferWriter<byte>.GetMemory(int) method returned an empty memory block, which is not allowed. This is a bug in " + bufferWriter.GetType().FullName);
		}
		return memory;
	}
}
