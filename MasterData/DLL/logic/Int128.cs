using System;
using System.Globalization;
using System.Text;

public struct Int128 : IComparable<Int128>, IComparable, IEquatable<Int128>, IConvertible, IFormattable
{
	private ulong _hi;

	private ulong _lo;

	private const ulong HiNeg = 9223372036854775808uL;

	public static Int128 Zero = GetZero();

	public static Int128 MaxValue = GetMaxValue();

	public static Int128 MinValue = GetMinValue();

	public int Sign
	{
		get
		{
			if (_hi == 0L && _lo == 0L)
			{
				return 0;
			}
			if ((_hi & 0x8000000000000000uL) != 0L)
			{
				return -1;
			}
			return 1;
		}
	}

	private static Int128 GetMaxValue()
	{
		return new Int128(9223372036854775807uL, ulong.MaxValue);
	}

	private static Int128 GetMinValue()
	{
		return new Int128(9223372036854775808uL, 0uL);
	}

	private static Int128 GetZero()
	{
		return default(Int128);
	}

	public Int128(byte value)
	{
		_hi = 0uL;
		_lo = value;
	}

	public Int128(bool value)
	{
		_hi = 0uL;
		_lo = (ulong)(value ? 1 : 0);
	}

	public Int128(char value)
	{
		_hi = 0uL;
		_lo = value;
	}

	public Int128(decimal value)
	{
		if (value < 0m)
		{
			Int128 @int = -new Int128(-value);
			_hi = @int._hi;
			_lo = @int._lo;
		}
		else
		{
			int[] bits = decimal.GetBits(value);
			_hi = (uint)bits[2];
			_lo = (ulong)((uint)bits[0] | ((long)bits[1] << 32));
		}
	}

	public Int128(double value)
		: this((decimal)value)
	{
	}

	public Int128(float value)
		: this((decimal)value)
	{
	}

	public Int128(short value)
	{
		if (value < 0)
		{
			Int128 @int = -new Int128(-(value + 1)) - 1;
			_hi = @int._hi;
			_lo = @int._lo;
		}
		else
		{
			_hi = 0uL;
			_lo = (ulong)value;
		}
	}

	public Int128(int value)
	{
		if (value < 0)
		{
			Int128 @int = -new Int128(-(value + 1)) - 1;
			_hi = @int._hi;
			_lo = @int._lo;
		}
		else
		{
			_hi = 0uL;
			_lo = (ulong)value;
		}
	}

	public Int128(long value)
	{
		if (value < 0)
		{
			Int128 @int = -new Int128(-(value + 1)) - 1;
			_hi = @int._hi;
			_lo = @int._lo;
		}
		else
		{
			_hi = 0uL;
			_lo = (ulong)value;
		}
	}

	public Int128(sbyte value)
	{
		if (value < 0)
		{
			Int128 @int = -new Int128(-(value + 1)) - 1;
			_hi = @int._hi;
			_lo = @int._lo;
		}
		else
		{
			_hi = 0uL;
			_lo = (ulong)value;
		}
	}

	public Int128(ushort value)
	{
		_hi = 0uL;
		_lo = value;
	}

	public Int128(uint value)
	{
		_hi = 0uL;
		_lo = value;
	}

	public Int128(ulong value)
	{
		_hi = 0uL;
		_lo = value;
	}

	public Int128(Guid value)
		: this(value.ToByteArray())
	{
	}

	public Int128(byte[] value)
	{
		if (value == null)
		{
			throw new ArgumentNullException("value");
		}
		if (value.Length != 16)
		{
			throw new ArgumentException(null, "value");
		}
		_hi = BitConverter.ToUInt64(value, 8);
		_lo = BitConverter.ToUInt64(value, 0);
	}

	private Int128(ulong hi, ulong lo)
	{
		_hi = hi;
		_lo = lo;
	}

