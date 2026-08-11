using System;
using Unity.Collections.LowLevel.Unsafe;

namespace UnityEngine.InputSystem.Utilities;

internal static class MemoryHelpers
{
	public struct BitRegion
	{
		public uint bitOffset;

		public uint sizeInBits;

		public bool isEmpty => sizeInBits == 0;

		public BitRegion(uint bitOffset, uint sizeInBits)
		{
			this.bitOffset = bitOffset;
			this.sizeInBits = sizeInBits;
		}

		public BitRegion(uint byteOffset, uint bitOffset, uint sizeInBits)
		{
			this.bitOffset = byteOffset * 8 + bitOffset;
			this.sizeInBits = sizeInBits;
		}

		public BitRegion Overlap(BitRegion other)
		{
			uint num = bitOffset + sizeInBits;
			uint num2 = other.bitOffset + other.sizeInBits;
			if (num <= other.bitOffset || num2 <= bitOffset)
			{
				return default(BitRegion);
			}
			uint num3 = Math.Min(num, num2);
			uint num4 = Math.Max(bitOffset, other.bitOffset);
			return new BitRegion(num4, num3 - num4);
		}
	}

	public unsafe static bool Compare(void* ptr1, void* ptr2, BitRegion region)
	{
		if (region.sizeInBits == 1)
		{
			return ReadSingleBit(ptr1, region.bitOffset) == ReadSingleBit(ptr2, region.bitOffset);
		}
		return MemCmpBitRegion(ptr1, ptr2, region.bitOffset, region.sizeInBits, null);
	}

	public static uint ComputeFollowingByteOffset(uint byteOffset, uint sizeInBits)
	{
		return (uint)(byteOffset + sizeInBits / 8 + ((sizeInBits % 8 != 0) ? 1 : 0));
	}

	public unsafe static void WriteSingleBit(void* ptr, uint bitOffset, bool value)
	{
		uint num = bitOffset >> 3;
		bitOffset &= 7;
		if (value)
		{
			byte* num2 = (byte*)ptr + num;
			*num2 |= (byte)(1 << (int)bitOffset);
		}
		else
		{
			byte* num3 = (byte*)ptr + num;
			*num3 &= (byte)(~(1 << (int)bitOffset));
		}
	}

	public unsafe static bool ReadSingleBit(void* ptr, uint bitOffset)
	{
		uint num = bitOffset >> 3;
		bitOffset &= 7;
		return (((byte*)ptr)[num] & (1 << (int)bitOffset)) != 0;
	}

	public unsafe static void MemCpyBitRegion(void* destination, void* source, uint bitOffset, uint bitCount)
	{
		byte* ptr = (byte*)destination;
		byte* ptr2 = (byte*)source;
		if (bitOffset >= 8)
		{
			uint num = bitOffset / 8;
			ptr += num;
			ptr2 += num;
			bitOffset %= 8;
		}
		if (bitOffset != 0)
		{
			int num2 = 255 << (int)bitOffset;
			if (bitCount + bitOffset < 8)
			{
				num2 &= 255 >> (int)(8 - (bitCount + bitOffset));
			}
			*ptr = (byte)(((*ptr & ~num2) | (*ptr2 & num2)) & 0xFF);
			if (bitCount + bitOffset <= 8)
			{
				return;
			}
			ptr++;
			ptr2++;
			bitCount -= 8 - bitOffset;
		}
		uint num3 = bitCount / 8;
		if (num3 >= 1)
		{
			UnsafeUtility.MemCpy(ptr, ptr2, num3);
		}
		uint num4 = bitCount % 8;
		if (num4 != 0)
		{
			ptr += num3;
			ptr2 += num3;
			int num5 = 255 >> (int)(8 - num4);
			*ptr = (byte)(((*ptr & ~num5) | (*ptr2 & num5)) & 0xFF);
		}
	}

