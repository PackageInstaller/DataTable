using System;
using System.Buffers.Binary;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Text;

namespace Google.Protobuf;

internal static class WritingPrimitives
{
	internal static readonly Encoding Utf8Encoding = Encoding.UTF8;

	public static void WriteDouble(ref Span<byte> buffer, ref WriterInternalState state, double value)
	{
		WriteRawLittleEndian64(ref buffer, ref state, (ulong)BitConverter.DoubleToInt64Bits(value));
	}

	public static void WriteFloat(ref Span<byte> buffer, ref WriterInternalState state, float value)
	{
		if (buffer.Length - state.position >= 4)
		{
			Span<byte> span = buffer.Slice(state.position, 4);
			Unsafe.WriteUnaligned(ref MemoryMarshal.GetReference(span), value);
			if (!BitConverter.IsLittleEndian)
			{
				span.Reverse();
			}
			state.position += 4;
		}
		else
		{
			WriteFloatSlowPath(ref buffer, ref state, value);
		}
	}

	[MethodImpl((MethodImplOptions)8)]
	private static void WriteFloatSlowPath(ref Span<byte> buffer, ref WriterInternalState state, float value)
	{
		Span<byte> span = stackalloc byte[4];
		Unsafe.WriteUnaligned(ref MemoryMarshal.GetReference(span), value);
		if (!BitConverter.IsLittleEndian)
		{
			span.Reverse();
		}
		WriteRawByte(ref buffer, ref state, span[0]);
		WriteRawByte(ref buffer, ref state, span[1]);
		WriteRawByte(ref buffer, ref state, span[2]);
		WriteRawByte(ref buffer, ref state, span[3]);
	}

	public static void WriteUInt64(ref Span<byte> buffer, ref WriterInternalState state, ulong value)
	{
		WriteRawVarint64(ref buffer, ref state, value);
	}

	public static void WriteInt64(ref Span<byte> buffer, ref WriterInternalState state, long value)
	{
		WriteRawVarint64(ref buffer, ref state, (ulong)value);
	}

	public static void WriteInt32(ref Span<byte> buffer, ref WriterInternalState state, int value)
	{
		if (value >= 0)
		{
			WriteRawVarint32(ref buffer, ref state, (uint)value);
		}
		else
		{
			WriteRawVarint64(ref buffer, ref state, (ulong)value);
		}
	}

	public static void WriteFixed64(ref Span<byte> buffer, ref WriterInternalState state, ulong value)
	{
		WriteRawLittleEndian64(ref buffer, ref state, value);
	}

	public static void WriteFixed32(ref Span<byte> buffer, ref WriterInternalState state, uint value)
	{
		WriteRawLittleEndian32(ref buffer, ref state, value);
	}

	public static void WriteBool(ref Span<byte> buffer, ref WriterInternalState state, bool value)
	{
		WriteRawByte(ref buffer, ref state, (byte)(value ? 1 : 0));
	}

	public static void WriteString(ref Span<byte> buffer, ref WriterInternalState state, string value)
	{
		if (value.Length <= 42 && buffer.Length - state.position - 1 >= value.Length * 3)
		{
			buffer[state.position++] = (byte)WriteStringToBuffer(buffer, ref state, value);
			return;
		}
		int byteCount = Utf8Encoding.GetByteCount(value);
		WriteLength(ref buffer, ref state, byteCount);
		if (buffer.Length - state.position >= byteCount)
		{
			if (byteCount == value.Length)
			{
				WriteAsciiStringToBuffer(buffer, ref state, value, byteCount);
			}
			else
			{
				WriteStringToBuffer(buffer, ref state, value);
			}
		}
		else
		{
			byte[] bytes = Utf8Encoding.GetBytes(value);
			WriteRawBytes(ref buffer, ref state, bytes);
		}
	}

	private static void WriteAsciiStringToBuffer(Span<byte> buffer, ref WriterInternalState state, string value, int length)
	{
		ref char reference = ref MemoryMarshal.GetReference<char>(value);
		ref byte reference2 = ref MemoryMarshal.GetReference(buffer.Slice(state.position));
		int i = 0;
		if (IntPtr.Size == 8 && length >= 4)
		{
			ref byte source = ref Unsafe.As<char, byte>(ref reference);
			int num = value.Length - 4;
			do
			{
				NarrowFourUtf16CharsToAsciiAndWriteToBuffer(ref Unsafe.AddByteOffset(ref reference2, (IntPtr)i), Unsafe.ReadUnaligned<ulong>(ref Unsafe.AddByteOffset(ref source, (IntPtr)(i * 2))));
			}
			while ((i += 4) <= num);
		}
		for (; i < length; i++)
		{
			Unsafe.AddByteOffset(ref reference2, (IntPtr)i) = (byte)Unsafe.AddByteOffset(ref reference, (IntPtr)(i * 2));
		}
		state.position += length;
	}

