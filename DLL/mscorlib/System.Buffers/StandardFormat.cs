namespace System.Buffers;

public readonly struct StandardFormat : IEquatable<StandardFormat>
{
	private readonly byte _format;

	private readonly byte _precision;

	public char Symbol => (char)_format;

	public byte Precision => _precision;

	public bool HasPrecision => _precision != byte.MaxValue;

	public bool IsDefault
	{
		get
		{
			if (_format == 0)
			{
				return _precision == 0;
			}
			return false;
		}
	}

	public StandardFormat(char symbol, byte precision = byte.MaxValue)
	{
		if (precision != byte.MaxValue && precision > 99)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException_PrecisionTooLarge();
		}
		if (symbol != (byte)symbol)
		{
			ThrowHelper.ThrowArgumentOutOfRangeException_SymbolDoesNotFit();
		}
		_format = (byte)symbol;
		_precision = precision;
	}

	public static implicit operator StandardFormat(char symbol)
	{
		return new StandardFormat(symbol);
	}

	public static StandardFormat Parse(ReadOnlySpan<char> format)
	{
		ParseHelper(format, out var standardFormat, throws: true);
		return standardFormat;
	}

	private static bool ParseHelper(ReadOnlySpan<char> format, out StandardFormat standardFormat, bool throws = false)
	{
		standardFormat = default(StandardFormat);
		if (format.Length == 0)
		{
			return true;
		}
		char symbol = format[0];
		byte precision;
		if (format.Length == 1)
		{
			precision = byte.MaxValue;
		}
		else
		{
			uint num = 0u;
			for (int i = 1; i < format.Length; i++)
			{
				uint num2 = (uint)(format[i] - 48);
				if (num2 > 9)
				{
					if (!throws)
					{
						return false;
					}
					throw new FormatException(SR.Format("Characters following the format symbol must be a number of {0} or less.", (byte)99));
				}
				num = num * 10 + num2;
				if (num > 99)
				{
					if (!throws)
					{
						return false;
					}
					throw new FormatException(SR.Format("Precision cannot be larger than {0}.", (byte)99));
				}
			}
			precision = (byte)num;
		}
		standardFormat = new StandardFormat(symbol, precision);
		return true;
	}

	public override bool Equals(object obj)
	{
		if (obj is StandardFormat other)
		{
			return Equals(other);
		}
		return false;
	}

	public override int GetHashCode()
	{
		return _format.GetHashCode() ^ _precision.GetHashCode();
	}

	public bool Equals(StandardFormat other)
	{
		if (_format == other._format)
		{
			return _precision == other._precision;
		}
		return false;
	}

	public override string ToString()
	{
		Span<char> destination = stackalloc char[3];
		int length = Format(destination);
		return new string(destination.Slice(0, length));
	}

	internal int Format(Span<char> destination)
	{
		int num = 0;
		char symbol = Symbol;
		if (symbol != 0 && destination.Length == 3)
		{
			destination[0] = symbol;
			num = 1;
			uint result = Precision;
			if (result != 255)
			{
				if (result >= 10)
				{
					uint num2 = Math.DivRem(result, 10u, out result);
					destination[1] = (char)(48 + num2 % 10);
					num = 2;
				}
				destination[num] = (char)(48 + result);
				num++;
			}
		}
		return num;
	}

	public static bool operator !=(StandardFormat left, StandardFormat right)
	{
		return !left.Equals(right);
	}
}
