using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

namespace System;

public static class BitConverter
{
	[Intrinsic]
	public static readonly bool IsLittleEndian;

	public static byte[] GetBytes(bool value)
	{
		return new byte[1] { (byte)(value ? 1 : 0) };
	}

	public static bool TryWriteBytes(Span<byte> destination, bool value)
	{
		if (destination.Length < 1)
		{
			return false;
		}
		Unsafe.WriteUnaligned(ref MemoryMarshal.GetReference(destination), (byte)(value ? 1 : 0));
		return true;
	}

	public static byte[] GetBytes(char value)
	{
		byte[] array = new byte[2];
		Unsafe.As<byte, char>(ref array[0]) = value;
		return array;
	}

	public static bool TryWriteBytes(Span<byte> destination, char value)
	{
		if (destination.Length < 2)
		{
			return false;
		}
		Unsafe.WriteUnaligned(ref MemoryMarshal.GetReference(destination), value);
		return true;
	}

	public static byte[] GetBytes(short value)
	{
		byte[] array = new byte[2];
		Unsafe.As<byte, short>(ref array[0]) = value;
		return array;
	}

	public static bool TryWriteBytes(Span<byte> destination, short value)
	{
		if (destination.Length < 2)
		{
			return false;
		}
		Unsafe.WriteUnaligned(ref MemoryMarshal.GetReference(destination), value);
		return true;
	}

	public static byte[] GetBytes(int value)
	{
		byte[] array = new byte[4];
		Unsafe.As<byte, int>(ref array[0]) = value;
		return array;
	}

	public static bool TryWriteBytes(Span<byte> destination, int value)
	{
		if (destination.Length < 4)
		{
			return false;
		}
		Unsafe.WriteUnaligned(ref MemoryMarshal.GetReference(destination), value);
		return true;
	}

	public static byte[] GetBytes(long value)
	{
		byte[] array = new byte[8];
		Unsafe.As<byte, long>(ref array[0]) = value;
		return array;
	}

	public static bool TryWriteBytes(Span<byte> destination, long value)
	{
		if (destination.Length < 8)
		{
			return false;
		}
		Unsafe.WriteUnaligned(ref MemoryMarshal.GetReference(destination), value);
		return true;
	}

	[CLSCompliant(false)]
	public static byte[] GetBytes(ushort value)
	{
		byte[] array = new byte[2];
		Unsafe.As<byte, ushort>(ref array[0]) = value;
		return array;
	}

	[CLSCompliant(false)]
	public static bool TryWriteBytes(Span<byte> destination, ushort value)
	{
		if (destination.Length < 2)
		{
			return false;
		}
		Unsafe.WriteUnaligned(ref MemoryMarshal.GetReference(destination), value);
		return true;
	}

	[CLSCompliant(false)]
	public static byte[] GetBytes(uint value)
	{
		byte[] array = new byte[4];
		Unsafe.As<byte, uint>(ref array[0]) = value;
		return array;
	}

	[CLSCompliant(false)]
	public static bool TryWriteBytes(Span<byte> destination, uint value)
	{
		if (destination.Length < 4)
		{
			return false;
		}
		Unsafe.WriteUnaligned(ref MemoryMarshal.GetReference(destination), value);
		return true;
	}

	[CLSCompliant(false)]
	public static byte[] GetBytes(ulong value)
	{
		byte[] array = new byte[8];
		Unsafe.As<byte, ulong>(ref array[0]) = value;
		return array;
	}

	[CLSCompliant(false)]
	public static bool TryWriteBytes(Span<byte> destination, ulong value)
	{
		if (destination.Length < 8)
		{
			return false;
		}
		Unsafe.WriteUnaligned(ref MemoryMarshal.GetReference(destination), value);
		return true;
	}

	public static byte[] GetBytes(float value)
	{
		byte[] array = new byte[4];
		Unsafe.As<byte, float>(ref array[0]) = value;
		return array;
	}

	public static bool TryWriteBytes(Span<byte> destination, float value)
	{
		if (destination.Length < 4)
		{
			return false;
		}
		Unsafe.WriteUnaligned(ref MemoryMarshal.GetReference(destination), value);
		return true;
	}

