using System.Runtime.Versioning;

namespace System;

[Serializable]
public readonly struct Boolean : IComparable, IConvertible, IComparable<bool>, IEquatable<bool>
{
	private readonly bool m_value;

	internal const int True = 1;

	internal const int False = 0;

	internal const string TrueLiteral = "True";

	internal const string FalseLiteral = "False";

	public static readonly string TrueString = "True";

	public static readonly string FalseString = "False";

	public override int GetHashCode()
	{
		if (!this)
		{
			return 0;
		}
		return 1;
	}

	public override string ToString()
	{
		if (!this)
		{
			return "False";
		}
		return "True";
	}

	public string ToString(IFormatProvider provider)
	{
		return ToString();
	}

	public bool TryFormat(Span<char> destination, out int charsWritten)
	{
		string text = (this ? "True" : "False");
		if (text.AsSpan().TryCopyTo(destination))
		{
			charsWritten = text.Length;
			return true;
		}
		charsWritten = 0;
		return false;
	}

	public override bool Equals(object obj)
	{
		if (!(obj is bool))
		{
			return false;
		}
		return this == (bool)obj;
	}

	[NonVersionable]
	public bool Equals(bool obj)
	{
		return this == obj;
	}

	public int CompareTo(object obj)
	{
		if (obj == null)
		{
			return 1;
		}
		if (!(obj is bool))
		{
			throw new ArgumentException("Object must be of type Boolean.");
		}
		if (this == (bool)obj)
		{
			return 0;
		}
		if (!this)
		{
			return -1;
		}
		return 1;
	}

	public int CompareTo(bool value)
	{
		if (this == value)
		{
			return 0;
		}
		if (!this)
		{
			return -1;
		}
		return 1;
	}

	public static bool Parse(string value)
	{
		if (value == null)
		{
			throw new ArgumentNullException("value");
		}
		return Parse(value.AsSpan());
	}

	public static bool Parse(ReadOnlySpan<char> value)
	{
		if (!TryParse(value, out var result))
		{
			throw new FormatException("String was not recognized as a valid Boolean.");
		}
		return result;
	}

	public static bool TryParse(string value, out bool result)
	{
		if (value == null)
		{
			result = false;
			return false;
		}
		return TryParse(value.AsSpan(), out result);
	}

	public static bool TryParse(ReadOnlySpan<char> value, out bool result)
	{
		ReadOnlySpan<char> span = "True".AsSpan();
		if (span.EqualsOrdinalIgnoreCase(value))
		{
			result = true;
			return true;
		}
		ReadOnlySpan<char> span2 = "False".AsSpan();
		if (span2.EqualsOrdinalIgnoreCase(value))
		{
			result = false;
			return true;
		}
		value = TrimWhiteSpaceAndNull(value);
		if (span.EqualsOrdinalIgnoreCase(value))
		{
			result = true;
			return true;
		}
		if (span2.EqualsOrdinalIgnoreCase(value))
		{
			result = false;
			return true;
		}
		result = false;
		return false;
	}

	private static ReadOnlySpan<char> TrimWhiteSpaceAndNull(ReadOnlySpan<char> value)
	{
		int i;
		for (i = 0; i < value.Length && (char.IsWhiteSpace(value[i]) || value[i] == '\0'); i++)
		{
		}
		int num = value.Length - 1;
		while (num >= i && (char.IsWhiteSpace(value[num]) || value[num] == '\0'))
		{
			num--;
		}
		return value.Slice(i, num - i + 1);
	}

	public TypeCode GetTypeCode()
	{
		return TypeCode.Boolean;
	}

	bool IConvertible.ToBoolean(IFormatProvider provider)
	{
		return this;
	}

	char IConvertible.ToChar(IFormatProvider provider)
	{
		throw new InvalidCastException(SR.Format("Invalid cast from '{0}' to '{1}'.", "Boolean", "Char"));
	}

	sbyte IConvertible.ToSByte(IFormatProvider provider)
	{
		return Convert.ToSByte(this);
	}

	byte IConvertible.ToByte(IFormatProvider provider)
	{
		return Convert.ToByte(this);
	}

	short IConvertible.ToInt16(IFormatProvider provider)
	{
		return Convert.ToInt16(this);
	}

	ushort IConvertible.ToUInt16(IFormatProvider provider)
	{
		return Convert.ToUInt16(this);
	}

	int IConvertible.ToInt32(IFormatProvider provider)
	{
		return Convert.ToInt32(this);
	}

	uint IConvertible.ToUInt32(IFormatProvider provider)
	{
		return Convert.ToUInt32(this);
	}

	long IConvertible.ToInt64(IFormatProvider provider)
	{
		return Convert.ToInt64(this);
	}

	ulong IConvertible.ToUInt64(IFormatProvider provider)
	{
		return Convert.ToUInt64(this);
	}

	float IConvertible.ToSingle(IFormatProvider provider)
	{
		return Convert.ToSingle(this);
	}

	double IConvertible.ToDouble(IFormatProvider provider)
	{
		return Convert.ToDouble(this);
	}

	decimal IConvertible.ToDecimal(IFormatProvider provider)
	{
		return Convert.ToDecimal(this);
	}

	DateTime IConvertible.ToDateTime(IFormatProvider provider)
	{
		throw new InvalidCastException(SR.Format("Invalid cast from '{0}' to '{1}'.", "Boolean", "DateTime"));
	}

	object IConvertible.ToType(Type type, IFormatProvider provider)
	{
		return Convert.DefaultToType(this, type, provider);
	}
}
