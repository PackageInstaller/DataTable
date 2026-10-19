using System.Globalization;
using System.Runtime.CompilerServices;
using System.Runtime.Versioning;

namespace System;

[Serializable]
public readonly struct Double : IComparable, IConvertible, IFormattable, IComparable<double>, IEquatable<double>, ISpanFormattable
{
	private readonly double m_value;

	public const double MinValue = -1.7976931348623157E+308;

	public const double MaxValue = 1.7976931348623157E+308;

	public const double Epsilon = 5E-324;

	public const double NegativeInfinity = -1.0 / 0.0;

	public const double PositiveInfinity = 1.0 / 0.0;

	public const double NaN = 0.0 / 0.0;

	internal const double NegativeZero = -0.0;

	[MethodImpl((MethodImplOptions)256)]
	[NonVersionable]
	public static bool IsFinite(double d)
	{
		return (BitConverter.DoubleToInt64Bits(d) & 0x7FFFFFFFFFFFFFFFL) < 9218868437227405312L;
	}

	[MethodImpl((MethodImplOptions)256)]
	[NonVersionable]
	public static bool IsInfinity(double d)
	{
		return (BitConverter.DoubleToInt64Bits(d) & 0x7FFFFFFFFFFFFFFFL) == 9218868437227405312L;
	}

	[MethodImpl((MethodImplOptions)256)]
	[NonVersionable]
	public static bool IsNaN(double d)
	{
		return (BitConverter.DoubleToInt64Bits(d) & 0x7FFFFFFFFFFFFFFFL) > 9218868437227405312L;
	}

	[MethodImpl((MethodImplOptions)256)]
	[NonVersionable]
	public static bool IsNegative(double d)
	{
		return (BitConverter.DoubleToInt64Bits(d) & long.MinValue) == long.MinValue;
	}

	[MethodImpl((MethodImplOptions)256)]
	[NonVersionable]
	public static bool IsNegativeInfinity(double d)
	{
		return d == double.NegativeInfinity;
	}

	[NonVersionable]
	public static bool IsNormal(double d)
	{
		long num = BitConverter.DoubleToInt64Bits(d);
		num &= 0x7FFFFFFFFFFFFFFFL;
		if (num < 9218868437227405312L && num != 0L)
		{
			return (num & 0x7FF0000000000000L) != 0;
		}
		return false;
	}

	[MethodImpl((MethodImplOptions)256)]
	[NonVersionable]
	public static bool IsPositiveInfinity(double d)
	{
		return d == double.PositiveInfinity;
	}

	[NonVersionable]
	public static bool IsSubnormal(double d)
	{
		long num = BitConverter.DoubleToInt64Bits(d);
		num &= 0x7FFFFFFFFFFFFFFFL;
		if (num < 9218868437227405312L && num != 0L)
		{
			return (num & 0x7FF0000000000000L) == 0;
		}
		return false;
	}

	public int CompareTo(object value)
	{
		if (value == null)
		{
			return 1;
		}
		if (value is double num)
		{
			if (this < num)
			{
				return -1;
			}
			if (this > num)
			{
				return 1;
			}
			if (this == num)
			{
				return 0;
			}
			if (IsNaN(this))
			{
				if (!IsNaN(num))
				{
					return -1;
				}
				return 0;
			}
			return 1;
		}
		throw new ArgumentException("Object must be of type Double.");
	}

	public int CompareTo(double value)
	{
		if (this < value)
		{
			return -1;
		}
		if (this > value)
		{
			return 1;
		}
		if (this == value)
		{
			return 0;
		}
		if (IsNaN(this))
		{
			if (!IsNaN(value))
			{
				return -1;
			}
			return 0;
		}
		return 1;
	}

	public override bool Equals(object obj)
	{
		if (!(obj is double num))
		{
			return false;
		}
		if (num == this)
		{
			return true;
		}
		if (IsNaN(num))
		{
			return IsNaN(this);
		}
		return false;
	}

	[NonVersionable]
	public static bool operator ==(double left, double right)
	{
		return left == right;
	}

	[NonVersionable]
	public static bool operator !=(double left, double right)
	{
		return left != right;
	}

	[NonVersionable]
	public static bool operator <(double left, double right)
	{
		return left < right;
	}

	[NonVersionable]
	public static bool operator >(double left, double right)
	{
		return left > right;
	}

	[NonVersionable]
	public static bool operator <=(double left, double right)
	{
		return left <= right;
	}

	[NonVersionable]
	public static bool operator >=(double left, double right)
	{
		return left >= right;
	}

	public bool Equals(double obj)
	{
		if (obj == this)
		{
			return true;
		}
		if (IsNaN(obj))
		{
			return IsNaN(this);
		}
		return false;
	}

	[MethodImpl((MethodImplOptions)256)]
	public override int GetHashCode()
	{
		long num = BitConverter.DoubleToInt64Bits(this);
		if (((num - 1) & 0x7FFFFFFFFFFFFFFFL) >= 9218868437227405312L)
		{
			num &= 0x7FF0000000000000L;
		}
		return (int)num ^ (int)(num >> 32);
	}

	public override string ToString()
	{
		return Number.FormatDouble(this, null, NumberFormatInfo.CurrentInfo);
	}

	public string ToString(string format)
	{
		return Number.FormatDouble(this, format, NumberFormatInfo.CurrentInfo);
	}

	public string ToString(IFormatProvider provider)
	{
		return Number.FormatDouble(this, null, NumberFormatInfo.GetInstance(provider));
	}

	public string ToString(string format, IFormatProvider provider)
	{
		return Number.FormatDouble(this, format, NumberFormatInfo.GetInstance(provider));
	}

	public bool TryFormat(Span<char> destination, out int charsWritten, ReadOnlySpan<char> format = default(ReadOnlySpan<char>), IFormatProvider provider = null)
	{
		return Number.TryFormatDouble(this, format, NumberFormatInfo.GetInstance(provider), destination, out charsWritten);
	}

	public static double Parse(string s)
	{
		if (s == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.s);
		}
		return Number.ParseDouble(s, NumberStyles.Float | NumberStyles.AllowThousands, NumberFormatInfo.CurrentInfo);
	}

	public static double Parse(string s, NumberStyles style)
	{
		NumberFormatInfo.ValidateParseStyleFloatingPoint(style);
		if (s == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.s);
		}
		return Number.ParseDouble(s, style, NumberFormatInfo.CurrentInfo);
	}

	public static double Parse(string s, IFormatProvider provider)
	{
		if (s == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.s);
		}
		return Number.ParseDouble(s, NumberStyles.Float | NumberStyles.AllowThousands, NumberFormatInfo.GetInstance(provider));
	}

	public static double Parse(string s, NumberStyles style, IFormatProvider provider)
	{
		NumberFormatInfo.ValidateParseStyleFloatingPoint(style);
		if (s == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.s);
		}
		return Number.ParseDouble(s, style, NumberFormatInfo.GetInstance(provider));
	}

	public static double Parse(ReadOnlySpan<char> s, NumberStyles style = NumberStyles.Float | NumberStyles.AllowThousands, IFormatProvider provider = null)
	{
		NumberFormatInfo.ValidateParseStyleFloatingPoint(style);
		return Number.ParseDouble(s, style, NumberFormatInfo.GetInstance(provider));
	}

	public static bool TryParse(string s, out double result)
	{
		if (s == null)
		{
			result = 0.0;
			return false;
		}
		return TryParse((ReadOnlySpan<char>)s, NumberStyles.Float | NumberStyles.AllowThousands, NumberFormatInfo.CurrentInfo, out result);
	}

	public static bool TryParse(ReadOnlySpan<char> s, out double result)
	{
		return TryParse(s, NumberStyles.Float | NumberStyles.AllowThousands, NumberFormatInfo.CurrentInfo, out result);
	}

	public static bool TryParse(string s, NumberStyles style, IFormatProvider provider, out double result)
	{
		NumberFormatInfo.ValidateParseStyleFloatingPoint(style);
		if (s == null)
		{
			result = 0.0;
			return false;
		}
		return TryParse((ReadOnlySpan<char>)s, style, NumberFormatInfo.GetInstance(provider), out result);
	}

	public static bool TryParse(ReadOnlySpan<char> s, NumberStyles style, IFormatProvider provider, out double result)
	{
		NumberFormatInfo.ValidateParseStyleFloatingPoint(style);
		return TryParse(s, style, NumberFormatInfo.GetInstance(provider), out result);
	}

	private static bool TryParse(ReadOnlySpan<char> s, NumberStyles style, NumberFormatInfo info, out double result)
	{
		if (!Number.TryParseDouble(s, style, info, out result))
		{
			ReadOnlySpan<char> span = s.Trim();
			if (span.EqualsOrdinal(info.PositiveInfinitySymbol))
			{
				result = double.PositiveInfinity;
			}
			else if (span.EqualsOrdinal(info.NegativeInfinitySymbol))
			{
				result = double.NegativeInfinity;
			}
			else
			{
				if (!span.EqualsOrdinal(info.NaNSymbol))
				{
					return false;
				}
				result = double.NaN;
			}
		}
		return true;
	}

	public TypeCode GetTypeCode()
	{
		return TypeCode.Double;
	}

	bool IConvertible.ToBoolean(IFormatProvider provider)
	{
		return Convert.ToBoolean(this);
	}

	char IConvertible.ToChar(IFormatProvider provider)
	{
		throw new InvalidCastException(SR.Format("Invalid cast from '{0}' to '{1}'.", "Double", "Char"));
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
		return this;
	}

	decimal IConvertible.ToDecimal(IFormatProvider provider)
	{
		return Convert.ToDecimal(this);
	}

	DateTime IConvertible.ToDateTime(IFormatProvider provider)
	{
		throw new InvalidCastException(SR.Format("Invalid cast from '{0}' to '{1}'.", "Double", "DateTime"));
	}

	object IConvertible.ToType(Type type, IFormatProvider provider)
	{
		return Convert.DefaultToType(this, type, provider);
	}
}
