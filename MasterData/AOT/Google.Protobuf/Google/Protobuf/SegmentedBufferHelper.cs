using System;
using System.Buffers;
using System.IO;
using System.Runtime.CompilerServices;

namespace Google.Protobuf;

internal struct SegmentedBufferHelper
{
	private int? totalLength;

	private ReadOnlySequence<byte>.Enumerator readOnlySequenceEnumerator;

	private CodedInputStream codedInputStream;

	public int? TotalLength => totalLength;

	public CodedInputStream CodedInputStream => codedInputStream;

	[MethodImpl((MethodImplOptions)256)]
	public static void Initialize(CodedInputStream codedInputStream, out SegmentedBufferHelper instance)
	{
		instance.totalLength = ((codedInputStream.InternalInputStream == null) ? new int?(codedInputStream.InternalBuffer.Length) : ((int?)null));
		instance.readOnlySequenceEnumerator = default;
		instance.codedInputStream = codedInputStream;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static void Initialize(ReadOnlySequence<byte> sequence, out SegmentedBufferHelper instance, out ReadOnlySpan<byte> firstSpan)
	{
		instance.codedInputStream = null;
		ReadOnlyMemory<byte> readOnlyMemory;
		if (sequence.IsSingleSegment)
		{
			readOnlyMemory = sequence.First;
			firstSpan = readOnlyMemory.Span;
			instance.totalLength = firstSpan.Length;
			instance.readOnlySequenceEnumerator = default;
		}
		else
		{
			instance.readOnlySequenceEnumerator = sequence.GetEnumerator();
			instance.totalLength = (int)sequence.Length;
			instance.readOnlySequenceEnumerator.MoveNext();
			readOnlyMemory = instance.readOnlySequenceEnumerator.Current;
			firstSpan = readOnlyMemory.Span;
		}
	}

	public bool RefillBuffer(ref ReadOnlySpan<byte> buffer, ref ParserInternalState state, bool mustSucceed)
	{
		if (codedInputStream != null)
		{
			return RefillFromCodedInputStream(ref buffer, ref state, mustSucceed);
		}
		return RefillFromReadOnlySequence(ref buffer, ref state, mustSucceed);
	}

	public static int PushLimit(ref ParserInternalState state, int byteLimit)
	{
		if (byteLimit < 0)
		{
			throw InvalidProtocolBufferException.NegativeSize();
		}
		byteLimit += state.totalBytesRetired + state.bufferPos;
		int currentLimit = state.currentLimit;
		if (byteLimit > currentLimit)
		{
			throw InvalidProtocolBufferException.TruncatedMessage();
		}
		state.currentLimit = byteLimit;
		RecomputeBufferSizeAfterLimit(ref state);
		return currentLimit;
	}

	public static void PopLimit(ref ParserInternalState state, int oldLimit)
	{
		state.currentLimit = oldLimit;
		RecomputeBufferSizeAfterLimit(ref state);
	}

	public static bool IsReachedLimit(ref ParserInternalState state)
	{
		if (state.currentLimit == int.MaxValue)
		{
			return false;
		}
		return state.totalBytesRetired + state.bufferPos >= state.currentLimit;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static bool IsAtEnd(ref ReadOnlySpan<byte> buffer, ref ParserInternalState state)
	{
		if (state.bufferPos == state.bufferSize)
		{
			return !state.segmentedBufferHelper.RefillBuffer(ref buffer, ref state, mustSucceed: false);
		}
		return false;
	}

	private bool RefillFromReadOnlySequence(ref ReadOnlySpan<byte> buffer, ref ParserInternalState state, bool mustSucceed)
	{
		CheckCurrentBufferIsEmpty(ref state);
		if (state.totalBytesRetired + state.bufferSize == state.currentLimit)
		{
			if (mustSucceed)
			{
				throw InvalidProtocolBufferException.TruncatedMessage();
			}
			return false;
		}
		state.totalBytesRetired += state.bufferSize;
		state.bufferPos = 0;
		state.bufferSize = 0;
		while (readOnlySequenceEnumerator.MoveNext())
		{
			buffer = readOnlySequenceEnumerator.Current.Span;
			state.bufferSize = buffer.Length;
			if (buffer.Length != 0)
			{
				break;
			}
		}
		if (state.bufferSize == 0)
		{
			if (mustSucceed)
			{
				throw InvalidProtocolBufferException.TruncatedMessage();
			}
			return false;
		}
		RecomputeBufferSizeAfterLimit(ref state);
		int num = state.totalBytesRetired + state.bufferSize + state.bufferSizeAfterLimit;
		if (num < 0 || num > state.sizeLimit)
		{
			throw InvalidProtocolBufferException.SizeLimitExceeded();
		}
		return true;
	}

	private bool RefillFromCodedInputStream(ref ReadOnlySpan<byte> buffer, ref ParserInternalState state, bool mustSucceed)
	{
		CheckCurrentBufferIsEmpty(ref state);
		if (state.totalBytesRetired + state.bufferSize == state.currentLimit)
		{
			if (mustSucceed)
			{
				throw InvalidProtocolBufferException.TruncatedMessage();
			}
			return false;
		}
		Stream internalInputStream = codedInputStream.InternalInputStream;
		state.totalBytesRetired += state.bufferSize;
		state.bufferPos = 0;
		state.bufferSize = internalInputStream?.Read(codedInputStream.InternalBuffer, 0, buffer.Length) ?? 0;
		if (state.bufferSize < 0)
		{
			throw new InvalidOperationException("Stream.Read returned a negative count");
		}
		if (state.bufferSize == 0)
		{
			if (mustSucceed)
			{
				throw InvalidProtocolBufferException.TruncatedMessage();
			}
			return false;
		}
		RecomputeBufferSizeAfterLimit(ref state);
		int num = state.totalBytesRetired + state.bufferSize + state.bufferSizeAfterLimit;
		if (num < 0 || num > state.sizeLimit)
		{
			throw InvalidProtocolBufferException.SizeLimitExceeded();
		}
		return true;
	}

	private static void RecomputeBufferSizeAfterLimit(ref ParserInternalState state)
	{
		state.bufferSize += state.bufferSizeAfterLimit;
		int num = state.totalBytesRetired + state.bufferSize;
		if (num > state.currentLimit)
		{
			state.bufferSizeAfterLimit = num - state.currentLimit;
			state.bufferSize -= state.bufferSizeAfterLimit;
		}
		else
		{
			state.bufferSizeAfterLimit = 0;
		}
	}

	private static void CheckCurrentBufferIsEmpty(ref ParserInternalState state)
	{
		if (state.bufferPos < state.bufferSize)
		{
			throw new InvalidOperationException("RefillBuffer() called when buffer wasn't empty.");
		}
	}
}