	[MethodImpl((MethodImplOptions)256)]
	private static void NarrowFourUtf16CharsToAsciiAndWriteToBuffer(ref byte outputBuffer, ulong value)
	{
		if (BitConverter.IsLittleEndian)
		{
			outputBuffer = (byte)value;
			value >>= 16;
			Unsafe.Add(ref outputBuffer, 1) = (byte)value;
			value >>= 16;
			Unsafe.Add(ref outputBuffer, 2) = (byte)value;
			value >>= 16;
			Unsafe.Add(ref outputBuffer, 3) = (byte)value;
		}
		else
		{
			Unsafe.Add(ref outputBuffer, 3) = (byte)value;
			value >>= 16;
			Unsafe.Add(ref outputBuffer, 2) = (byte)value;
			value >>= 16;
			Unsafe.Add(ref outputBuffer, 1) = (byte)value;
			value >>= 16;
			outputBuffer = (byte)value;
		}
	}

	private unsafe static int WriteStringToBuffer(Span<byte> buffer, ref WriterInternalState state, string value)
	{
		ReadOnlySpan<char> span = value;
		int bytes;
		fixed (char* reference = &MemoryMarshal.GetReference(span))
		{
			fixed (byte* reference2 = &MemoryMarshal.GetReference(buffer))
			{
				bytes = Utf8Encoding.GetBytes(reference, span.Length, reference2 + state.position, buffer.Length - state.position);
			}
		}
		state.position += bytes;
		return bytes;
	}

	public static void WriteBytes(ref Span<byte> buffer, ref WriterInternalState state, ByteString value)
	{
		WriteLength(ref buffer, ref state, value.Length);
		WriteRawBytes(ref buffer, ref state, value.Span);
	}

	public static void WriteUInt32(ref Span<byte> buffer, ref WriterInternalState state, uint value)
	{
		WriteRawVarint32(ref buffer, ref state, value);
	}

	public static void WriteEnum(ref Span<byte> buffer, ref WriterInternalState state, int value)
	{
		WriteInt32(ref buffer, ref state, value);
	}

	public static void WriteSFixed32(ref Span<byte> buffer, ref WriterInternalState state, int value)
	{
		WriteRawLittleEndian32(ref buffer, ref state, (uint)value);
	}

	public static void WriteSFixed64(ref Span<byte> buffer, ref WriterInternalState state, long value)
	{
		WriteRawLittleEndian64(ref buffer, ref state, (ulong)value);
	}

	public static void WriteSInt32(ref Span<byte> buffer, ref WriterInternalState state, int value)
	{
		WriteRawVarint32(ref buffer, ref state, EncodeZigZag32(value));
	}

	public static void WriteSInt64(ref Span<byte> buffer, ref WriterInternalState state, long value)
	{
		WriteRawVarint64(ref buffer, ref state, EncodeZigZag64(value));
	}

	public static void WriteLength(ref Span<byte> buffer, ref WriterInternalState state, int length)
	{
		WriteRawVarint32(ref buffer, ref state, (uint)length);
	}

	public static void WriteRawVarint32(ref Span<byte> buffer, ref WriterInternalState state, uint value)
	{
		if (value < 128 && state.position < buffer.Length)
		{
			buffer[state.position++] = (byte)value;
			return;
		}
		while (state.position < buffer.Length)
		{
			if (value > 127)
			{
				buffer[state.position++] = (byte)((value & 0x7F) | 0x80);
				value >>= 7;
				continue;
			}
			buffer[state.position++] = (byte)value;
			return;
		}
		while (value > 127)
		{
			WriteRawByte(ref buffer, ref state, (byte)((value & 0x7F) | 0x80));
			value >>= 7;
		}
		WriteRawByte(ref buffer, ref state, (byte)value);
	}