	public Int128(int sign, uint[] ints)
	{
		if (ints == null)
		{
			throw new ArgumentNullException("ints");
		}
		byte[] array = new byte[8];
		byte[] array2 = new byte[8];
		if (ints.Length != 0)
		{
			Array.Copy(BitConverter.GetBytes(ints[0]), 0, array, 0, 4);
			if (ints.Length > 1)
			{
				Array.Copy(BitConverter.GetBytes(ints[1]), 0, array, 4, 4);
				if (ints.Length > 2)
				{
					Array.Copy(BitConverter.GetBytes(ints[2]), 0, array2, 0, 4);
					if (ints.Length > 3)
					{
						Array.Copy(BitConverter.GetBytes(ints[3]), 0, array2, 4, 4);
					}
				}
			}
		}
		_lo = BitConverter.ToUInt64(array, 0);
		_hi = BitConverter.ToUInt64(array2, 0);
		if (sign < 0)
		{
			_hi |= 9223372036854775808uL;
		}
		else
		{
			_hi &= 9223372036854775807uL;
		}
	}

	public override int GetHashCode()
	{
		return _hi.GetHashCode() ^ _lo.GetHashCode();
	}

	public override bool Equals(object obj)
	{
		return base.Equals(obj);
	}

	public bool Equals(Int128 obj)
	{
		if (_hi == obj._hi)
		{
			return _lo == obj._lo;
		}
		return false;
	}

	public override string ToString()
	{
		return ToString(null, null);
	}

	public string ToString(string format)
	{
		return ToString(format, null);
	}

	public string ToString(string format, IFormatProvider formatProvider)
	{
		if (formatProvider == null)
		{
			formatProvider = CultureInfo.CurrentCulture;
		}
		if (!string.IsNullOrEmpty(format))
		{
			char c = format[0];
			switch (c)
			{
			case 'X':
			case 'x':
			{
				int.TryParse(format.Substring(1).Trim(), out var result);
				return ToHexaString(c == 'X', result);
			}
			default:
				throw new NotSupportedException("Not supported format: " + format);
			case 'D':
			case 'G':
			case 'd':
			case 'g':
				break;
			}
		}
		return ToString((NumberFormatInfo)formatProvider.GetFormat(typeof(NumberFormatInfo)));
	}

	private string ToHexaString(bool caps, int min)
	{
		StringBuilder stringBuilder = new StringBuilder();
		string text = (caps ? "X" : "x");
		if (min < 0 || min > 16 || _hi != 0L)
		{
			stringBuilder.Append((min > 16) ? _hi.ToString(text + (min - 16)) : _hi.ToString(text));
			stringBuilder.Append(_lo.ToString(text + "16"));
		}
		else
		{
			stringBuilder.Append(_lo.ToString(text + min));
		}
		return stringBuilder.ToString();
	}

	private string ToString(NumberFormatInfo info)
	{
		if (Sign == 0)
		{
			return "0";
		}
		StringBuilder stringBuilder = new StringBuilder();
		Int128 divisor = new Int128(10);
		Int128 dividend = this;
		dividend._hi &= 9223372036854775807uL;
		do
		{
			dividend = DivRem(dividend, divisor, out var remainder);
			if (remainder._lo != 0 || dividend.Sign != 0 || stringBuilder.Length == 0)
			{
				stringBuilder.Insert(0, (char)(48 + remainder._lo));
			}
		}
		while (dividend.Sign != 0);
		string text = stringBuilder.ToString();
		if (Sign < 0 && text != "0")
		{
			return info.NegativeSign + text;
		}
		return text;
	}

	TypeCode IConvertible.GetTypeCode()
	{
		return TypeCode.Object;
	}

	bool IConvertible.ToBoolean(IFormatProvider provider)
	{
		return (bool)this;
	}

	byte IConvertible.ToByte(IFormatProvider provider)
	{
		return (byte)this;
	}

	char IConvertible.ToChar(IFormatProvider provider)
	{
		return (char)this;
	}

	DateTime IConvertible.ToDateTime(IFormatProvider provider)
	{
		throw new InvalidCastException();
	}

