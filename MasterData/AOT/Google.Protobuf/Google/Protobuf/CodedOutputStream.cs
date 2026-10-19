using System;
using System.IO;

namespace Google.Protobuf;

public sealed class CodedOutputStream : IDisposable
{
	public sealed class OutOfSpaceException : IOException
	{
		internal OutOfSpaceException()
			: base("CodedOutputStream was writing to a flat byte array and ran out of space.")
		{
		}
	}

	private const int LittleEndian64Size = 8;

	private const int LittleEndian32Size = 4;

	internal const int DoubleSize = 8;

	internal const int FloatSize = 4;

	internal const int BoolSize = 1;

	public static readonly int DefaultBufferSize = 4096;

	private readonly bool leaveOpen;

	private readonly byte[] buffer;

	private WriterInternalState state;

	private readonly Stream output;

	public long Position
	{
		get
		{
			if (output != null)
			{
				return output.Position + state.position;
			}
			return state.position;
		}
	}

	public int SpaceLeft => WriteBufferHelper.GetSpaceLeft(ref state);

	internal byte[] InternalBuffer => buffer;

	internal Stream InternalOutputStream => output;

	internal ref WriterInternalState InternalState => ref state;

	public static int ComputeDoubleSize(double value)
	{
		return 8;
	}

	public static int ComputeFloatSize(float value)
	{
		return 4;
	}

	public static int ComputeUInt64Size(ulong value)
	{
		return ComputeRawVarint64Size(value);
	}

	public static int ComputeInt64Size(long value)
	{
		return ComputeRawVarint64Size((ulong)value);
	}

	public static int ComputeInt32Size(int value)
	{
		if (value >= 0)
		{
			return ComputeRawVarint32Size((uint)value);
		}
		return 10;
	}

	public static int ComputeFixed64Size(ulong value)
	{
		return 8;
	}

	public static int ComputeFixed32Size(uint value)
	{
		return 4;
	}

	public static int ComputeBoolSize(bool value)
	{
		return 1;
	}

	public static int ComputeStringSize(string value)
	{
		int byteCount = WritingPrimitives.Utf8Encoding.GetByteCount(value);
		return ComputeLengthSize(byteCount) + byteCount;
	}

	public static int ComputeGroupSize(IMessage value)
	{
		return value.CalculateSize();
	}

	public static int ComputeMessageSize(IMessage value)
	{
		int num = value.CalculateSize();
		return ComputeLengthSize(num) + num;
	}

	public static int ComputeBytesSize(ByteString value)
	{
		return ComputeLengthSize(value.Length) + value.Length;
	}

	public static int ComputeUInt32Size(uint value)
	{
		return ComputeRawVarint32Size(value);
	}

	public static int ComputeEnumSize(int value)
	{
		return ComputeInt32Size(value);
	}

	public static int ComputeSFixed32Size(int value)
	{
		return 4;
	}

	public static int ComputeSFixed64Size(long value)
	{
		return 8;
	}

	public static int ComputeSInt32Size(int value)
	{
		return ComputeRawVarint32Size(WritingPrimitives.EncodeZigZag32(value));
	}

	public static int ComputeSInt64Size(long value)
	{
		return ComputeRawVarint64Size(WritingPrimitives.EncodeZigZag64(value));
	}

	public static int ComputeLengthSize(int length)
	{
		return ComputeRawVarint32Size((uint)length);
	}

	public static int ComputeRawVarint32Size(uint value)
	{
		if ((value & 0xFFFFFF80u) == 0)
		{
			return 1;
		}
		if ((value & 0xFFFFC000u) == 0)
		{
			return 2;
		}
		if ((value & 0xFFE00000u) == 0)
		{
			return 3;
		}
		if ((value & 0xF0000000u) == 0)
		{
			return 4;
		}
		return 5;
	}

	public static int ComputeRawVarint64Size(ulong value)
	{
		if ((value & 0xFFFFFFFFFFFFFF80uL) == 0L)
		{
			return 1;
		}
		if ((value & 0xFFFFFFFFFFFFC000uL) == 0L)
		{
			return 2;
		}
		if ((value & 0xFFFFFFFFFFE00000uL) == 0L)
		{
			return 3;
		}
		if ((value & 0xFFFFFFFFF0000000uL) == 0L)
		{
			return 4;
		}
		if ((value & 0xFFFFFFF800000000uL) == 0L)
		{
			return 5;
		}
		if ((value & 0xFFFFFC0000000000uL) == 0L)
		{
			return 6;
		}
		if ((value & 0xFFFE000000000000uL) == 0L)
		{
			return 7;
		}
		if ((value & 0xFF00000000000000uL) == 0L)
		{
			return 8;
		}
		if ((value & 0x8000000000000000uL) == 0L)
		{
			return 9;
		}
		return 10;
	}

