using System;
using System.Buffers;
using System.Collections.Generic;
using Google.Protobuf.Collections;

namespace Google.Protobuf;

internal static class ParsingPrimitivesMessages
{
	private static readonly byte[] ZeroLengthMessageStreamData = new byte[1];

	public static void SkipLastField(ref ReadOnlySpan<byte> buffer, ref ParserInternalState state)
	{
		if (state.lastTag == 0)
		{
			throw new InvalidOperationException("SkipLastField cannot be called at the end of a stream");
		}
		switch (WireFormat.GetTagWireType(state.lastTag))
		{
		case WireFormat.WireType.StartGroup:
			SkipGroup(ref buffer, ref state, state.lastTag);
			break;
		case WireFormat.WireType.EndGroup:
			throw new InvalidProtocolBufferException("SkipLastField called on an end-group tag, indicating that the corresponding start-group was missing");
		case WireFormat.WireType.Fixed32:
			ParsingPrimitives.ParseRawLittleEndian32(ref buffer, ref state);
			break;
		case WireFormat.WireType.Fixed64:
			ParsingPrimitives.ParseRawLittleEndian64(ref buffer, ref state);
			break;
		case WireFormat.WireType.LengthDelimited:
		{
			int size = ParsingPrimitives.ParseLength(ref buffer, ref state);
			ParsingPrimitives.SkipRawBytes(ref buffer, ref state, size);
			break;
		}
		case WireFormat.WireType.Varint:
			ParsingPrimitives.ParseRawVarint32(ref buffer, ref state);
			break;
		}
	}

	public static void SkipGroup(ref ReadOnlySpan<byte> buffer, ref ParserInternalState state, uint startGroupTag)
	{
		state.recursionDepth++;
		if (state.recursionDepth >= state.recursionLimit)
		{
			throw InvalidProtocolBufferException.RecursionLimitExceeded();
		}
		uint num;
		while (true)
		{
			num = ParsingPrimitives.ParseTag(ref buffer, ref state);
			if (num == 0)
			{
				throw InvalidProtocolBufferException.TruncatedMessage();
			}
			if (WireFormat.GetTagWireType(num) == WireFormat.WireType.EndGroup)
			{
				break;
			}
			SkipLastField(ref buffer, ref state);
		}
		int tagFieldNumber = WireFormat.GetTagFieldNumber(startGroupTag);
		int tagFieldNumber2 = WireFormat.GetTagFieldNumber(num);
		if (tagFieldNumber != tagFieldNumber2)
		{
			throw new InvalidProtocolBufferException($"Mismatched end-group tag. Started with field {tagFieldNumber}; ended with field {tagFieldNumber2}");
		}
		state.recursionDepth--;
	}

	public static void ReadMessage(ref ParseContext ctx, IMessage message)
	{
		int byteLimit = ParsingPrimitives.ParseLength(ref ctx.buffer, ref ctx.state);
		if (ctx.state.recursionDepth >= ctx.state.recursionLimit)
		{
			throw InvalidProtocolBufferException.RecursionLimitExceeded();
		}
		int oldLimit = SegmentedBufferHelper.PushLimit(ref ctx.state, byteLimit);
		ctx.state.recursionDepth++;
		ReadRawMessage(ref ctx, message);
		CheckReadEndOfStreamTag(ref ctx.state);
		if (!SegmentedBufferHelper.IsReachedLimit(ref ctx.state))
		{
			throw InvalidProtocolBufferException.TruncatedMessage();
		}
		ctx.state.recursionDepth--;
		SegmentedBufferHelper.PopLimit(ref ctx.state, oldLimit);
	}

