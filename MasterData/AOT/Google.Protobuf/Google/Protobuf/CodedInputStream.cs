using System;
using System.IO;

namespace Google.Protobuf;

public sealed class CodedInputStream : IDisposable
{
	private readonly bool leaveOpen;

	private readonly byte[] buffer;

	private readonly Stream input;

	private ParserInternalState state;

	internal const int DefaultRecursionLimit = 100;

	internal const int DefaultSizeLimit = int.MaxValue;

	internal const int BufferSize = 4096;

	public long Position
	{
		get
		{
			if (input != null)
			{
				return input.Position - (state.bufferSize + state.bufferSizeAfterLimit - state.bufferPos);
			}
			return state.bufferPos;
		}
	}

	internal uint LastTag => state.lastTag;

	public int SizeLimit => state.sizeLimit;

	public int RecursionLimit => state.recursionLimit;

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

	internal byte[] InternalBuffer => buffer;

	internal Stream InternalInputStream => input;

	internal ref ParserInternalState InternalState => ref state;

	internal bool ReachedLimit => SegmentedBufferHelper.IsReachedLimit(ref state);

	public bool IsAtEnd
	{
		get
		{
			ReadOnlySpan<byte> readOnlySpan = new ReadOnlySpan<byte>(buffer);
			return SegmentedBufferHelper.IsAtEnd(ref readOnlySpan, ref state);
		}
	}

	public CodedInputStream(byte[] buffer)
		: this(null, ProtoPreconditions.CheckNotNull(buffer, "buffer"), 0, buffer.Length, leaveOpen: true)
	{
	}

	public CodedInputStream(byte[] buffer, int offset, int length)
		: this(null, ProtoPreconditions.CheckNotNull(buffer, "buffer"), offset, offset + length, leaveOpen: true)
	{
		if (offset < 0 || offset > buffer.Length)
		{
			throw new ArgumentOutOfRangeException("offset", "Offset must be within the buffer");
		}
		if (length < 0 || offset + length > buffer.Length)
		{
			throw new ArgumentOutOfRangeException("length", "Length must be non-negative and within the buffer");
		}
	}

	public CodedInputStream(Stream input)
		: this(input, leaveOpen: false)
	{
	}

	public CodedInputStream(Stream input, bool leaveOpen)
		: this(ProtoPreconditions.CheckNotNull(input, "input"), new byte[4096], 0, 0, leaveOpen)
	{
	}

	internal CodedInputStream(Stream input, byte[] buffer, int bufferPos, int bufferSize, bool leaveOpen)
	{
		this.input = input;
		this.buffer = buffer;
		state.bufferPos = bufferPos;
		state.bufferSize = bufferSize;
		state.sizeLimit = int.MaxValue;
		state.recursionLimit = 100;
		SegmentedBufferHelper.Initialize(this, out state.segmentedBufferHelper);
		this.leaveOpen = leaveOpen;
		state.currentLimit = int.MaxValue;
	}

	internal CodedInputStream(Stream input, byte[] buffer, int bufferPos, int bufferSize, int sizeLimit, int recursionLimit, bool leaveOpen)
		: this(input, buffer, bufferPos, bufferSize, leaveOpen)
	{
		if (sizeLimit <= 0)
		{
			throw new ArgumentOutOfRangeException("sizeLimit", "Size limit must be positive");
		}
		if (recursionLimit <= 0)
		{
			throw new ArgumentOutOfRangeException("recursionLimit!", "Recursion limit must be positive");
		}
		state.sizeLimit = sizeLimit;
		state.recursionLimit = recursionLimit;
	}

	public static CodedInputStream CreateWithLimits(Stream input, int sizeLimit, int recursionLimit)
	{
		return new CodedInputStream(input, new byte[4096], 0, 0, sizeLimit, recursionLimit, leaveOpen: false);
	}

	public void Dispose()
	{
		if (!leaveOpen)
		{
			input.Dispose();
		}
	}

	internal void CheckReadEndOfStreamTag()
	{
		ParsingPrimitivesMessages.CheckReadEndOfStreamTag(ref state);
	}

	public uint PeekTag()
	{
		ReadOnlySpan<byte> readOnlySpan = new ReadOnlySpan<byte>(buffer);
		return ParsingPrimitives.PeekTag(ref readOnlySpan, ref state);
	}

	public uint ReadTag()
	{
		ReadOnlySpan<byte> readOnlySpan = new ReadOnlySpan<byte>(buffer);
		return ParsingPrimitives.ParseTag(ref readOnlySpan, ref state);
	}

	public void SkipLastField()
	{
		ReadOnlySpan<byte> readOnlySpan = new ReadOnlySpan<byte>(buffer);
		ParsingPrimitivesMessages.SkipLastField(ref readOnlySpan, ref state);
	}

	internal void SkipGroup(uint startGroupTag)
	{
		ReadOnlySpan<byte> readOnlySpan = new ReadOnlySpan<byte>(buffer);
		ParsingPrimitivesMessages.SkipGroup(ref readOnlySpan, ref state, startGroupTag);
	}

	public double ReadDouble()
	{
		ReadOnlySpan<byte> readOnlySpan = new ReadOnlySpan<byte>(buffer);
		return ParsingPrimitives.ParseDouble(ref readOnlySpan, ref state);
	}