	public static void WriteRawVarint64(ref Span<byte> buffer, ref WriterInternalState state, ulong value)
	{
		if (value < 128 && state.position < buffer.Length)
		{
			buffer[state.position++] = (byte)value;
			return;
		}
		while (state.position < buffer.Length)
		{
			if (value > 127)
			{
				buffer[state.position++] = (byte)((value & 0x7F) | 0x80);
				value >>= 7;
				continue;
			}
			buffer[state.position++] = (byte)value;
			return;
		}
		while (value > 127)
		{
			WriteRawByte(ref buffer, ref state, (byte)((value & 0x7F) | 0x80));
			value >>= 7;
		}
		WriteRawByte(ref buffer, ref state, (byte)value);
	}

	public static void WriteRawLittleEndian32(ref Span<byte> buffer, ref WriterInternalState state, uint value)
	{
		if (state.position + 4 > buffer.Length)
		{
			WriteRawLittleEndian32SlowPath(ref buffer, ref state, value);
			return;
		}
		BinaryPrimitives.WriteUInt32LittleEndian(buffer.Slice(state.position), value);
		state.position += 4;
	}

	[MethodImpl((MethodImplOptions)8)]
	private static void WriteRawLittleEndian32SlowPath(ref Span<byte> buffer, ref WriterInternalState state, uint value)
	{
		WriteRawByte(ref buffer, ref state, (byte)value);
		WriteRawByte(ref buffer, ref state, (byte)(value >> 8));
		WriteRawByte(ref buffer, ref state, (byte)(value >> 16));
		WriteRawByte(ref buffer, ref state, (byte)(value >> 24));
	}

	public static void WriteRawLittleEndian64(ref Span<byte> buffer, ref WriterInternalState state, ulong value)
	{
		if (state.position + 8 > buffer.Length)
		{
			WriteRawLittleEndian64SlowPath(ref buffer, ref state, value);
			return;
		}
		BinaryPrimitives.WriteUInt64LittleEndian(buffer.Slice(state.position), value);
		state.position += 8;
	}

	[MethodImpl((MethodImplOptions)8)]
	public static void WriteRawLittleEndian64SlowPath(ref Span<byte> buffer, ref WriterInternalState state, ulong value)
	{
		WriteRawByte(ref buffer, ref state, (byte)value);
		WriteRawByte(ref buffer, ref state, (byte)(value >> 8));
		WriteRawByte(ref buffer, ref state, (byte)(value >> 16));
		WriteRawByte(ref buffer, ref state, (byte)(value >> 24));
		WriteRawByte(ref buffer, ref state, (byte)(value >> 32));
		WriteRawByte(ref buffer, ref state, (byte)(value >> 40));
		WriteRawByte(ref buffer, ref state, (byte)(value >> 48));
		WriteRawByte(ref buffer, ref state, (byte)(value >> 56));
	}

	private static void WriteRawByte(ref Span<byte> buffer, ref WriterInternalState state, byte value)
	{
		if (state.position == buffer.Length)
		{
			WriteBufferHelper.RefreshBuffer(ref buffer, ref state);
		}
		buffer[state.position++] = value;
	}

	public static void WriteRawBytes(ref Span<byte> buffer, ref WriterInternalState state, byte[] value)
	{
		WriteRawBytes(ref buffer, ref state, new ReadOnlySpan<byte>(value));
	}

	public static void WriteRawBytes(ref Span<byte> buffer, ref WriterInternalState state, byte[] value, int offset, int length)
	{
		WriteRawBytes(ref buffer, ref state, new ReadOnlySpan<byte>(value, offset, length));
	}

	public static void WriteRawBytes(ref Span<byte> buffer, ref WriterInternalState state, ReadOnlySpan<byte> value)
	{
		if (buffer.Length - state.position >= value.Length)
		{
			value.CopyTo(buffer.Slice(state.position, value.Length));
			state.position += value.Length;
			return;
		}
		int num = 0;
		while (buffer.Length - state.position < value.Length - num)
		{
			int num2 = buffer.Length - state.position;
			value.Slice(num, num2).CopyTo(buffer.Slice(state.position, num2));
			num += num2;
			state.position += num2;
			WriteBufferHelper.RefreshBuffer(ref buffer, ref state);
		}
		int num3 = value.Length - num;
		value.Slice(num, num3).CopyTo(buffer.Slice(state.position, num3));
		state.position += num3;
	}

