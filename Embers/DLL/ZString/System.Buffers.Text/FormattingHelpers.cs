using System.Numerics;
using System.Runtime.CompilerServices;

namespace System.Buffers.Text;

internal static class FormattingHelpers
{
	[MethodImpl((MethodImplOptions)256)]
	public static int CountDigits(ulong value)
	{
		int num = 1;
		uint num2;
		if (value >= 10000000)
		{
			if (value >= 100000000000000L)
			{
				num2 = (uint)(value / 100000000000000L);
				num += 14;
			}
			else
			{
				num2 = (uint)(value / 10000000);
				num += 7;
			}
		}
		else
		{
			num2 = (uint)value;
		}
		if (num2 >= 10)
		{
			num = ((num2 < 100) ? (num + 1) : ((num2 < 1000) ? (num + 2) : ((num2 < 10000) ? (num + 3) : ((num2 < 100000) ? (num + 4) : ((num2 >= 1000000) ? (num + 6) : (num + 5))))));
		}
		return num;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int CountDigits(uint value)
	{
		int num = 1;
		if (value >= 100000)
		{
			value /= 100000;
			num += 5;
		}
		if (value >= 10)
		{
			num = ((value < 100) ? (num + 1) : ((value < 1000) ? (num + 2) : ((value >= 10000) ? (num + 4) : (num + 3))));
		}
		return num;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int CountHexDigits(ulong value)
	{
		return 64 - BitOperations.LeadingZeroCount(value | 1) + 3 >> 2;
	}

	[MethodImpl((MethodImplOptions)256)]
	public static int CountDecimalTrailingZeros(uint value, out uint valueWithoutTrailingZeros)
	{
		int num = 0;
		if (value != 0)
		{
			while (true)
			{
				uint num2 = value / 10;
				if (value != num2 * 10)
				{
					break;
				}
				value = num2;
				num++;
			}
		}
		valueWithoutTrailingZeros = value;
		return num;
	}
}
