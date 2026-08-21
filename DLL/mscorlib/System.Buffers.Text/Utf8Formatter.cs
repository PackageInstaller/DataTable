using System.Buffers.Binary;
using System.Globalization;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

namespace System.Buffers.Text;

public static class Utf8Formatter
{
	[StructLayout(LayoutKind.Explicit)]
	private struct DecomposedGuid
	{
		[FieldOffset(0)]
		public Guid Guid;

		[FieldOffset(0)]
		public byte Byte00;

		[FieldOffset(1)]
		public byte Byte01;

		[FieldOffset(2)]
		public byte Byte02;

		[FieldOffset(3)]
		public byte Byte03;

		[FieldOffset(4)]
		public byte Byte04;

		[FieldOffset(5)]
		public byte Byte05;

		[FieldOffset(6)]
		public byte Byte06;

		[FieldOffset(7)]
		public byte Byte07;

		[FieldOffset(8)]
		public byte Byte08;

		[FieldOffset(9)]
		public byte Byte09;

		[FieldOffset(10)]
		public byte Byte10;

		[FieldOffset(11)]
		public byte Byte11;

		[FieldOffset(12)]
		public byte Byte12;

		[FieldOffset(13)]
		public byte Byte13;

		[FieldOffset(14)]
		public byte Byte14;

		[FieldOffset(15)]
		public byte Byte15;
	}

	private static readonly uint[] DayAbbreviations = new uint[7] { 7238995u, 7237453u, 6649172u, 6579543u, 7694420u, 6910534u, 7627091u };

	private static readonly uint[] DayAbbreviationsLowercase = new uint[7] { 7239027u, 7237485u, 6649204u, 6579575u, 7694452u, 6910566u, 7627123u };

	private static readonly uint[] MonthAbbreviations = new uint[12]
	{
		7233866u, 6448454u, 7496013u, 7499841u, 7954765u, 7238986u, 7107914u, 6780225u, 7365971u, 7627599u,
		7761742u, 6513988u
	};

	private static readonly uint[] MonthAbbreviationsLowercase = new uint[12]
	{
		7233898u, 6448486u, 7496045u, 7499873u, 7954797u, 7239018u, 7107946u, 6780257u, 7366003u, 7627631u,
		7761774u, 6514020u
	};

	public static bool TryFormat(bool value, Span<byte> destination, out int bytesWritten, StandardFormat format = default(StandardFormat))
	{
		char symbolOrDefault = FormattingHelpers.GetSymbolOrDefault(in format, 'G');
		if (value)
		{
			if (symbolOrDefault == 'G')
			{
				if (BinaryPrimitives.TryWriteUInt32BigEndian(destination, 1416787301u))
				{
					goto IL_0033;
				}
			}
			else
			{
				if (symbolOrDefault != 'l')
				{
					goto IL_0083;
				}
				if (BinaryPrimitives.TryWriteUInt32BigEndian(destination, 1953658213u))
				{
					goto IL_0033;
				}
			}
		}
		else if (symbolOrDefault == 'G')
		{
			if (4u < (uint)destination.Length)
			{
				BinaryPrimitives.WriteUInt32BigEndian(destination, 1180789875u);
				goto IL_006e;
			}
		}
		else
		{
			if (symbolOrDefault != 'l')
			{
				goto IL_0083;
			}
			if (4u < (uint)destination.Length)
			{
				BinaryPrimitives.WriteUInt32BigEndian(destination, 1717660787u);
				goto IL_006e;
			}
		}
		bytesWritten = 0;
		return false;
		IL_006e:
		destination[4] = 101;
		bytesWritten = 5;
		return true;
		IL_0083:
		return ThrowHelper.TryFormatThrowFormatException(out bytesWritten);
		IL_0033:
		bytesWritten = 4;
		return true;
	}

	private static bool TryFormatDateTimeG(DateTime value, TimeSpan offset, Span<byte> destination, out int bytesWritten)
	{
		int num = 19;
		if (offset != Utf8Constants.s_nullUtcOffset)
		{
			num += 7;
		}
		if (destination.Length < num)
		{
			bytesWritten = 0;
			return false;
		}
		bytesWritten = num;
		_ = ref destination[18];
		FormattingHelpers.WriteTwoDecimalDigits((uint)value.Month, destination);
		destination[2] = 47;
		FormattingHelpers.WriteTwoDecimalDigits((uint)value.Day, destination, 3);
		destination[5] = 47;
		FormattingHelpers.WriteFourDecimalDigits((uint)value.Year, destination, 6);
		destination[10] = 32;
		FormattingHelpers.WriteTwoDecimalDigits((uint)value.Hour, destination, 11);
		destination[13] = 58;
		FormattingHelpers.WriteTwoDecimalDigits((uint)value.Minute, destination, 14);
		destination[16] = 58;
		FormattingHelpers.WriteTwoDecimalDigits((uint)value.Second, destination, 17);
		if (offset != Utf8Constants.s_nullUtcOffset)
		{
			byte b;
			if (offset < default(TimeSpan))
			{
				b = 45;
				offset = TimeSpan.FromTicks(-offset.Ticks);
			}
			else
			{
				b = 43;
			}
			FormattingHelpers.WriteTwoDecimalDigits((uint)offset.Minutes, destination, 24);
			destination[23] = 58;
			FormattingHelpers.WriteTwoDecimalDigits((uint)offset.Hours, destination, 21);
			destination[20] = b;
			destination[19] = 32;
		}
		return true;
	}

