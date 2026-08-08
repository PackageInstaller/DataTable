using System.Runtime;
using System.Runtime.CompilerServices;
using System.Runtime.ConstrainedExecution;
using System.Runtime.InteropServices;
using System.Threading;

namespace System;

[ComVisible(true)]
public static class Buffer
{
	[MethodImpl((MethodImplOptions)4096)]
	internal static extern bool InternalBlockCopy(Array src, int srcOffsetBytes, Array dst, int dstOffsetBytes, int byteCount);

	internal unsafe static int IndexOfByte(byte* src, byte value, int index, int count)
	{
		byte* ptr;
		for (ptr = src + index; ((int)ptr & 3) != 0; ptr++)
		{
			if (count == 0)
			{
				return -1;
			}
			if (*ptr == value)
			{
				return (int)(ptr - src);
			}
			count--;
		}
		uint num = (uint)((value << 8) + value);
		num = (num << 16) + num;
		while (count > 3)
		{
			uint num2 = *(uint*)ptr;
			num2 ^= num;
			uint num3 = 2130640639 + num2;
			num2 ^= 0xFFFFFFFFu;
			num2 ^= num3;
			if ((num2 & 0x81010100u) != 0)
			{
				int num4 = (int)(ptr - src);
				if (*ptr == value)
				{
					return num4;
				}
				if (ptr[1] == value)
				{
					return num4 + 1;
				}
				if (ptr[2] == value)
				{
					return num4 + 2;
				}
				if (ptr[3] == value)
				{
					return num4 + 3;
				}
			}
			count -= 4;
			ptr += 4;
		}
		while (count > 0)
		{
			if (*ptr == value)
			{
				return (int)(ptr - src);
			}
			count--;
			ptr++;
		}
		return -1;
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern int _ByteLength(Array array);

	internal unsafe static void ZeroMemory(byte* src, long len)
	{
		while (len-- > 0)
		{
			src[len] = 0;
		}
	}

	[ReliabilityContract(Consistency.WillNotCorruptState, Cer.Success)]
	internal unsafe static void Memcpy(byte* pDest, int destIndex, byte[] src, int srcIndex, int len)
	{
		if (len != 0)
		{
			fixed (byte* ptr = src)
			{
				Memcpy(pDest + destIndex, ptr + srcIndex, len);
			}
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal unsafe static extern void InternalMemcpy(byte* dest, byte* src, int count);

	public static int ByteLength(Array array)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		int num = _ByteLength(array);
		if (num < 0)
		{
			throw new ArgumentException("Object must be an array of primitives.");
		}
		return num;
	}

	public static void BlockCopy(Array src, int srcOffset, Array dst, int dstOffset, int count)
	{
		if (src == null)
		{
			throw new ArgumentNullException("src");
		}
		if (dst == null)
		{
			throw new ArgumentNullException("dst");
		}
		if (srcOffset < 0)
		{
			throw new ArgumentOutOfRangeException("srcOffset", "Non-negative number required.");
		}
		if (dstOffset < 0)
		{
			throw new ArgumentOutOfRangeException("dstOffset", "Non-negative number required.");
		}
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count", "Non-negative number required.");
		}
		if (!InternalBlockCopy(src, srcOffset, dst, dstOffset, count) && (srcOffset > ByteLength(src) - count || dstOffset > ByteLength(dst) - count))
		{
			throw new ArgumentException("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection.");
		}
	}

	[CLSCompliant(false)]
	public unsafe static void MemoryCopy(void* source, void* destination, long destinationSizeInBytes, long sourceBytesToCopy)
	{
		if (sourceBytesToCopy > destinationSizeInBytes)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException(ExceptionArgument.sourceBytesToCopy);
		}
		byte* ptr = (byte*)source;
		byte* ptr2 = (byte*)destination;
		while (sourceBytesToCopy > uint.MaxValue)
		{
			Memmove(ptr2, ptr, uint.MaxValue);
			sourceBytesToCopy -= uint.MaxValue;
			ptr += uint.MaxValue;
			ptr2 += uint.MaxValue;
		}
		Memmove(ptr2, ptr, (uint)sourceBytesToCopy);
	}

