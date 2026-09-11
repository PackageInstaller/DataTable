using System.Globalization;
using System.Runtime.Versioning;

namespace System;

[Serializable]
[CLSCompliant(false)]
public readonly struct UInt32 : IComparable, IConvertible, IFormattable, IComparable<uint>, IEquatable<uint>, ISpanFormattable
{
	private readonly uint m_value;

	public const uint MaxValue = 4294967295u;

	public const uint MinValue = 0u;

	public int CompareTo(object value)
	{
		if (value == null)
		{
			return 1;
		}
		if (value is uint num)
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
		throw new ArgumentException("Object must be of type UInt32.");
	}

	public int CompareTo(uint value)
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
		if (!(obj is uint))
		{
			return false;
		}
		return this == (uint)obj;
	}

	[NonVersionable]
	public bool Equals(uint obj)
	{
		return this == obj;
	}

	public override int GetHashCode()
	{
		return (int)this;
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
	public static uint Parse(string s)
	{
		if (s == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.s);
		}
		return Number.ParseUInt32(s, NumberStyles.Integer, NumberFormatInfo.CurrentInfo);
	}

	[CLSCompliant(false)]
	public static uint Parse(string s, NumberStyles style)
	{
		NumberFormatInfo.ValidateParseStyleInteger(style);
		if (s == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.s);
		}
		return Number.ParseUInt32(s, style, NumberFormatInfo.CurrentInfo);
	}

	[CLSCompliant(false)]
	public static uint Parse(string s, IFormatProvider provider)
	{
		if (s == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.s);
		}
		return Number.ParseUInt32(s, NumberStyles.Integer, NumberFormatInfo.GetInstance(provider));
	}

	[CLSCompliant(false)]
	public static uint Parse(string s, NumberStyles style, IFormatProvider provider)
	{
		NumberFormatInfo.ValidateParseStyleInteger(style);
		if (s == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.s);
		}
		return Number.ParseUInt32(s, style, NumberFormatInfo.GetInstance(provider));
	}

	[CLSCompliant(false)]
	public static uint Parse(ReadOnlySpan<char> s, NumberStyles style = NumberStyles.Integer, IFormatProvider provider = null)
	{
		NumberFormatInfo.ValidateParseStyleInteger(style);
		return Number.ParseUInt32(s, style, NumberFormatInfo.GetInstance(provider));
	}

	[CLSCompliant(false)]
	public static bool TryParse(string s, out uint result)
	{
		if (s == null)
		{
			result = 0u;
			return false;
		}
		return Number.TryParseUInt32(s, NumberStyles.Integer, NumberFormatInfo.CurrentInfo, out result);
	}

	[CLSCompliant(false)]
	public static bool TryParse(ReadOnlySpan<char> s, out uint result)
	{
		return Number.TryParseUInt32(s, NumberStyles.Integer, NumberFormatInfo.CurrentInfo, out result);
	}

	[CLSCompliant(false)]
	public static bool TryParse(string s, NumberStyles style, IFormatProvider provider, out uint result)
	{
		NumberFormatInfo.ValidateParseStyleInteger(style);
		if (s == null)
		{
			result = 0u;
			return false;
		}
		return Number.TryParseUInt32(s, style, NumberFormatInfo.GetInstance(provider), out result);
	}

	[CLSCompliant(false)]
	public static bool TryParse(ReadOnlySpan<char> s, NumberStyles style, IFormatProvider provider, out uint result)
	{
		NumberFormatInfo.ValidateParseStyleInteger(style);
		return Number.TryParseUInt32(s, style, NumberFormatInfo.GetInstance(provider), out result);
	}

	public TypeCode GetTypeCode()
	{
		return TypeCode.UInt32;
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
		return Convert.ToInt32(this);
	}

	uint IConvertible.ToUInt32(IFormatProvider provider)
	{
		return this;
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
		throw new InvalidCastException(SR.Format("Invalid cast from '{0}' to '{1}'.", "UInt32", "DateTime"));
	}

	object IConvertible.ToType(Type type, IFormatProvider provider)
	{
		return Convert.DefaultToType(this, type, provider);
	}
}