	private static bool TryFormatDateTimeL(DateTime value, Span<byte> destination, out int bytesWritten)
	{
		if (28u >= (uint)destination.Length)
		{
			bytesWritten = 0;
			return false;
		}
		uint num = DayAbbreviationsLowercase[(int)value.DayOfWeek];
		destination[0] = (byte)num;
		num >>= 8;
		destination[1] = (byte)num;
		num >>= 8;
		destination[2] = (byte)num;
		destination[3] = 44;
		destination[4] = 32;
		FormattingHelpers.WriteTwoDecimalDigits((uint)value.Day, destination, 5);
		destination[7] = 32;
		uint num2 = MonthAbbreviationsLowercase[value.Month - 1];
		destination[8] = (byte)num2;
		num2 >>= 8;
		destination[9] = (byte)num2;
		num2 >>= 8;
		destination[10] = (byte)num2;
		destination[11] = 32;
		FormattingHelpers.WriteFourDecimalDigits((uint)value.Year, destination, 12);
		destination[16] = 32;
		FormattingHelpers.WriteTwoDecimalDigits((uint)value.Hour, destination, 17);
		destination[19] = 58;
		FormattingHelpers.WriteTwoDecimalDigits((uint)value.Minute, destination, 20);
		destination[22] = 58;
		FormattingHelpers.WriteTwoDecimalDigits((uint)value.Second, destination, 23);
		destination[25] = 32;
		destination[26] = 103;
		destination[27] = 109;
		destination[28] = 116;
		bytesWritten = 29;
		return true;
	}

	private static bool TryFormatDateTimeO(DateTime value, TimeSpan offset, Span<byte> destination, out int bytesWritten)
	{
		int num = 27;
		DateTimeKind dateTimeKind = DateTimeKind.Local;
		if (offset == Utf8Constants.s_nullUtcOffset)
		{
			dateTimeKind = value.Kind;
			switch (dateTimeKind)
			{
			case DateTimeKind.Local:
				offset = TimeZoneInfo.Local.GetUtcOffset(value);
				num += 6;
				break;
			case DateTimeKind.Utc:
				num++;
				break;
			}
		}
		else
		{
			num += 6;
		}
		if (destination.Length < num)
		{
			bytesWritten = 0;
			return false;
		}
		bytesWritten = num;
		_ = ref destination[26];
		FormattingHelpers.WriteFourDecimalDigits((uint)value.Year, destination);
		destination[4] = 45;
		FormattingHelpers.WriteTwoDecimalDigits((uint)value.Month, destination, 5);
		destination[7] = 45;
		FormattingHelpers.WriteTwoDecimalDigits((uint)value.Day, destination, 8);
		destination[10] = 84;
		FormattingHelpers.WriteTwoDecimalDigits((uint)value.Hour, destination, 11);
		destination[13] = 58;
		FormattingHelpers.WriteTwoDecimalDigits((uint)value.Minute, destination, 14);
		destination[16] = 58;
		FormattingHelpers.WriteTwoDecimalDigits((uint)value.Second, destination, 17);
		destination[19] = 46;
		FormattingHelpers.WriteDigits((uint)((ulong)value.Ticks % 10000000uL), destination.Slice(20, 7));
		switch (dateTimeKind)
		{
		case DateTimeKind.Local:
		{
			byte b;
			if (offset < default(TimeSpan))
			{
				b = 45;
				offset = TimeSpan.FromTicks(-offset.Ticks);
			}
			else
			{
				b = 43;
			}
			FormattingHelpers.WriteTwoDecimalDigits((uint)offset.Minutes, destination, 31);
			destination[30] = 58;
			FormattingHelpers.WriteTwoDecimalDigits((uint)offset.Hours, destination, 28);
			destination[27] = b;
			break;
		}
		case DateTimeKind.Utc:
			destination[27] = 90;
			break;
		}
		return true;
	}

