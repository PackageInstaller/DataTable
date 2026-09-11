using System;
using System.Buffers;
using System.ComponentModel;

namespace MessagePack.Internal;

[EditorBrowsable(EditorBrowsableState.Never)]
public static class CodeGenHelpers
{
	public static byte[] GetEncodedStringBytes(string value)
	{
		int byteCount = StringEncoding.UTF8.GetByteCount(value);
		if (byteCount <= 31)
		{
			byte[] array = new byte[byteCount + 1];
			array[0] = (byte)(0xA0 | byteCount);
			StringEncoding.UTF8.GetBytes(value, 0, value.Length, array, 1);
			return array;
		}
		if (byteCount <= 255)
		{
			byte[] array2 = new byte[byteCount + 2];
			array2[0] = 217;
			array2[1] = (byte)byteCount;
			StringEncoding.UTF8.GetBytes(value, 0, value.Length, array2, 2);
			return array2;
		}
		if (byteCount <= 65535)
		{
			byte[] array3 = new byte[byteCount + 3];
			array3[0] = 218;
			array3[1] = (byte)(byteCount >> 8);
			array3[2] = (byte)byteCount;
			StringEncoding.UTF8.GetBytes(value, 0, value.Length, array3, 3);
			return array3;
		}
		byte[] array4 = new byte[byteCount + 5];
		array4[0] = 219;
		array4[1] = (byte)(byteCount >> 24);
		array4[2] = (byte)(byteCount >> 16);
		array4[3] = (byte)(byteCount >> 8);
		array4[4] = (byte)byteCount;
		StringEncoding.UTF8.GetBytes(value, 0, value.Length, array4, 5);
		return array4;
	}

	public static ReadOnlySpan<byte> GetSpanFromSequence(in ReadOnlySequence<byte> sequence)
	{
		if (sequence.IsSingleSegment)
		{
			return sequence.First.Span;
		}
		return BuffersExtensions.ToArray(in sequence);
	}

	public static ReadOnlySpan<byte> ReadStringSpan(ref MessagePackReader reader)
	{
		if (!reader.TryReadStringSpan(out var span))
		{
			return GetSpanFromSequence(reader.ReadStringSequence());
		}
		return span;
	}

	public static byte[] GetArrayFromNullableSequence(in ReadOnlySequence<byte>? sequence)
	{
		if (!sequence.HasValue)
		{
			return null;
		}
		return sequence.GetValueOrDefault().ToArray<byte>();
	}

	private static ReadOnlySpan<byte> GetSpanFromSequence(in ReadOnlySequence<byte>? sequence)
	{
		if (!sequence.HasValue)
		{
			return default(ReadOnlySpan<byte>);
		}
		return GetSpanFromSequence(sequence.Value);
	}
}