	decimal IConvertible.ToDecimal(IFormatProvider provider)
	{
		return (decimal)this;
	}

	short IConvertible.ToInt16(IFormatProvider provider)
	{
		return (short)this;
	}

	int IConvertible.ToInt32(IFormatProvider provider)
	{
		return (int)this;
	}

	long IConvertible.ToInt64(IFormatProvider provider)
	{
		return (int)this;
	}

	sbyte IConvertible.ToSByte(IFormatProvider provider)
	{
		return (sbyte)(short)this;
	}

	float IConvertible.ToSingle(IFormatProvider provider)
	{
		return (float)this;
	}

	double IConvertible.ToDouble(IFormatProvider provider)
	{
		return (double)this;
	}

	string IConvertible.ToString(IFormatProvider provider)
	{
		return ToString(null, provider);
	}

	public bool TryConvert(Type conversionType, IFormatProvider provider, out object value)
	{
		if (conversionType == typeof(bool))
		{
			value = (bool)this;
			return true;
		}
		if (conversionType == typeof(byte))
		{
			value = (byte)this;
			return true;
		}
		if (conversionType == typeof(char))
		{
			value = (char)this;
			return true;
		}
		if (conversionType == typeof(decimal))
		{
			value = (decimal)this;
			return true;
		}
		if (conversionType == typeof(double))
		{
			value = (double)this;
			return true;
		}
		if (conversionType == typeof(short))
		{
			value = (short)this;
			return true;
		}
		if (conversionType == typeof(int))
		{
			value = (int)this;
			return true;
		}
		if (conversionType == typeof(long))
		{
			value = (long)this;
			return true;
		}
		if (conversionType == typeof(sbyte))
		{
			value = (sbyte)(short)this;
			return true;
		}
		if (conversionType == typeof(float))
		{
			value = (float)this;
			return true;
		}
		if (conversionType == typeof(string))
		{
			value = ToString(null, provider);
			return true;
		}
		if (conversionType == typeof(ushort))
		{
			value = (ushort)this;
			return true;
		}
		if (conversionType == typeof(uint))
		{
			value = (uint)this;
			return true;
		}
		if (conversionType == typeof(ulong))
		{
			value = (ulong)this;
			return true;
		}
		if (conversionType == typeof(byte[]))
		{
			value = ToByteArray();
			return true;
		}
		if (conversionType == typeof(Guid))
		{
			value = new Guid(ToByteArray());
			return true;
		}
		value = null;
		return false;
	}

	public static Int128 Parse(string value)
	{
		return Parse(value, NumberStyles.Integer, NumberFormatInfo.CurrentInfo);
	}

	public static Int128 Parse(string value, NumberStyles style)
	{
		return Parse(value, style, NumberFormatInfo.CurrentInfo);
	}

	public static Int128 Parse(string value, IFormatProvider provider)
	{
		return Parse(value, NumberStyles.Integer, NumberFormatInfo.GetInstance(provider));
	}

	public static Int128 Parse(string value, NumberStyles style, IFormatProvider provider)
	{
		if (!TryParse(value, style, provider, out var result))
		{
			throw new ArgumentException(null, "value");
		}
		return result;
	}

	public static bool TryParse(string value, out Int128 result)
	{
		return TryParse(value, NumberStyles.Integer, NumberFormatInfo.CurrentInfo, out result);
	}

	public static bool TryParse(string value, NumberStyles style, IFormatProvider provider, out Int128 result)
	{
		result = Zero;
		if (string.IsNullOrEmpty(value))
		{
			return false;
		}
		if (value.StartsWith("x", StringComparison.OrdinalIgnoreCase))
		{
			style |= NumberStyles.AllowHexSpecifier;
			value = value.Substring(1);
		}
		else if (value.StartsWith("0x", StringComparison.OrdinalIgnoreCase))
		{
			style |= NumberStyles.AllowHexSpecifier;
			value = value.Substring(2);
		}
		if ((style & NumberStyles.AllowHexSpecifier) == NumberStyles.AllowHexSpecifier)
		{
			return TryParseHex(value, out result);
		}
		return TryParseNum(value, out result);
	}