	private static bool TryFormatDateTimeR(DateTime value, Span<byte> destination, out int bytesWritten)
	{
		if (28u >= (uint)destination.Length)
		{
			bytesWritten = 0;
			return false;
		}
		uint num = DayAbbreviations[(int)value.DayOfWeek];
		destination[0] = (byte)num;
		num >>= 8;
		destination[1] = (byte)num;
		num >>= 8;
		destination[2] = (byte)num;
		destination[3] = 44;
		destination[4] = 32;
		FormattingHelpers.WriteTwoDecimalDigits((uint)value.Day, destination, 5);
		destination[7] = 32;
		uint num2 = MonthAbbreviations[value.Month - 1];
		destination[8] = (byte)num2;
		num2 >>= 8;
		destination[9] = (byte)num2;
		num2 >>= 8;
		destination[10] = (byte)num2;
		destination[11] = 32;
		FormattingHelpers.WriteFourDecimalDigits((uint)value.Year, destination, 12);
		destination[16] = 32;
		FormattingHelpers.WriteTwoDecimalDigits((uint)value.Hour, destination, 17);
		destination[19] = 58;
		FormattingHelpers.WriteTwoDecimalDigits((uint)value.Minute, destination, 20);
		destination[22] = 58;
		FormattingHelpers.WriteTwoDecimalDigits((uint)value.Second, destination, 23);
		destination[25] = 32;
		destination[26] = 71;
		destination[27] = 77;
		destination[28] = 84;
		bytesWritten = 29;
		return true;
	}

	public static bool TryFormat(DateTimeOffset value, Span<byte> destination, out int bytesWritten, StandardFormat format = default(StandardFormat))
	{
		TimeSpan offset = Utf8Constants.s_nullUtcOffset;
		char c = format.Symbol;
		if (format.IsDefault)
		{
			c = 'G';
			offset = value.Offset;
		}
		return c switch
		{
			'R' => TryFormatDateTimeR(value.UtcDateTime, destination, out bytesWritten), 
			'l' => TryFormatDateTimeL(value.UtcDateTime, destination, out bytesWritten), 
			'O' => TryFormatDateTimeO(value.DateTime, value.Offset, destination, out bytesWritten), 
			'G' => TryFormatDateTimeG(value.DateTime, offset, destination, out bytesWritten), 
			_ => ThrowHelper.TryFormatThrowFormatException(out bytesWritten), 
		};
	}

	public static bool TryFormat(DateTime value, Span<byte> destination, out int bytesWritten, StandardFormat format = default(StandardFormat))
	{
		return FormattingHelpers.GetSymbolOrDefault(in format, 'G') switch
		{
			'R' => TryFormatDateTimeR(value, destination, out bytesWritten), 
			'l' => TryFormatDateTimeL(value, destination, out bytesWritten), 
			'O' => TryFormatDateTimeO(value, Utf8Constants.s_nullUtcOffset, destination, out bytesWritten), 
			'G' => TryFormatDateTimeG(value, Utf8Constants.s_nullUtcOffset, destination, out bytesWritten), 
			_ => ThrowHelper.TryFormatThrowFormatException(out bytesWritten), 
		};
	}

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

	public static bool TryFormat(double value, Span<byte> destination, out int bytesWritten, StandardFormat format = default(StandardFormat))
	{
		return TryFormatFloatingPoint(value, destination, out bytesWritten, format);
	}

	public static bool TryFormat(float value, Span<byte> destination, out int bytesWritten, StandardFormat format = default(StandardFormat))
	{
		return TryFormatFloatingPoint(value, destination, out bytesWritten, format);
	}

	private static bool TryFormatFloatingPoint<T>(T value, Span<byte> destination, out int bytesWritten, StandardFormat format) where T : IFormattable
	{
		if (format.IsDefault)
		{
			format = 'G';
		}
		switch (format.Symbol)
		{
		case 'G':
		case 'g':
			if (format.Precision != byte.MaxValue)
			{
				throw new NotSupportedException("The 'G' format combined with a precision is not supported.");
			}
			break;
		default:
			return ThrowHelper.TryFormatThrowFormatException(out bytesWritten);
		case 'E':
		case 'F':
		case 'e':
		case 'f':
			break;
		}
		string text = format.ToString();
		string text2 = value.ToString(text, CultureInfo.InvariantCulture);
		int length = text2.Length;
		if (length > destination.Length)
		{
			bytesWritten = 0;
			return false;
		}
		for (int i = 0; i < length; i++)
		{
			destination[i] = (byte)text2[i];
		}
		bytesWritten = length;
		return true;
	}