	public static void WriteTag(ref Span<byte> buffer, ref WriterInternalState state, int fieldNumber, WireFormat.WireType type)
	{
		WriteRawVarint32(ref buffer, ref state, WireFormat.MakeTag(fieldNumber, type));
	}

	public static void WriteTag(ref Span<byte> buffer, ref WriterInternalState state, uint tag)
	{
		WriteRawVarint32(ref buffer, ref state, tag);
	}

	public static void WriteRawTag(ref Span<byte> buffer, ref WriterInternalState state, byte b1)
	{
		WriteRawByte(ref buffer, ref state, b1);
	}

	public static void WriteRawTag(ref Span<byte> buffer, ref WriterInternalState state, byte b1, byte b2)
	{
		if (state.position + 2 > buffer.Length)
		{
			WriteRawTagSlowPath(ref buffer, ref state, b1, b2);
			return;
		}
		buffer[state.position++] = b1;
		buffer[state.position++] = b2;
	}

	[MethodImpl((MethodImplOptions)8)]
	private static void WriteRawTagSlowPath(ref Span<byte> buffer, ref WriterInternalState state, byte b1, byte b2)
	{
		WriteRawByte(ref buffer, ref state, b1);
		WriteRawByte(ref buffer, ref state, b2);
	}

	public static void WriteRawTag(ref Span<byte> buffer, ref WriterInternalState state, byte b1, byte b2, byte b3)
	{
		if (state.position + 3 > buffer.Length)
		{
			WriteRawTagSlowPath(ref buffer, ref state, b1, b2, b3);
			return;
		}
		buffer[state.position++] = b1;
		buffer[state.position++] = b2;
		buffer[state.position++] = b3;
	}

	[MethodImpl((MethodImplOptions)8)]
	private static void WriteRawTagSlowPath(ref Span<byte> buffer, ref WriterInternalState state, byte b1, byte b2, byte b3)
	{
		WriteRawByte(ref buffer, ref state, b1);
		WriteRawByte(ref buffer, ref state, b2);
		WriteRawByte(ref buffer, ref state, b3);
	}

	public static void WriteRawTag(ref Span<byte> buffer, ref WriterInternalState state, byte b1, byte b2, byte b3, byte b4)
	{
		if (state.position + 4 > buffer.Length)
		{
			WriteRawTagSlowPath(ref buffer, ref state, b1, b2, b3, b4);
			return;
		}
		buffer[state.position++] = b1;
		buffer[state.position++] = b2;
		buffer[state.position++] = b3;
		buffer[state.position++] = b4;
	}

	[MethodImpl((MethodImplOptions)8)]
	private static void WriteRawTagSlowPath(ref Span<byte> buffer, ref WriterInternalState state, byte b1, byte b2, byte b3, byte b4)
	{
		WriteRawByte(ref buffer, ref state, b1);
		WriteRawByte(ref buffer, ref state, b2);
		WriteRawByte(ref buffer, ref state, b3);
		WriteRawByte(ref buffer, ref state, b4);
	}

	public static void WriteRawTag(ref Span<byte> buffer, ref WriterInternalState state, byte b1, byte b2, byte b3, byte b4, byte b5)
	{
		if (state.position + 5 > buffer.Length)
		{
			WriteRawTagSlowPath(ref buffer, ref state, b1, b2, b3, b4, b5);
			return;
		}
		buffer[state.position++] = b1;
		buffer[state.position++] = b2;
		buffer[state.position++] = b3;
		buffer[state.position++] = b4;
		buffer[state.position++] = b5;
	}

	[MethodImpl((MethodImplOptions)8)]
	private static void WriteRawTagSlowPath(ref Span<byte> buffer, ref WriterInternalState state, byte b1, byte b2, byte b3, byte b4, byte b5)
	{
		WriteRawByte(ref buffer, ref state, b1);
		WriteRawByte(ref buffer, ref state, b2);
		WriteRawByte(ref buffer, ref state, b3);
		WriteRawByte(ref buffer, ref state, b4);
		WriteRawByte(ref buffer, ref state, b5);
	}

	public static uint EncodeZigZag32(int n)
	{
		return (uint)((n << 1) ^ (n >> 31));
	}

	public static ulong EncodeZigZag64(long n)
	{
		return (ulong)((n << 1) ^ (n >> 63));
	}
}