	private static bool TryParseHex(string value, out Int128 result)
	{
		if (value.Length > 32)
		{
			throw new OverflowException();
		}
		result = Zero;
		bool flag = false;
		int num = 0;
		for (int num2 = value.Length - 1; num2 >= 0; num2--)
		{
			char c = value[num2];
			ulong num3;
			if (c >= '0' && c <= '9')
			{
				num3 = (ulong)(c - 48);
			}
			else if (c >= 'A' && c <= 'F')
			{
				num3 = (ulong)(c - 65 + 10);
			}
			else
			{
				if (c < 'a' || c > 'f')
				{
					return false;
				}
				num3 = (ulong)(c - 97 + 10);
			}
			if (flag)
			{
				result._hi |= num3 << num;
				num += 4;
			}
			else
			{
				result._lo |= num3 << num;
				num += 4;
				if (num == 64)
				{
					num = 0;
					flag = true;
				}
			}
		}
		return true;
	}

	private static bool TryParseNum(string value, out Int128 result)
	{
		result = Zero;
		foreach (char c in value)
		{
			if (c >= '0' && c <= '9')
			{
				byte b = (byte)(c - 48);
				result = 10 * result;
				result += (Int128)b;
				continue;
			}
			return false;
		}
		return true;
	}

	public object ToType(Type conversionType, IFormatProvider provider)
	{
		if (TryConvert(conversionType, provider, out var value))
		{
			return value;
		}
		throw new InvalidCastException();
	}

	ushort IConvertible.ToUInt16(IFormatProvider provider)
	{
		if (_hi != 0L)
		{
			throw new OverflowException();
		}
		return Convert.ToUInt16(_lo);
	}

	uint IConvertible.ToUInt32(IFormatProvider provider)
	{
		if (_hi != 0L)
		{
			throw new OverflowException();
		}
		return Convert.ToUInt32(_lo);
	}

	ulong IConvertible.ToUInt64(IFormatProvider provider)
	{
		if (_hi != 0L)
		{
			throw new OverflowException();
		}
		return _lo;
	}

	int IComparable.CompareTo(object obj)
	{
		return Compare(this, obj);
	}

	public static int Compare(Int128 left, object right)
	{
		if (right is Int128)
		{
			return Compare(left, (Int128)right);
		}
		if (right is bool)
		{
			return Compare(left, new Int128((bool)right));
		}
		if (right is byte)
		{
			return Compare(left, new Int128((byte)right));
		}
		if (right is char)
		{
			return Compare(left, new Int128((char)right));
		}
		if (right is decimal)
		{
			return Compare(left, new Int128((decimal)right));
		}
		if (right is double)
		{
			return Compare(left, new Int128((double)right));
		}
		if (right is short)
		{
			return Compare(left, new Int128((short)right));
		}
		if (right is int)
		{
			return Compare(left, new Int128((int)right));
		}
		if (right is long)
		{
			return Compare(left, new Int128((long)right));
		}
		if (right is sbyte)
		{
			return Compare(left, new Int128((sbyte)right));
		}
		if (right is float)
		{
			return Compare(left, new Int128((float)right));
		}
		if (right is ushort)
		{
			return Compare(left, new Int128((ushort)right));
		}
		if (right is uint)
		{
			return Compare(left, new Int128((uint)right));
		}
		if (right is ulong)
		{
			return Compare(left, new Int128((ulong)right));
		}
		if (right is byte[] array && array.Length != 16)
		{
			return Compare(left, new Int128(array));
		}
		if (right is Guid)
		{
			return Compare(left, new Int128((Guid)right));
		}
		throw new ArgumentException();
	}