	public static bool TryFormat(Guid value, Span<byte> destination, out int bytesWritten, StandardFormat format = default(StandardFormat))
	{
		int num;
		switch (FormattingHelpers.GetSymbolOrDefault(in format, 'D'))
		{
		case 'D':
			num = -2147483612;
			break;
		case 'B':
			num = -2139260122;
			break;
		case 'P':
			num = -2144786394;
			break;
		case 'N':
			num = 32;
			break;
		default:
			return ThrowHelper.TryFormatThrowFormatException(out bytesWritten);
		}
		if ((byte)num > destination.Length)
		{
			bytesWritten = 0;
			return false;
		}
		bytesWritten = (byte)num;
		num >>= 8;
		if ((byte)num != 0)
		{
			destination[0] = (byte)num;
			destination = destination.Slice(1);
		}
		num >>= 8;
		DecomposedGuid decomposedGuid = new DecomposedGuid
		{
			Guid = value
		};
		_ = ref destination[8];
		FormattingHelpers.WriteHexByte(decomposedGuid.Byte03, destination, 0, FormattingHelpers.HexCasing.Lowercase);
		FormattingHelpers.WriteHexByte(decomposedGuid.Byte02, destination, 2, FormattingHelpers.HexCasing.Lowercase);
		FormattingHelpers.WriteHexByte(decomposedGuid.Byte01, destination, 4, FormattingHelpers.HexCasing.Lowercase);
		FormattingHelpers.WriteHexByte(decomposedGuid.Byte00, destination, 6, FormattingHelpers.HexCasing.Lowercase);
		if (num < 0)
		{
			destination[8] = 45;
			destination = destination.Slice(9);
		}
		else
		{
			destination = destination.Slice(8);
		}
		_ = ref destination[4];
		FormattingHelpers.WriteHexByte(decomposedGuid.Byte05, destination, 0, FormattingHelpers.HexCasing.Lowercase);
		FormattingHelpers.WriteHexByte(decomposedGuid.Byte04, destination, 2, FormattingHelpers.HexCasing.Lowercase);
		if (num < 0)
		{
			destination[4] = 45;
			destination = destination.Slice(5);
		}
		else
		{
			destination = destination.Slice(4);
		}
		_ = ref destination[4];
		FormattingHelpers.WriteHexByte(decomposedGuid.Byte07, destination, 0, FormattingHelpers.HexCasing.Lowercase);
		FormattingHelpers.WriteHexByte(decomposedGuid.Byte06, destination, 2, FormattingHelpers.HexCasing.Lowercase);
		if (num < 0)
		{
			destination[4] = 45;
			destination = destination.Slice(5);
		}
		else
		{
			destination = destination.Slice(4);
		}
		_ = ref destination[4];
		FormattingHelpers.WriteHexByte(decomposedGuid.Byte08, destination, 0, FormattingHelpers.HexCasing.Lowercase);
		FormattingHelpers.WriteHexByte(decomposedGuid.Byte09, destination, 2, FormattingHelpers.HexCasing.Lowercase);
		if (num < 0)
		{
			destination[4] = 45;
			destination = destination.Slice(5);
		}
		else
		{
			destination = destination.Slice(4);
		}
		_ = ref destination[11];
		FormattingHelpers.WriteHexByte(decomposedGuid.Byte10, destination, 0, FormattingHelpers.HexCasing.Lowercase);
		FormattingHelpers.WriteHexByte(decomposedGuid.Byte11, destination, 2, FormattingHelpers.HexCasing.Lowercase);
		FormattingHelpers.WriteHexByte(decomposedGuid.Byte12, destination, 4, FormattingHelpers.HexCasing.Lowercase);
		FormattingHelpers.WriteHexByte(decomposedGuid.Byte13, destination, 6, FormattingHelpers.HexCasing.Lowercase);
		FormattingHelpers.WriteHexByte(decomposedGuid.Byte14, destination, 8, FormattingHelpers.HexCasing.Lowercase);
		FormattingHelpers.WriteHexByte(decomposedGuid.Byte15, destination, 10, FormattingHelpers.HexCasing.Lowercase);
		if ((byte)num != 0)
		{
			destination[12] = (byte)num;
		}
		return true;
	}

	[MethodImpl((MethodImplOptions)256)]
	private static bool TryFormatInt64D(long value, byte precision, Span<byte> destination, out int bytesWritten)
	{
		bool insertNegationSign = false;
		if (value < 0)
		{
			insertNegationSign = true;
			value = -value;
		}
		return TryFormatUInt64D((ulong)value, precision, destination, insertNegationSign, out bytesWritten);
	}

