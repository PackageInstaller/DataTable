using System;
using System.Buffers.Binary;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

namespace MessagePack;

internal static class SequenceReaderExtensions
{
	[MethodImpl((MethodImplOptions)256)]
	internal unsafe static bool TryRead<T>(this ref SequenceReader<byte> reader, out T value) where T : unmanaged
	{
		ReadOnlySpan<byte> unreadSpan = reader.UnreadSpan;
		if (unreadSpan.Length < sizeof(T))
		{
			return TryReadMultisegment<T>(ref reader, out value);
		}
		value = Unsafe.ReadUnaligned<T>(ref MemoryMarshal.GetReference(unreadSpan));
		reader.Advance(sizeof(T));
		return true;
	}

	private unsafe static bool TryReadMultisegment<T>(ref SequenceReader<byte> reader, out T value) where T : unmanaged
	{
		T val = default(T);
		Span<byte> span = new Span<byte>(&val, sizeof(T));
		if (!reader.TryCopyTo(span))
		{
			value = default(T);
			return false;
		}
		value = Unsafe.ReadUnaligned<T>(ref MemoryMarshal.GetReference(span));
		reader.Advance(sizeof(T));
		return true;
	}

	public static bool TryRead(this ref SequenceReader<byte> reader, out sbyte value)
	{
		if (TryRead(ref reader, out byte value2))
		{
			value = (sbyte)value2;
			return true;
		}
		value = 0;
		return false;
	}

	public static bool TryReadBigEndian(this ref SequenceReader<byte> reader, out short value)
	{
		if (!BitConverter.IsLittleEndian)
		{
			return reader.TryRead(out value);
		}
		return TryReadReverseEndianness(ref reader, out value);
	}

	public static bool TryReadBigEndian(this ref SequenceReader<byte> reader, out ushort value)
	{
		if (reader.TryReadBigEndian(out short value2))
		{
			value = (ushort)value2;
			return true;
		}
		value = 0;
		return false;
	}

	private static bool TryReadReverseEndianness(ref SequenceReader<byte> reader, out short value)
	{
		if (reader.TryRead(out value))
		{
			value = BinaryPrimitives.ReverseEndianness(value);
			return true;
		}
		return false;
	}

	public static bool TryReadBigEndian(this ref SequenceReader<byte> reader, out int value)
	{
		if (!BitConverter.IsLittleEndian)
		{
			return reader.TryRead(out value);
		}
		return TryReadReverseEndianness(ref reader, out value);
	}

	public static bool TryReadBigEndian(this ref SequenceReader<byte> reader, out uint value)
	{
		if (reader.TryReadBigEndian(out int value2))
		{
			value = (uint)value2;
			return true;
		}
		value = 0u;
		return false;
	}

	private static bool TryReadReverseEndianness(ref SequenceReader<byte> reader, out int value)
	{
		if (reader.TryRead(out value))
		{
			value = BinaryPrimitives.ReverseEndianness(value);
			return true;
		}
		return false;
	}

	public static bool TryReadBigEndian(this ref SequenceReader<byte> reader, out long value)
	{
		if (!BitConverter.IsLittleEndian)
		{
			return reader.TryRead(out value);
		}
		return TryReadReverseEndianness(ref reader, out value);
	}

	public static bool TryReadBigEndian(this ref SequenceReader<byte> reader, out ulong value)
	{
		if (reader.TryReadBigEndian(out long value2))
		{
			value = (ulong)value2;
			return true;
		}
		value = 0uL;
		return false;
	}

	private static bool TryReadReverseEndianness(ref SequenceReader<byte> reader, out long value)
	{
		if (reader.TryRead(out value))
		{
			value = BinaryPrimitives.ReverseEndianness(value);
			return true;
		}
		return false;
	}

	public unsafe static bool TryReadBigEndian(this ref SequenceReader<byte> reader, out float value)
	{
		if (reader.TryReadBigEndian(out int value2))
		{
			value = *(float*)(&value2);
			return true;
		}
		value = 0f;
		return false;
	}

	public unsafe static bool TryReadBigEndian(this ref SequenceReader<byte> reader, out double value)
	{
		if (reader.TryReadBigEndian(out long value2))
		{
			value = *(double*)(&value2);
			return true;
		}
		value = 0.0;
		return false;
	}
}