	public byte[] ToByteArray()
	{
		byte[] array = new byte[16];
		Buffer.BlockCopy(BitConverter.GetBytes(_lo), 0, array, 0, 8);
		Buffer.BlockCopy(BitConverter.GetBytes(_hi), 0, array, 8, 8);
		return array;
	}

	public static int Compare(Int128 left, Int128 right)
	{
		if (left.Sign < 0)
		{
			if (right.Sign >= 0)
			{
				return -1;
			}
			ulong num = left._hi & 0x7FFFFFFFFFFFFFFFL;
			ulong num2 = right._hi & 0x7FFFFFFFFFFFFFFFL;
			if (num != num2)
			{
				return -num.CompareTo(num2);
			}
			return -left._lo.CompareTo(right._lo);
		}
		if (right.Sign < 0)
		{
			return 1;
		}
		if (left._hi != right._hi)
		{
			return left._hi.CompareTo(right._hi);
		}
		return left._lo.CompareTo(right._lo);
	}

	public int CompareTo(Int128 value)
	{
		return Compare(this, value);
	}

	public static implicit operator Int128(bool value)
	{
		return new Int128(value);
	}

	public static implicit operator Int128(byte value)
	{
		return new Int128(value);
	}

	public static implicit operator Int128(char value)
	{
		return new Int128(value);
	}

	public static explicit operator Int128(decimal value)
	{
		return new Int128(value);
	}

	public static explicit operator Int128(double value)
	{
		return new Int128(value);
	}

	public static implicit operator Int128(short value)
	{
		return new Int128(value);
	}

	public static implicit operator Int128(int value)
	{
		return new Int128(value);
	}

	public static implicit operator Int128(long value)
	{
		return new Int128(value);
	}

	public static implicit operator Int128(sbyte value)
	{
		return new Int128(value);
	}

	public static explicit operator Int128(float value)
	{
		return new Int128(value);
	}

	public static implicit operator Int128(ushort value)
	{
		return new Int128(value);
	}

	public static implicit operator Int128(uint value)
	{
		return new Int128(value);
	}

	public static implicit operator Int128(ulong value)
	{
		return new Int128(value);
	}

	public static explicit operator bool(Int128 value)
	{
		return value.Sign != 0;
	}

	public static explicit operator byte(Int128 value)
	{
		if (value.Sign == 0)
		{
			return 0;
		}
		if (value.Sign < 0 || value._lo > 255)
		{
			throw new OverflowException();
		}
		return (byte)value._lo;
	}

	public static explicit operator char(Int128 value)
	{
		if (value.Sign == 0)
		{
			return '\0';
		}
		if (value.Sign < 0 || value._lo > 65535)
		{
			throw new OverflowException();
		}
		return (char)value._lo;
	}

	public static explicit operator decimal(Int128 value)
	{
		if (value.Sign == 0)
		{
			return 0m;
		}
		return new decimal((int)(value._lo & 0xFFFFFFFFu), (int)(value._lo >> 32), (int)(value._hi & 0xFFFFFFFFu), value.Sign < 0, 0);
	}

	public static explicit operator double(Int128 value)
	{
		if (value.Sign == 0)
		{
			return 0.0;
		}
		NumberFormatInfo numberFormat = CultureInfo.InvariantCulture.NumberFormat;
		if (!double.TryParse(value.ToString(numberFormat), NumberStyles.Number, numberFormat, out var result))
		{
			throw new OverflowException();
		}
		return result;
	}

	public static explicit operator float(Int128 value)
	{
		if (value.Sign == 0)
		{
			return 0f;
		}
		NumberFormatInfo numberFormat = CultureInfo.InvariantCulture.NumberFormat;
		if (!float.TryParse(value.ToString(numberFormat), NumberStyles.Number, numberFormat, out var result))
		{
			throw new OverflowException();
		}
		return result;
	}

	public static explicit operator short(Int128 value)
	{
		if (value.Sign == 0)
		{
			return 0;
		}
		if (value._lo > 32768)
		{
			throw new OverflowException();
		}
		if (value._lo == 32768 && value.Sign > 0)
		{
			throw new OverflowException();
		}
		return (short)((int)value._lo * value.Sign);
	}