	internal unsafe static void memcpy4(byte* dest, byte* src, int size)
	{
		while (size >= 16)
		{
			*(int*)dest = *(int*)src;
			((int*)dest)[1] = ((int*)src)[1];
			((int*)dest)[2] = ((int*)src)[2];
			((int*)dest)[3] = ((int*)src)[3];
			dest += 16;
			src += 16;
			size -= 16;
		}
		while (size >= 4)
		{
			*(int*)dest = *(int*)src;
			dest += 4;
			src += 4;
			size -= 4;
		}
		while (size > 0)
		{
			*dest = *src;
			dest++;
			src++;
			size--;
		}
	}

	internal unsafe static void memcpy2(byte* dest, byte* src, int size)
	{
		while (size >= 8)
		{
			*(short*)dest = *(short*)src;
			((short*)dest)[1] = ((short*)src)[1];
			((short*)dest)[2] = ((short*)src)[2];
			((short*)dest)[3] = ((short*)src)[3];
			dest += 8;
			src += 8;
			size -= 8;
		}
		while (size >= 2)
		{
			*(short*)dest = *(short*)src;
			dest += 2;
			src += 2;
			size -= 2;
		}
		if (size > 0)
		{
			*dest = *src;
		}
	}

	private unsafe static void memcpy1(byte* dest, byte* src, int size)
	{
		while (size >= 8)
		{
			*dest = *src;
			dest[1] = src[1];
			dest[2] = src[2];
			dest[3] = src[3];
			dest[4] = src[4];
			dest[5] = src[5];
			dest[6] = src[6];
			dest[7] = src[7];
			dest += 8;
			src += 8;
			size -= 8;
		}
		while (size >= 2)
		{
			*dest = *src;
			dest[1] = src[1];
			dest += 2;
			src += 2;
			size -= 2;
		}
		if (size > 0)
		{
			*dest = *src;
		}
	}

	internal unsafe static void Memcpy(byte* dest, byte* src, int len)
	{
		if (len > 32)
		{
			long location = *dest;
			Interlocked.Read(ref location);
			InternalMemcpy(dest, src, len);
			return;
		}
		if ((((int)dest | (int)src) & 3) != 0)
		{
			if (((int)dest & 1) != 0 && ((int)src & 1) != 0 && len >= 1)
			{
				*dest = *src;
				dest++;
				src++;
				len--;
			}
			if (((int)dest & 2) != 0 && ((int)src & 2) != 0 && len >= 2)
			{
				*(short*)dest = *(short*)src;
				dest += 2;
				src += 2;
				len -= 2;
			}
			if ((((int)dest | (int)src) & 1) != 0)
			{
				memcpy1(dest, src, len);
				return;
			}
			if ((((int)dest | (int)src) & 2) != 0)
			{
				memcpy2(dest, src, len);
				return;
			}
		}
		memcpy4(dest, src, len);
	}

	internal unsafe static void Memmove(byte* dest, byte* src, uint len)
	{
		if ((ulong)((long)dest - (long)src) >= (ulong)len && (ulong)((long)src - (long)dest) >= (ulong)len)
		{
			Memcpy(dest, src, (int)len);
		}
		else
		{
			RuntimeImports.Memmove(dest, src, len);
		}
	}

	internal unsafe static void Memmove<T>(ref T destination, ref T source, ulong elementCount)
	{
		if (!RuntimeHelpers.IsReferenceOrContainsReferences<T>())
		{
			fixed (byte* dest = &Unsafe.As<T, byte>(ref destination))
			{
				fixed (byte* src = &Unsafe.As<T, byte>(ref source))
				{
					Memmove(dest, src, (uint)((int)elementCount * Unsafe.SizeOf<T>()));
				}
			}
			return;
		}
		fixed (byte* dest2 = &Unsafe.As<T, byte>(ref destination))
		{
			fixed (byte* src2 = &Unsafe.As<T, byte>(ref source))
			{
				RuntimeImports.Memmove_wbarrier(dest2, src2, (uint)elementCount, typeof(T).TypeHandle.Value);
			}
		}
	}
}