	public unsafe static bool MemCmpBitRegion(void* ptr1, void* ptr2, uint bitOffset, uint bitCount, void* mask = null)
	{
		byte* ptr3 = (byte*)ptr1;
		byte* ptr4 = (byte*)ptr2;
		byte* ptr5 = (byte*)mask;
		if (bitOffset >= 8)
		{
			uint num = bitOffset / 8;
			ptr3 += num;
			ptr4 += num;
			if (ptr5 != null)
			{
				ptr5 += num;
			}
			bitOffset %= 8;
		}
		if (bitOffset != 0)
		{
			int num2 = 255 << (int)bitOffset;
			if (bitCount + bitOffset < 8)
			{
				num2 &= 255 >> (int)(8 - (bitCount + bitOffset));
			}
			if (ptr5 != null)
			{
				num2 &= *ptr5;
				ptr5++;
			}
			int num3 = *ptr3 & num2;
			int num4 = *ptr4 & num2;
			if (num3 != num4)
			{
				return false;
			}
			if (bitCount + bitOffset <= 8)
			{
				return true;
			}
			ptr3++;
			ptr4++;
			bitCount -= 8 - bitOffset;
		}
		uint num5 = bitCount / 8;
		if (num5 >= 1)
		{
			if (ptr5 != null)
			{
				for (int i = 0; i < num5; i++)
				{
					byte num6 = ptr3[i];
					byte b = ptr4[i];
					byte b2 = ptr5[i];
					if ((num6 & b2) != (b & b2))
					{
						return false;
					}
				}
			}
			else if (UnsafeUtility.MemCmp(ptr3, ptr4, num5) != 0)
			{
				return false;
			}
		}
		uint num7 = bitCount % 8;
		if (num7 != 0)
		{
			ptr3 += num5;
			ptr4 += num5;
			int num8 = 255 >> (int)(8 - num7);
			if (ptr5 != null)
			{
				ptr5 += num5;
				num8 &= *ptr5;
			}
			int num9 = *ptr3 & num8;
			int num10 = *ptr4 & num8;
			if (num9 != num10)
			{
				return false;
			}
		}
		return true;
	}

	public unsafe static void MemSet(void* destination, int numBytes, byte value)
	{
		int num = 0;
		while (numBytes >= 4)
		{
			*(int*)((byte*)destination + num) = (value << 24) | (value << 16) | (value << 8) | value;
			numBytes -= 4;
			num += 4;
		}
		while (numBytes > 0)
		{
			((sbyte*)destination)[num] = (sbyte)value;
			numBytes--;
			num++;
		}
	}

	public unsafe static void MemCpyMasked(void* destination, void* source, int numBytes, void* mask)
	{
		int num = 0;
		while (numBytes >= 4)
		{
			*(int*)((byte*)destination + num) &= (int)(~(*(uint*)((byte*)mask + num)));
			*(int*)((byte*)destination + num) |= (int)(*(uint*)((byte*)source + num) & *(uint*)((byte*)mask + num));
			numBytes -= 4;
			num += 4;
		}
		while (numBytes > 0)
		{
			byte* num2 = (byte*)destination + num;
			*num2 &= (byte)(~((byte*)mask)[num]);
			byte* num3 = (byte*)destination + num;
			*num3 |= (byte)(((byte*)source)[num] & ((byte*)mask)[num]);
			numBytes--;
			num++;
		}
	}

	public unsafe static uint ReadMultipleBitsAsUInt(void* ptr, uint bitOffset, uint bitCount)
	{
		if (ptr == null)
		{
			throw new ArgumentNullException("ptr");
		}
		if (bitCount > 32)
		{
			throw new ArgumentException("Trying to read more than 32 bits as int", "bitCount");
		}
		if (bitOffset > 32)
		{
			int num = (int)bitOffset % 32;
			int num2 = ((int)bitOffset - num) / 32;
			ptr = (byte*)ptr + num2 * 4;
			bitOffset = (uint)num;
		}
		if (bitOffset + bitCount <= 8)
		{
			byte num3 = (byte)(*(byte*)ptr >> (int)bitOffset);
			uint num4 = 255u >> (int)(8 - bitCount);
			return num3 & num4;
		}
		if (bitOffset + bitCount <= 16)
		{
			ushort num5 = (ushort)(*(ushort*)ptr >> (int)bitOffset);
			uint num6 = 65535u >> (int)(16 - bitCount);
			return num5 & num6;
		}
		if (bitOffset + bitCount <= 32)
		{
			uint num7 = *(uint*)ptr >> (int)bitOffset;
			uint num8 = uint.MaxValue >> (int)(32 - bitCount);
			return num7 & num8;
		}
		throw new NotImplementedException("Reading int straddling int boundary");
	}

	public unsafe static void WriteUIntAsMultipleBits(void* ptr, uint bitOffset, uint bitCount, uint value)
	{
		if (ptr == null)
		{
			throw new ArgumentNullException("ptr");
		}
		if (bitCount > 32)
		{
			throw new ArgumentException("Trying to write more than 32 bits as int", "bitCount");
		}
		if (bitOffset > 32)
		{
			int num = (int)bitOffset % 32;
			int num2 = ((int)bitOffset - num) / 32;
			ptr = (byte*)ptr + num2 * 4;
			bitOffset = (uint)num;
		}
		if (bitOffset + bitCount <= 8)
		{
			byte b = (byte)value;
			b = (byte)(b << (int)bitOffset);
			uint num3 = (uint)(~(255 >>> (int)(8 - bitCount) << (int)bitOffset));
			*(byte*)ptr = (byte)((*(byte*)ptr & num3) | b);
			return;
		}
		if (bitOffset + bitCount <= 16)
		{
			ushort num4 = (ushort)value;
			num4 = (ushort)(num4 << (int)bitOffset);
			uint num5 = (uint)(~(65535 >>> (int)(16 - bitCount) << (int)bitOffset));
			*(ushort*)ptr = (ushort)((*(ushort*)ptr & num5) | num4);
			return;
		}
		if (bitOffset + bitCount <= 32)
		{
			uint num6 = value;
			num6 <<= (int)bitOffset;
			uint num7 = (uint)(~(-1 >>> (int)(32 - bitCount) << (int)bitOffset));
			*(uint*)ptr = (*(uint*)ptr & num7) | num6;
			return;
		}
		throw new NotImplementedException("Writing int straddling int boundary");
	}

