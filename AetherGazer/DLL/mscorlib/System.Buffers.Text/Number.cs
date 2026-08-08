using System.Runtime.CompilerServices;

namespace System.Buffers.Text;

internal static class Number
{
	private static readonly ulong[] s_rgval64Power10 = new ulong[30]
	{
		36283883772416uL, 280375465086976uL, 230897441895168uL, 13194139585792uL, 259484744160000uL, 166026255818496uL, 25288767456256uL, 183618441888768uL, 67070209326592uL, 102254581408768uL,
		126443837200640uL, 141837000007680uL, 241892558130944uL, 46179488375296uL, 149533581414400uL, 261683767428608uL, 21990232602624uL, 103354093067776uL, 240793046485760uL, 54975581446144uL,
		10995116292608uL, 6597069785344uL, 101155069764608uL, 231996953510400uL, 107752139566080uL, 163827232575744uL, 133040907019264uL, 219902325614336uL, 119846767441664uL, 234195976752384uL
	};

	private static readonly sbyte[] s_rgexp64Power10 = new sbyte[15]
	{
		81, 0, 105, 0, -62, 1, -61, 1, 81, 0,
		81, 0, -60, 1, 81
	};

	private static readonly ulong[] s_rgval64Power10By16 = new ulong[42]
	{
		22799821011222609uL, 22799821011222609uL, 22799821011222609uL, 22799821011222609uL, 22799821011222609uL, 22799821011222609uL, 22799821011222609uL, 60236564153106588uL, 65865492447953192uL, 22799821011222609uL,
		22799821011222609uL, 22799821011222609uL, 22799821011222609uL, 21393653013479785uL, 102458450596855824uL, 22799821029834768uL, 103302888416149585uL, 104147326249992226uL, 104427285080178704uL, 105554722608710004uL,
		105834917665701964uL, 106680639676285305uL, 106960839047708753uL, 107523789001130365uL, 108086541393658239uL, 22801126681280740uL, 43910444284576130uL, 109212638861394000uL, 110339870228349317uL, 110902828751454289uL,
		111745913672434059uL, 112027388628500561uL, 113154662945784207uL, 3942067039633811uL, 3942393457213454uL, 3940709804408846uL, 55452318468997201uL, 22799821011222609uL, 22799821011222609uL, 22799821011222609uL,
		22799821011222609uL, 22799821011222609uL
	};

	private static readonly short[] s_rgexp64Power10By16 = new short[21]
	{
		27684, 9288, -7076, 23736, 24002, -15713, 28371, -11331, -4180, -21437,
		-22942, 25284, -22383, -28359, -23403, -27343, 14308, -6957, -29831, 31218,
		13031
	};

	public unsafe static bool NumberBufferToDecimal(ref NumberBuffer number, ref decimal value)
	{
		MutableDecimal source = default(MutableDecimal);
		byte* ptr = number.UnsafeDigits;
		int num = number.Scale;
		if (*ptr == 0)
		{
			if (num > 0)
			{
				num = 0;
			}
		}
		else
		{
			if (num > 29)
			{
				return false;
			}
			while ((num > 0 || (*ptr != 0 && num > -28)) && (source.High < 429496729 || (source.High == 429496729 && (source.Mid < 2576980377u || (source.Mid == 2576980377u && (source.Low < 2576980377u || (source.Low == 2576980377u && *ptr <= 53)))))))
			{
				DecimalDecCalc.DecMul10(ref source);
				if (*ptr != 0)
				{
					DecimalDecCalc.DecAddInt32(ref source, (uint)(*(ptr++) - 48));
				}
				num--;
			}
			if (*(ptr++) >= 53)
			{
				bool flag = true;
				if (*(ptr - 1) == 53 && *(ptr - 2) % 2 == 0)
				{
					int num2 = 20;
					while (*ptr == 48 && num2 != 0)
					{
						ptr++;
						num2--;
					}
					if (*ptr == 0 || num2 == 0)
					{
						flag = false;
					}
				}
				if (flag)
				{
					DecimalDecCalc.DecAddInt32(ref source, 1u);
					if ((source.High | source.Mid | source.Low) == 0)
					{
						source.High = 429496729u;
						source.Mid = 2576980377u;
						source.Low = 2576980378u;
						num++;
					}
				}
			}
		}
		if (num > 0)
		{
			return false;
		}
		if (num <= -29)
		{
			source.High = 0u;
			source.Low = 0u;
			source.Mid = 0u;
			source.Scale = 28;
		}
		else
		{
			source.Scale = -num;
		}
		source.IsNegative = number.IsNegative;
		value = Unsafe.As<MutableDecimal, decimal>(ref source);
		return true;
	}

	public static void DecimalToNumber(decimal value, ref NumberBuffer number)
	{
		ref MutableDecimal reference = ref Unsafe.As<decimal, MutableDecimal>(ref value);
		Span<byte> digits = number.Digits;
		number.IsNegative = reference.IsNegative;
		int num = 29;
		while ((reference.Mid != 0) | (reference.High != 0))
		{
			uint num2 = DecimalDecCalc.DecDivMod1E9(ref reference);
			for (int i = 0; i < 9; i++)
			{
				digits[--num] = (byte)(num2 % 10 + 48);
				num2 /= 10;
			}
		}
		for (uint num3 = reference.Low; num3 != 0; num3 /= 10)
		{
			digits[--num] = (byte)(num3 % 10 + 48);
		}
		int num4 = 29 - num;
		number.Scale = num4 - reference.Scale;
		Span<byte> digits2 = number.Digits;
		int index = 0;
		while (--num4 >= 0)
		{
			digits2[index++] = digits[num++];
		}
		digits2[index] = 0;
	}

	public static void RoundNumber(ref NumberBuffer number, int pos)
	{
		Span<byte> digits = number.Digits;
		int i;
		for (i = 0; i < pos && digits[i] != 0; i++)
		{
		}
		if (i == pos && digits[i] >= 53)
		{
			while (i > 0 && digits[i - 1] == 57)
			{
				i--;
			}
			if (i > 0)
			{
				digits[i - 1]++;
			}
			else
			{
				number.Scale++;
				digits[0] = 49;
				i = 1;
			}
		}
		else
		{
			while (i > 0 && digits[i - 1] == 48)
			{
				i--;
			}
		}
		if (i == 0)
		{
			number.Scale = 0;
			number.IsNegative = false;
		}
		digits[i] = 0;
	}
}
