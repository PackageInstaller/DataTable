using System.Globalization;
using System.Runtime.Versioning;

namespace System;

[Serializable]
[CLSCompliant(false)]
public readonly struct UInt16 : IComparable, IConvertible, IFormattable, IComparable<ushort>, IEquatable<ushort>, ISpanFormattable
{
	private readonly ushort m_value;

	public const ushort MaxValue = 65535;

	public const ushort MinValue = 0;

	public int CompareTo(object value)
	{
		if (value == null)
		{
			return 1;
		}
		if (value is ushort)
		{
			return this - (ushort)value;
		}
		throw new ArgumentException("Object must be of type UInt16.");
	}

	public int CompareTo(ushort value)
	{
		return this - value;
	}

	public override bool Equals(object obj)
	{
		if (!(obj is ushort))
		{
			return false;
		}
		return this == (ushort)obj;
	}

	[NonVersionable]
	public bool Equals(ushort obj)
	{
		return this == obj;
	}

	public override int GetHashCode()
	{
		return this;
	}

	public override string ToString()
	{
		return Number.FormatUInt32(this, null, null);
	}

	public string ToString(IFormatProvider provider)
	{
		return Number.FormatUInt32(this, null, provider);
	}

	public string ToString(string format)
	{
		return Number.FormatUInt32(this, format, null);
	}

	public string ToString(string format, IFormatProvider provider)
	{
		return Number.FormatUInt32(this, format, provider);
	}

	public bool TryFormat(Span<char> destination, out int charsWritten, ReadOnlySpan<char> format = default(ReadOnlySpan<char>), IFormatProvider provider = null)
	{
		return Number.TryFormatUInt32(this, format, provider, destination, out charsWritten);
	}

	[CLSCompliant(false)]
	public static ushort Parse(string s)
	{
		if (s == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.s);
		}
		return Parse((ReadOnlySpan<char>)s, NumberStyles.Integer, NumberFormatInfo.CurrentInfo);
	}

	[CLSCompliant(false)]
	public static ushort Parse(string s, NumberStyles style)
	{
		NumberFormatInfo.ValidateParseStyleInteger(style);
		if (s == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.s);
		}
		return Parse((ReadOnlySpan<char>)s, style, NumberFormatInfo.CurrentInfo);
	}

	[CLSCompliant(false)]
	public static ushort Parse(string s, IFormatProvider provider)
	{
		if (s == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.s);
		}
		return Parse((ReadOnlySpan<char>)s, NumberStyles.Integer, NumberFormatInfo.GetInstance(provider));
	}

	[CLSCompliant(false)]
	public static ushort Parse(string s, NumberStyles style, IFormatProvider provider)
	{
		NumberFormatInfo.ValidateParseStyleInteger(style);
		if (s == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.s);
		}
		return Parse((ReadOnlySpan<char>)s, style, NumberFormatInfo.GetInstance(provider));
	}

	[CLSCompliant(false)]
	public static ushort Parse(ReadOnlySpan<char> s, NumberStyles style = NumberStyles.Integer, IFormatProvider provider = null)
	{
		NumberFormatInfo.ValidateParseStyleInteger(style);
		return Parse(s, style, NumberFormatInfo.GetInstance(provider));
	}

	private static ushort Parse(ReadOnlySpan<char> s, NumberStyles style, NumberFormatInfo info)
	{
		uint num = 0u;
		try
		{
			num = Number.ParseUInt32(s, style, info);
		}
		catch (OverflowException innerException)
		{
			throw new OverflowException("Value was either too large or too small for a UInt16.", innerException);
		}
		if (num > 65535)
		{
			throw new OverflowException("Value was either too large or too small for a UInt16.");
		}
		return (ushort)num;
	}

	[CLSCompliant(false)]
	public static bool TryParse(string s, out ushort result)
	{
		if (s == null)
		{
			result = 0;
			return false;
		}
		return TryParse((ReadOnlySpan<char>)s, NumberStyles.Integer, NumberFormatInfo.CurrentInfo, out result);
	}

	[CLSCompliant(false)]
	public static bool TryParse(ReadOnlySpan<char> s, out ushort result)
	{
		return TryParse(s, NumberStyles.Integer, NumberFormatInfo.CurrentInfo, out result);
	}

	[CLSCompliant(false)]
	public static bool TryParse(string s, NumberStyles style, IFormatProvider provider, out ushort result)
	{
		NumberFormatInfo.ValidateParseStyleInteger(style);
		if (s == null)
		{
			result = 0;
			return false;
		}
		return TryParse((ReadOnlySpan<char>)s, style, NumberFormatInfo.GetInstance(provider), out result);
	}

	[CLSCompliant(false)]
	public static bool TryParse(ReadOnlySpan<char> s, NumberStyles style, IFormatProvider provider, out ushort result)
	{
		NumberFormatInfo.ValidateParseStyleInteger(style);
		return TryParse(s, style, NumberFormatInfo.GetInstance(provider), out result);
	}

	private static bool TryParse(ReadOnlySpan<char> s, NumberStyles style, NumberFormatInfo info, out ushort result)
	{
		result = 0;
		if (!Number.TryParseUInt32(s, style, info, out var result2))
		{
			return false;
		}
		if (result2 > 65535)
		{
			return false;
		}
		result = (ushort)result2;
		return true;
	}

	public TypeCode GetTypeCode()
	{
		return TypeCode.UInt16;
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
		return this;
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
		throw new InvalidCastException(SR.Format("Invalid cast from '{0}' to '{1}'.", "UInt16", "DateTime"));
	}

	object IConvertible.ToType(Type type, IFormatProvider provider)
	{
		return Convert.DefaultToType(this, type, provider);
	}
}