	[MethodImpl((MethodImplOptions)256)]
	private static bool TryFormatInt64Default(long value, Span<byte> destination, out int bytesWritten)
	{
		if ((ulong)value < 10uL)
		{
			return TryFormatUInt32SingleDigit((uint)value, destination, out bytesWritten);
		}
		if (IntPtr.Size == 8)
		{
			return TryFormatInt64MultipleDigits(value, destination, out bytesWritten);
		}
		if (value <= int.MaxValue && value >= int.MinValue)
		{
			return TryFormatInt32MultipleDigits((int)value, destination, out bytesWritten);
		}
		if (value <= 4294967295000000000L && value >= -4294967295000000000L)
		{
			if (value >= 0)
			{
				return TryFormatUInt64LessThanBillionMaxUInt((ulong)value, destination, out bytesWritten);
			}
			return TryFormatInt64MoreThanNegativeBillionMaxUInt(-value, destination, out bytesWritten);
		}
		if (value >= 0)
		{
			return TryFormatUInt64MoreThanBillionMaxUInt((ulong)value, destination, out bytesWritten);
		}
		return TryFormatInt64LessThanNegativeBillionMaxUInt(-value, destination, out bytesWritten);
	}

	[MethodImpl((MethodImplOptions)256)]
	private static bool TryFormatInt32MultipleDigits(int value, Span<byte> destination, out int bytesWritten)
	{
		if (value < 0)
		{
			value = -value;
			int num = FormattingHelpers.CountDigits((uint)value);
			if (num >= destination.Length)
			{
				bytesWritten = 0;
				return false;
			}
			destination[0] = 45;
			bytesWritten = num + 1;
			FormattingHelpers.WriteDigits((uint)value, destination.Slice(1, num));
			return true;
		}
		return TryFormatUInt32MultipleDigits((uint)value, destination, out bytesWritten);
	}

	[MethodImpl((MethodImplOptions)256)]
	private static bool TryFormatInt64MultipleDigits(long value, Span<byte> destination, out int bytesWritten)
	{
		if (value < 0)
		{
			value = -value;
			int num = FormattingHelpers.CountDigits((ulong)value);
			if (num >= destination.Length)
			{
				bytesWritten = 0;
				return false;
			}
			destination[0] = 45;
			bytesWritten = num + 1;
			FormattingHelpers.WriteDigits((ulong)value, destination.Slice(1, num));
			return true;
		}
		return TryFormatUInt64MultipleDigits((ulong)value, destination, out bytesWritten);
	}

	private static bool TryFormatInt64MoreThanNegativeBillionMaxUInt(long value, Span<byte> destination, out int bytesWritten)
	{
		uint num = (uint)(value / 1000000000);
		uint value2 = (uint)(value - num * 1000000000);
		int num2 = FormattingHelpers.CountDigits(num);
		int num3 = num2 + 9;
		if (num3 >= destination.Length)
		{
			bytesWritten = 0;
			return false;
		}
		destination[0] = 45;
		bytesWritten = num3 + 1;
		FormattingHelpers.WriteDigits(num, destination.Slice(1, num2));
		FormattingHelpers.WriteDigits(value2, destination.Slice(num2 + 1, 9));
		return true;
	}

	private static bool TryFormatInt64LessThanNegativeBillionMaxUInt(long value, Span<byte> destination, out int bytesWritten)
	{
		ulong num = (ulong)value / 1000000000uL;
		uint value2 = (uint)((ulong)value - num * 1000000000);
		uint num2 = (uint)(num / 1000000000);
		uint value3 = (uint)(num - num2 * 1000000000);
		int num3 = FormattingHelpers.CountDigits(num2);
		int num4 = num3 + 18;
		if (num4 >= destination.Length)
		{
			bytesWritten = 0;
			return false;
		}
		destination[0] = 45;
		bytesWritten = num4 + 1;
		FormattingHelpers.WriteDigits(num2, destination.Slice(1, num3));
		FormattingHelpers.WriteDigits(value3, destination.Slice(num3 + 1, 9));
		FormattingHelpers.WriteDigits(value2, destination.Slice(num3 + 1 + 9, 9));
		return true;
	}

	[MethodImpl((MethodImplOptions)256)]
	private static bool TryFormatInt64N(long value, byte precision, Span<byte> destination, out int bytesWritten)
	{
		bool insertNegationSign = false;
		if (value < 0)
		{
			insertNegationSign = true;
			value = -value;
		}
		return TryFormatUInt64N((ulong)value, precision, destination, insertNegationSign, out bytesWritten);
	}