	public float ReadFloat()
	{
		ReadOnlySpan<byte> readOnlySpan = new ReadOnlySpan<byte>(buffer);
		return ParsingPrimitives.ParseFloat(ref readOnlySpan, ref state);
	}

	public ulong ReadUInt64()
	{
		return ReadRawVarint64();
	}

	public long ReadInt64()
	{
		return (long)ReadRawVarint64();
	}

	public int ReadInt32()
	{
		return (int)ReadRawVarint32();
	}

	public ulong ReadFixed64()
	{
		return ReadRawLittleEndian64();
	}

	public uint ReadFixed32()
	{
		return ReadRawLittleEndian32();
	}

	public bool ReadBool()
	{
		return ReadRawVarint64() != 0;
	}

	public string ReadString()
	{
		ReadOnlySpan<byte> readOnlySpan = new ReadOnlySpan<byte>(buffer);
		return ParsingPrimitives.ReadString(ref readOnlySpan, ref state);
	}

	public void ReadMessage(IMessage builder)
	{
		ParseContext.Initialize(buffer.AsSpan(), ref state, out var ctx);
		try
		{
			ParsingPrimitivesMessages.ReadMessage(ref ctx, builder);
		}
		finally
		{
			ctx.CopyStateTo(this);
		}
	}

	public void ReadGroup(IMessage builder)
	{
		ParseContext.Initialize(this, out var ctx);
		try
		{
			ParsingPrimitivesMessages.ReadGroup(ref ctx, builder);
		}
		finally
		{
			ctx.CopyStateTo(this);
		}
	}

	public ByteString ReadBytes()
	{
		ReadOnlySpan<byte> readOnlySpan = new ReadOnlySpan<byte>(buffer);
		return ParsingPrimitives.ReadBytes(ref readOnlySpan, ref state);
	}

	public uint ReadUInt32()
	{
		return ReadRawVarint32();
	}

	public int ReadEnum()
	{
		return (int)ReadRawVarint32();
	}

	public int ReadSFixed32()
	{
		return (int)ReadRawLittleEndian32();
	}

	public long ReadSFixed64()
	{
		return (long)ReadRawLittleEndian64();
	}

	public int ReadSInt32()
	{
		return ParsingPrimitives.DecodeZigZag32(ReadRawVarint32());
	}

	public long ReadSInt64()
	{
		return ParsingPrimitives.DecodeZigZag64(ReadRawVarint64());
	}

	public int ReadLength()
	{
		ReadOnlySpan<byte> readOnlySpan = new ReadOnlySpan<byte>(buffer);
		return ParsingPrimitives.ParseLength(ref readOnlySpan, ref state);
	}

	public bool MaybeConsumeTag(uint tag)
	{
		ReadOnlySpan<byte> readOnlySpan = new ReadOnlySpan<byte>(buffer);
		return ParsingPrimitives.MaybeConsumeTag(ref readOnlySpan, ref state, tag);
	}

	internal uint ReadRawVarint32()
	{
		ReadOnlySpan<byte> readOnlySpan = new ReadOnlySpan<byte>(buffer);
		return ParsingPrimitives.ParseRawVarint32(ref readOnlySpan, ref state);
	}

	internal static uint ReadRawVarint32(Stream input)
	{
		return ParsingPrimitives.ReadRawVarint32(input);
	}

	internal ulong ReadRawVarint64()
	{
		ReadOnlySpan<byte> readOnlySpan = new ReadOnlySpan<byte>(buffer);
		return ParsingPrimitives.ParseRawVarint64(ref readOnlySpan, ref state);
	}

	internal uint ReadRawLittleEndian32()
	{
		ReadOnlySpan<byte> readOnlySpan = new ReadOnlySpan<byte>(buffer);
		return ParsingPrimitives.ParseRawLittleEndian32(ref readOnlySpan, ref state);
	}

	internal ulong ReadRawLittleEndian64()
	{
		ReadOnlySpan<byte> readOnlySpan = new ReadOnlySpan<byte>(buffer);
		return ParsingPrimitives.ParseRawLittleEndian64(ref readOnlySpan, ref state);
	}

	internal int PushLimit(int byteLimit)
	{
		return SegmentedBufferHelper.PushLimit(ref state, byteLimit);
	}

	internal void PopLimit(int oldLimit)
	{
		SegmentedBufferHelper.PopLimit(ref state, oldLimit);
	}

	private bool RefillBuffer(bool mustSucceed)
	{
		ReadOnlySpan<byte> readOnlySpan = new ReadOnlySpan<byte>(buffer);
		return state.segmentedBufferHelper.RefillBuffer(ref readOnlySpan, ref state, mustSucceed);
	}

	internal byte[] ReadRawBytes(int size)
	{
		ReadOnlySpan<byte> readOnlySpan = new ReadOnlySpan<byte>(buffer);
		return ParsingPrimitives.ReadRawBytes(ref readOnlySpan, ref state, size);
	}

	public void ReadRawMessage(IMessage message)
	{
		ParseContext.Initialize(this, out var ctx);
		try
		{
			ParsingPrimitivesMessages.ReadRawMessage(ref ctx, message);
		}
		finally
		{
			ctx.CopyStateTo(this);
		}
	}
}
