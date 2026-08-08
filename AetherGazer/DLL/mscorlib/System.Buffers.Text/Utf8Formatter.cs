namespace System.Buffers.Text;

public static class Utf8Formatter
{
	private static readonly uint[] DayAbbreviations = new uint[7] { 256u, 5242881u, 1572872u, 4294967295u, 4294967295u, 4294967295u, 4294967295u };

	private static readonly uint[] DayAbbreviationsLowercase = new uint[7] { 8388608u, 0u, 8388736u, 0u, 8421376u, 0u, 8421504u };

	private static readonly uint[] MonthAbbreviations = new uint[12]
	{
		1074282496u, 16384u, 1074266112u, 1073758208u, 16u, 1074282512u, 540688u, 16u, 16384u, 1073741824u,
		16400u, 1074282496u
	};

	private static readonly uint[] MonthAbbreviationsLowercase = new uint[12]
	{
		264347078u, 604807628u, 770255983u, 1249150122u, 1555081692u, 1996064986u, 2554220882u, 2821834349u, 2952996808u, 3210313671u,
		3336571891u, 3584528711u
	};

	private static bool TryFormatDecimalE(ref NumberBuffer number, Span<byte> destination, out int bytesWritten, byte precision, byte exponentSymbol)
	{
		int scale = number.Scale;
		ReadOnlySpan<byte> readOnlySpan = number.Digits;
		int num = (number.IsNegative ? 1 : 0) + 1 + ((precision != 0) ? (precision + 1) : 0) + 2 + 3;
		if (destination.Length < num)
		{
			bytesWritten = 0;
			return false;
		}
		int num2 = 0;
		int num3 = 0;
		if (number.IsNegative)
		{
			destination[num2++] = 45;
		}
		byte b = readOnlySpan[num3];
		int num4;
		if (b == 0)
		{
			destination[num2++] = 48;
			num4 = 0;
		}
		else
		{
			destination[num2++] = b;
			num3++;
			num4 = scale - 1;
		}
		if (precision > 0)
		{
			destination[num2++] = 46;
			for (int i = 0; i < precision; i++)
			{
				byte b2 = readOnlySpan[num3];
				if (b2 == 0)
				{
					while (i++ < precision)
					{
						destination[num2++] = 48;
					}
					break;
				}
				destination[num2++] = b2;
				num3++;
			}
		}
		destination[num2++] = exponentSymbol;
		if (num4 >= 0)
		{
			destination[num2++] = 43;
		}
		else
		{
			destination[num2++] = 45;
			num4 = -num4;
		}
		destination[num2++] = 48;
		destination[num2++] = (byte)(num4 / 10 + 48);
		destination[num2++] = (byte)(num4 % 10 + 48);
		bytesWritten = num;
		return true;
	}

	private static bool TryFormatDecimalF(ref NumberBuffer number, Span<byte> destination, out int bytesWritten, byte precision)
	{
		int scale = number.Scale;
		ReadOnlySpan<byte> readOnlySpan = number.Digits;
		int num = (number.IsNegative ? 1 : 0) + ((scale <= 0) ? 1 : scale) + ((precision != 0) ? (precision + 1) : 0);
		if (destination.Length < num)
		{
			bytesWritten = 0;
			return false;
		}
		int i = 0;
		int num2 = 0;
		if (number.IsNegative)
		{
			destination[num2++] = 45;
		}
		if (scale <= 0)
		{
			destination[num2++] = 48;
		}
		else
		{
			for (; i < scale; i++)
			{
				byte b = readOnlySpan[i];
				if (b == 0)
				{
					int num3 = scale - i;
					for (int j = 0; j < num3; j++)
					{
						destination[num2++] = 48;
					}
					break;
				}
				destination[num2++] = b;
			}
		}
		if (precision > 0)
		{
			destination[num2++] = 46;
			int k = 0;
			if (scale < 0)
			{
				int num4 = Math.Min(precision, -scale);
				for (int l = 0; l < num4; l++)
				{
					destination[num2++] = 48;
				}
				k += num4;
			}
			for (; k < precision; k++)
			{
				byte b2 = readOnlySpan[i];
				if (b2 == 0)
				{
					while (k++ < precision)
					{
						destination[num2++] = 48;
					}
					break;
				}
				destination[num2++] = b2;
				i++;
			}
		}
		bytesWritten = num;
		return true;
	}

	private static bool TryFormatDecimalG(ref NumberBuffer number, Span<byte> destination, out int bytesWritten)
	{
		int scale = number.Scale;
		ReadOnlySpan<byte> readOnlySpan = number.Digits;
		int numDigits = number.NumDigits;
		bool flag = scale < numDigits;
		int num;
		if (flag)
		{
			num = numDigits + 1;
			if (scale <= 0)
			{
				num += 1 + -scale;
			}
		}
		else
		{
			num = ((scale <= 0) ? 1 : scale);
		}
		if (number.IsNegative)
		{
			num++;
		}
		if (destination.Length < num)
		{
			bytesWritten = 0;
			return false;
		}
		int i = 0;
		int num2 = 0;
		if (number.IsNegative)
		{
			destination[num2++] = 45;
		}
		if (scale <= 0)
		{
			destination[num2++] = 48;
		}
		else
		{
			for (; i < scale; i++)
			{
				byte b = readOnlySpan[i];
				if (b == 0)
				{
					int num3 = scale - i;
					for (int j = 0; j < num3; j++)
					{
						destination[num2++] = 48;
					}
					break;
				}
				destination[num2++] = b;
			}
		}
		if (flag)
		{
			destination[num2++] = 46;
			if (scale < 0)
			{
				int num4 = -scale;
				for (int k = 0; k < num4; k++)
				{
					destination[num2++] = 48;
				}
			}
			byte b2;
			while ((b2 = readOnlySpan[i++]) != 0)
			{
				destination[num2++] = b2;
			}
		}
		bytesWritten = num;
		return true;
	}

	public static bool TryFormat(decimal value, Span<byte> destination, out int bytesWritten, StandardFormat format = default(StandardFormat))
	{
		if (format.IsDefault)
		{
			format = 'G';
		}
		switch (format.Symbol)
		{
		case 'G':
		case 'g':
		{
			if (format.Precision != byte.MaxValue)
			{
				throw new NotSupportedException("The 'G' format combined with a precision is not supported.");
			}
			NumberBuffer number3 = default(NumberBuffer);
			Number.DecimalToNumber(value, ref number3);
			if (number3.Digits[0] == 0)
			{
				number3.IsNegative = false;
			}
			return TryFormatDecimalG(ref number3, destination, out bytesWritten);
		}
		case 'F':
		case 'f':
		{
			NumberBuffer number2 = default(NumberBuffer);
			Number.DecimalToNumber(value, ref number2);
			byte b2 = (byte)((format.Precision == byte.MaxValue) ? 2 : format.Precision);
			Number.RoundNumber(ref number2, number2.Scale + b2);
			return TryFormatDecimalF(ref number2, destination, out bytesWritten, b2);
		}
		case 'E':
		case 'e':
		{
			NumberBuffer number = default(NumberBuffer);
			Number.DecimalToNumber(value, ref number);
			byte b = (byte)((format.Precision == byte.MaxValue) ? 6 : format.Precision);
			Number.RoundNumber(ref number, b + 1);
			return TryFormatDecimalE(ref number, destination, out bytesWritten, b, (byte)format.Symbol);
		}
		default:
			return ThrowHelper.TryFormatThrowFormatException(out bytesWritten);
		}
	}
}