	public static KeyValuePair<TKey, TValue> ReadMapEntry<TKey, TValue>(ref ParseContext ctx, MapField<TKey, TValue>.Codec codec)
	{
		int byteLimit = ParsingPrimitives.ParseLength(ref ctx.buffer, ref ctx.state);
		if (ctx.state.recursionDepth >= ctx.state.recursionLimit)
		{
			throw InvalidProtocolBufferException.RecursionLimitExceeded();
		}
		int oldLimit = SegmentedBufferHelper.PushLimit(ref ctx.state, byteLimit);
		ctx.state.recursionDepth++;
		TKey key = codec.KeyCodec.DefaultValue;
		TValue val = codec.ValueCodec.DefaultValue;
		uint num;
		while ((num = ctx.ReadTag()) != 0)
		{
			if (num == codec.KeyCodec.Tag)
			{
				key = codec.KeyCodec.Read(ref ctx);
			}
			else if (num == codec.ValueCodec.Tag)
			{
				val = codec.ValueCodec.Read(ref ctx);
			}
			else
			{
				SkipLastField(ref ctx.buffer, ref ctx.state);
			}
		}
		if (val == null)
		{
			if (ctx.state.CodedInputStream != null)
			{
				val = codec.ValueCodec.Read(new CodedInputStream(ZeroLengthMessageStreamData));
			}
			else
			{
				ParseContext.Initialize(new ReadOnlySequence<byte>(ZeroLengthMessageStreamData), out var ctx2);
				val = codec.ValueCodec.Read(ref ctx2);
			}
		}
		CheckReadEndOfStreamTag(ref ctx.state);
		if (!SegmentedBufferHelper.IsReachedLimit(ref ctx.state))
		{
			throw InvalidProtocolBufferException.TruncatedMessage();
		}
		ctx.state.recursionDepth--;
		SegmentedBufferHelper.PopLimit(ref ctx.state, oldLimit);
		return new KeyValuePair<TKey, TValue>(key, val);
	}

	public static void ReadGroup(ref ParseContext ctx, IMessage message)
	{
		if (ctx.state.recursionDepth >= ctx.state.recursionLimit)
		{
			throw InvalidProtocolBufferException.RecursionLimitExceeded();
		}
		ctx.state.recursionDepth++;
		int tagFieldNumber = WireFormat.GetTagFieldNumber(ctx.state.lastTag);
		ReadRawMessage(ref ctx, message);
		CheckLastTagWas(ref ctx.state, WireFormat.MakeTag(tagFieldNumber, WireFormat.WireType.EndGroup));
		ctx.state.recursionDepth--;
	}

	public static void ReadGroup(ref ParseContext ctx, int fieldNumber, UnknownFieldSet set)
	{
		if (ctx.state.recursionDepth >= ctx.state.recursionLimit)
		{
			throw InvalidProtocolBufferException.RecursionLimitExceeded();
		}
		ctx.state.recursionDepth++;
		set.MergeGroupFrom(ref ctx);
		CheckLastTagWas(ref ctx.state, WireFormat.MakeTag(fieldNumber, WireFormat.WireType.EndGroup));
		ctx.state.recursionDepth--;
	}

	public static void ReadRawMessage(ref ParseContext ctx, IMessage message)
	{
		if (message is IBufferMessage bufferMessage)
		{
			bufferMessage.InternalMergeFrom(ref ctx);
			return;
		}
		if (ctx.state.CodedInputStream == null)
		{
			throw new InvalidProtocolBufferException("Message " + message.GetType().Name + " doesn't provide the generated method that enables ParseContext-based parsing. You might need to regenerate the generated protobuf code.");
		}
		ctx.CopyStateTo(ctx.state.CodedInputStream);
		try
		{
			message.MergeFrom(ctx.state.CodedInputStream);
		}
		finally
		{
			ctx.LoadStateFrom(ctx.state.CodedInputStream);
		}
	}

	public static void CheckReadEndOfStreamTag(ref ParserInternalState state)
	{
		if (state.lastTag != 0)
		{
			throw InvalidProtocolBufferException.MoreDataAvailable();
		}
	}

	private static void CheckLastTagWas(ref ParserInternalState state, uint expectedTag)
	{
		if (state.lastTag != expectedTag)
		{
			throw InvalidProtocolBufferException.InvalidEndTag();
		}
	}
}
