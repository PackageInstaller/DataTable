using System;
using System.Buffers;
using System.Runtime.CompilerServices;

namespace Google.Protobuf;

public ref struct ParseContext
{
	internal const int DefaultRecursionLimit = 100;

	internal const int DefaultSizeLimit = int.MaxValue;

	internal ReadOnlySpan<byte> buffer;

	internal ParserInternalState state;

	internal uint LastTag => state.lastTag;

	internal bool DiscardUnknownFields
	{
		get
		{
			return state.DiscardUnknownFields;
		}
		set
		{
			state.DiscardUnknownFields = value;
		}
	}

	internal ExtensionRegistry ExtensionRegistry
	{
		get
		{
			return state.ExtensionRegistry;
		}
		set
		{
			state.ExtensionRegistry = value;
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	internal static void Initialize(ReadOnlySpan<byte> buffer, out ParseContext ctx)
	{
		ParserInternalState parserInternalState = new ParserInternalState
		{
			sizeLimit = int.MaxValue,
			recursionLimit = 100,
			currentLimit = int.MaxValue,
			bufferSize = buffer.Length
		};
		Initialize(buffer, ref parserInternalState, out ctx);
	}

	[MethodImpl((MethodImplOptions)256)]
	internal static void Initialize(ReadOnlySpan<byte> buffer, ref ParserInternalState state, out ParseContext ctx)
	{
		ctx.buffer = buffer;
		ctx.state = state;
	}

	[MethodImpl((MethodImplOptions)256)]
	internal static void Initialize(CodedInputStream input, out ParseContext ctx)
	{
		ctx.buffer = new ReadOnlySpan<byte>(input.InternalBuffer);
		ctx.state = input.InternalState;
	}

	[MethodImpl((MethodImplOptions)256)]
	internal static void Initialize(ReadOnlySequence<byte> input, out ParseContext ctx)
	{
		Initialize(input, 100, out ctx);
	}

	[MethodImpl((MethodImplOptions)256)]
	internal static void Initialize(ReadOnlySequence<byte> input, int recursionLimit, out ParseContext ctx)
	{
		ctx.buffer = default;
		ctx.state = default;
		ctx.state.lastTag = 0u;
		ctx.state.recursionDepth = 0;
		ctx.state.sizeLimit = int.MaxValue;
		ctx.state.recursionLimit = recursionLimit;
		ctx.state.currentLimit = int.MaxValue;
		SegmentedBufferHelper.Initialize(input, out ctx.state.segmentedBufferHelper, out ctx.buffer);
		ctx.state.bufferPos = 0;
		ctx.state.bufferSize = ctx.buffer.Length;
		ctx.state.DiscardUnknownFields = false;
		ctx.state.ExtensionRegistry = null;
	}

	[MethodImpl((MethodImplOptions)256)]
	public uint ReadTag()
	{
		return ParsingPrimitives.ParseTag(ref buffer, ref state);
	}

	[MethodImpl((MethodImplOptions)256)]
	public double ReadDouble()
	{
		return ParsingPrimitives.ParseDouble(ref buffer, ref state);
	}

	[MethodImpl((MethodImplOptions)256)]
	public float ReadFloat()
	{
		return ParsingPrimitives.ParseFloat(ref buffer, ref state);
	}

	[MethodImpl((MethodImplOptions)256)]
	public ulong ReadUInt64()
	{
		return ParsingPrimitives.ParseRawVarint64(ref buffer, ref state);
	}

	[MethodImpl((MethodImplOptions)256)]
	public long ReadInt64()
	{
		return (long)ParsingPrimitives.ParseRawVarint64(ref buffer, ref state);
	}

	[MethodImpl((MethodImplOptions)256)]
	public int ReadInt32()
	{
		return (int)ParsingPrimitives.ParseRawVarint32(ref buffer, ref state);
	}

	[MethodImpl((MethodImplOptions)256)]
	public ulong ReadFixed64()
	{
		return ParsingPrimitives.ParseRawLittleEndian64(ref buffer, ref state);
	}

	[MethodImpl((MethodImplOptions)256)]
	public uint ReadFixed32()
	{
		return ParsingPrimitives.ParseRawLittleEndian32(ref buffer, ref state);
	}

	[MethodImpl((MethodImplOptions)256)]
	public bool ReadBool()
	{
		return ParsingPrimitives.ParseRawVarint64(ref buffer, ref state) != 0;
	}

	[MethodImpl((MethodImplOptions)256)]
	public string ReadString()
	{
		return ParsingPrimitives.ReadString(ref buffer, ref state);
	}

	[MethodImpl((MethodImplOptions)256)]
	public void ReadMessage(IMessage message)
	{
		ParsingPrimitivesMessages.ReadMessage(ref this, message);
	}

	[MethodImpl((MethodImplOptions)256)]
	public void ReadGroup(IMessage message)
	{
		ParsingPrimitivesMessages.ReadGroup(ref this, message);
	}

	[MethodImpl((MethodImplOptions)256)]
	public ByteString ReadBytes()
	{
		return ParsingPrimitives.ReadBytes(ref buffer, ref state);
	}

	[MethodImpl((MethodImplOptions)256)]
	public uint ReadUInt32()
	{
		return ParsingPrimitives.ParseRawVarint32(ref buffer, ref state);
	}

	[MethodImpl((MethodImplOptions)256)]
	public int ReadEnum()
	{
		return (int)ParsingPrimitives.ParseRawVarint32(ref buffer, ref state);
	}

	[MethodImpl((MethodImplOptions)256)]
	public int ReadSFixed32()
	{
		return (int)ParsingPrimitives.ParseRawLittleEndian32(ref buffer, ref state);
	}

	[MethodImpl((MethodImplOptions)256)]
	public long ReadSFixed64()
	{
		return (long)ParsingPrimitives.ParseRawLittleEndian64(ref buffer, ref state);
	}

	[MethodImpl((MethodImplOptions)256)]
	public int ReadSInt32()
	{
		return ParsingPrimitives.DecodeZigZag32(ParsingPrimitives.ParseRawVarint32(ref buffer, ref state));
	}

	[MethodImpl((MethodImplOptions)256)]
	public long ReadSInt64()
	{
		return ParsingPrimitives.DecodeZigZag64(ParsingPrimitives.ParseRawVarint64(ref buffer, ref state));
	}

	[MethodImpl((MethodImplOptions)256)]
	public int ReadLength()
	{
		return (int)ParsingPrimitives.ParseRawVarint32(ref buffer, ref state);
	}

	internal void CopyStateTo(CodedInputStream input)
	{
		input.InternalState = state;
	}

	internal void LoadStateFrom(CodedInputStream input)
	{
		state = input.InternalState;
	}
}
