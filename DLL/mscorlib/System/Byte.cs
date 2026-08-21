using System.Globalization;
using System.Runtime.Versioning;

namespace System;

[Serializable]
public readonly struct Byte : IComparable, IConvertible, IFormattable, IComparable<byte>, IEquatable<byte>, ISpanFormattable
{
	private readonly byte m_value;

	public const byte MaxValue = 255;

	public const byte MinValue = 0;

	public int CompareTo(object value)
	{
		if (value == null)
		{
			return 1;
		}
		if (!(value is byte))
		{
			throw new ArgumentException("Object must be of type Byte.");
		}
		return this - (byte)value;
	}

	public int CompareTo(byte value)
	{
		return this - value;
	}

	public override bool Equals(object obj)
	{
		if (!(obj is byte))
		{
			return false;
		}
		return this == (byte)obj;
	}

	[NonVersionable]
	public bool Equals(byte obj)
	{
		return this == obj;
	}

	public override int GetHashCode()
	{
		return this;
	}

	public static byte Parse(string s)
	{
		if (s == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.s);
		}
		return Parse((ReadOnlySpan<char>)s, NumberStyles.Integer, NumberFormatInfo.CurrentInfo);
	}

	public static byte Parse(string s, NumberStyles style)
	{
		NumberFormatInfo.ValidateParseStyleInteger(style);
		if (s == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.s);
		}
		return Parse((ReadOnlySpan<char>)s, style, NumberFormatInfo.CurrentInfo);
	}

	public static byte Parse(string s, IFormatProvider provider)
	{
		if (s == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.s);
		}
		return Parse((ReadOnlySpan<char>)s, NumberStyles.Integer, NumberFormatInfo.GetInstance(provider));
	}

	public static byte Parse(string s, NumberStyles style, IFormatProvider provider)
	{
		NumberFormatInfo.ValidateParseStyleInteger(style);
		if (s == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.s);
		}
		return Parse((ReadOnlySpan<char>)s, style, NumberFormatInfo.GetInstance(provider));
	}

	public static byte Parse(ReadOnlySpan<char> s, NumberStyles style = NumberStyles.Integer, IFormatProvider provider = null)
	{
		NumberFormatInfo.ValidateParseStyleInteger(style);
		return Parse(s, style, NumberFormatInfo.GetInstance(provider));
	}

	private static byte Parse(ReadOnlySpan<char> s, NumberStyles style, NumberFormatInfo info)
	{
		int num = 0;
		try
		{
			num = Number.ParseInt32(s, style, info);
		}
		catch (OverflowException innerException)
		{
			throw new OverflowException("Value was either too large or too small for an unsigned byte.", innerException);
		}
		if (num < 0 || num > 255)
		{
			throw new OverflowException("Value was either too large or too small for an unsigned byte.");
		}
		return (byte)num;
	}

	public static bool TryParse(string s, out byte result)
	{
		if (s == null)
		{
			result = 0;
			return false;
		}
		return TryParse((ReadOnlySpan<char>)s, NumberStyles.Integer, NumberFormatInfo.CurrentInfo, out result);
	}

	public static bool TryParse(ReadOnlySpan<char> s, out byte result)
	{
		return TryParse(s, NumberStyles.Integer, NumberFormatInfo.CurrentInfo, out result);
	}

	public static bool TryParse(string s, NumberStyles style, IFormatProvider provider, out byte result)
	{
		NumberFormatInfo.ValidateParseStyleInteger(style);
		if (s == null)
		{
			result = 0;
			return false;
		}
		return TryParse((ReadOnlySpan<char>)s, style, NumberFormatInfo.GetInstance(provider), out result);
	}

	public static bool TryParse(ReadOnlySpan<char> s, NumberStyles style, IFormatProvider provider, out byte result)
	{
		NumberFormatInfo.ValidateParseStyleInteger(style);
		return TryParse(s, style, NumberFormatInfo.GetInstance(provider), out result);
	}

	private static bool TryParse(ReadOnlySpan<char> s, NumberStyles style, NumberFormatInfo info, out byte result)
	{
		result = 0;
		if (!Number.TryParseInt32(s, style, info, out var result2))
		{
			return false;
		}
		if (result2 < 0 || result2 > 255)
		{
			return false;
		}
		result = (byte)result2;
		return true;
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

	public TypeCode GetTypeCode()
	{
		return TypeCode.Byte;
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
		return this;
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
		throw new InvalidCastException(SR.Format("Invalid cast from '{0}' to '{1}'.", "Byte", "DateTime"));
	}

	object IConvertible.ToType(Type type, IFormatProvider provider)
	{
		return Convert.DefaultToType(this, type, provider);
	}
}
