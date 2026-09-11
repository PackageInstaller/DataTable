using System;
using System.Buffers;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics;
using System.Reflection;
using System.Runtime.InteropServices;

namespace Nerdbank.Streams;

[DebuggerDisplay("{DebuggerDisplay,nq}")]
public class Sequence<T> : IBufferWriter<T>, IDisposable
{
	private class SequenceSegment : ReadOnlySequenceSegment<T>
	{
		private static readonly bool MayContainReferences = !typeof(T).GetTypeInfo().IsPrimitive;

		private T[] array;

		internal int Start { get; private set; }

		internal int End { get; private set; }

		internal Memory<T> RemainingMemory => AvailableMemory.Slice(End);

		internal Span<T> RemainingSpan => AvailableMemory.Span.Slice(End);

		internal IMemoryOwner<T> MemoryOwner { get; private set; }

		internal Memory<T> AvailableMemory
		{
			get
			{
				T[] array = this.array;
				if (array == null)
				{
					return MemoryOwner?.Memory ?? default(Memory<T>);
				}
				return array;
			}
		}

		internal int Length => End - Start;

		internal int WritableBytes => AvailableMemory.Length - End;

		internal new SequenceSegment Next
		{
			get
			{
				return (SequenceSegment)base.Next;
			}
			set
			{
				base.Next = value;
			}
		}

		internal void Assign(IMemoryOwner<T> memoryOwner)
		{
			MemoryOwner = memoryOwner;
			base.Memory = memoryOwner.Memory;
		}

		internal void Assign(T[] array)
		{
			this.array = array;
			base.Memory = array;
		}

		internal void ResetMemory(ArrayPool<T> arrayPool)
		{
			ClearReferences(Start, End);
			base.Memory = default(ReadOnlyMemory<T>);
			Next = null;
			base.RunningIndex = 0L;
			Start = 0;
			End = 0;
			if (array != null)
			{
				arrayPool.Return(array);
				array = null;
			}
			else
			{
				MemoryOwner?.Dispose();
				MemoryOwner = null;
			}
		}

		internal void SetNext(SequenceSegment segment)
		{
			Next = segment;
			segment.RunningIndex = base.RunningIndex + Start + Length;
			base.Memory = AvailableMemory.Slice(0, Start + Length);
		}

		internal void Advance(int count)
		{
			Requires.Range(count >= 0 && End + count <= base.Memory.Length, "count");
			End += count;
		}

		internal void AdvanceTo(int offset)
		{
			ClearReferences(Start, offset - Start);
			Start = offset;
		}

		private void ClearReferences(int startIndex, int length)
		{
			if (MayContainReferences)
			{
				Span<T> span = AvailableMemory.Span;
				span = span.Slice(startIndex, length);
				span.Clear();
			}
		}
	}

	private static readonly int DefaultLengthFromArrayPool = 1 + 4095 / Marshal.SizeOf<T>();

	private readonly Stack<SequenceSegment> segmentPool = new Stack<SequenceSegment>();

	private readonly MemoryPool<T> memoryPool;

	private readonly ArrayPool<T> arrayPool;

	private SequenceSegment first;

	private SequenceSegment last;

	public int MinimumSpanLength { get; set; }

	public ReadOnlySequence<T> AsReadOnlySequence => this;

	public long Length => AsReadOnlySequence.Length;

	private string DebuggerDisplay => $"Length: {AsReadOnlySequence.Length}";

	public Sequence()
		: this(ArrayPool<T>.Create())
	{
	}

	public Sequence(MemoryPool<T> memoryPool)
	{
		Requires.NotNull(memoryPool, "memoryPool");
		this.memoryPool = memoryPool;
	}

	public Sequence(ArrayPool<T> arrayPool)
	{
		Requires.NotNull(arrayPool, "arrayPool");
		this.arrayPool = arrayPool;
	}

	public static implicit operator ReadOnlySequence<T>(Sequence<T> sequence)
	{
		if (sequence.first == null)
		{
			return ReadOnlySequence<T>.Empty;
		}
		return new ReadOnlySequence<T>(sequence.first, sequence.first.Start, sequence.last, sequence.last.End);
	}

	public void AdvanceTo(SequencePosition position)
	{
		SequenceSegment sequenceSegment = (SequenceSegment)position.GetObject();
		int integer = position.GetInteger();
		SequenceSegment next = first;
		while (next != sequenceSegment && next != null)
		{
			next = next.Next;
		}
		Requires.Argument(next != null, "position", "Position does not represent a valid position in this sequence.");
		Requires.Argument(integer >= next.Start, "position", "Position must not be earlier than current position.");
		for (next = first; next != sequenceSegment; next = RecycleAndGetNext(next))
		{
		}
		sequenceSegment.AdvanceTo(integer);
		if (sequenceSegment.Length == 0)
		{
			sequenceSegment = RecycleAndGetNext(sequenceSegment);
		}
		first = sequenceSegment;
		if (first == null)
		{
			last = null;
		}
	}

	public void Advance(int count)
	{
		SequenceSegment sequenceSegment = last;
		Verify.Operation(sequenceSegment != null, "Cannot advance before acquiring memory.");
		sequenceSegment.Advance(count);
	}

	public Memory<T> GetMemory(int sizeHint)
	{
		return GetSegment(sizeHint).RemainingMemory;
	}

	public Span<T> GetSpan(int sizeHint)
	{
		return GetSegment(sizeHint).RemainingSpan;
	}

	[EditorBrowsable(EditorBrowsableState.Never)]
	public void Dispose()
	{
		Reset();
	}

	public void Reset()
	{
		for (SequenceSegment sequenceSegment = first; sequenceSegment != null; sequenceSegment = RecycleAndGetNext(sequenceSegment))
		{
		}
		first = (last = null);
	}

	private SequenceSegment GetSegment(int sizeHint)
	{
		Requires.Range(sizeHint >= 0, "sizeHint");
		int? num = null;
		if (sizeHint == 0)
		{
			if (last == null || last.WritableBytes == 0)
			{
				num = -1;
			}
		}
		else
		{
			sizeHint = Math.Max(MinimumSpanLength, sizeHint);
			if (last == null || last.WritableBytes < sizeHint)
			{
				num = sizeHint;
			}
		}
		if (num.HasValue)
		{
			SequenceSegment sequenceSegment = ((segmentPool.Count > 0) ? segmentPool.Pop() : new SequenceSegment());
			if (arrayPool != null)
			{
				sequenceSegment.Assign(arrayPool.Rent((num.Value == -1) ? DefaultLengthFromArrayPool : num.Value));
			}
			else
			{
				sequenceSegment.Assign(memoryPool.Rent(num.Value));
			}
			Append(sequenceSegment);
		}
		return last;
	}

	private void Append(SequenceSegment segment)
	{
		if (last == null)
		{
			first = (last = segment);
			return;
		}
		if (last.Length > 0)
		{
			last.SetNext(segment);
		}
		else
		{
			SequenceSegment next = first;
			if (first != last)
			{
				while (next.Next != last)
				{
					next = next.Next;
				}
			}
			else
			{
				first = segment;
			}
			next.SetNext(segment);
			RecycleAndGetNext(last);
		}
		last = segment;
	}

	private SequenceSegment RecycleAndGetNext(SequenceSegment segment)
	{
		SequenceSegment sequenceSegment = segment;
		segment = segment.Next;
		sequenceSegment.ResetMemory(arrayPool);
		segmentPool.Push(sequenceSegment);
		return segment;
	}
}