	public unsafe static int ReadTwosComplementMultipleBitsAsInt(void* ptr, uint bitOffset, uint bitCount)
	{
		return (int)ReadMultipleBitsAsUInt(ptr, bitOffset, bitCount);
	}

	public unsafe static void WriteIntAsTwosComplementMultipleBits(void* ptr, uint bitOffset, uint bitCount, int value)
	{
		WriteUIntAsMultipleBits(ptr, bitOffset, bitCount, (uint)value);
	}

	public unsafe static int ReadExcessKMultipleBitsAsInt(void* ptr, uint bitOffset, uint bitCount)
	{
		long num = ReadMultipleBitsAsUInt(ptr, bitOffset, bitCount);
		long num2 = (long)((ulong)(1L << (int)bitCount) / 2uL);
		return (int)(num - num2);
	}

	public unsafe static void WriteIntAsExcessKMultipleBits(void* ptr, uint bitOffset, uint bitCount, int value)
	{
		long num = (long)((ulong)(1L << (int)bitCount) / 2uL) + (long)value;
		WriteUIntAsMultipleBits(ptr, bitOffset, bitCount, (uint)num);
	}

	public unsafe static float ReadMultipleBitsAsNormalizedUInt(void* ptr, uint bitOffset, uint bitCount)
	{
		uint value = ReadMultipleBitsAsUInt(ptr, bitOffset, bitCount);
		uint maxValue = (uint)((1L << (int)bitCount) - 1);
		return NumberHelpers.UIntToNormalizedFloat(value, 0u, maxValue);
	}

	public unsafe static void WriteNormalizedUIntAsMultipleBits(void* ptr, uint bitOffset, uint bitCount, float value)
	{
		uint uintMaxValue = (uint)((1L << (int)bitCount) - 1);
		uint value2 = NumberHelpers.NormalizedFloatToUInt(value, 0u, uintMaxValue);
		WriteUIntAsMultipleBits(ptr, bitOffset, bitCount, value2);
	}

	public unsafe static void SetBitsInBuffer(void* buffer, int byteOffset, int bitOffset, int sizeInBits, bool value)
	{
		if (buffer == null)
		{
			throw new ArgumentException("A buffer must be provided to apply the bitmask on", "buffer");
		}
		if (sizeInBits < 0)
		{
			throw new ArgumentException("Negative sizeInBits", "sizeInBits");
		}
		if (bitOffset < 0)
		{
			throw new ArgumentException("Negative bitOffset", "bitOffset");
		}
		if (byteOffset < 0)
		{
			throw new ArgumentException("Negative byteOffset", "byteOffset");
		}
		if (bitOffset >= 8)
		{
			int num = bitOffset / 8;
			byteOffset += num;
			bitOffset %= 8;
		}
		byte* ptr = (byte*)buffer + byteOffset;
		int num2 = sizeInBits;
		if (bitOffset != 0)
		{
			int num3 = 255 << bitOffset;
			if (num2 + bitOffset < 8)
			{
				num3 &= 255 >> 8 - (num2 + bitOffset);
			}
			if (value)
			{
				byte* intPtr = ptr;
				*intPtr |= (byte)num3;
			}
			else
			{
				byte* intPtr2 = ptr;
				*intPtr2 &= (byte)(~num3);
			}
			ptr++;
			num2 -= 8 - bitOffset;
		}
		while (num2 >= 8)
		{
			*ptr = (byte)(value ? byte.MaxValue : 0);
			ptr++;
			num2 -= 8;
		}
		if (num2 > 0)
		{
			byte b = (byte)(255 >> 8 - num2);
			if (value)
			{
				byte* intPtr3 = ptr;
				*intPtr3 |= b;
			}
			else
			{
				byte* intPtr4 = ptr;
				*intPtr4 &= (byte)(~b);
			}
		}
	}

	public static void Swap<TValue>(ref TValue a, ref TValue b)
	{
		TValue val = a;
		a = b;
		b = val;
	}

	public static uint AlignNatural(uint offset, uint sizeInBytes)
	{
		uint alignment = Math.Min(8u, sizeInBytes);
		return offset.AlignToMultipleOf(alignment);
	}
}
