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
		int num = 1;
		if (value > uint.MaxValue)
		{
			num += 8;
			value >>= 32;
		}
		if (value > 65535)
		{
			num += 4;
			value >>= 16;
		}
		if (value > 255)
		{
			num += 2;
			value >>= 8;
		}
		if (value > 15)
		{
			num++;
		}
		return num;
	}
}