	public static int ComputeTagSize(int fieldNumber)
	{
		return ComputeRawVarint32Size(WireFormat.MakeTag(fieldNumber, WireFormat.WireType.Varint));
	}

	public CodedOutputStream(byte[] flatArray)
		: this(flatArray, 0, flatArray.Length)
	{
	}

	private CodedOutputStream(byte[] buffer, int offset, int length)
	{
		output = null;
		this.buffer = ProtoPreconditions.CheckNotNull(buffer, "buffer");
		state.position = offset;
		state.limit = offset + length;
		WriteBufferHelper.Initialize(this, out state.writeBufferHelper);
		leaveOpen = true;
	}

	private CodedOutputStream(Stream output, byte[] buffer, bool leaveOpen)
	{
		this.output = ProtoPreconditions.CheckNotNull(output, "output");
		this.buffer = buffer;
		state.position = 0;
		state.limit = buffer.Length;
		WriteBufferHelper.Initialize(this, out state.writeBufferHelper);
		this.leaveOpen = leaveOpen;
	}

	public CodedOutputStream(Stream output)
		: this(output, DefaultBufferSize, leaveOpen: false)
	{
	}

	public CodedOutputStream(Stream output, int bufferSize)
		: this(output, new byte[bufferSize], leaveOpen: false)
	{
	}

	public CodedOutputStream(Stream output, bool leaveOpen)
		: this(output, DefaultBufferSize, leaveOpen)
	{
	}

	public CodedOutputStream(Stream output, int bufferSize, bool leaveOpen)
		: this(output, new byte[bufferSize], leaveOpen)
	{
	}

	public void WriteDouble(double value)
	{
		Span<byte> span = new Span<byte>(buffer);
		WritingPrimitives.WriteDouble(ref span, ref state, value);
	}

	public void WriteFloat(float value)
	{
		Span<byte> span = new Span<byte>(buffer);
		WritingPrimitives.WriteFloat(ref span, ref state, value);
	}

	public void WriteUInt64(ulong value)
	{
		Span<byte> span = new Span<byte>(buffer);
		WritingPrimitives.WriteUInt64(ref span, ref state, value);
	}

	public void WriteInt64(long value)
	{
		Span<byte> span = new Span<byte>(buffer);
		WritingPrimitives.WriteInt64(ref span, ref state, value);
	}

	public void WriteInt32(int value)
	{
		Span<byte> span = new Span<byte>(buffer);
		WritingPrimitives.WriteInt32(ref span, ref state, value);
	}

	public void WriteFixed64(ulong value)
	{
		Span<byte> span = new Span<byte>(buffer);
		WritingPrimitives.WriteFixed64(ref span, ref state, value);
	}

	public void WriteFixed32(uint value)
	{
		Span<byte> span = new Span<byte>(buffer);
		WritingPrimitives.WriteFixed32(ref span, ref state, value);
	}

	public void WriteBool(bool value)
	{
		Span<byte> span = new Span<byte>(buffer);
		WritingPrimitives.WriteBool(ref span, ref state, value);
	}

	public void WriteString(string value)
	{
		Span<byte> span = new Span<byte>(buffer);
		WritingPrimitives.WriteString(ref span, ref state, value);
	}

	public void WriteMessage(IMessage value)
	{
		Span<byte> span = new Span<byte>(buffer);
		WriteContext.Initialize(ref span, ref state, out var ctx);
		try
		{
			WritingPrimitivesMessages.WriteMessage(ref ctx, value);
		}
		finally
		{
			ctx.CopyStateTo(this);
		}
	}

	public void WriteRawMessage(IMessage value)
	{
		Span<byte> span = new Span<byte>(buffer);
		WriteContext.Initialize(ref span, ref state, out var ctx);
		try
		{
			WritingPrimitivesMessages.WriteRawMessage(ref ctx, value);
		}
		finally
		{
			ctx.CopyStateTo(this);
		}
	}

	public void WriteGroup(IMessage value)
	{
		Span<byte> span = new Span<byte>(buffer);
		WriteContext.Initialize(ref span, ref state, out var ctx);
		try
		{
			WritingPrimitivesMessages.WriteGroup(ref ctx, value);
		}
		finally
		{
			ctx.CopyStateTo(this);
		}
	}