	[MethodImpl((MethodImplOptions)256)]
	private static bool TryFormatInt64(long value, ulong mask, Span<byte> destination, out int bytesWritten, StandardFormat format)
	{
		if (format.IsDefault)
		{
			return TryFormatInt64Default(value, destination, out bytesWritten);
		}
		switch (format.Symbol)
		{
		case 'G':
		case 'g':
			if (format.HasPrecision)
			{
				throw new NotSupportedException("The 'G' format combined with a precision is not supported.");
			}
			return TryFormatInt64D(value, format.Precision, destination, out bytesWritten);
		case 'D':
		case 'd':
			return TryFormatInt64D(value, format.Precision, destination, out bytesWritten);
		case 'N':
		case 'n':
			return TryFormatInt64N(value, format.Precision, destination, out bytesWritten);
		case 'x':
			return TryFormatUInt64X((ulong)value & mask, format.Precision, useLower: true, destination, out bytesWritten);
		case 'X':
			return TryFormatUInt64X((ulong)value & mask, format.Precision, useLower: false, destination, out bytesWritten);
		default:
			return ThrowHelper.TryFormatThrowFormatException(out bytesWritten);
		}
	}

	private static bool TryFormatUInt64D(ulong value, byte precision, Span<byte> destination, bool insertNegationSign, out int bytesWritten)
	{
		int num = FormattingHelpers.CountDigits(value);
		int num2 = ((precision != byte.MaxValue) ? precision : 0) - num;
		if (num2 < 0)
		{
			num2 = 0;
		}
		int num3 = num + num2;
		if (insertNegationSign)
		{
			num3++;
		}
		if (num3 > destination.Length)
		{
			bytesWritten = 0;
			return false;
		}
		bytesWritten = num3;
		if (insertNegationSign)
		{
			destination[0] = 45;
			destination = destination.Slice(1);
		}
		if (num2 > 0)
		{
			FormattingHelpers.FillWithAsciiZeros(destination.Slice(0, num2));
		}
		FormattingHelpers.WriteDigits(value, destination.Slice(num2, num));
		return true;
	}

	[MethodImpl((MethodImplOptions)256)]
	private static bool TryFormatUInt64Default(ulong value, Span<byte> destination, out int bytesWritten)
	{
		if (value < 10)
		{
			return TryFormatUInt32SingleDigit((uint)value, destination, out bytesWritten);
		}
		if (IntPtr.Size == 8)
		{
			return TryFormatUInt64MultipleDigits(value, destination, out bytesWritten);
		}
		if (value <= uint.MaxValue)
		{
			return TryFormatUInt32MultipleDigits((uint)value, destination, out bytesWritten);
		}
		if (value <= 4294967295000000000L)
		{
			return TryFormatUInt64LessThanBillionMaxUInt(value, destination, out bytesWritten);
		}
		return TryFormatUInt64MoreThanBillionMaxUInt(value, destination, out bytesWritten);
	}

	[MethodImpl((MethodImplOptions)256)]
	private static bool TryFormatUInt32SingleDigit(uint value, Span<byte> destination, out int bytesWritten)
	{
		if (destination.Length == 0)
		{
			bytesWritten = 0;
			return false;
		}
		destination[0] = (byte)(48 + value);
		bytesWritten = 1;
		return true;
	}

	[MethodImpl((MethodImplOptions)256)]
	private static bool TryFormatUInt32MultipleDigits(uint value, Span<byte> destination, out int bytesWritten)
	{
		int num = FormattingHelpers.CountDigits(value);
		if (num > destination.Length)
		{
			bytesWritten = 0;
			return false;
		}
		bytesWritten = num;
		FormattingHelpers.WriteDigits(value, destination.Slice(0, num));
		return true;
	}

	[MethodImpl((MethodImplOptions)256)]
	private static bool TryFormatUInt64MultipleDigits(ulong value, Span<byte> destination, out int bytesWritten)
	{
		int num = FormattingHelpers.CountDigits(value);
		if (num > destination.Length)
		{
			bytesWritten = 0;
			return false;
		}
		bytesWritten = num;
		FormattingHelpers.WriteDigits(value, destination.Slice(0, num));
		return true;
	}

	private static bool TryFormatUInt64LessThanBillionMaxUInt(ulong value, Span<byte> destination, out int bytesWritten)
	{
		uint num = (uint)(value / 1000000000);
		uint value2 = (uint)(value - num * 1000000000);
		int num2 = FormattingHelpers.CountDigits(num);
		int num3 = num2 + 9;
		if (num3 > destination.Length)
		{
			bytesWritten = 0;
			return false;
		}
		bytesWritten = num3;
		FormattingHelpers.WriteDigits(num, destination.Slice(0, num2));
		FormattingHelpers.WriteDigits(value2, destination.Slice(num2, 9));
		return true;
	}