	public static explicit operator int(Int128 value)
	{
		if (value.Sign == 0)
		{
			return 0;
		}
		if (value._lo > 2147483648u)
		{
			throw new OverflowException();
		}
		if (value._lo == 2147483648u && value.Sign > 0)
		{
			throw new OverflowException();
		}
		return (int)value._lo * value.Sign;
	}

	public static explicit operator long(Int128 value)
	{
		if (value.Sign == 0)
		{
			return 0L;
		}
		if (value._lo > long.MaxValue)
		{
			throw new OverflowException();
		}
		return (long)value._lo * (long)value.Sign;
	}

	public static explicit operator uint(Int128 value)
	{
		if (value.Sign == 0)
		{
			return 0u;
		}
		if (value.Sign < 0 || value._lo > uint.MaxValue)
		{
			throw new OverflowException();
		}
		return (uint)value._lo;
	}

	public static explicit operator ushort(Int128 value)
	{
		if (value.Sign == 0)
		{
			return 0;
		}
		if (value.Sign < 0 || value._lo > 65535)
		{
			throw new OverflowException();
		}
		return (ushort)value._lo;
	}

	public static explicit operator ulong(Int128 value)
	{
		if (value.Sign < 0 || value._hi != 0L)
		{
			throw new OverflowException();
		}
		return value._lo;
	}

	public static bool operator >(Int128 left, Int128 right)
	{
		return Compare(left, right) > 0;
	}

	public static bool operator <(Int128 left, Int128 right)
	{
		return Compare(left, right) < 0;
	}

	public static bool operator >=(Int128 left, Int128 right)
	{
		return Compare(left, right) >= 0;
	}

	public static bool operator <=(Int128 left, Int128 right)
	{
		return Compare(left, right) <= 0;
	}

	public static bool operator !=(Int128 left, Int128 right)
	{
		return Compare(left, right) != 0;
	}

	public static bool operator ==(Int128 left, Int128 right)
	{
		return Compare(left, right) == 0;
	}

	public static Int128 operator +(Int128 value)
	{
		return value;
	}

	public static Int128 operator -(Int128 value)
	{
		return Negate(value);
	}

	public static Int128 Negate(Int128 value)
	{
		return new Int128(~value._hi, ~value._lo) + 1;
	}

	public Int128 ToAbs()
	{
		return Abs(this);
	}

	public static Int128 Abs(Int128 value)
	{
		if (value.Sign < 0)
		{
			return -value;
		}
		return value;
	}

	public static Int128 operator +(Int128 left, Int128 right)
	{
		Int128 result = left;
		result._hi += right._hi;
		result._lo += right._lo;
		if (result._lo < left._lo)
		{
			result._hi++;
		}
		return result;
	}

	public static Int128 operator -(Int128 left, Int128 right)
	{
		return left + -right;
	}

	public static Int128 Add(Int128 left, Int128 right)
	{
		return left + right;
	}

	public static Int128 Subtract(Int128 left, Int128 right)
	{
		return left - right;
	}

	public static Int128 Divide(Int128 dividend, Int128 divisor)
	{
		Int128 remainder;
		return DivRem(dividend, divisor, out remainder);
	}

	public static Int128 DivRem(Int128 dividend, Int128 divisor, out Int128 remainder)
	{
		if (divisor == 0)
		{
			throw new DivideByZeroException();
		}
		DivRem(dividend.ToUIn32Array(), divisor.ToUIn32Array(), out var quotient, out var remainder2);
		remainder = new Int128(1, remainder2);
		return new Int128(dividend.Sign * divisor.Sign, quotient);
	}

