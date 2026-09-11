using System.Globalization;
using System.Runtime.Versioning;

namespace System;

[Serializable]
public readonly struct Int16 : IComparable, IConvertible, IFormattable, IComparable<short>, IEquatable<short>, ISpanFormattable
{
	private readonly short m_value;

	public const short MaxValue = 32767;

	public const short MinValue = -32768;

	public int CompareTo(object value)
	{
		if (value == null)
		{
			return 1;
		}
		if (value is short)
		{
			return this - (short)value;
		}
		throw new ArgumentException("Object must be of type Int16.");
	}

	public int CompareTo(short value)
	{
		return this - value;
	}

	public override bool Equals(object obj)
	{
		if (!(obj is short))
		{
			return false;
		}
		return this == (short)obj;
	}

	[NonVersionable]
	public bool Equals(short obj)
	{
		return this == obj;
	}

	public override int GetHashCode()
	{
		return (ushort)this | (this << 16);
	}

	public override string ToString()
	{
		return Number.FormatInt32(this, null, null);
	}

	public string ToString(IFormatProvider provider)
	{
		return Number.FormatInt32(this, null, provider);
	}

	public string ToString(string format)
	{
		return ToString(format, null);
	}

	public string ToString(string format, IFormatProvider provider)
	{
		if (this < 0 && format != null && format.Length > 0 && (format[0] == 'X' || format[0] == 'x'))
		{
			return Number.FormatUInt32((uint)(this & 0xFFFF), format, provider);
		}
		return Number.FormatInt32(this, format, provider);
	}

	public bool TryFormat(Span<char> destination, out int charsWritten, ReadOnlySpan<char> format = default(ReadOnlySpan<char>), IFormatProvider provider = null)
	{
		if (this < 0 && format.Length > 0 && (format[0] == 'X' || format[0] == 'x'))
		{
			return Number.TryFormatUInt32((uint)(this & 0xFFFF), format, provider, destination, out charsWritten);
		}
		return Number.TryFormatInt32(this, format, provider, destination, out charsWritten);
	}

	public static short Parse(string s)
	{
		if (s == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.s);
		}
		return Parse((ReadOnlySpan<char>)s, NumberStyles.Integer, NumberFormatInfo.CurrentInfo);
	}

	public static short Parse(string s, NumberStyles style)
	{
		NumberFormatInfo.ValidateParseStyleInteger(style);
		if (s == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.s);
		}
		return Parse((ReadOnlySpan<char>)s, style, NumberFormatInfo.CurrentInfo);
	}

	public static short Parse(string s, IFormatProvider provider)
	{
		if (s == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.s);
		}
		return Parse((ReadOnlySpan<char>)s, NumberStyles.Integer, NumberFormatInfo.GetInstance(provider));
	}

	public static short Parse(string s, NumberStyles style, IFormatProvider provider)
	{
		NumberFormatInfo.ValidateParseStyleInteger(style);
		if (s == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.s);
		}
		return Parse((ReadOnlySpan<char>)s, style, NumberFormatInfo.GetInstance(provider));
	}

	public static short Parse(ReadOnlySpan<char> s, NumberStyles style = NumberStyles.Integer, IFormatProvider provider = null)
	{
		NumberFormatInfo.ValidateParseStyleInteger(style);
		return Parse(s, style, NumberFormatInfo.GetInstance(provider));
	}

	private static short Parse(ReadOnlySpan<char> s, NumberStyles style, NumberFormatInfo info)
	{
		int num = 0;
		try
		{
			num = Number.ParseInt32(s, style, info);
		}
		catch (OverflowException innerException)
		{
			throw new OverflowException("Value was either too large or too small for an Int16.", innerException);
		}
		if ((style & NumberStyles.AllowHexSpecifier) != NumberStyles.None)
		{
			if (num < 0 || num > 65535)
			{
				throw new OverflowException("Value was either too large or too small for an Int16.");
			}
			return (short)num;
		}
		if (num < -32768 || num > 32767)
		{
			throw new OverflowException("Value was either too large or too small for an Int16.");
		}
		return (short)num;
	}

	public static bool TryParse(string s, out short result)
	{
		if (s == null)
		{
			result = 0;
			return false;
		}
		return TryParse((ReadOnlySpan<char>)s, NumberStyles.Integer, NumberFormatInfo.CurrentInfo, out result);
	}

	public static bool TryParse(ReadOnlySpan<char> s, out short result)
	{
		return TryParse(s, NumberStyles.Integer, NumberFormatInfo.CurrentInfo, out result);
	}

	public static bool TryParse(string s, NumberStyles style, IFormatProvider provider, out short result)
	{
		NumberFormatInfo.ValidateParseStyleInteger(style);
		if (s == null)
		{
			result = 0;
			return false;
		}
		return TryParse((ReadOnlySpan<char>)s, style, NumberFormatInfo.GetInstance(provider), out result);
	}

	public static bool TryParse(ReadOnlySpan<char> s, NumberStyles style, IFormatProvider provider, out short result)
	{
		NumberFormatInfo.ValidateParseStyleInteger(style);
		return TryParse(s, style, NumberFormatInfo.GetInstance(provider), out result);
	}

	private static bool TryParse(ReadOnlySpan<char> s, NumberStyles style, NumberFormatInfo info, out short result)
	{
		result = 0;
		if (!Number.TryParseInt32(s, style, info, out var result2))
		{
			return false;
		}
		if ((style & NumberStyles.AllowHexSpecifier) != NumberStyles.None)
		{
			if (result2 < 0 || result2 > 65535)
			{
				return false;
			}
			result = (short)result2;
			return true;
		}
		if (result2 < -32768 || result2 > 32767)
		{
			return false;
		}
		result = (short)result2;
		return true;
	}

	public TypeCode GetTypeCode()
	{
		return TypeCode.Int16;
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
		return this;
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
		throw new InvalidCastException(SR.Format("Invalid cast from '{0}' to '{1}'.", "Int16", "DateTime"));
	}

	object IConvertible.ToType(Type type, IFormatProvider provider)
	{
		return Convert.DefaultToType(this, type, provider);
	}
}
