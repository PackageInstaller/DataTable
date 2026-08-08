using System;
using System.Buffers;
using System.Runtime.CompilerServices;
using System.Threading;

namespace MessagePack;

public ref struct MessagePackWriter
{
	private BufferWriter writer;

	public CancellationToken CancellationToken { get; set; }

	public bool OldSpec { get; set; }

	public MessagePackWriter(IBufferWriter<byte> writer)
	{
		this = default(MessagePackWriter);
		this.writer = new BufferWriter(writer);
		OldSpec = false;
	}

	internal MessagePackWriter(SequencePool sequencePool, byte[] array)
	{
		this = default(MessagePackWriter);
		writer = new BufferWriter(sequencePool, array);
		OldSpec = false;
	}

	public MessagePackWriter Clone(IBufferWriter<byte> writer)
	{
		MessagePackWriter result = new MessagePackWriter(writer);
		result.OldSpec = OldSpec;
		result.CancellationToken = CancellationToken;
		return result;
	}

	public void Flush()
	{
		writer.Commit();
	}

	public void WriteNil()
	{
		writer.GetSpan(1)[0] = 192;
		writer.Advance(1);
	}

	public void WriteRaw(ReadOnlySpan<byte> rawMessagePackBlock)
	{
		writer.Write(rawMessagePackBlock);
	}

	public void WriteRaw(in ReadOnlySequence<byte> rawMessagePackBlock)
	{
		foreach (ReadOnlyMemory<byte> item in rawMessagePackBlock)
		{
			writer.Write(item.Span);
		}
	}

	public void WriteArrayHeader(int count)
	{
		WriteArrayHeader((uint)count);
	}

	[MethodImpl((MethodImplOptions)256)]
	public void WriteArrayHeader(uint count)
	{
		if (count <= 15)
		{
			writer.GetSpan(1)[0] = (byte)(0x90 | count);
			writer.Advance(1);
		}
		else if (count <= 65535)
		{
			Span<byte> span = writer.GetSpan(3);
			span[0] = 220;
			WriteBigEndian((ushort)count, span.Slice(1));
			writer.Advance(3);
		}
		else
		{
			Span<byte> span2 = writer.GetSpan(5);
			span2[0] = 221;
			WriteBigEndian(count, span2.Slice(1));
			writer.Advance(5);
		}
	}

	public void WriteMapHeader(int count)
	{
		WriteMapHeader((uint)count);
	}

	public void WriteMapHeader(uint count)
	{
		if (count <= 15)
		{
			writer.GetSpan(1)[0] = (byte)(0x80 | count);
			writer.Advance(1);
		}
		else if (count <= 65535)
		{
			Span<byte> span = writer.GetSpan(3);
			span[0] = 222;
			WriteBigEndian((ushort)count, span.Slice(1));
			writer.Advance(3);
		}
		else
		{
			Span<byte> span2 = writer.GetSpan(5);
			span2[0] = 223;
			WriteBigEndian(count, span2.Slice(1));
			writer.Advance(5);
		}
	}

	public void Write(byte value)
	{
		if (value <= 127)
		{
			writer.GetSpan(1)[0] = value;
			writer.Advance(1);
		}
		else
		{
			WriteUInt8(value);
		}
	}

	public void WriteUInt8(byte value)
	{
		Span<byte> span = writer.GetSpan(2);
		span[0] = 204;
		span[1] = value;
		writer.Advance(2);
	}

	public void Write(sbyte value)
	{
		if (value < -32)
		{
			WriteInt8(value);
			return;
		}
		writer.GetSpan(1)[0] = (byte)value;
		writer.Advance(1);
	}

	public void WriteInt8(sbyte value)
	{
		Span<byte> span = writer.GetSpan(2);
		span[0] = 208;
		span[1] = (byte)value;
		writer.Advance(2);
	}

	public void Write(ushort value)
	{
		if (value <= 127)
		{
			writer.GetSpan(1)[0] = (byte)value;
			writer.Advance(1);
		}
		else if (value <= 255)
		{
			Span<byte> span = writer.GetSpan(2);
			span[0] = 204;
			span[1] = (byte)value;
			writer.Advance(2);
		}
		else
		{
			WriteUInt16(value);
		}
	}

	public void WriteUInt16(ushort value)
	{
		Span<byte> span = writer.GetSpan(3);
		span[0] = 205;
		WriteBigEndian(value, span.Slice(1));
		writer.Advance(3);
	}

	public void Write(short value)
	{
		if (value >= 0)
		{
			Write((ushort)value);
		}
		else if (value >= -32)
		{
			writer.GetSpan(1)[0] = (byte)value;
			writer.Advance(1);
		}
		else if (value >= -128)
		{
			Span<byte> span = writer.GetSpan(2);
			span[0] = 208;
			span[1] = (byte)value;
			writer.Advance(2);
		}
		else
		{
			WriteInt16(value);
		}
	}

	public void WriteInt16(short value)
	{
		Span<byte> span = writer.GetSpan(3);
		span[0] = 209;
		WriteBigEndian(value, span.Slice(1));
		writer.Advance(3);
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Write(uint value)
	{
		if (value <= 127)
		{
			writer.GetSpan(1)[0] = (byte)value;
			writer.Advance(1);
		}
		else if (value <= 255)
		{
			Span<byte> span = writer.GetSpan(2);
			span[0] = 204;
			span[1] = (byte)value;
			writer.Advance(2);
		}
		else if (value <= 65535)
		{
			Span<byte> span2 = writer.GetSpan(3);
			span2[0] = 205;
			WriteBigEndian((ushort)value, span2.Slice(1));
			writer.Advance(3);
		}
		else
		{
			WriteUInt32(value);
		}
	}

	public void WriteUInt32(uint value)
	{
		Span<byte> span = writer.GetSpan(5);
		span[0] = 206;
		WriteBigEndian(value, span.Slice(1));
		writer.Advance(5);
	}

	[MethodImpl((MethodImplOptions)256)]
	public void Write(int value)
	{
		if (value >= 0)
		{
			Write((uint)value);
		}
		else if (value >= -32)
		{
			writer.GetSpan(1)[0] = (byte)value;
			writer.Advance(1);
		}
		else if (value >= -128)
		{
			Span<byte> span = writer.GetSpan(2);
			span[0] = 208;
			span[1] = (byte)value;
			writer.Advance(2);
		}
		else if (value >= -32768)
		{
			Span<byte> span2 = writer.GetSpan(3);
			span2[0] = 209;
			WriteBigEndian((short)value, span2.Slice(1));
			writer.Advance(3);
		}
		else
		{
			WriteInt32(value);
		}
	}

	public void WriteInt32(int value)
	{
		Span<byte> span = writer.GetSpan(5);
		span[0] = 210;
		WriteBigEndian(value, span.Slice(1));
		writer.Advance(5);
	}

	public void Write(ulong value)
	{
		if (value <= 127)
		{
			writer.GetSpan(1)[0] = (byte)value;
			writer.Advance(1);
		}
		else if (value <= 255)
		{
			Span<byte> span = writer.GetSpan(2);
			span[0] = 204;
			span[1] = (byte)value;
			writer.Advance(2);
		}
		else if (value <= 65535)
		{
			Span<byte> span2 = writer.GetSpan(3);
			span2[0] = 205;
			WriteBigEndian((ushort)value, span2.Slice(1));
			writer.Advance(3);
		}
		else if (value <= uint.MaxValue)
		{
			Span<byte> span3 = writer.GetSpan(5);
			span3[0] = 206;
			WriteBigEndian((uint)value, span3.Slice(1));
			writer.Advance(5);
		}
		else
		{
			WriteUInt64(value);
		}
	}

	public void WriteUInt64(ulong value)
	{
		Span<byte> span = writer.GetSpan(9);
		span[0] = 207;
		WriteBigEndian(value, span.Slice(1));
		writer.Advance(9);
	}

	public void Write(long value)
	{
		if (value >= 0)
		{
			Write((ulong)value);
		}
		else if (value >= -32)
		{
			writer.GetSpan(1)[0] = (byte)value;
			writer.Advance(1);
		}
		else if (value >= -128)
		{
			Span<byte> span = writer.GetSpan(2);
			span[0] = 208;
			span[1] = (byte)value;
			writer.Advance(2);
		}
		else if (value >= -32768)
		{
			Span<byte> span2 = writer.GetSpan(3);
			span2[0] = 209;
			WriteBigEndian((short)value, span2.Slice(1));
			writer.Advance(3);
		}
		else if (value >= int.MinValue)
		{
			Span<byte> span3 = writer.GetSpan(5);
			span3[0] = 210;
			WriteBigEndian((int)value, span3.Slice(1));
			writer.Advance(5);
		}
		else
		{
			WriteInt64(value);
		}
	}

	public void WriteInt64(long value)
	{
		Span<byte> span = writer.GetSpan(9);
		span[0] = 211;
		WriteBigEndian(value, span.Slice(1));
		writer.Advance(9);
	}

	public void Write(bool value)
	{
		writer.GetSpan(1)[0] = (byte)(value ? 195 : 194);
		writer.Advance(1);
	}

	public void Write(char value)
	{
		Write((ushort)value);
	}

	public void Write(float value)
	{
		Span<byte> span = writer.GetSpan(5);
		span[0] = 202;
		WriteBigEndian(value, span.Slice(1));
		writer.Advance(5);
	}

	public void Write(double value)
	{
		Span<byte> span = writer.GetSpan(9);
		span[0] = 203;
		WriteBigEndian(value, span.Slice(1));
		writer.Advance(9);
	}

	public void Write(DateTime dateTime)
	{
		if (OldSpec)
		{
			throw new NotSupportedException("The MsgPack spec does not define a format for DateTime in OldSpec mode. Turn off OldSpec mode or use NativeDateTimeFormatter.");
		}
		if (dateTime.Kind == DateTimeKind.Local)
		{
			dateTime = dateTime.ToUniversalTime();
		}
		long num = dateTime.Ticks / 10000000 - 62135596800L;
		long num2 = dateTime.Ticks % 10000000 * 100;
		if (num >> 34 == 0L)
		{
			ulong num3 = (ulong)((num2 << 34) | num);
			if ((num3 & 0xFFFFFFFF00000000uL) == 0L)
			{
				int value = (int)num3;
				Span<byte> span = writer.GetSpan(6);
				span[0] = 214;
				span[1] = byte.MaxValue;
				WriteBigEndian((uint)value, span.Slice(2));
				writer.Advance(6);
			}
			else
			{
				Span<byte> span2 = writer.GetSpan(10);
				span2[0] = 215;
				span2[1] = byte.MaxValue;
				WriteBigEndian(num3, span2.Slice(2));
				writer.Advance(10);
			}
		}
		else
		{
			Span<byte> span3 = writer.GetSpan(15);
			span3[0] = 199;
			span3[1] = 12;
			span3[2] = byte.MaxValue;
			WriteBigEndian((uint)num2, span3.Slice(3));
			WriteBigEndian(num, span3.Slice(7));
			writer.Advance(15);
		}
	}

	public void Write(byte[] src)
	{
		if (src == null)
		{
			WriteNil();
		}
		else
		{
			Write(src.AsSpan());
		}
	}

	public void Write(ReadOnlySpan<byte> src)
	{
		int length = src.Length;
		WriteBinHeader(length);
		Span<byte> span = writer.GetSpan(length);
		src.CopyTo(span);
		writer.Advance(length);
	}

	public void Write(in ReadOnlySequence<byte> src)
	{
		int num = (int)src.Length;
		WriteBinHeader(num);
		Span<byte> span = writer.GetSpan(num);
		src.CopyTo(span);
		writer.Advance(num);
	}

	public void WriteBinHeader(int length)
	{
		if (OldSpec)
		{
			WriteStringHeader(length);
		}
		else if (length <= 255)
		{
			int sizeHint = length + 2;
			Span<byte> span = writer.GetSpan(sizeHint);
			span[0] = 196;
			span[1] = (byte)length;
			writer.Advance(2);
		}
		else if (length <= 65535)
		{
			int sizeHint2 = length + 3;
			Span<byte> span2 = writer.GetSpan(sizeHint2);
			span2[0] = 197;
			WriteBigEndian((ushort)length, span2.Slice(1));
			writer.Advance(3);
		}
		else
		{
			int sizeHint3 = length + 5;
			Span<byte> span3 = writer.GetSpan(sizeHint3);
			span3[0] = 198;
			WriteBigEndian(length, span3.Slice(1));
			writer.Advance(5);
		}
	}

	public void WriteString(in ReadOnlySequence<byte> utf8stringBytes)
	{
		int num = (int)utf8stringBytes.Length;
		WriteStringHeader(num);
		Span<byte> span = writer.GetSpan(num);
		utf8stringBytes.CopyTo(span);
		writer.Advance(num);
	}

	public void WriteString(ReadOnlySpan<byte> utf8stringBytes)
	{
		int length = utf8stringBytes.Length;
		WriteStringHeader(length);
		Span<byte> span = writer.GetSpan(length);
		utf8stringBytes.CopyTo(span);
		writer.Advance(length);
	}

	public void WriteStringHeader(int byteCount)
	{
		if (byteCount <= 31)
		{
			writer.GetSpan(byteCount + 1)[0] = (byte)(0xA0 | byteCount);
			writer.Advance(1);
		}
		else if (byteCount <= 255 && !OldSpec)
		{
			Span<byte> span = writer.GetSpan(byteCount + 2);
			span[0] = 217;
			span[1] = (byte)byteCount;
			writer.Advance(2);
		}
		else if (byteCount <= 65535)
		{
			Span<byte> span2 = writer.GetSpan(byteCount + 3);
			span2[0] = 218;
			WriteBigEndian((ushort)byteCount, span2.Slice(1));
			writer.Advance(3);
		}
		else
		{
			Span<byte> span3 = writer.GetSpan(byteCount + 5);
			span3[0] = 219;
			WriteBigEndian(byteCount, span3.Slice(1));
			writer.Advance(5);
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	public unsafe void Write(string value)
	{
		if (value == null)
		{
			WriteNil();
			return;
		}
		ref byte reference = ref WriteString_PrepareSpan(value.Length, out var bufferSize, out var encodedBytesOffset);
		fixed (char* chars = value)
		{
			fixed (byte* ptr = &reference)
			{
				int bytes = StringEncoding.UTF8.GetBytes(chars, value.Length, ptr + encodedBytesOffset, bufferSize);
				WriteString_PostEncoding(ptr, encodedBytesOffset, bytes);
			}
		}
	}

	public unsafe void Write(ReadOnlySpan<char> value)
	{
		ref byte reference = ref WriteString_PrepareSpan(value.Length, out var bufferSize, out var encodedBytesOffset);
		fixed (char* chars = value)
		{
			fixed (byte* ptr = &reference)
			{
				int bytes = StringEncoding.UTF8.GetBytes(chars, value.Length, ptr + encodedBytesOffset, bufferSize);
				WriteString_PostEncoding(ptr, encodedBytesOffset, bytes);
			}
		}
	}

	public void WriteExtensionFormatHeader(ExtensionHeader extensionHeader)
	{
		int length = (int)extensionHeader.Length;
		byte b = (byte)extensionHeader.TypeCode;
		switch (length)
		{
		case 1:
		{
			Span<byte> span = writer.GetSpan(2);
			span[0] = 212;
			span[1] = b;
			writer.Advance(2);
			return;
		}
		case 2:
		{
			Span<byte> span = writer.GetSpan(2);
			span[0] = 213;
			span[1] = b;
			writer.Advance(2);
			return;
		}
		case 4:
		{
			Span<byte> span = writer.GetSpan(2);
			span[0] = 214;
			span[1] = b;
			writer.Advance(2);
			return;
		}
		case 8:
		{
			Span<byte> span = writer.GetSpan(2);
			span[0] = 215;
			span[1] = b;
			writer.Advance(2);
			return;
		}
		case 16:
		{
			Span<byte> span = writer.GetSpan(2);
			span[0] = 216;
			span[1] = b;
			writer.Advance(2);
			return;
		}
		}
		if (length <= 255)
		{
			Span<byte> span = writer.GetSpan(length + 3);
			span[0] = 199;
			span[1] = (byte)length;
			span[2] = b;
			writer.Advance(3);
		}
		else if (length <= 65535)
		{
			Span<byte> span = writer.GetSpan(length + 4);
			span[0] = 200;
			WriteBigEndian((ushort)length, span.Slice(1));
			span[3] = b;
			writer.Advance(4);
		}
		else
		{
			Span<byte> span = writer.GetSpan(length + 6);
			span[0] = 201;
			WriteBigEndian(length, span.Slice(1));
			span[5] = b;
			writer.Advance(6);
		}
	}

	public void WriteExtensionFormat(ExtensionResult extensionData)
	{
		WriteExtensionFormatHeader(extensionData.Header);
		WriteRaw(extensionData.Data);
	}

	public Span<byte> GetSpan(int length)
	{
		return writer.GetSpan(length);
	}

	public void Advance(int length)
	{
		writer.Advance(length);
	}

	internal void WriteBigEndian(ushort value)
	{
		Span<byte> span = writer.GetSpan(2);
		WriteBigEndian(value, span);
		writer.Advance(2);
	}

	internal void WriteBigEndian(uint value)
	{
		Span<byte> span = writer.GetSpan(4);
		WriteBigEndian(value, span);
		writer.Advance(4);
	}

	internal void WriteBigEndian(ulong value)
	{
		Span<byte> span = writer.GetSpan(8);
		WriteBigEndian(value, span);
		writer.Advance(8);
	}

	internal byte[] FlushAndGetArray()
	{
		if (writer.TryGetUncommittedSpan(out var span))
		{
			return span.ToArray();
		}
		if (writer.SequenceRental.Value == null)
		{
			throw new NotSupportedException("This instance was not initialized to support this operation.");
		}
		Flush();
		byte[] result = writer.SequenceRental.Value.AsReadOnlySequence.ToArray<byte>();
		writer.SequenceRental.Dispose();
		return result;
	}

	private static void WriteBigEndian(short value, Span<byte> span)
	{
		WriteBigEndian((ushort)value, span);
	}

	private static void WriteBigEndian(int value, Span<byte> span)
	{
		WriteBigEndian((uint)value, span);
	}

	private static void WriteBigEndian(long value, Span<byte> span)
	{
		WriteBigEndian((ulong)value, span);
	}

	private static void WriteBigEndian(ushort value, Span<byte> span)
	{
		span[1] = (byte)value;
		span[0] = (byte)(value >> 8);
	}

	private unsafe static void WriteBigEndian(ushort value, byte* span)
	{
		*span = (byte)(value >> 8);
		span[1] = (byte)value;
	}

	private static void WriteBigEndian(uint value, Span<byte> span)
	{
		span[3] = (byte)value;
		span[2] = (byte)(value >> 8);
		span[1] = (byte)(value >> 16);
		span[0] = (byte)(value >> 24);
	}

	private unsafe static void WriteBigEndian(uint value, byte* span)
	{
		*span = (byte)(value >> 24);
		span[1] = (byte)(value >> 16);
		span[2] = (byte)(value >> 8);
		span[3] = (byte)value;
	}

	private static void WriteBigEndian(ulong value, Span<byte> span)
	{
		span[7] = (byte)value;
		span[6] = (byte)(value >> 8);
		span[5] = (byte)(value >> 16);
		span[4] = (byte)(value >> 24);
		span[3] = (byte)(value >> 32);
		span[2] = (byte)(value >> 40);
		span[1] = (byte)(value >> 48);
		span[0] = (byte)(value >> 56);
	}

	private unsafe static void WriteBigEndian(float value, Span<byte> span)
	{
		WriteBigEndian(*(int*)(&value), span);
	}

	private unsafe static void WriteBigEndian(double value, Span<byte> span)
	{
		WriteBigEndian(*(long*)(&value), span);
	}

	[MethodImpl((MethodImplOptions)256)]
	private ref byte WriteString_PrepareSpan(int characterLength, out int bufferSize, out int encodedBytesOffset)
	{
		bufferSize = StringEncoding.UTF8.GetMaxByteCount(characterLength) + 5;
		ref byte pointer = ref writer.GetPointer(bufferSize);
		int num = ((characterLength <= 31) ? 1 : ((characterLength <= 255 && !OldSpec) ? 2 : ((characterLength > 65535) ? 5 : 3)));
		encodedBytesOffset = num;
		return ref pointer;
	}

	[MethodImpl((MethodImplOptions)256)]
	private unsafe void WriteString_PostEncoding(byte* pBuffer, int estimatedOffset, int byteCount)
	{
		if (byteCount <= 31)
		{
			if (estimatedOffset != 1)
			{
				MemoryCopy(pBuffer + estimatedOffset, pBuffer + 1, byteCount, byteCount);
			}
			*pBuffer = (byte)(0xA0 | byteCount);
			writer.Advance(byteCount + 1);
		}
		else if (byteCount <= 255 && !OldSpec)
		{
			if (estimatedOffset != 2)
			{
				MemoryCopy(pBuffer + estimatedOffset, pBuffer + 2, byteCount, byteCount);
			}
			*pBuffer = 217;
			pBuffer[1] = (byte)byteCount;
			writer.Advance(byteCount + 2);
		}
		else if (byteCount <= 65535)
		{
			if (estimatedOffset != 3)
			{
				MemoryCopy(pBuffer + estimatedOffset, pBuffer + 3, byteCount, byteCount);
			}
			*pBuffer = 218;
			WriteBigEndian((ushort)byteCount, pBuffer + 1);
			writer.Advance(byteCount + 3);
		}
		else
		{
			if (estimatedOffset != 5)
			{
				MemoryCopy(pBuffer + estimatedOffset, pBuffer + 5, byteCount, byteCount);
			}
			*pBuffer = 219;
			WriteBigEndian((uint)byteCount, pBuffer + 1);
			writer.Advance(byteCount + 5);
		}
	}

	[MethodImpl((MethodImplOptions)256)]
	private unsafe static void MemoryCopy(void* source, void* destination, long destinationSizeInBytes, long sourceBytesToCopy)
	{
		byte[] array = ArrayPool<byte>.Shared.Rent((int)sourceBytesToCopy);
		try
		{
			fixed (byte* ptr = array)
			{
				Buffer.MemoryCopy(source, ptr, sourceBytesToCopy, sourceBytesToCopy);
				Buffer.MemoryCopy(ptr, destination, destinationSizeInBytes, sourceBytesToCopy);
			}
		}
		finally
		{
			ArrayPool<byte>.Shared.Return(array);
		}
	}
}
