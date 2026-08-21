using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

namespace System;

internal static class InternalSpanEx
{
	[MethodImpl((MethodImplOptions)256)]
	internal static bool EqualsOrdinalIgnoreCase(this ReadOnlySpan<char> span, ReadOnlySpan<char> value)
	{
		if (span.Length != value.Length)
		{
			return false;
		}
		if (value.Length == 0)
		{
			return true;
		}
		return EqualsOrdinalIgnoreCase(ref MemoryMarshal.GetReference(span), ref MemoryMarshal.GetReference(value), span.Length);
	}

	private static bool EqualsOrdinalIgnoreCase(ref char charA, ref char charB, int length)
	{
		IntPtr zero = IntPtr.Zero;
		if (IntPtr.Size == 8)
		{
			while ((uint)length >= 4u)
			{
				ulong num = Unsafe.ReadUnaligned<ulong>(ref Unsafe.As<char, byte>(ref Unsafe.AddByteOffset(ref charA, zero)));
				ulong num2 = Unsafe.ReadUnaligned<ulong>(ref Unsafe.As<char, byte>(ref Unsafe.AddByteOffset(ref charB, zero)));
				ulong num3 = num | num2;
				if (AllCharsInUInt32AreAscii((uint)((int)num3 | (int)(num3 >> 32))))
				{
					if (!UInt64OrdinalIgnoreCaseAscii(num, num2))
					{
						return false;
					}
					zero += 8;
					length -= 4;
					continue;
				}
				goto IL_0104;
			}
		}
		while (true)
		{
			switch (length)
			{
			default:
			{
				uint num6 = Unsafe.ReadUnaligned<uint>(ref Unsafe.As<char, byte>(ref Unsafe.AddByteOffset(ref charA, zero)));
				uint num7 = Unsafe.ReadUnaligned<uint>(ref Unsafe.As<char, byte>(ref Unsafe.AddByteOffset(ref charB, zero)));
				if (AllCharsInUInt32AreAscii(num6 | num7))
				{
					if (UInt32OrdinalIgnoreCaseAscii(num6, num7))
					{
						goto IL_00aa;
					}
					return false;
				}
				break;
			}
			case 1:
			{
				uint num4 = Unsafe.AddByteOffset(ref charA, zero);
				uint num5 = Unsafe.AddByteOffset(ref charB, zero);
				if ((num4 | num5) <= 127)
				{
					if (num4 == num5)
					{
						return true;
					}
					num4 |= 0x20;
					if (num4 - 97 > 25)
					{
						return false;
					}
					if (num4 != (num5 | 0x20))
					{
						return false;
					}
					return true;
				}
				break;
			}
			case 0:
				return true;
			}
			break;
			IL_00aa:
			zero += 4;
			length -= 2;
		}
		goto IL_0104;
		IL_0104:
		return EqualsOrdinalIgnoreCaseNonAscii(ref Unsafe.AddByteOffset(ref charA, zero), ref Unsafe.AddByteOffset(ref charB, zero), length);
	}

	[MethodImpl((MethodImplOptions)256)]
	internal static bool AllCharsInUInt32AreAscii(uint value)
	{
		return (value & 0xFF80FF80u) == 0;
	}

	[MethodImpl((MethodImplOptions)256)]
	internal static bool AllCharsInUInt64AreAscii(ulong value)
	{
		return (value & 0xFF80FF80FF80FF80uL) == 0;
	}

	[MethodImpl((MethodImplOptions)256)]
	internal static bool UInt32OrdinalIgnoreCaseAscii(uint valueA, uint valueB)
	{
		uint num = valueA ^ valueB;
		uint num2 = valueA + 16777472 - 4259905;
		uint num3 = (valueA | 0x200020) + 8388736 - 8061051;
		return ((((num2 | num3) >> 2) | 0xFFDFFFDFu) & num) == 0;
	}

	[MethodImpl((MethodImplOptions)256)]
	internal static bool UInt64OrdinalIgnoreCaseAscii(ulong valueA, ulong valueB)
	{
		ulong num = valueA + 36029346783166592L - 18296152663326785L;
		ulong num2 = (valueA | 0x20002000200020L) + 72058693566333184L - 34621950424449147L;
		ulong num3 = (0x80008000800080L & num & num2) >> 2;
		return (valueA | num3) == (valueB | num3);
	}

	private static bool EqualsOrdinalIgnoreCaseNonAscii(ref char charA, ref char charB, int length)
	{
		IntPtr zero = IntPtr.Zero;
		while (length != 0)
		{
			uint num = Unsafe.AddByteOffset(ref charA, zero);
			uint num2 = Unsafe.AddByteOffset(ref charB, zero);
			if (num == num2 || ((num | 0x20) == (num2 | 0x20) && (num | 0x20) - 97 <= 25))
			{
				zero += 2;
				length--;
				continue;
			}
			return false;
		}
		return true;
	}
}