	private static void DivRem(uint[] dividend, uint[] divisor, out uint[] quotient, out uint[] remainder)
	{
		int length = GetLength(divisor);
		int length2 = GetLength(dividend);
		if (length <= 1)
		{
			ulong num = 0uL;
			uint num2 = divisor[0];
			quotient = new uint[length2];
			remainder = new uint[1];
			for (int num3 = length2 - 1; num3 >= 0; num3--)
			{
				num *= 4294967296L;
				num += dividend[num3];
				ulong num4 = num / num2;
				num -= num4 * num2;
				quotient[num3] = (uint)num4;
			}
			remainder[0] = (uint)num;
		}
		else if (length2 >= length)
		{
			int normalizeShift = GetNormalizeShift(divisor[length - 1]);
			uint[] array = new uint[length2 + 1];
			uint[] array2 = new uint[length];
			Normalize(dividend, length2, array, normalizeShift);
			Normalize(divisor, length, array2, normalizeShift);
			quotient = new uint[length2 - length + 1];
			for (int num5 = length2 - length; num5 >= 0; num5--)
			{
				ulong num6 = (ulong)(4294967296L * (long)array[num5 + length] + array[num5 + length - 1]);
				ulong num7 = num6 / array2[length - 1];
				num6 -= num7 * array2[length - 1];
				while (num7 >= 4294967296L || num7 * array2[length - 2] > num6 * 4294967296L + array[num5 + length - 2])
				{
					num7--;
					num6 += array2[length - 1];
					if (num6 >= 4294967296L)
					{
						break;
					}
				}
				long num8 = 0L;
				long num10;
				for (int i = 0; i < length; i++)
				{
					ulong num9 = array2[i] * num7;
					num10 = (uint)((int)array[i + num5] - (int)num9) - num8;
					array[i + num5] = (uint)num10;
					num9 >>= 32;
					num10 >>= 32;
					num8 = (long)num9 - num10;
				}
				num10 = array[num5 + length] - num8;
				array[num5 + length] = (uint)num10;
				quotient[num5] = (uint)num7;
				if (num10 < 0)
				{
					quotient[num5]--;
					ulong num11 = 0uL;
					for (int i = 0; i < length; i++)
					{
						num11 = array2[i] + array[num5 + i] + num11;
						array[num5 + i] = (uint)num11;
						num11 >>= 32;
					}
					num11 += array[num5 + length];
					array[num5 + length] = (uint)num11;
				}
			}
			remainder = Unnormalize(array, normalizeShift);
		}
		else
		{
			quotient = new uint[0];
			remainder = dividend;
		}
	}

	private static int GetLength(uint[] uints)
	{
		int num = uints.Length - 1;
		while (num >= 0 && uints[num] == 0)
		{
			num--;
		}
		return num + 1;
	}

	private static int GetNormalizeShift(uint ui)
	{
		int num = 0;
		if ((ui & 0xFFFF0000u) == 0)
		{
			ui <<= 16;
			num += 16;
		}
		if ((ui & 0xFF000000u) == 0)
		{
			ui <<= 8;
			num += 8;
		}
		if ((ui & 0xF0000000u) == 0)
		{
			ui <<= 4;
			num += 4;
		}
		if ((ui & 0xC0000000u) == 0)
		{
			ui <<= 2;
			num += 2;
		}
		if ((ui & 0x80000000u) == 0)
		{
			num++;
		}
		return num;
	}

	private static uint[] Unnormalize(uint[] normalized, int shift)
	{
		int length = GetLength(normalized);
		uint[] array = new uint[length];
		if (shift > 0)
		{
			int num = 32 - shift;
			uint num2 = 0u;
			for (int num3 = length - 1; num3 >= 0; num3--)
			{
				array[num3] = (normalized[num3] >> shift) | num2;
				num2 = normalized[num3] << num;
			}
		}
		else
		{
			for (int i = 0; i < length; i++)
			{
				array[i] = normalized[i];
			}
		}
		return array;
	}