	public static byte[] GetBytes(double value)
	{
		byte[] array = new byte[8];
		Unsafe.As<byte, double>(ref array[0]) = value;
		return array;
	}

	public static bool TryWriteBytes(Span<byte> destination, double value)
	{
		if (destination.Length < 8)
		{
			return false;
		}
		Unsafe.WriteUnaligned(ref MemoryMarshal.GetReference(destination), value);
		return true;
	}

	public static char ToChar(byte[] value, int startIndex)
	{
		return (char)ToInt16(value, startIndex);
	}

	public static char ToChar(ReadOnlySpan<byte> value)
	{
		if (value.Length < 2)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.value);
		}
		return Unsafe.ReadUnaligned<char>(ref MemoryMarshal.GetReference(value));
	}

	public static short ToInt16(byte[] value, int startIndex)
	{
		if (value == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.value);
		}
		if ((uint)startIndex >= (uint)value.Length)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.startIndex, ExceptionResource.ArgumentOutOfRange_Index);
		}
		if (startIndex > value.Length - 2)
		{
			ThrowHelper.ThrowArgumentException(ExceptionResource.Arg_ArrayPlusOffTooSmall, ExceptionArgument.value);
		}
		return Unsafe.ReadUnaligned<short>(ref value[startIndex]);
	}

	public static short ToInt16(ReadOnlySpan<byte> value)
	{
		if (value.Length < 2)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.value);
		}
		return Unsafe.ReadUnaligned<short>(ref MemoryMarshal.GetReference(value));
	}

	public static int ToInt32(byte[] value, int startIndex)
	{
		if (value == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.value);
		}
		if ((uint)startIndex >= (uint)value.Length)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.startIndex, ExceptionResource.ArgumentOutOfRange_Index);
		}
		if (startIndex > value.Length - 4)
		{
			ThrowHelper.ThrowArgumentException(ExceptionResource.Arg_ArrayPlusOffTooSmall, ExceptionArgument.value);
		}
		return Unsafe.ReadUnaligned<int>(ref value[startIndex]);
	}

	public static int ToInt32(ReadOnlySpan<byte> value)
	{
		if (value.Length < 4)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.value);
		}
		return Unsafe.ReadUnaligned<int>(ref MemoryMarshal.GetReference(value));
	}

	public static long ToInt64(byte[] value, int startIndex)
	{
		if (value == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.value);
		}
		if ((uint)startIndex >= (uint)value.Length)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.startIndex, ExceptionResource.ArgumentOutOfRange_Index);
		}
		if (startIndex > value.Length - 8)
		{
			ThrowHelper.ThrowArgumentException(ExceptionResource.Arg_ArrayPlusOffTooSmall, ExceptionArgument.value);
		}
		return Unsafe.ReadUnaligned<long>(ref value[startIndex]);
	}

	public static long ToInt64(ReadOnlySpan<byte> value)
	{
		if (value.Length < 8)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.value);
		}
		return Unsafe.ReadUnaligned<long>(ref MemoryMarshal.GetReference(value));
	}

	[CLSCompliant(false)]
	public static ushort ToUInt16(byte[] value, int startIndex)
	{
		return (ushort)ToInt16(value, startIndex);
	}

	[CLSCompliant(false)]
	public static ushort ToUInt16(ReadOnlySpan<byte> value)
	{
		if (value.Length < 2)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.value);
		}
		return Unsafe.ReadUnaligned<ushort>(ref MemoryMarshal.GetReference(value));
	}

	[CLSCompliant(false)]
	public static uint ToUInt32(byte[] value, int startIndex)
	{
		return (uint)ToInt32(value, startIndex);
	}

	[CLSCompliant(false)]
	public static uint ToUInt32(ReadOnlySpan<byte> value)
	{
		if (value.Length < 4)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.value);
		}
		return Unsafe.ReadUnaligned<uint>(ref MemoryMarshal.GetReference(value));
	}

	[CLSCompliant(false)]
	public static ulong ToUInt64(byte[] value, int startIndex)
	{
		return (ulong)ToInt64(value, startIndex);
	}

	[CLSCompliant(false)]
	public static ulong ToUInt64(ReadOnlySpan<byte> value)
	{
		if (value.Length < 8)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.value);
		}
		return Unsafe.ReadUnaligned<ulong>(ref MemoryMarshal.GetReference(value));
	}

	public static float ToSingle(byte[] value, int startIndex)
	{
		return Int32BitsToSingle(ToInt32(value, startIndex));
	}

	public static float ToSingle(ReadOnlySpan<byte> value)
	{
		if (value.Length < 4)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.value);
		}
		return Unsafe.ReadUnaligned<float>(ref MemoryMarshal.GetReference(value));
	}

	public static double ToDouble(byte[] value, int startIndex)
	{
		return Int64BitsToDouble(ToInt64(value, startIndex));
	}

	public static double ToDouble(ReadOnlySpan<byte> value)
	{
		if (value.Length < 8)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.value);
		}
		return Unsafe.ReadUnaligned<double>(ref MemoryMarshal.GetReference(value));
	}

	public static string ToString(byte[] value, int startIndex, int length)
	{
		if (value == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.value);
		}
		if (startIndex < 0 || (startIndex >= value.Length && startIndex > 0))
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.startIndex, ExceptionResource.ArgumentOutOfRange_Index);
		}
		if (length < 0)
		{
			throw new ArgumentOutOfRangeException("length", "Value must be positive.");
		}
		if (startIndex > value.Length - length)
		{
			ThrowHelper.ThrowArgumentException(ExceptionResource.Arg_ArrayPlusOffTooSmall, ExceptionArgument.value);
		}
		if (length == 0)
		{
			return string.Empty;
		}
		if (length > 715827882)
		{
			throw new ArgumentOutOfRangeException("length", SR.Format("The specified length exceeds the maximum value of {0}.", 715827882));
		}
		return string.Create(length * 3 - 1, (value, startIndex, length), delegate(Span<char> dst, (byte[] value, int startIndex, int length) state)
		{
			ReadOnlySpan<byte> readOnlySpan = new ReadOnlySpan<byte>(state.value, state.startIndex, state.length);
			int num = 0;
			int num2 = 0;
			byte b = readOnlySpan[num++];
			dst[num2++] = "0123456789ABCDEF"[b >> 4];
			dst[num2++] = "0123456789ABCDEF"[b & 0xF];
			while (num < readOnlySpan.Length)
			{
				b = readOnlySpan[num++];
				dst[num2++] = '-';
				dst[num2++] = "0123456789ABCDEF"[b >> 4];
				dst[num2++] = "0123456789ABCDEF"[b & 0xF];
			}
		});
	}

	public static string ToString(byte[] value)
	{
		if (value == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.value);
		}
		return ToString(value, 0, value.Length);
	}

	public static string ToString(byte[] value, int startIndex)
	{
		if (value == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.value);
		}
		return ToString(value, startIndex, value.Length - startIndex);
	}

	public static bool ToBoolean(byte[] value, int startIndex)
	{
		if (value == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.value);
		}
		if (startIndex < 0)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.startIndex, ExceptionResource.ArgumentOutOfRange_Index);
		}
		if (startIndex > value.Length - 1)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.startIndex, ExceptionResource.ArgumentOutOfRange_Index);
		}
		return value[startIndex] != 0;
	}

	public static bool ToBoolean(ReadOnlySpan<byte> value)
	{
		if (value.Length < 1)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.value);
		}
		return Unsafe.ReadUnaligned<byte>(ref MemoryMarshal.GetReference(value)) != 0;
	}

	[MethodImpl((MethodImplOptions)256)]
	public unsafe static long DoubleToInt64Bits(double value)
	{
		return *(long*)(&value);
	}

	[MethodImpl((MethodImplOptions)256)]
	public unsafe static double Int64BitsToDouble(long value)
	{
		return *(double*)(&value);
	}

	[MethodImpl((MethodImplOptions)256)]
	public unsafe static int SingleToInt32Bits(float value)
	{
		return *(int*)(&value);
	}

	[MethodImpl((MethodImplOptions)256)]
	public unsafe static float Int32BitsToSingle(int value)
	{
		return *(float*)(&value);
	}

	unsafe static BitConverter()
	{
		ushort num = 4660;
		byte* ptr = (byte*)(&num);
		IsLittleEndian = *ptr == 52;
	}
}
