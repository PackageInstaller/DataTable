using System.Globalization;
using System.Runtime.CompilerServices;
using System.Runtime.Versioning;

namespace System;

[Serializable]
public readonly struct Single : IComparable, IConvertible, IFormattable, IComparable<float>, IEquatable<float>, ISpanFormattable
{
	private readonly float m_value;

	public const float MinValue = -3.4028235E+38f;

	public const float Epsilon = 1E-45f;

	public const float MaxValue = 3.4028235E+38f;

	public const float PositiveInfinity = 1f / 0f;

	public const float NegativeInfinity = -1f / 0f;

	public const float NaN = 0f / 0f;

	internal const float NegativeZero = -0f;

	[MethodImpl((MethodImplOptions)256)]
	[NonVersionable]
	public static bool IsFinite(float f)
	{
		return (BitConverter.SingleToInt32Bits(f) & 0x7FFFFFFF) < 2139095040;
	}

	[MethodImpl((MethodImplOptions)256)]
	[NonVersionable]
	public static bool IsInfinity(float f)
	{
		return (BitConverter.SingleToInt32Bits(f) & 0x7FFFFFFF) == 2139095040;
	}

	[MethodImpl((MethodImplOptions)256)]
	[NonVersionable]
	public static bool IsNaN(float f)
	{
		return (BitConverter.SingleToInt32Bits(f) & 0x7FFFFFFF) > 2139095040;
	}

	[MethodImpl((MethodImplOptions)256)]
	[NonVersionable]
	public static bool IsNegative(float f)
	{
		return (BitConverter.SingleToInt32Bits(f) & int.MinValue) == int.MinValue;
	}

	[MethodImpl((MethodImplOptions)256)]
	[NonVersionable]
	public static bool IsNegativeInfinity(float f)
	{
		return f == float.NegativeInfinity;
	}

	[NonVersionable]
	public static bool IsNormal(float f)
	{
		int num = BitConverter.SingleToInt32Bits(f);
		num &= 0x7FFFFFFF;
		if (num < 2139095040 && num != 0)
		{
			return (num & 0x7F800000) != 0;
		}
		return false;
	}

	[MethodImpl((MethodImplOptions)256)]
	[NonVersionable]
	public static bool IsPositiveInfinity(float f)
	{
		return f == float.PositiveInfinity;
	}

	[NonVersionable]
	public static bool IsSubnormal(float f)
	{
		int num = BitConverter.SingleToInt32Bits(f);
		num &= 0x7FFFFFFF;
		if (num < 2139095040 && num != 0)
		{
			return (num & 0x7F800000) == 0;
		}
		return false;
	}

	public int CompareTo(object value)
	{
		if (value == null)
		{
			return 1;
		}
		if (value is float num)
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
		throw new ArgumentException("Object must be of type Single.");
	}

	public int CompareTo(float value)
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

	[NonVersionable]
	public static bool operator ==(float left, float right)
	{
		return left == right;
	}

	[NonVersionable]
	public static bool operator !=(float left, float right)
	{
		return left != right;
	}

	[NonVersionable]
	public static bool operator <(float left, float right)
	{
		return left < right;
	}

	[NonVersionable]
	public static bool operator >(float left, float right)
	{
		return left > right;
	}

	[NonVersionable]
	public static bool operator <=(float left, float right)
	{
		return left <= right;
	}

	[NonVersionable]
	public static bool operator >=(float left, float right)
	{
		return left >= right;
	}

	public override bool Equals(object obj)
	{
		if (!(obj is float num))
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

	public bool Equals(float obj)
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

	public override int GetHashCode()
	{
		int num = BitConverter.SingleToInt32Bits(this);
		if (((num - 1) & 0x7FFFFFFF) >= 2139095040)
		{
			num &= 0x7F800000;
		}
		return num;
	}

	public override string ToString()
	{
		return Number.FormatSingle(this, null, NumberFormatInfo.CurrentInfo);
	}

	public string ToString(IFormatProvider provider)
	{
		return Number.FormatSingle(this, null, NumberFormatInfo.GetInstance(provider));
	}

	public string ToString(string format)
	{
		return Number.FormatSingle(this, format, NumberFormatInfo.CurrentInfo);
	}

	public string ToString(string format, IFormatProvider provider)
	{
		return Number.FormatSingle(this, format, NumberFormatInfo.GetInstance(provider));
	}

	public bool TryFormat(Span<char> destination, out int charsWritten, ReadOnlySpan<char> format = default(ReadOnlySpan<char>), IFormatProvider provider = null)
	{
		return Number.TryFormatSingle(this, format, NumberFormatInfo.GetInstance(provider), destination, out charsWritten);
	}

	public static float Parse(string s)
	{
		if (s == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.s);
		}
		return Number.ParseSingle(s, NumberStyles.Float | NumberStyles.AllowThousands, NumberFormatInfo.CurrentInfo);
	}

	public static float Parse(string s, NumberStyles style)
	{
		NumberFormatInfo.ValidateParseStyleFloatingPoint(style);
		if (s == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.s);
		}
		return Number.ParseSingle(s, style, NumberFormatInfo.CurrentInfo);
	}

	public static float Parse(string s, IFormatProvider provider)
	{
		if (s == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.s);
		}
		return Number.ParseSingle(s, NumberStyles.Float | NumberStyles.AllowThousands, NumberFormatInfo.GetInstance(provider));
	}

	public static float Parse(string s, NumberStyles style, IFormatProvider provider)
	{
		NumberFormatInfo.ValidateParseStyleFloatingPoint(style);
		if (s == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.s);
		}
		return Number.ParseSingle(s, style, NumberFormatInfo.GetInstance(provider));
	}

	public static float Parse(ReadOnlySpan<char> s, NumberStyles style = NumberStyles.Float | NumberStyles.AllowThousands, IFormatProvider provider = null)
	{
		NumberFormatInfo.ValidateParseStyleFloatingPoint(style);
		return Number.ParseSingle(s, style, NumberFormatInfo.GetInstance(provider));
	}

	public static bool TryParse(string s, out float result)
	{
		if (s == null)
		{
			result = 0f;
			return false;
		}
		return TryParse((ReadOnlySpan<char>)s, NumberStyles.Float | NumberStyles.AllowThousands, NumberFormatInfo.CurrentInfo, out result);
	}

	public static bool TryParse(ReadOnlySpan<char> s, out float result)
	{
		return TryParse(s, NumberStyles.Float | NumberStyles.AllowThousands, NumberFormatInfo.CurrentInfo, out result);
	}

	public static bool TryParse(string s, NumberStyles style, IFormatProvider provider, out float result)
	{
		NumberFormatInfo.ValidateParseStyleFloatingPoint(style);
		if (s == null)
		{
			result = 0f;
			return false;
		}
		return TryParse((ReadOnlySpan<char>)s, style, NumberFormatInfo.GetInstance(provider), out result);
	}

	public static bool TryParse(ReadOnlySpan<char> s, NumberStyles style, IFormatProvider provider, out float result)
	{
		NumberFormatInfo.ValidateParseStyleFloatingPoint(style);
		return TryParse(s, style, NumberFormatInfo.GetInstance(provider), out result);
	}

	private static bool TryParse(ReadOnlySpan<char> s, NumberStyles style, NumberFormatInfo info, out float result)
	{
		if (!Number.TryParseSingle(s, style, info, out result))
		{
			ReadOnlySpan<char> span = s.Trim();
			if (span.EqualsOrdinal(info.PositiveInfinitySymbol))
			{
				result = float.PositiveInfinity;
			}
			else if (span.EqualsOrdinal(info.NegativeInfinitySymbol))
			{
				result = float.NegativeInfinity;
			}
			else
			{
				if (!span.EqualsOrdinal(info.NaNSymbol))
				{
					return false;
				}
				result = float.NaN;
			}
		}
		return true;
	}

	public TypeCode GetTypeCode()
	{
		return TypeCode.Single;
	}

	bool IConvertible.ToBoolean(IFormatProvider provider)
	{
		return Convert.ToBoolean(this);
	}

	char IConvertible.ToChar(IFormatProvider provider)
	{
		throw new InvalidCastException(SR.Format("Invalid cast from '{0}' to '{1}'.", "Single", "Char"));
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
		return this;
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
		throw new InvalidCastException(SR.Format("Invalid cast from '{0}' to '{1}'.", "Single", "DateTime"));
	}

	object IConvertible.ToType(Type type, IFormatProvider provider)
	{
		return Convert.DefaultToType(this, type, provider);
	}
}
