using System.Runtime.CompilerServices;

namespace System.Buffers;

public static class BuffersExtensions
{
	[MethodImpl((MethodImplOptions)256)]
	public static SequencePosition? PositionOf<T>(this in ReadOnlySequence<T> source, T value) where T : IEquatable<T>
	{
		if (source.IsSingleSegment)
		{
			int num = source.First.Span.IndexOf(value);
			if (num != -1)
			{
				return source.GetPosition(num);
			}
			return null;
		}
		return PositionOfMultiSegment(in source, value);
	}

	private static SequencePosition? PositionOfMultiSegment<T>(in ReadOnlySequence<T> source, T value) where T : IEquatable<T>
	{
		SequencePosition position = source.Start;
		SequencePosition origin = position;
		ReadOnlyMemory<T> memory;
		while (source.TryGet(ref position, out memory))
		{
			int num = memory.Span.IndexOf(value);
			if (num != -1)
			{
				return source.GetPosition(num, origin);
			}
			if (position.GetObject() == null)
			{
				break;
			}
			origin = position;
		}
		return null;
	}

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

	public static T[] ToArray<T>(this in ReadOnlySequence<T> sequence)
	{
		T[] array = new T[sequence.Length];
		sequence.CopyTo(array);
		return array;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static void Write<T>(this IBufferWriter<T> writer, ReadOnlySpan<T> value)
	{
		Span<T> span = writer.GetSpan();
		if (value.Length <= span.Length)
		{
			value.CopyTo(span);
			writer.Advance(value.Length);
		}
		else
		{
			WriteMultiSegment(writer, in value, span);
		}
	}

	private static void WriteMultiSegment<T>(IBufferWriter<T> writer, in ReadOnlySpan<T> source, Span<T> destination)
	{
		ReadOnlySpan<T> readOnlySpan = source;
		while (true)
		{
			int num = Math.Min(destination.Length, readOnlySpan.Length);
			readOnlySpan.Slice(0, num).CopyTo(destination);
			writer.Advance(num);
			readOnlySpan = readOnlySpan.Slice(num);
			if (readOnlySpan.Length > 0)
			{
				destination = writer.GetSpan(readOnlySpan.Length);
				continue;
			}
			break;
		}
	}
}
