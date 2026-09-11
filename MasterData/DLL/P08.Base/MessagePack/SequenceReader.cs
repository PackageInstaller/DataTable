using System;
using System.Buffers;
using System.Runtime.CompilerServices;

namespace MessagePack;

internal ref struct SequenceReader<T> where T : unmanaged, IEquatable<T>
{
	private bool usingSequence;

	private ReadOnlySequence<T> sequence;

	private SequencePosition currentPosition;

	private SequencePosition nextPosition;

	private ReadOnlyMemory<T> memory;

	private bool moreData;

	private long length;

	public bool End => !moreData;

	public ReadOnlySequence<T> Sequence
	{
		get
		{
			if (sequence.IsEmpty && !memory.IsEmpty)
			{
				sequence = new ReadOnlySequence<T>(memory);
				currentPosition = sequence.Start;
				nextPosition = sequence.End;
			}
			return sequence;
		}
	}

	public SequencePosition Position => Sequence.GetPosition(CurrentSpanIndex, currentPosition);

	public ReadOnlySpan<T> CurrentSpan { get; private set; }

	public int CurrentSpanIndex { get; private set; }

	public ReadOnlySpan<T> UnreadSpan
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			return CurrentSpan.Slice(CurrentSpanIndex);
		}
	}

	public long Consumed { get; private set; }

	public long Remaining => Length - Consumed;

	public long Length
	{
		[MethodImpl((MethodImplOptions)256)]
		get
		{
			if (length < 0)
			{
				length = Sequence.Length;
			}
			return length;
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public SequenceReader(in ReadOnlySequence<T> sequence)
	{
		usingSequence = true;
		CurrentSpanIndex = 0;
		Consumed = 0L;
		this.sequence = sequence;
		memory = default(ReadOnlyMemory<T>);
		currentPosition = sequence.Start;
		length = -1L;
		ReadOnlySpan<T> span = sequence.First.Span;
		nextPosition = sequence.GetPosition(span.Length);
		CurrentSpan = span;
		moreData = span.Length > 0;
		if (!moreData && !sequence.IsSingleSegment)
		{
			moreData = true;
			GetNextSpan();
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public SequenceReader(ReadOnlyMemory<T> memory)
	{
		usingSequence = false;
		CurrentSpanIndex = 0;
		Consumed = 0L;
		this.memory = memory;
		CurrentSpan = memory.Span;
		length = memory.Length;
		moreData = memory.Length > 0;
		currentPosition = default(SequencePosition);
		nextPosition = default(SequencePosition);
		sequence = default(ReadOnlySequence<T>);
	}

	[MethodImpl((MethodImplOptions)256)]
	public bool TryPeek(out T value)
	{
		if (moreData)
		{
			value = CurrentSpan[CurrentSpanIndex];
			return true;
		}
		value = default(T);
		return false;
	}

	[MethodImpl((MethodImplOptions)256)]
	public bool TryRead(out T value)
	{
		if (End)
		{
			value = default(T);
			return false;
		}
		value = CurrentSpan[CurrentSpanIndex];
		CurrentSpanIndex++;
		Consumed++;
		if (CurrentSpanIndex >= CurrentSpan.Length)
		{
			if (usingSequence)
			{
				GetNextSpan();
			}
			else
			{
				moreData = false;
			}
		}
		return true;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Rewind(long count)
	{
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count");
		}
		Consumed -= count;
		if (CurrentSpanIndex >= count)
		{
			CurrentSpanIndex -= (int)count;
			moreData = true;
			return;
		}
		if (usingSequence)
		{
			RetreatToPreviousSpan(Consumed);
			return;
		}
		throw new ArgumentOutOfRangeException("Rewind went past the start of the memory.");
	}

	[MethodImpl((MethodImplOptions)8)]
	private void RetreatToPreviousSpan(long consumed)
	{
		ResetReader();
		Advance(consumed);
	}

	private void ResetReader()
	{
		CurrentSpanIndex = 0;
		Consumed = 0L;
		currentPosition = Sequence.Start;
		nextPosition = currentPosition;
		if (Sequence.TryGet(ref nextPosition, out var readOnlyMemory))
		{
			moreData = true;
			if (readOnlyMemory.Length == 0)
			{
				CurrentSpan = default(ReadOnlySpan<T>);
				GetNextSpan();
			}
			else
			{
				CurrentSpan = readOnlyMemory.Span;
			}
		}
		else
		{
			moreData = false;
			CurrentSpan = default(ReadOnlySpan<T>);
		}
	}

	private void GetNextSpan()
	{
		if (!Sequence.IsSingleSegment)
		{
			SequencePosition sequencePosition = nextPosition;
			ReadOnlyMemory<T> readOnlyMemory;
			while (Sequence.TryGet(ref nextPosition, out readOnlyMemory))
			{
				currentPosition = sequencePosition;
				if (readOnlyMemory.Length > 0)
				{
					CurrentSpan = readOnlyMemory.Span;
					CurrentSpanIndex = 0;
					return;
				}
				CurrentSpan = default(ReadOnlySpan<T>);
				CurrentSpanIndex = 0;
				sequencePosition = nextPosition;
			}
		}
		moreData = false;
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Advance(long count)
	{
		if ((count & int.MinValue) == 0L && CurrentSpan.Length - CurrentSpanIndex > (int)count)
		{
			CurrentSpanIndex += (int)count;
			Consumed += count;
			return;
		}
		if (usingSequence)
		{
			AdvanceToNextSpan(count);
			return;
		}
		if (CurrentSpan.Length - CurrentSpanIndex == (int)count)
		{
			CurrentSpanIndex += (int)count;
			Consumed += count;
			moreData = false;
			return;
		}
		throw new ArgumentOutOfRangeException("count");
	}

	[MethodImpl((MethodImplOptions)256)]
	internal void AdvanceCurrentSpan(long count)
	{
		Consumed += count;
		CurrentSpanIndex += (int)count;
		if (usingSequence && CurrentSpanIndex >= CurrentSpan.Length)
		{
			GetNextSpan();
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	internal void AdvanceWithinSpan(long count)
	{
		Consumed += count;
		CurrentSpanIndex += (int)count;
	}

	internal bool TryAdvance(long count)
	{
		if (Remaining < count)
		{
			return false;
		}
		Advance(count);
		return true;
	}

	private void AdvanceToNextSpan(long count)
	{
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count");
		}
		Consumed += count;
		while (moreData)
		{
			int num = CurrentSpan.Length - CurrentSpanIndex;
			if (num > count)
			{
				CurrentSpanIndex += (int)count;
				count = 0L;
				break;
			}
			CurrentSpanIndex += num;
			count -= num;
			GetNextSpan();
			if (count == 0L)
			{
				break;
			}
		}
		if (count != 0L)
		{
			Consumed -= count;
			throw new ArgumentOutOfRangeException("count");
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public bool TryCopyTo(Span<T> destination)
	{
		ReadOnlySpan<T> unreadSpan = UnreadSpan;
		if (unreadSpan.Length >= destination.Length)
		{
			unreadSpan.Slice(0, destination.Length).CopyTo(destination);
			return true;
		}
		return TryCopyMultisegment(destination);
	}

	internal bool TryCopyMultisegment(Span<T> destination)
	{
		if (Remaining < destination.Length)
		{
			return false;
		}
		ReadOnlySpan<T> unreadSpan = UnreadSpan;
		unreadSpan.CopyTo(destination);
		int num = unreadSpan.Length;
		SequencePosition position = nextPosition;
		ReadOnlyMemory<T> readOnlyMemory;
		while (Sequence.TryGet(ref position, out readOnlyMemory))
		{
			if (readOnlyMemory.Length > 0)
			{
				ReadOnlySpan<T> span = readOnlyMemory.Span;
				int num2 = Math.Min(span.Length, destination.Length - num);
				span.Slice(0, num2).CopyTo(destination.Slice(num));
				num += num2;
				if (num >= destination.Length)
				{
					break;
				}
			}
		}
		return true;
	}
}