	private static bool TryFormatUInt64MoreThanBillionMaxUInt(ulong value, Span<byte> destination, out int bytesWritten)
	{
		ulong num = value / 1000000000;
		uint value2 = (uint)(value - num * 1000000000);
		uint num2 = (uint)(num / 1000000000);
		uint value3 = (uint)(num - num2 * 1000000000);
		int num3 = FormattingHelpers.CountDigits(num2);
		int num4 = num3 + 18;
		if (num4 > destination.Length)
		{
			bytesWritten = 0;
			return false;
		}
		bytesWritten = num4;
		FormattingHelpers.WriteDigits(num2, destination.Slice(0, num3));
		FormattingHelpers.WriteDigits(value3, destination.Slice(num3, 9));
		FormattingHelpers.WriteDigits(value2, destination.Slice(num3 + 9, 9));
		return true;
	}

	private static bool TryFormatUInt64N(ulong value, byte precision, Span<byte> destination, bool insertNegationSign, out int bytesWritten)
	{
		int num = FormattingHelpers.CountDigits(value);
		int num2 = (num - 1) / 3;
		int num3 = ((precision == byte.MaxValue) ? 2 : precision);
		int num4 = num + num2;
		if (num3 > 0)
		{
			num4 += num3 + 1;
		}
		if (insertNegationSign)
		{
			num4++;
		}
		if (num4 > destination.Length)
		{
			bytesWritten = 0;
			return false;
		}
		bytesWritten = num4;
		if (insertNegationSign)
		{
			destination[0] = 45;
			destination = destination.Slice(1);
		}
		FormattingHelpers.WriteDigitsWithGroupSeparator(value, destination.Slice(0, num + num2));
		if (num3 > 0)
		{
			destination[num + num2] = 46;
			FormattingHelpers.FillWithAsciiZeros(destination.Slice(num + num2 + 1, num3));
		}
		return true;
	}

	private static bool TryFormatUInt64X(ulong value, byte precision, bool useLower, Span<byte> destination, out int bytesWritten)
	{
		int num = FormattingHelpers.CountHexDigits(value);
		int num2 = ((precision == byte.MaxValue) ? num : Math.Max(precision, num));
		if (destination.Length < num2)
		{
			bytesWritten = 0;
			return false;
		}
		bytesWritten = num2;
		string text = (useLower ? "0123456789abcdef" : "0123456789ABCDEF");
		while ((uint)(--num2) < (uint)destination.Length)
		{
			destination[num2] = (byte)text[(int)value & 0xF];
			value >>= 4;
		}
		return true;
	}

	[MethodImpl((MethodImplOptions)256)]
	private static bool TryFormatUInt64(ulong value, Span<byte> destination, out int bytesWritten, StandardFormat format)
	{
		if (format.IsDefault)
		{
			return TryFormatUInt64Default(value, destination, out bytesWritten);
		}
		switch (format.Symbol)
		{
		case 'G':
		case 'g':
			if (format.HasPrecision)
			{
				throw new NotSupportedException("The 'G' format combined with a precision is not supported.");
			}
			return TryFormatUInt64D(value, format.Precision, destination, insertNegationSign: false, out bytesWritten);
		case 'D':
		case 'd':
			return TryFormatUInt64D(value, format.Precision, destination, insertNegationSign: false, out bytesWritten);
		case 'N':
		case 'n':
			return TryFormatUInt64N(value, format.Precision, destination, insertNegationSign: false, out bytesWritten);
		case 'x':
			return TryFormatUInt64X(value, format.Precision, useLower: true, destination, out bytesWritten);
		case 'X':
			return TryFormatUInt64X(value, format.Precision, useLower: false, destination, out bytesWritten);
		default:
			return ThrowHelper.TryFormatThrowFormatException(out bytesWritten);
		}
	}

	public static bool TryFormat(byte value, Span<byte> destination, out int bytesWritten, StandardFormat format = default(StandardFormat))
	{
		return TryFormatUInt64(value, destination, out bytesWritten, format);
	}

	[CLSCompliant(false)]
	public static bool TryFormat(sbyte value, Span<byte> destination, out int bytesWritten, StandardFormat format = default(StandardFormat))
	{
		return TryFormatInt64(value, 255uL, destination, out bytesWritten, format);
	}

	[CLSCompliant(false)]
	public static bool TryFormat(ushort value, Span<byte> destination, out int bytesWritten, StandardFormat format = default(StandardFormat))
	{
		return TryFormatUInt64(value, destination, out bytesWritten, format);
	}

	public static bool TryFormat(short value, Span<byte> destination, out int bytesWritten, StandardFormat format = default(StandardFormat))
	{
		return TryFormatInt64(value, 65535uL, destination, out bytesWritten, format);
	}

