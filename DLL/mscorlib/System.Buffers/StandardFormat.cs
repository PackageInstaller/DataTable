namespace System.Buffers;

public readonly struct StandardFormat : IEquatable<StandardFormat>
{
	private readonly byte _format;

	private readonly byte _precision;

	public char Symbol => (char)_format;

	public byte Precision => _precision;

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
}
