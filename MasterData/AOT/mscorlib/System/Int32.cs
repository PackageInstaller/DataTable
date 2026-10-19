using System.Globalization;
using System.Runtime.Versioning;

namespace System;

[Serializable]
public readonly struct Int32 : IComparable, IConvertible, IFormattable, IComparable<int>, IEquatable<int>, ISpanFormattable
{
	private readonly int m_value;

	public const int MaxValue = 2147483647;

	public const int MinValue = -2147483648;

	public int CompareTo(object value)
	{
		if (value == null)
		{
			return 1;
		}
		if (value is int num)
		{
			if (this < num)
			{
				return -1;
			}
			if (this > num)
			{
				return 1;
			}
			return 0;
		}
		throw new ArgumentException("Object must be of type Int32.");
	}

	public int CompareTo(int value)
	{
		if (this < value)
		{
			return -1;
		}
		if (this > value)
		{
			return 1;
		}
		return 0;
	}

	public override bool Equals(object obj)
	{
		if (!(obj is int))
		{
			return false;
		}
		return this == (int)obj;
	}

	[NonVersionable]
	public bool Equals(int obj)
	{
		return this == obj;
	}

	public override int GetHashCode()
	{
		return this;
	}

	public override string ToString()
	{
		return Number.FormatInt32(this, null, null);
	}

	public string ToString(string format)
	{
		return Number.FormatInt32(this, format, null);
	}

	public string ToString(IFormatProvider provider)
	{
		return Number.FormatInt32(this, null, provider);
	}

	public string ToString(string format, IFormatProvider provider)
	{
		return Number.FormatInt32(this, format, provider);
	}

	public bool TryFormat(Span<char> destination, out int charsWritten, ReadOnlySpan<char> format = default(ReadOnlySpan<char>), IFormatProvider provider = null)
	{
		return Number.TryFormatInt32(this, format, provider, destination, out charsWritten);
	}

	public static int Parse(string s)
	{
		if (s == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.s);
		}
		return Number.ParseInt32(s, NumberStyles.Integer, NumberFormatInfo.CurrentInfo);
	}

	public static int Parse(string s, NumberStyles style)
	{
		NumberFormatInfo.ValidateParseStyleInteger(style);
		if (s == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.s);
		}
		return Number.ParseInt32(s, style, NumberFormatInfo.CurrentInfo);
	}

	public static int Parse(string s, IFormatProvider provider)
	{
		if (s == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.s);
		}
		return Number.ParseInt32(s, NumberStyles.Integer, NumberFormatInfo.GetInstance(provider));
	}

	public static int Parse(string s, NumberStyles style, IFormatProvider provider)
	{
		NumberFormatInfo.ValidateParseStyleInteger(style);
		if (s == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.s);
		}
		return Number.ParseInt32(s, style, NumberFormatInfo.GetInstance(provider));
	}

	public static int Parse(ReadOnlySpan<char> s, NumberStyles style = NumberStyles.Integer, IFormatProvider provider = null)
	{
		NumberFormatInfo.ValidateParseStyleInteger(style);
		return Number.ParseInt32(s, style, NumberFormatInfo.GetInstance(provider));
	}

	public static bool TryParse(string s, out int result)
	{
		if (s == null)
		{
			result = 0;
			return false;
		}
		return Number.TryParseInt32(s, NumberStyles.Integer, NumberFormatInfo.CurrentInfo, out result);
	}

	public static bool TryParse(ReadOnlySpan<char> s, out int result)
	{
		return Number.TryParseInt32(s, NumberStyles.Integer, NumberFormatInfo.CurrentInfo, out result);
	}

	public static bool TryParse(string s, NumberStyles style, IFormatProvider provider, out int result)
	{
		NumberFormatInfo.ValidateParseStyleInteger(style);
		if (s == null)
		{
			result = 0;
			return false;
		}
		return Number.TryParseInt32(s, style, NumberFormatInfo.GetInstance(provider), out result);
	}

	public static bool TryParse(ReadOnlySpan<char> s, NumberStyles style, IFormatProvider provider, out int result)
	{
		NumberFormatInfo.ValidateParseStyleInteger(style);
		return Number.TryParseInt32(s, style, NumberFormatInfo.GetInstance(provider), out result);
	}

	public TypeCode GetTypeCode()
	{
		return TypeCode.Int32;
	}

	bool IConvertible.ToBoolean(IFormatProvider provider)
	{
		return Convert.ToBoolean(this);
	}

	char IConvertible.ToChar(IFormatProvider provider)
	{
		return Convert.ToChar(this);
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
		return this;
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
		throw new InvalidCastException(SR.Format("Invalid cast from '{0}' to '{1}'.", "Int32", "DateTime"));
	}

	object IConvertible.ToType(Type type, IFormatProvider provider)
	{
		return Convert.DefaultToType(this, type, provider);
	}
}