	[CLSCompliant(false)]
	public static bool TryFormat(uint value, Span<byte> destination, out int bytesWritten, StandardFormat format = default(StandardFormat))
	{
		return TryFormatUInt64(value, destination, out bytesWritten, format);
	}

	public static bool TryFormat(int value, Span<byte> destination, out int bytesWritten, StandardFormat format = default(StandardFormat))
	{
		return TryFormatInt64(value, 4294967295uL, destination, out bytesWritten, format);
	}

	[CLSCompliant(false)]
	public static bool TryFormat(ulong value, Span<byte> destination, out int bytesWritten, StandardFormat format = default(StandardFormat))
	{
		return TryFormatUInt64(value, destination, out bytesWritten, format);
	}

	public static bool TryFormat(long value, Span<byte> destination, out int bytesWritten, StandardFormat format = default(StandardFormat))
	{
		return TryFormatInt64(value, ulong.MaxValue, destination, out bytesWritten, format);
	}

	public static bool TryFormat(TimeSpan value, Span<byte> destination, out int bytesWritten, StandardFormat format = default(StandardFormat))
	{
		char c = FormattingHelpers.GetSymbolOrDefault(in format, 'c');
		switch (c)
		{
		case 'T':
		case 't':
			c = 'c';
			break;
		default:
			return ThrowHelper.TryFormatThrowFormatException(out bytesWritten);
		case 'G':
		case 'c':
		case 'g':
			break;
		}
		int num = 8;
		long ticks = value.Ticks;
		uint valueWithoutTrailingZeros;
		ulong num2;
		if (ticks < 0)
		{
			ticks = -ticks;
			if (ticks < 0)
			{
				valueWithoutTrailingZeros = 4775808u;
				num2 = 922337203685uL;
				goto IL_0082;
			}
		}
		num2 = FormattingHelpers.DivMod((ulong)Math.Abs(value.Ticks), 10000000uL, out var modulo);
		valueWithoutTrailingZeros = (uint)modulo;
		goto IL_0082;
		IL_0082:
		int num3 = 0;
		switch (c)
		{
		case 'c':
			if (valueWithoutTrailingZeros != 0)
			{
				num3 = 7;
			}
			break;
		case 'G':
			num3 = 7;
			break;
		default:
			if (valueWithoutTrailingZeros != 0)
			{
				num3 = 7 - FormattingHelpers.CountDecimalTrailingZeros(valueWithoutTrailingZeros, out valueWithoutTrailingZeros);
			}
			break;
		}
		if (num3 != 0)
		{
			num += num3 + 1;
		}
		ulong num4 = 0uL;
		ulong modulo2 = 0uL;
		if (num2 != 0)
		{
			num4 = FormattingHelpers.DivMod(num2, 60uL, out modulo2);
		}
		ulong num5 = 0uL;
		ulong modulo3 = 0uL;
		if (num4 != 0)
		{
			num5 = FormattingHelpers.DivMod(num4, 60uL, out modulo3);
		}
		uint num6 = 0u;
		uint modulo4 = 0u;
		if (num5 != 0)
		{
			num6 = FormattingHelpers.DivMod((uint)num5, 24u, out modulo4);
		}
		int num7 = 2;
		if (modulo4 < 10 && c == 'g')
		{
			num7--;
			num--;
		}
		int num8 = 0;
		if (num6 == 0)
		{
			if (c == 'G')
			{
				num += 2;
				num8 = 1;
			}
		}
		else
		{
			num8 = FormattingHelpers.CountDigits(num6);
			num += num8 + 1;
		}
		if (value.Ticks < 0)
		{
			num++;
		}
		if (destination.Length < num)
		{
			bytesWritten = 0;
			return false;
		}
		bytesWritten = num;
		int num9 = 0;
		if (value.Ticks < 0)
		{
			destination[num9++] = 45;
		}
		if (num8 > 0)
		{
			FormattingHelpers.WriteDigits(num6, destination.Slice(num9, num8));
			num9 += num8;
			destination[num9++] = (byte)((c == 'c') ? 46 : 58);
		}
		FormattingHelpers.WriteDigits(modulo4, destination.Slice(num9, num7));
		num9 += num7;
		destination[num9++] = 58;
		FormattingHelpers.WriteDigits((uint)modulo3, destination.Slice(num9, 2));
		num9 += 2;
		destination[num9++] = 58;
		FormattingHelpers.WriteDigits((uint)modulo2, destination.Slice(num9, 2));
		num9 += 2;
		if (num3 > 0)
		{
			destination[num9++] = 46;
			FormattingHelpers.WriteDigits(valueWithoutTrailingZeros, destination.Slice(num9, num3));
			num9 += num3;
		}
		return true;
	}
}
