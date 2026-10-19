using System.Runtime.CompilerServices;

namespace System.Buffers;

public static class BuffersExtensions
{
	[MethodImpl((MethodImplOptions)256)]
	public static void CopyTo<T>(this in ReadOnlySequence<T> source, Span<T> destination)
	{
		if (source.Length > destination.Length)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.destination);
		}
		if (source.IsSingleSegment)
		{
			source.First.Span.CopyTo(destination);
		}
		else
		{
			CopyToMultiSegment(in source, destination);
		}
	}

	private static void CopyToMultiSegment<T>(in ReadOnlySequence<T> sequence, Span<T> destination)
	{
		SequencePosition position = sequence.Start;
		ReadOnlyMemory<T> memory;
		while (sequence.TryGet(ref position, out memory))
		{
			ReadOnlySpan<T> span = memory.Span;
			span.CopyTo(destination);
			if (position.GetObject() != null)
			{
				destination = destination.Slice(span.Length);
				continue;
			}
			break;
		}
	}
}