	private static void Normalize(uint[] unormalized, int len, uint[] normalized, int shift)
	{
		uint num = 0u;
		int i;
		if (shift > 0)
		{
			int num2 = 32 - shift;
			for (i = 0; i < len; i++)
			{
				normalized[i] = (unormalized[i] << shift) | num;
				num = unormalized[i] >> num2;
			}
		}
		else
		{
			for (i = 0; i < len; i++)
			{
				normalized[i] = unormalized[i];
			}
		}
		while (i < normalized.Length)
		{
			normalized[i++] = 0u;
		}
		if (num != 0)
		{
			normalized[len] = num;
		}
	}

	public static Int128 Remainder(Int128 dividend, Int128 divisor)
	{
		DivRem(dividend, divisor, out var remainder);
		return remainder;
	}

	public static Int128 operator %(Int128 dividend, Int128 divisor)
	{
		return Remainder(dividend, divisor);
	}

	public static Int128 operator /(Int128 dividend, Int128 divisor)
	{
		return Divide(dividend, divisor);
	}

	public ulong[] ToUIn64Array()
	{
		return new ulong[2] { _hi, _lo };
	}

	public uint[] ToUIn32Array()
	{
		uint[] array = new uint[4];
		byte[] bytes = BitConverter.GetBytes(_lo);
		byte[] bytes2 = BitConverter.GetBytes(_hi);
		Buffer.BlockCopy(bytes, 0, array, 0, 4);
		Buffer.BlockCopy(bytes, 4, array, 4, 4);
		Buffer.BlockCopy(bytes2, 0, array, 8, 4);
		Buffer.BlockCopy(bytes2, 4, array, 12, 4);
		return array;
	}

	public static Int128 Multiply(Int128 left, Int128 right)
	{
		uint[] array = left.ToUIn32Array();
		uint[] array2 = right.ToUIn32Array();
		uint[] array3 = new uint[8];
		for (int i = 0; i < array.Length; i++)
		{
			int num = i;
			ulong num2 = 0uL;
			uint[] array4 = array2;
			foreach (uint num3 in array4)
			{
				num2 = (ulong)((long)num2 + (long)array[i] * (long)num3 + array3[num]);
				array3[num++] = (uint)num2;
				num2 >>= 32;
			}
			while (num2 != 0L)
			{
				num2 += array3[num];
				array3[num++] = (uint)num2;
				num2 >>= 32;
			}
		}
		return new Int128(left.Sign * right.Sign, array3);
	}

	public static Int128 operator *(Int128 left, Int128 right)
	{
		return Multiply(left, right);
	}

	public static Int128 operator >>(Int128 value, int shift)
	{
		if (shift == 0)
		{
			return value;
		}
		if (shift < 0)
		{
			return value << -shift;
		}
		shift %= 128;
		Int128 result = default(Int128);
		if (shift > 63)
		{
			result._lo = value._hi >> shift - 64;
			result._hi = 0uL;
		}
		else
		{
			result._hi = value._hi >> shift;
			result._lo = (value._hi << 64 - shift) | (value._lo >> shift);
		}
		return result;
	}

	public static Int128 operator <<(Int128 value, int shift)
	{
		if (shift == 0)
		{
			return value;
		}
		if (shift < 0)
		{
			return value >> -shift;
		}
		shift %= 128;
		Int128 result = default(Int128);
		if (shift > 63)
		{
			result._hi = value._lo << shift - 64;
			result._lo = 0uL;
		}
		else
		{
			ulong num = value._lo >> 64 - shift;
			result._hi = num | (value._hi << shift);
			result._lo = value._lo << shift;
		}
		return result;
	}

	public static Int128 operator |(Int128 left, Int128 right)
	{
		if (left == 0)
		{
			return right;
		}
		if (right == 0)
		{
			return left;
		}
		Int128 result = left;
		result._hi |= right._hi;
		result._lo |= right._lo;
		return result;
	}

	public static Int128 operator &(Int128 left, Int128 right)
	{
		if (left == 0 || right == 0)
		{
			return Zero;
		}
		Int128 result = left;
		result._hi &= right._hi;
		result._lo &= right._lo;
		return result;
	}
}