	public void WriteBytes(ByteString value)
	{
		Span<byte> span = new Span<byte>(buffer);
		WritingPrimitives.WriteBytes(ref span, ref state, value);
	}

	public void WriteUInt32(uint value)
	{
		Span<byte> span = new Span<byte>(buffer);
		WritingPrimitives.WriteUInt32(ref span, ref state, value);
	}

	public void WriteEnum(int value)
	{
		Span<byte> span = new Span<byte>(buffer);
		WritingPrimitives.WriteEnum(ref span, ref state, value);
	}

	public void WriteSFixed32(int value)
	{
		Span<byte> span = new Span<byte>(buffer);
		WritingPrimitives.WriteSFixed32(ref span, ref state, value);
	}

	public void WriteSFixed64(long value)
	{
		Span<byte> span = new Span<byte>(buffer);
		WritingPrimitives.WriteSFixed64(ref span, ref state, value);
	}

	public void WriteSInt32(int value)
	{
		Span<byte> span = new Span<byte>(buffer);
		WritingPrimitives.WriteSInt32(ref span, ref state, value);
	}

	public void WriteSInt64(long value)
	{
		Span<byte> span = new Span<byte>(buffer);
		WritingPrimitives.WriteSInt64(ref span, ref state, value);
	}

	public void WriteLength(int length)
	{
		Span<byte> span = new Span<byte>(buffer);
		WritingPrimitives.WriteLength(ref span, ref state, length);
	}

	public void WriteTag(int fieldNumber, WireFormat.WireType type)
	{
		Span<byte> span = new Span<byte>(buffer);
		WritingPrimitives.WriteTag(ref span, ref state, fieldNumber, type);
	}

	public void WriteTag(uint tag)
	{
		Span<byte> span = new Span<byte>(buffer);
		WritingPrimitives.WriteTag(ref span, ref state, tag);
	}

	public void WriteRawTag(byte b1)
	{
		Span<byte> span = new Span<byte>(buffer);
		WritingPrimitives.WriteRawTag(ref span, ref state, b1);
	}

	public void WriteRawTag(byte b1, byte b2)
	{
		Span<byte> span = new Span<byte>(buffer);
		WritingPrimitives.WriteRawTag(ref span, ref state, b1, b2);
	}

	public void WriteRawTag(byte b1, byte b2, byte b3)
	{
		Span<byte> span = new Span<byte>(buffer);
		WritingPrimitives.WriteRawTag(ref span, ref state, b1, b2, b3);
	}

	public void WriteRawTag(byte b1, byte b2, byte b3, byte b4)
	{
		Span<byte> span = new Span<byte>(buffer);
		WritingPrimitives.WriteRawTag(ref span, ref state, b1, b2, b3, b4);
	}

	public void WriteRawTag(byte b1, byte b2, byte b3, byte b4, byte b5)
	{
		Span<byte> span = new Span<byte>(buffer);
		WritingPrimitives.WriteRawTag(ref span, ref state, b1, b2, b3, b4, b5);
	}

	internal void WriteRawVarint32(uint value)
	{
		Span<byte> span = new Span<byte>(buffer);
		WritingPrimitives.WriteRawVarint32(ref span, ref state, value);
	}

	internal void WriteRawVarint64(ulong value)
	{
		Span<byte> span = new Span<byte>(buffer);
		WritingPrimitives.WriteRawVarint64(ref span, ref state, value);
	}

	internal void WriteRawLittleEndian32(uint value)
	{
		Span<byte> span = new Span<byte>(buffer);
		WritingPrimitives.WriteRawLittleEndian32(ref span, ref state, value);
	}

	internal void WriteRawLittleEndian64(ulong value)
	{
		Span<byte> span = new Span<byte>(buffer);
		WritingPrimitives.WriteRawLittleEndian64(ref span, ref state, value);
	}

	internal void WriteRawBytes(byte[] value)
	{
		WriteRawBytes(value, 0, value.Length);
	}

	internal void WriteRawBytes(byte[] value, int offset, int length)
	{
		Span<byte> span = new Span<byte>(buffer);
		WritingPrimitives.WriteRawBytes(ref span, ref state, value, offset, length);
	}

	public void Dispose()
	{
		Flush();
		if (!leaveOpen)
		{
			output.Dispose();
		}
	}

	public void Flush()
	{
		Span<byte> span = new Span<byte>(buffer);
		WriteBufferHelper.Flush(ref span, ref state);
	}

	public void CheckNoSpaceLeft()
	{
		WriteBufferHelper.CheckNoSpaceLeft(ref state);
	}
}
