using System.Globalization;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

namespace System;

public static class Convert
{
	private static readonly sbyte[] s_decodingMap = new sbyte[256]
	{
		96, 31, 97, 31, 98, 31, 99, 31, 100, 31,
		101, 31, 102, 31, 103, 31, 112, 31, 113, 31,
		114, 31, 115, 31, 116, 31, 117, 31, 118, 31,
		119, 31, 120, 31, 121, 31, 122, 31, 123, 31,
		124, 31, 125, 31, 126, 31, 127, 31, -128, 31,
		-127, 31, -126, 31, -125, 31, -124, 31, -123, 31,
		-122, 31, -121, 31, -128, 31, -127, 31, -126, 31,
		-125, 31, -124, 31, -123, 31, -122, 31, -121, 31,
		-112, 31, -111, 31, -110, 31, -109, 31, -108, 31,
		-107, 31, -106, 31, -105, 31, -112, 31, -111, 31,
		-110, 31, -109, 31, -108, 31, -107, 31, -106, 31,
		-105, 31, -96, 31, -95, 31, -94, 31, -93, 31,
		-92, 31, -91, 31, -90, 31, -89, 31, -96, 31,
		-95, 31, -94, 31, -93, 31, -92, 31, -91, 31,
		-90, 31, -89, 31, -80, 31, -79, 31, -78, 31,
		-77, 31, -76, 31, -75, 31, -74, 31, -73, 31,
		-80, 31, -79, 31, 112, 31, 113, 31, -77, 31,
		-67, 31, -66, 31, -65, 31, -64, 31, -63, 31,
		-62, 31, -61, 31, -60, 31, -59, 31, -58, 31,
		-57, 31, 114, 31, 115, 31, 116, 31, 117, 31,
		-61, 31, -51, 31, -50, 31, -49, 31, -48, 31,
		-47, 31, -46, 31, -45, 31, -44, 31, -43, 31,
		-42, 31, -41, 31, -48, 31, -47, 31, 118, 31,
		119, 31, -36, 31, -35, 31, -34, 31, -33, 31,
		-32, 31, -31, 31, -30, 31, -29, 31, -28, 31,
		-27, 31, -26, 31, -25, 31
	};

	private const byte EncodingPad = 61;

	internal static readonly Type[] ConvertTypes = new Type[19]
	{
		typeof(Empty),
		typeof(object),
		typeof(DBNull),
		typeof(bool),
		typeof(char),
		typeof(sbyte),
		typeof(byte),
		typeof(short),
		typeof(ushort),
		typeof(int),
		typeof(uint),
		typeof(long),
		typeof(ulong),
		typeof(float),
		typeof(double),
		typeof(decimal),
		typeof(DateTime),
		typeof(object),
		typeof(string)
	};

	private static readonly Type EnumType = typeof(Enum);

	internal static readonly char[] base64Table = new char[65]
	{
		'\0', 'ᰀ', '\0', '甀', '\0', '\udf00', '\0', '渀', '\0', '䜀',
		'\0', '\uf100', '\0', 'ᨀ', '\0', '焀', '\0', 'ᴀ', '\0', '⤀',
		'\0', '씀', '\0', '褀', '\0', '漀', '\0', '뜀', '\0', '戀',
		'\0', '\u0e00', '\0', 'ꨀ', '\0', '᠀', '\0', '븀', '\0', '\u1b00',
		'\0', 'ﰀ', '\0', '嘀', '\0', '㸀', '\0', '䬀', '\0', '였',
		'\0', '툀', '\0', '礀', '\0', '\u2000', '\0', '騀', '\0', '\udb00',
		'\0', '쀀', '\0', '\ufe00', '\0'
	};

	private const int base64LineBreakPosition = 76;

	public static readonly object DBNull = System.DBNull.Value;

	private static bool TryDecodeFromUtf16(ReadOnlySpan<char> utf16, Span<byte> bytes, out int consumed, out int written)
	{
		ref char reference = ref MemoryMarshal.GetReference(utf16);
		ref byte reference2 = ref MemoryMarshal.GetReference(bytes);
		int num = utf16.Length & -4;
		int length = bytes.Length;
		int num2 = 0;
		int num3 = 0;
		if (utf16.Length != 0)
		{
			ref sbyte reference3 = ref s_decodingMap[0];
			int num4 = ((length < (num >> 2) * 3) ? (length / 3 * 4) : (num - 4));
			while (true)
			{
				if (num2 < num4)
				{
					int num5 = Decode(ref Unsafe.Add(ref reference, num2), ref reference3);
					if (num5 >= 0)
					{
						WriteThreeLowOrderBytes(ref Unsafe.Add(ref reference2, num3), num5);
						num3 += 3;
						num2 += 4;
						continue;
					}
				}
				else if (num4 == num - 4 && num2 != num)
				{
					int num6 = Unsafe.Add(ref reference, num - 4);
					int num7 = Unsafe.Add(ref reference, num - 3);
					int num8 = Unsafe.Add(ref reference, num - 2);
					int num9 = Unsafe.Add(ref reference, num - 1);
					if (((num6 | num7 | num8 | num9) & 0xFFFFFF00u) == 0L)
					{
						num6 = Unsafe.Add(ref reference3, num6);
						num7 = Unsafe.Add(ref reference3, num7);
						num6 <<= 18;
						num7 <<= 12;
						num6 |= num7;
						if (num9 != 61)
						{
							num8 = Unsafe.Add(ref reference3, num8);
							num9 = Unsafe.Add(ref reference3, num9);
							num8 <<= 6;
							num6 |= num9;
							num6 |= num8;
							if (num6 >= 0 && num3 <= length - 3)
							{
								WriteThreeLowOrderBytes(ref Unsafe.Add(ref reference2, num3), num6);
								num3 += 3;
								goto IL_01e7;
							}
						}
						else if (num8 != 61)
						{
							num8 = Unsafe.Add(ref reference3, num8);
							num8 <<= 6;
							num6 |= num8;
							if (num6 >= 0 && num3 <= length - 2)
							{
								Unsafe.Add(ref reference2, num3) = (byte)(num6 >> 16);
								Unsafe.Add(ref reference2, num3 + 1) = (byte)(num6 >> 8);
								num3 += 2;
								goto IL_01e7;
							}
						}
						else if (num6 >= 0 && num3 <= length - 1)
						{
							Unsafe.Add(ref reference2, num3) = (byte)(num6 >> 16);
							num3++;
							goto IL_01e7;
						}
					}
				}
				goto IL_0201;
				IL_0201:
				consumed = num2;
				written = num3;
				return false;
				IL_01e7:
				num2 += 4;
				if (num == utf16.Length)
				{
					break;
				}
				goto IL_0201;
			}
		}
		consumed = num2;
		written = num3;
		return true;
	}

	[MethodImpl((MethodImplOptions)256)]
	private static int Decode(ref char encodedChars, ref sbyte decodingMap)
	{
		int num = encodedChars;
		int num2 = Unsafe.Add(ref encodedChars, 1);
		int num3 = Unsafe.Add(ref encodedChars, 2);
		int num4 = Unsafe.Add(ref encodedChars, 3);
		if (((num | num2 | num3 | num4) & 0xFFFFFF00u) != 0L)
		{
			return -1;
		}
		num = Unsafe.Add(ref decodingMap, num);
		num2 = Unsafe.Add(ref decodingMap, num2);
		num3 = Unsafe.Add(ref decodingMap, num3);
		num4 = Unsafe.Add(ref decodingMap, num4);
		num <<= 18;
		num2 <<= 12;
		num3 <<= 6;
		num |= num4;
		num2 |= num3;
		return num | num2;
	}

	[MethodImpl((MethodImplOptions)256)]
	private static void WriteThreeLowOrderBytes(ref byte destination, int value)
	{
		destination = (byte)(value >> 16);
		Unsafe.Add(ref destination, 1) = (byte)(value >> 8);
		Unsafe.Add(ref destination, 2) = (byte)value;
	}

	public static TypeCode GetTypeCode(object value)
	{
		if (value == null)
		{
			return TypeCode.Empty;
		}
		if (value is IConvertible convertible)
		{
			return convertible.GetTypeCode();
		}
		return TypeCode.Object;
	}

	public static bool IsDBNull(object value)
	{
		if (value == System.DBNull.Value)
		{
			return true;
		}
		if (!(value is IConvertible convertible))
		{
			return false;
		}
		return convertible.GetTypeCode() == TypeCode.DBNull;
	}

	public static object ChangeType(object value, TypeCode typeCode)
	{
		return ChangeType(value, typeCode, CultureInfo.CurrentCulture);
	}

	public static object ChangeType(object value, TypeCode typeCode, IFormatProvider provider)
	{
		if (value == null && (typeCode == TypeCode.Empty || typeCode == TypeCode.String || typeCode == TypeCode.Object))
		{
			return null;
		}
		if (!(value is IConvertible convertible))
		{
			throw new InvalidCastException("Object must implement IConvertible.");
		}
		return typeCode switch
		{
			TypeCode.Boolean => convertible.ToBoolean(provider), 
			TypeCode.Char => convertible.ToChar(provider), 
			TypeCode.SByte => convertible.ToSByte(provider), 
			TypeCode.Byte => convertible.ToByte(provider), 
			TypeCode.Int16 => convertible.ToInt16(provider), 
			TypeCode.UInt16 => convertible.ToUInt16(provider), 
			TypeCode.Int32 => convertible.ToInt32(provider), 
			TypeCode.UInt32 => convertible.ToUInt32(provider), 
			TypeCode.Int64 => convertible.ToInt64(provider), 
			TypeCode.UInt64 => convertible.ToUInt64(provider), 
			TypeCode.Single => convertible.ToSingle(provider), 
			TypeCode.Double => convertible.ToDouble(provider), 
			TypeCode.Decimal => convertible.ToDecimal(provider), 
			TypeCode.DateTime => convertible.ToDateTime(provider), 
			TypeCode.String => convertible.ToString(provider), 
			TypeCode.Object => value, 
			TypeCode.DBNull => throw new InvalidCastException("Object cannot be cast to DBNull."), 
			TypeCode.Empty => throw new InvalidCastException("Object cannot be cast to Empty."), 
			_ => throw new ArgumentException("Unknown TypeCode value."), 
		};
	}

	internal static object DefaultToType(IConvertible value, Type targetType, IFormatProvider provider)
	{
		if (targetType == null)
		{
			throw new ArgumentNullException("targetType");
		}
		if ((object)value.GetType() == targetType)
		{
			return value;
		}
		if ((object)targetType == ConvertTypes[3])
		{
			return value.ToBoolean(provider);
		}
		if ((object)targetType == ConvertTypes[4])
		{
			return value.ToChar(provider);
		}
		if ((object)targetType == ConvertTypes[5])
		{
			return value.ToSByte(provider);
		}
		if ((object)targetType == ConvertTypes[6])
		{
			return value.ToByte(provider);
		}
		if ((object)targetType == ConvertTypes[7])
		{
			return value.ToInt16(provider);
		}
		if ((object)targetType == ConvertTypes[8])
		{
			return value.ToUInt16(provider);
		}
		if ((object)targetType == ConvertTypes[9])
		{
			return value.ToInt32(provider);
		}
		if ((object)targetType == ConvertTypes[10])
		{
			return value.ToUInt32(provider);
		}
		if ((object)targetType == ConvertTypes[11])
		{
			return value.ToInt64(provider);
		}
		if ((object)targetType == ConvertTypes[12])
		{
			return value.ToUInt64(provider);
		}
		if ((object)targetType == ConvertTypes[13])
		{
			return value.ToSingle(provider);
		}
		if ((object)targetType == ConvertTypes[14])
		{
			return value.ToDouble(provider);
		}
		if ((object)targetType == ConvertTypes[15])
		{
			return value.ToDecimal(provider);
		}
		if ((object)targetType == ConvertTypes[16])
		{
			return value.ToDateTime(provider);
		}
		if ((object)targetType == ConvertTypes[18])
		{
			return value.ToString(provider);
		}
		if ((object)targetType == ConvertTypes[1])
		{
			return value;
		}
		if ((object)targetType == EnumType)
		{
			return (Enum)value;
		}
		if ((object)targetType == ConvertTypes[2])
		{
			throw new InvalidCastException("Object cannot be cast to DBNull.");
		}
		if ((object)targetType == ConvertTypes[0])
		{
			throw new InvalidCastException("Object cannot be cast to Empty.");
		}
		throw new InvalidCastException($"Invalid cast from '{value.GetType().FullName}' to '{targetType.FullName}'.");
	}

	public static object ChangeType(object value, Type conversionType)
	{
		return ChangeType(value, conversionType, CultureInfo.CurrentCulture);
	}

	public static object ChangeType(object value, Type conversionType, IFormatProvider provider)
	{
		if ((object)conversionType == null)
		{
			throw new ArgumentNullException("conversionType");
		}
		if (value == null)
		{
			if (conversionType.IsValueType)
			{
				throw new InvalidCastException("Null object cannot be converted to a value type.");
			}
			return null;
		}
		if (!(value is IConvertible convertible))
		{
			if (value.GetType() == conversionType)
			{
				return value;
			}
			throw new InvalidCastException("Object must implement IConvertible.");
		}
		if ((object)conversionType == ConvertTypes[3])
		{
			return convertible.ToBoolean(provider);
		}
		if ((object)conversionType == ConvertTypes[4])
		{
			return convertible.ToChar(provider);
		}
		if ((object)conversionType == ConvertTypes[5])
		{
			return convertible.ToSByte(provider);
		}
		if ((object)conversionType == ConvertTypes[6])
		{
			return convertible.ToByte(provider);
		}
		if ((object)conversionType == ConvertTypes[7])
		{
			return convertible.ToInt16(provider);
		}
		if ((object)conversionType == ConvertTypes[8])
		{
			return convertible.ToUInt16(provider);
		}
		if ((object)conversionType == ConvertTypes[9])
		{
			return convertible.ToInt32(provider);
		}
		if ((object)conversionType == ConvertTypes[10])
		{
			return convertible.ToUInt32(provider);
		}
		if ((object)conversionType == ConvertTypes[11])
		{
			return convertible.ToInt64(provider);
		}
		if ((object)conversionType == ConvertTypes[12])
		{
			return convertible.ToUInt64(provider);
		}
		if ((object)conversionType == ConvertTypes[13])
		{
			return convertible.ToSingle(provider);
		}
		if ((object)conversionType == ConvertTypes[14])
		{
			return convertible.ToDouble(provider);
		}
		if ((object)conversionType == ConvertTypes[15])
		{
			return convertible.ToDecimal(provider);
		}
		if ((object)conversionType == ConvertTypes[16])
		{
			return convertible.ToDateTime(provider);
		}
		if ((object)conversionType == ConvertTypes[18])
		{
			return convertible.ToString(provider);
		}
		if ((object)conversionType == ConvertTypes[1])
		{
			return value;
		}
		return convertible.ToType(conversionType, provider);
	}

	[MethodImpl((MethodImplOptions)8)]
	private static void ThrowCharOverflowException()
	{
		throw new OverflowException("Value was either too large or too small for a character.");
	}

	[MethodImpl((MethodImplOptions)8)]
	private static void ThrowByteOverflowException()
	{
		throw new OverflowException("Value was either too large or too small for an unsigned byte.");
	}

	[MethodImpl((MethodImplOptions)8)]
	private static void ThrowSByteOverflowException()
	{
		throw new OverflowException("Value was either too large or too small for a signed byte.");
	}

	[MethodImpl((MethodImplOptions)8)]
	private static void ThrowInt16OverflowException()
	{
		throw new OverflowException("Value was either too large or too small for an Int16.");
	}

	[MethodImpl((MethodImplOptions)8)]
	private static void ThrowUInt16OverflowException()
	{
		throw new OverflowException("Value was either too large or too small for a UInt16.");
	}

	[MethodImpl((MethodImplOptions)8)]
	private static void ThrowInt32OverflowException()
	{
		throw new OverflowException("Value was either too large or too small for an Int32.");
	}

	[MethodImpl((MethodImplOptions)8)]
	private static void ThrowUInt32OverflowException()
	{
		throw new OverflowException("Value was either too large or too small for a UInt32.");
	}

	[MethodImpl((MethodImplOptions)8)]
	private static void ThrowInt64OverflowException()
	{
		throw new OverflowException("Value was either too large or too small for an Int64.");
	}

	[MethodImpl((MethodImplOptions)8)]
	private static void ThrowUInt64OverflowException()
	{
		throw new OverflowException("Value was either too large or too small for a UInt64.");
	}

	public static bool ToBoolean(object value)
	{
		if (value != null)
		{
			return ((IConvertible)value).ToBoolean(null);
		}
		return false;
	}

	public static bool ToBoolean(object value, IFormatProvider provider)
	{
		if (value != null)
		{
			return ((IConvertible)value).ToBoolean(provider);
		}
		return false;
	}

	public static bool ToBoolean(bool value)
	{
		return value;
	}

	[CLSCompliant(false)]
	public static bool ToBoolean(sbyte value)
	{
		return value != 0;
	}

	public static bool ToBoolean(char value)
	{
		return ((IConvertible)value).ToBoolean((IFormatProvider)null);
	}

	public static bool ToBoolean(byte value)
	{
		return value != 0;
	}

	public static bool ToBoolean(short value)
	{
		return value != 0;
	}

	[CLSCompliant(false)]
	public static bool ToBoolean(ushort value)
	{
		return value != 0;
	}

	public static bool ToBoolean(int value)
	{
		return value != 0;
	}

	[CLSCompliant(false)]
	public static bool ToBoolean(uint value)
	{
		return value != 0;
	}

	public static bool ToBoolean(long value)
	{
		return value != 0;
	}

	[CLSCompliant(false)]
	public static bool ToBoolean(ulong value)
	{
		return value != 0;
	}

	public static bool ToBoolean(string value)
	{
		if (value == null)
		{
			return false;
		}
		return bool.Parse(value);
	}

	public static bool ToBoolean(string value, IFormatProvider provider)
	{
		if (value == null)
		{
			return false;
		}
		return bool.Parse(value);
	}

	public static bool ToBoolean(float value)
	{
		return value != 0f;
	}

	public static bool ToBoolean(double value)
	{
		return value != 0.0;
	}

	public static bool ToBoolean(decimal value)
	{
		return value != 0m;
	}

	public static bool ToBoolean(DateTime value)
	{
		return ((IConvertible)value).ToBoolean((IFormatProvider)null);
	}

	public static char ToChar(object value)
	{
		if (value != null)
		{
			return ((IConvertible)value).ToChar(null);
		}
		return '\0';
	}

	public static char ToChar(object value, IFormatProvider provider)
	{
		if (value != null)
		{
			return ((IConvertible)value).ToChar(provider);
		}
		return '\0';
	}

	public static char ToChar(bool value)
	{
		return ((IConvertible)value).ToChar((IFormatProvider)null);
	}

	public static char ToChar(char value)
	{
		return value;
	}

	[CLSCompliant(false)]
	public static char ToChar(sbyte value)
	{
		if (value < 0)
		{
			ThrowCharOverflowException();
		}
		return (char)value;
	}

	public static char ToChar(byte value)
	{
		return (char)value;
	}

	public static char ToChar(short value)
	{
		if (value < 0)
		{
			ThrowCharOverflowException();
		}
		return (char)value;
	}

	[CLSCompliant(false)]
	public static char ToChar(ushort value)
	{
		return (char)value;
	}

	public static char ToChar(int value)
	{
		if (value < 0 || value > 65535)
		{
			ThrowCharOverflowException();
		}
		return (char)value;
	}

	[CLSCompliant(false)]
	public static char ToChar(uint value)
	{
		if (value > 65535)
		{
			ThrowCharOverflowException();
		}
		return (char)value;
	}

	public static char ToChar(long value)
	{
		if (value < 0 || value > 65535)
		{
			ThrowCharOverflowException();
		}
		return (char)value;
	}

	[CLSCompliant(false)]
	public static char ToChar(ulong value)
	{
		if (value > 65535)
		{
			ThrowCharOverflowException();
		}
		return (char)value;
	}

	public static char ToChar(string value)
	{
		return ToChar(value, null);
	}

	public static char ToChar(string value, IFormatProvider provider)
	{
		if (value == null)
		{
			throw new ArgumentNullException("value");
		}
		if (value.Length != 1)
		{
			throw new FormatException("String must be exactly one character long.");
		}
		return value[0];
	}

	public static char ToChar(float value)
	{
		return ((IConvertible)value).ToChar((IFormatProvider)null);
	}

	public static char ToChar(double value)
	{
		return ((IConvertible)value).ToChar((IFormatProvider)null);
	}

	public static char ToChar(decimal value)
	{
		return ((IConvertible)value).ToChar((IFormatProvider)null);
	}

	public static char ToChar(DateTime value)
	{
		return ((IConvertible)value).ToChar((IFormatProvider)null);
	}

	[CLSCompliant(false)]
	public static sbyte ToSByte(object value)
	{
		if (value != null)
		{
			return ((IConvertible)value).ToSByte(null);
		}
		return 0;
	}

	[CLSCompliant(false)]
	public static sbyte ToSByte(object value, IFormatProvider provider)
	{
		if (value != null)
		{
			return ((IConvertible)value).ToSByte(provider);
		}
		return 0;
	}

	[CLSCompliant(false)]
	public static sbyte ToSByte(bool value)
	{
		if (!value)
		{
			return 0;
		}
		return 1;
	}

	[CLSCompliant(false)]
	public static sbyte ToSByte(sbyte value)
	{
		return value;
	}

	[CLSCompliant(false)]
	public static sbyte ToSByte(char value)
	{
		if (value > '\u007f')
		{
			ThrowSByteOverflowException();
		}
		return (sbyte)value;
	}

	[CLSCompliant(false)]
	public static sbyte ToSByte(byte value)
	{
		if (value > 127)
		{
			ThrowSByteOverflowException();
		}
		return (sbyte)value;
	}

	[CLSCompliant(false)]
	public static sbyte ToSByte(short value)
	{
		if (value < -128 || value > 127)
		{
			ThrowSByteOverflowException();
		}
		return (sbyte)value;
	}

	[CLSCompliant(false)]
	public static sbyte ToSByte(ushort value)
	{
		if (value > 127)
		{
			ThrowSByteOverflowException();
		}
		return (sbyte)value;
	}

	[CLSCompliant(false)]
	public static sbyte ToSByte(int value)
	{
		if (value < -128 || value > 127)
		{
			ThrowSByteOverflowException();
		}
		return (sbyte)value;
	}

	[CLSCompliant(false)]
	public static sbyte ToSByte(uint value)
	{
		if ((long)value > 127L)
		{
			ThrowSByteOverflowException();
		}
		return (sbyte)value;
	}

	[CLSCompliant(false)]
	public static sbyte ToSByte(long value)
	{
		if (value < -128 || value > 127)
		{
			ThrowSByteOverflowException();
		}
		return (sbyte)value;
	}

	[CLSCompliant(false)]
	public static sbyte ToSByte(ulong value)
	{
		if (value > 127)
		{
			ThrowSByteOverflowException();
		}
		return (sbyte)value;
	}

	[CLSCompliant(false)]
	public static sbyte ToSByte(float value)
	{
		return ToSByte((double)value);
	}

	[CLSCompliant(false)]
	public static sbyte ToSByte(double value)
	{
		return ToSByte(ToInt32(value));
	}

	[CLSCompliant(false)]
	public static sbyte ToSByte(decimal value)
	{
		return decimal.ToSByte(decimal.Round(value, 0));
	}

	[CLSCompliant(false)]
	public static sbyte ToSByte(string value)
	{
		if (value == null)
		{
			return 0;
		}
		return sbyte.Parse(value, CultureInfo.CurrentCulture);
	}

	[CLSCompliant(false)]
	public static sbyte ToSByte(string value, IFormatProvider provider)
	{
		return sbyte.Parse(value, NumberStyles.Integer, provider);
	}

	[CLSCompliant(false)]
	public static sbyte ToSByte(DateTime value)
	{
		return ((IConvertible)value).ToSByte((IFormatProvider)null);
	}

	public static byte ToByte(object value)
	{
		if (value != null)
		{
			return ((IConvertible)value).ToByte(null);
		}
		return 0;
	}

	public static byte ToByte(object value, IFormatProvider provider)
	{
		if (value != null)
		{
			return ((IConvertible)value).ToByte(provider);
		}
		return 0;
	}

	public static byte ToByte(bool value)
	{
		if (!value)
		{
			return 0;
		}
		return 1;
	}

	public static byte ToByte(byte value)
	{
		return value;
	}

	public static byte ToByte(char value)
	{
		if (value > 'ÿ')
		{
			ThrowByteOverflowException();
		}
		return (byte)value;
	}

	[CLSCompliant(false)]
	public static byte ToByte(sbyte value)
	{
		if (value < 0)
		{
			ThrowByteOverflowException();
		}
		return (byte)value;
	}

	public static byte ToByte(short value)
	{
		if (value < 0 || value > 255)
		{
			ThrowByteOverflowException();
		}
		return (byte)value;
	}

	[CLSCompliant(false)]
	public static byte ToByte(ushort value)
	{
		if (value > 255)
		{
			ThrowByteOverflowException();
		}
		return (byte)value;
	}

	public static byte ToByte(int value)
	{
		if (value < 0 || value > 255)
		{
			ThrowByteOverflowException();
		}
		return (byte)value;
	}

	[CLSCompliant(false)]
	public static byte ToByte(uint value)
	{
		if (value > 255)
		{
			ThrowByteOverflowException();
		}
		return (byte)value;
	}

	public static byte ToByte(long value)
	{
		if (value < 0 || value > 255)
		{
			ThrowByteOverflowException();
		}
		return (byte)value;
	}

	[CLSCompliant(false)]
	public static byte ToByte(ulong value)
	{
		if (value > 255)
		{
			ThrowByteOverflowException();
		}
		return (byte)value;
	}

	public static byte ToByte(float value)
	{
		return ToByte((double)value);
	}

	public static byte ToByte(double value)
	{
		return ToByte(ToInt32(value));
	}

	public static byte ToByte(decimal value)
	{
		return decimal.ToByte(decimal.Round(value, 0));
	}

	public static byte ToByte(string value)
	{
		if (value == null)
		{
			return 0;
		}
		return byte.Parse(value, CultureInfo.CurrentCulture);
	}

	public static byte ToByte(string value, IFormatProvider provider)
	{
		if (value == null)
		{
			return 0;
		}
		return byte.Parse(value, NumberStyles.Integer, provider);
	}

	public static byte ToByte(DateTime value)
	{
		return ((IConvertible)value).ToByte((IFormatProvider)null);
	}

	public static short ToInt16(object value)
	{
		if (value != null)
		{
			return ((IConvertible)value).ToInt16(null);
		}
		return 0;
	}

	public static short ToInt16(object value, IFormatProvider provider)
	{
		if (value != null)
		{
			return ((IConvertible)value).ToInt16(provider);
		}
		return 0;
	}

	public static short ToInt16(bool value)
	{
		if (!value)
		{
			return 0;
		}
		return 1;
	}

	public static short ToInt16(char value)
	{
		if (value > '翿')
		{
			ThrowInt16OverflowException();
		}
		return (short)value;
	}

	[CLSCompliant(false)]
	public static short ToInt16(sbyte value)
	{
		return value;
	}

	public static short ToInt16(byte value)
	{
		return value;
	}

	[CLSCompliant(false)]
	public static short ToInt16(ushort value)
	{
		if (value > 32767)
		{
			ThrowInt16OverflowException();
		}
		return (short)value;
	}

	public static short ToInt16(int value)
	{
		if (value < -32768 || value > 32767)
		{
			ThrowInt16OverflowException();
		}
		return (short)value;
	}

	[CLSCompliant(false)]
	public static short ToInt16(uint value)
	{
		if ((long)value > 32767L)
		{
			ThrowInt16OverflowException();
		}
		return (short)value;
	}

	public static short ToInt16(short value)
	{
		return value;
	}

	public static short ToInt16(long value)
	{
		if (value < -32768 || value > 32767)
		{
			ThrowInt16OverflowException();
		}
		return (short)value;
	}

	[CLSCompliant(false)]
	public static short ToInt16(ulong value)
	{
		if (value > 32767)
		{
			ThrowInt16OverflowException();
		}
		return (short)value;
	}

	public static short ToInt16(float value)
	{
		return ToInt16((double)value);
	}

	public static short ToInt16(double value)
	{
		return ToInt16(ToInt32(value));
	}

	public static short ToInt16(decimal value)
	{
		return decimal.ToInt16(decimal.Round(value, 0));
	}

	public static short ToInt16(string value)
	{
		if (value == null)
		{
			return 0;
		}
		return short.Parse(value, CultureInfo.CurrentCulture);
	}

	public static short ToInt16(string value, IFormatProvider provider)
	{
		if (value == null)
		{
			return 0;
		}
		return short.Parse(value, NumberStyles.Integer, provider);
	}

	public static short ToInt16(DateTime value)
	{
		return ((IConvertible)value).ToInt16((IFormatProvider)null);
	}

	[CLSCompliant(false)]
	public static ushort ToUInt16(object value)
	{
		if (value != null)
		{
			return ((IConvertible)value).ToUInt16(null);
		}
		return 0;
	}

	[CLSCompliant(false)]
	public static ushort ToUInt16(object value, IFormatProvider provider)
	{
		if (value != null)
		{
			return ((IConvertible)value).ToUInt16(provider);
		}
		return 0;
	}

	[CLSCompliant(false)]
	public static ushort ToUInt16(bool value)
	{
		if (!value)
		{
			return 0;
		}
		return 1;
	}

	[CLSCompliant(false)]
	public static ushort ToUInt16(char value)
	{
		return value;
	}

	[CLSCompliant(false)]
	public static ushort ToUInt16(sbyte value)
	{
		if (value < 0)
		{
			ThrowUInt16OverflowException();
		}
		return (ushort)value;
	}

	[CLSCompliant(false)]
	public static ushort ToUInt16(byte value)
	{
		return value;
	}

	[CLSCompliant(false)]
	public static ushort ToUInt16(short value)
	{
		if (value < 0)
		{
			ThrowUInt16OverflowException();
		}
		return (ushort)value;
	}

	[CLSCompliant(false)]
	public static ushort ToUInt16(int value)
	{
		if (value < 0 || value > 65535)
		{
			ThrowUInt16OverflowException();
		}
		return (ushort)value;
	}

	[CLSCompliant(false)]
	public static ushort ToUInt16(ushort value)
	{
		return value;
	}

	[CLSCompliant(false)]
	public static ushort ToUInt16(uint value)
	{
		if (value > 65535)
		{
			ThrowUInt16OverflowException();
		}
		return (ushort)value;
	}

	[CLSCompliant(false)]
	public static ushort ToUInt16(long value)
	{
		if (value < 0 || value > 65535)
		{
			ThrowUInt16OverflowException();
		}
		return (ushort)value;
	}

	[CLSCompliant(false)]
	public static ushort ToUInt16(ulong value)
	{
		if (value > 65535)
		{
			ThrowUInt16OverflowException();
		}
		return (ushort)value;
	}

	[CLSCompliant(false)]
	public static ushort ToUInt16(float value)
	{
		return ToUInt16((double)value);
	}

	[CLSCompliant(false)]
	public static ushort ToUInt16(double value)
	{
		return ToUInt16(ToInt32(value));
	}

	[CLSCompliant(false)]
	public static ushort ToUInt16(decimal value)
	{
		return decimal.ToUInt16(decimal.Round(value, 0));
	}

	[CLSCompliant(false)]
	public static ushort ToUInt16(string value)
	{
		if (value == null)
		{
			return 0;
		}
		return ushort.Parse(value, CultureInfo.CurrentCulture);
	}

	[CLSCompliant(false)]
	public static ushort ToUInt16(string value, IFormatProvider provider)
	{
		if (value == null)
		{
			return 0;
		}
		return ushort.Parse(value, NumberStyles.Integer, provider);
	}

	[CLSCompliant(false)]
	public static ushort ToUInt16(DateTime value)
	{
		return ((IConvertible)value).ToUInt16((IFormatProvider)null);
	}

	public static int ToInt32(object value)
	{
		if (value != null)
		{
			return ((IConvertible)value).ToInt32(null);
		}
		return 0;
	}

	public static int ToInt32(object value, IFormatProvider provider)
	{
		if (value != null)
		{
			return ((IConvertible)value).ToInt32(provider);
		}
		return 0;
	}

	public static int ToInt32(bool value)
	{
		if (!value)
		{
			return 0;
		}
		return 1;
	}

	public static int ToInt32(char value)
	{
		return value;
	}

	[CLSCompliant(false)]
	public static int ToInt32(sbyte value)
	{
		return value;
	}

	public static int ToInt32(byte value)
	{
		return value;
	}

	public static int ToInt32(short value)
	{
		return value;
	}

	[CLSCompliant(false)]
	public static int ToInt32(ushort value)
	{
		return value;
	}

	[CLSCompliant(false)]
	public static int ToInt32(uint value)
	{
		if (value > int.MaxValue)
		{
			ThrowInt32OverflowException();
		}
		return (int)value;
	}

	public static int ToInt32(int value)
	{
		return value;
	}

	public static int ToInt32(long value)
	{
		if (value < int.MinValue || value > int.MaxValue)
		{
			ThrowInt32OverflowException();
		}
		return (int)value;
	}

	[CLSCompliant(false)]
	public static int ToInt32(ulong value)
	{
		if (value > int.MaxValue)
		{
			ThrowInt32OverflowException();
		}
		return (int)value;
	}

	public static int ToInt32(float value)
	{
		return ToInt32((double)value);
	}

	public static int ToInt32(double value)
	{
		if (value >= 0.0)
		{
			if (value < 2147483647.5)
			{
				int num = (int)value;
				double num2 = value - (double)num;
				if (num2 > 0.5 || (num2 == 0.5 && (num & 1) != 0))
				{
					num++;
				}
				return num;
			}
		}
		else if (value >= -2147483648.5)
		{
			int num3 = (int)value;
			double num4 = value - (double)num3;
			if (num4 < -0.5 || (num4 == -0.5 && (num3 & 1) != 0))
			{
				num3--;
			}
			return num3;
		}
		throw new OverflowException("Value was either too large or too small for an Int32.");
	}

	public static int ToInt32(decimal value)
	{
		return decimal.ToInt32(decimal.Round(value, 0));
	}

	public static int ToInt32(string value)
	{
		if (value == null)
		{
			return 0;
		}
		return int.Parse(value, CultureInfo.CurrentCulture);
	}

	public static int ToInt32(string value, IFormatProvider provider)
	{
		if (value == null)
		{
			return 0;
		}
		return int.Parse(value, NumberStyles.Integer, provider);
	}

	public static int ToInt32(DateTime value)
	{
		return ((IConvertible)value).ToInt32((IFormatProvider)null);
	}

	[CLSCompliant(false)]
	public static uint ToUInt32(object value)
	{
		if (value != null)
		{
			return ((IConvertible)value).ToUInt32(null);
		}
		return 0u;
	}

	[CLSCompliant(false)]
	public static uint ToUInt32(object value, IFormatProvider provider)
	{
		if (value != null)
		{
			return ((IConvertible)value).ToUInt32(provider);
		}
		return 0u;
	}

	[CLSCompliant(false)]
	public static uint ToUInt32(bool value)
	{
		if (!value)
		{
			return 0u;
		}
		return 1u;
	}

	[CLSCompliant(false)]
	public static uint ToUInt32(char value)
	{
		return value;
	}

	[CLSCompliant(false)]
	public static uint ToUInt32(sbyte value)
	{
		if (value < 0)
		{
			ThrowUInt32OverflowException();
		}
		return (uint)value;
	}

	[CLSCompliant(false)]
	public static uint ToUInt32(byte value)
	{
		return value;
	}

	[CLSCompliant(false)]
	public static uint ToUInt32(short value)
	{
		if (value < 0)
		{
			ThrowUInt32OverflowException();
		}
		return (uint)value;
	}

	[CLSCompliant(false)]
	public static uint ToUInt32(ushort value)
	{
		return value;
	}

	[CLSCompliant(false)]
	public static uint ToUInt32(int value)
	{
		if (value < 0)
		{
			ThrowUInt32OverflowException();
		}
		return (uint)value;
	}

	[CLSCompliant(false)]
	public static uint ToUInt32(uint value)
	{
		return value;
	}

	[CLSCompliant(false)]
	public static uint ToUInt32(long value)
	{
		if (value < 0 || value > uint.MaxValue)
		{
			ThrowUInt32OverflowException();
		}
		return (uint)value;
	}

	[CLSCompliant(false)]
	public static uint ToUInt32(ulong value)
	{
		if (value > uint.MaxValue)
		{
			ThrowUInt32OverflowException();
		}
		return (uint)value;
	}

	[CLSCompliant(false)]
	public static uint ToUInt32(float value)
	{
		return ToUInt32((double)value);
	}

	[CLSCompliant(false)]
	public static uint ToUInt32(double value)
	{
		if (value >= -0.5 && value < 4294967295.5)
		{
			uint num = (uint)value;
			double num2 = value - (double)num;
			if (num2 > 0.5 || (num2 == 0.5 && (num & 1) != 0))
			{
				num++;
			}
			return num;
		}
		throw new OverflowException("Value was either too large or too small for a UInt32.");
	}

	[CLSCompliant(false)]
	public static uint ToUInt32(decimal value)
	{
		return decimal.ToUInt32(decimal.Round(value, 0));
	}

	[CLSCompliant(false)]
	public static uint ToUInt32(string value)
	{
		if (value == null)
		{
			return 0u;
		}
		return uint.Parse(value, CultureInfo.CurrentCulture);
	}

	[CLSCompliant(false)]
	public static uint ToUInt32(string value, IFormatProvider provider)
	{
		if (value == null)
		{
			return 0u;
		}
		return uint.Parse(value, NumberStyles.Integer, provider);
	}

	[CLSCompliant(false)]
	public static uint ToUInt32(DateTime value)
	{
		return ((IConvertible)value).ToUInt32((IFormatProvider)null);
	}

	public static long ToInt64(object value)
	{
		if (value != null)
		{
			return ((IConvertible)value).ToInt64(null);
		}
		return 0L;
	}

	public static long ToInt64(object value, IFormatProvider provider)
	{
		if (value != null)
		{
			return ((IConvertible)value).ToInt64(provider);
		}
		return 0L;
	}

	public static long ToInt64(bool value)
	{
		return value ? 1 : 0;
	}

	public static long ToInt64(char value)
	{
		return value;
	}

	[CLSCompliant(false)]
	public static long ToInt64(sbyte value)
	{
		return value;
	}

	public static long ToInt64(byte value)
	{
		return value;
	}

	public static long ToInt64(short value)
	{
		return value;
	}

	[CLSCompliant(false)]
	public static long ToInt64(ushort value)
	{
		return value;
	}

	public static long ToInt64(int value)
	{
		return value;
	}

	[CLSCompliant(false)]
	public static long ToInt64(uint value)
	{
		return value;
	}

	[CLSCompliant(false)]
	public static long ToInt64(ulong value)
	{
		if (value > long.MaxValue)
		{
			ThrowInt64OverflowException();
		}
		return (long)value;
	}

	public static long ToInt64(long value)
	{
		return value;
	}

	public static long ToInt64(float value)
	{
		return ToInt64((double)value);
	}

	public static long ToInt64(double value)
	{
		return checked((long)Math.Round(value));
	}

	public static long ToInt64(decimal value)
	{
		return decimal.ToInt64(decimal.Round(value, 0));
	}

	public static long ToInt64(string value)
	{
		if (value == null)
		{
			return 0L;
		}
		return long.Parse(value, CultureInfo.CurrentCulture);
	}

	public static long ToInt64(string value, IFormatProvider provider)
	{
		if (value == null)
		{
			return 0L;
		}
		return long.Parse(value, NumberStyles.Integer, provider);
	}

	public static long ToInt64(DateTime value)
	{
		return ((IConvertible)value).ToInt64((IFormatProvider)null);
	}

	[CLSCompliant(false)]
	public static ulong ToUInt64(object value)
	{
		if (value != null)
		{
			return ((IConvertible)value).ToUInt64(null);
		}
		return 0uL;
	}

	[CLSCompliant(false)]
	public static ulong ToUInt64(object value, IFormatProvider provider)
	{
		if (value != null)
		{
			return ((IConvertible)value).ToUInt64(provider);
		}
		return 0uL;
	}

	[CLSCompliant(false)]
	public static ulong ToUInt64(bool value)
	{
		if (!value)
		{
			return 0uL;
		}
		return 1uL;
	}

	[CLSCompliant(false)]
	public static ulong ToUInt64(char value)
	{
		return value;
	}

	[CLSCompliant(false)]
	public static ulong ToUInt64(sbyte value)
	{
		if (value < 0)
		{
			ThrowUInt64OverflowException();
		}
		return (ulong)value;
	}

	[CLSCompliant(false)]
	public static ulong ToUInt64(byte value)
	{
		return value;
	}

	[CLSCompliant(false)]
	public static ulong ToUInt64(short value)
	{
		if (value < 0)
		{
			ThrowUInt64OverflowException();
		}
		return (ulong)value;
	}

	[CLSCompliant(false)]
	public static ulong ToUInt64(ushort value)
	{
		return value;
	}

	[CLSCompliant(false)]
	public static ulong ToUInt64(int value)
	{
		if (value < 0)
		{
			ThrowUInt64OverflowException();
		}
		return (ulong)value;
	}

	[CLSCompliant(false)]
	public static ulong ToUInt64(uint value)
	{
		return value;
	}

	[CLSCompliant(false)]
	public static ulong ToUInt64(long value)
	{
		if (value < 0)
		{
			ThrowUInt64OverflowException();
		}
		return (ulong)value;
	}

	[CLSCompliant(false)]
	public static ulong ToUInt64(ulong value)
	{
		return value;
	}

	[CLSCompliant(false)]
	public static ulong ToUInt64(float value)
	{
		return ToUInt64((double)value);
	}

	[CLSCompliant(false)]
	public static ulong ToUInt64(double value)
	{
		return checked((ulong)Math.Round(value));
	}

	[CLSCompliant(false)]
	public static ulong ToUInt64(decimal value)
	{
		return decimal.ToUInt64(decimal.Round(value, 0));
	}

	[CLSCompliant(false)]
	public static ulong ToUInt64(string value)
	{
		if (value == null)
		{
			return 0uL;
		}
		return ulong.Parse(value, CultureInfo.CurrentCulture);
	}

	[CLSCompliant(false)]
	public static ulong ToUInt64(string value, IFormatProvider provider)
	{
		if (value == null)
		{
			return 0uL;
		}
		return ulong.Parse(value, NumberStyles.Integer, provider);
	}

	[CLSCompliant(false)]
	public static ulong ToUInt64(DateTime value)
	{
		return ((IConvertible)value).ToUInt64((IFormatProvider)null);
	}

	public static float ToSingle(object value)
	{
		if (value != null)
		{
			return ((IConvertible)value).ToSingle(null);
		}
		return 0f;
	}

	public static float ToSingle(object value, IFormatProvider provider)
	{
		if (value != null)
		{
			return ((IConvertible)value).ToSingle(provider);
		}
		return 0f;
	}

	[CLSCompliant(false)]
	public static float ToSingle(sbyte value)
	{
		return value;
	}

	public static float ToSingle(byte value)
	{
		return (int)value;
	}

	public static float ToSingle(char value)
	{
		return ((IConvertible)value).ToSingle((IFormatProvider)null);
	}

	public static float ToSingle(short value)
	{
		return value;
	}

	[CLSCompliant(false)]
	public static float ToSingle(ushort value)
	{
		return (int)value;
	}

	public static float ToSingle(int value)
	{
		return value;
	}

	[CLSCompliant(false)]
	public static float ToSingle(uint value)
	{
		return value;
	}

	public static float ToSingle(long value)
	{
		return value;
	}

	[CLSCompliant(false)]
	public static float ToSingle(ulong value)
	{
		return value;
	}

	public static float ToSingle(float value)
	{
		return value;
	}

	public static float ToSingle(double value)
	{
		return (float)value;
	}

	public static float ToSingle(decimal value)
	{
		return (float)value;
	}

	public static float ToSingle(string value)
	{
		if (value == null)
		{
			return 0f;
		}
		return float.Parse(value, CultureInfo.CurrentCulture);
	}

	public static float ToSingle(string value, IFormatProvider provider)
	{
		if (value == null)
		{
			return 0f;
		}
		return float.Parse(value, NumberStyles.Float | NumberStyles.AllowThousands, provider);
	}

	public static float ToSingle(bool value)
	{
		return value ? 1 : 0;
	}

	public static float ToSingle(DateTime value)
	{
		return ((IConvertible)value).ToSingle((IFormatProvider)null);
	}

	public static double ToDouble(object value)
	{
		if (value != null)
		{
			return ((IConvertible)value).ToDouble(null);
		}
		return 0.0;
	}

	public static double ToDouble(object value, IFormatProvider provider)
	{
		if (value != null)
		{
			return ((IConvertible)value).ToDouble(provider);
		}
		return 0.0;
	}

	[CLSCompliant(false)]
	public static double ToDouble(sbyte value)
	{
		return value;
	}

	public static double ToDouble(byte value)
	{
		return (int)value;
	}

	public static double ToDouble(short value)
	{
		return value;
	}

	public static double ToDouble(char value)
	{
		return ((IConvertible)value).ToDouble((IFormatProvider)null);
	}

	[CLSCompliant(false)]
	public static double ToDouble(ushort value)
	{
		return (int)value;
	}

	public static double ToDouble(int value)
	{
		return value;
	}

	[CLSCompliant(false)]
	public static double ToDouble(uint value)
	{
		return value;
	}

	public static double ToDouble(long value)
	{
		return value;
	}

	[CLSCompliant(false)]
	public static double ToDouble(ulong value)
	{
		return value;
	}

	public static double ToDouble(float value)
	{
		return value;
	}

	public static double ToDouble(double value)
	{
		return value;
	}

	public static double ToDouble(decimal value)
	{
		return (double)value;
	}

	public static double ToDouble(string value)
	{
		if (value == null)
		{
			return 0.0;
		}
		return double.Parse(value, CultureInfo.CurrentCulture);
	}

	public static double ToDouble(string value, IFormatProvider provider)
	{
		if (value == null)
		{
			return 0.0;
		}
		return double.Parse(value, NumberStyles.Float | NumberStyles.AllowThousands, provider);
	}

	public static double ToDouble(bool value)
	{
		return value ? 1 : 0;
	}

	public static double ToDouble(DateTime value)
	{
		return ((IConvertible)value).ToDouble((IFormatProvider)null);
	}

	public static decimal ToDecimal(object value)
	{
		if (value != null)
		{
			return ((IConvertible)value).ToDecimal(null);
		}
		return 0m;
	}

	public static decimal ToDecimal(object value, IFormatProvider provider)
	{
		if (value != null)
		{
			return ((IConvertible)value).ToDecimal(provider);
		}
		return 0m;
	}

	[CLSCompliant(false)]
	public static decimal ToDecimal(sbyte value)
	{
		return value;
	}

	public static decimal ToDecimal(byte value)
	{
		return value;
	}

	public static decimal ToDecimal(char value)
	{
		return ((IConvertible)value).ToDecimal((IFormatProvider)null);
	}

	public static decimal ToDecimal(short value)
	{
		return value;
	}

	[CLSCompliant(false)]
	public static decimal ToDecimal(ushort value)
	{
		return value;
	}

	public static decimal ToDecimal(int value)
	{
		return value;
	}

	[CLSCompliant(false)]
	public static decimal ToDecimal(uint value)
	{
		return value;
	}

	public static decimal ToDecimal(long value)
	{
		return value;
	}

	[CLSCompliant(false)]
	public static decimal ToDecimal(ulong value)
	{
		return value;
	}

	public static decimal ToDecimal(float value)
	{
		return (decimal)value;
	}

	public static decimal ToDecimal(double value)
	{
		return (decimal)value;
	}

	public static decimal ToDecimal(string value)
	{
		if (value == null)
		{
			return 0m;
		}
		return decimal.Parse(value, CultureInfo.CurrentCulture);
	}

	public static decimal ToDecimal(string value, IFormatProvider provider)
	{
		if (value == null)
		{
			return 0m;
		}
		return decimal.Parse(value, NumberStyles.Number, provider);
	}

	public static decimal ToDecimal(decimal value)
	{
		return value;
	}

	public static decimal ToDecimal(bool value)
	{
		return value ? 1 : 0;
	}

	public static decimal ToDecimal(DateTime value)
	{
		return ((IConvertible)value).ToDecimal((IFormatProvider)null);
	}

	public static DateTime ToDateTime(DateTime value)
	{
		return value;
	}

	public static DateTime ToDateTime(object value)
	{
		if (value != null)
		{
			return ((IConvertible)value).ToDateTime(null);
		}
		return DateTime.MinValue;
	}

	public static DateTime ToDateTime(object value, IFormatProvider provider)
	{
		if (value != null)
		{
			return ((IConvertible)value).ToDateTime(provider);
		}
		return DateTime.MinValue;
	}

	public static DateTime ToDateTime(string value)
	{
		if (value == null)
		{
			return new DateTime(0L);
		}
		return DateTime.Parse(value, CultureInfo.CurrentCulture);
	}

	public static DateTime ToDateTime(string value, IFormatProvider provider)
	{
		if (value == null)
		{
			return new DateTime(0L);
		}
		return DateTime.Parse(value, provider);
	}

	[CLSCompliant(false)]
	public static DateTime ToDateTime(sbyte value)
	{
		return ((IConvertible)value).ToDateTime((IFormatProvider)null);
	}

	public static DateTime ToDateTime(byte value)
	{
		return ((IConvertible)value).ToDateTime((IFormatProvider)null);
	}

	public static DateTime ToDateTime(short value)
	{
		return ((IConvertible)value).ToDateTime((IFormatProvider)null);
	}

	[CLSCompliant(false)]
	public static DateTime ToDateTime(ushort value)
	{
		return ((IConvertible)value).ToDateTime((IFormatProvider)null);
	}

	public static DateTime ToDateTime(int value)
	{
		return ((IConvertible)value).ToDateTime((IFormatProvider)null);
	}

	[CLSCompliant(false)]
	public static DateTime ToDateTime(uint value)
	{
		return ((IConvertible)value).ToDateTime((IFormatProvider)null);
	}

	public static DateTime ToDateTime(long value)
	{
		return ((IConvertible)value).ToDateTime((IFormatProvider)null);
	}

	[CLSCompliant(false)]
	public static DateTime ToDateTime(ulong value)
	{
		return ((IConvertible)value).ToDateTime((IFormatProvider)null);
	}

	public static DateTime ToDateTime(bool value)
	{
		return ((IConvertible)value).ToDateTime((IFormatProvider)null);
	}

	public static DateTime ToDateTime(char value)
	{
		return ((IConvertible)value).ToDateTime((IFormatProvider)null);
	}

	public static DateTime ToDateTime(float value)
	{
		return ((IConvertible)value).ToDateTime((IFormatProvider)null);
	}

	public static DateTime ToDateTime(double value)
	{
		return ((IConvertible)value).ToDateTime((IFormatProvider)null);
	}

	public static DateTime ToDateTime(decimal value)
	{
		return ((IConvertible)value).ToDateTime((IFormatProvider)null);
	}

	public static string ToString(object value)
	{
		return ToString(value, null);
	}

	public static string ToString(object value, IFormatProvider provider)
	{
		if (value is IConvertible convertible)
		{
			return convertible.ToString(provider);
		}
		if (value is IFormattable formattable)
		{
			return formattable.ToString(null, provider);
		}
		if (value != null)
		{
			return value.ToString();
		}
		return string.Empty;
	}

	public static string ToString(bool value)
	{
		return value.ToString();
	}

	public static string ToString(bool value, IFormatProvider provider)
	{
		return value.ToString();
	}

	public static string ToString(char value)
	{
		return char.ToString(value);
	}

	public static string ToString(char value, IFormatProvider provider)
	{
		return value.ToString();
	}

	[CLSCompliant(false)]
	public static string ToString(sbyte value)
	{
		return value.ToString(CultureInfo.CurrentCulture);
	}

	[CLSCompliant(false)]
	public static string ToString(sbyte value, IFormatProvider provider)
	{
		return value.ToString(provider);
	}

	public static string ToString(byte value)
	{
		return value.ToString(CultureInfo.CurrentCulture);
	}

	public static string ToString(byte value, IFormatProvider provider)
	{
		return value.ToString(provider);
	}

	public static string ToString(short value)
	{
		return value.ToString(CultureInfo.CurrentCulture);
	}

	public static string ToString(short value, IFormatProvider provider)
	{
		return value.ToString(provider);
	}

	[CLSCompliant(false)]
	public static string ToString(ushort value)
	{
		return value.ToString(CultureInfo.CurrentCulture);
	}

	[CLSCompliant(false)]
	public static string ToString(ushort value, IFormatProvider provider)
	{
		return value.ToString(provider);
	}

	public static string ToString(int value)
	{
		return value.ToString(CultureInfo.CurrentCulture);
	}

	public static string ToString(int value, IFormatProvider provider)
	{
		return value.ToString(provider);
	}

	[CLSCompliant(false)]
	public static string ToString(uint value)
	{
		return value.ToString(CultureInfo.CurrentCulture);
	}

	[CLSCompliant(false)]
	public static string ToString(uint value, IFormatProvider provider)
	{
		return value.ToString(provider);
	}

	public static string ToString(long value)
	{
		return value.ToString(CultureInfo.CurrentCulture);
	}

	public static string ToString(long value, IFormatProvider provider)
	{
		return value.ToString(provider);
	}

	[CLSCompliant(false)]
	public static string ToString(ulong value)
	{
		return value.ToString(CultureInfo.CurrentCulture);
	}

	[CLSCompliant(false)]
	public static string ToString(ulong value, IFormatProvider provider)
	{
		return value.ToString(provider);
	}

	public static string ToString(float value)
	{
		return value.ToString(CultureInfo.CurrentCulture);
	}

	public static string ToString(float value, IFormatProvider provider)
	{
		return value.ToString(provider);
	}

	public static string ToString(double value)
	{
		return value.ToString(CultureInfo.CurrentCulture);
	}

	public static string ToString(double value, IFormatProvider provider)
	{
		return value.ToString(provider);
	}

	public static string ToString(decimal value)
	{
		return value.ToString(CultureInfo.CurrentCulture);
	}

	public static string ToString(decimal value, IFormatProvider provider)
	{
		return value.ToString(provider);
	}

	public static string ToString(DateTime value)
	{
		return value.ToString();
	}

	public static string ToString(DateTime value, IFormatProvider provider)
	{
		return value.ToString(provider);
	}

	public static string ToString(string value)
	{
		return value;
	}

	public static string ToString(string value, IFormatProvider provider)
	{
		return value;
	}

	public static byte ToByte(string value, int fromBase)
	{
		if (fromBase != 2 && fromBase != 8 && fromBase != 10 && fromBase != 16)
		{
			throw new ArgumentException("Invalid Base.");
		}
		if (value == null)
		{
			return 0;
		}
		int num = ParseNumbers.StringToInt(value.AsSpan(), fromBase, 4608);
		if (num < 0 || num > 255)
		{
			ThrowByteOverflowException();
		}
		return (byte)num;
	}

	[CLSCompliant(false)]
	public static sbyte ToSByte(string value, int fromBase)
	{
		if (fromBase != 2 && fromBase != 8 && fromBase != 10 && fromBase != 16)
		{
			throw new ArgumentException("Invalid Base.");
		}
		if (value == null)
		{
			return 0;
		}
		int num = ParseNumbers.StringToInt(value.AsSpan(), fromBase, 5120);
		if (fromBase != 10 && num <= 255)
		{
			return (sbyte)num;
		}
		if (num < -128 || num > 127)
		{
			ThrowSByteOverflowException();
		}
		return (sbyte)num;
	}

	public static short ToInt16(string value, int fromBase)
	{
		if (fromBase != 2 && fromBase != 8 && fromBase != 10 && fromBase != 16)
		{
			throw new ArgumentException("Invalid Base.");
		}
		if (value == null)
		{
			return 0;
		}
		int num = ParseNumbers.StringToInt(value.AsSpan(), fromBase, 6144);
		if (fromBase != 10 && num <= 65535)
		{
			return (short)num;
		}
		if (num < -32768 || num > 32767)
		{
			ThrowInt16OverflowException();
		}
		return (short)num;
	}

	[CLSCompliant(false)]
	public static ushort ToUInt16(string value, int fromBase)
	{
		if (fromBase != 2 && fromBase != 8 && fromBase != 10 && fromBase != 16)
		{
			throw new ArgumentException("Invalid Base.");
		}
		if (value == null)
		{
			return 0;
		}
		int num = ParseNumbers.StringToInt(value.AsSpan(), fromBase, 4608);
		if (num < 0 || num > 65535)
		{
			ThrowUInt16OverflowException();
		}
		return (ushort)num;
	}

	public static int ToInt32(string value, int fromBase)
	{
		if (fromBase != 2 && fromBase != 8 && fromBase != 10 && fromBase != 16)
		{
			throw new ArgumentException("Invalid Base.");
		}
		if (value == null)
		{
			return 0;
		}
		return ParseNumbers.StringToInt(value.AsSpan(), fromBase, 4096);
	}

	[CLSCompliant(false)]
	public static uint ToUInt32(string value, int fromBase)
	{
		if (fromBase != 2 && fromBase != 8 && fromBase != 10 && fromBase != 16)
		{
			throw new ArgumentException("Invalid Base.");
		}
		if (value == null)
		{
			return 0u;
		}
		return (uint)ParseNumbers.StringToInt(value.AsSpan(), fromBase, 4608);
	}

	public static long ToInt64(string value, int fromBase)
	{
		if (fromBase != 2 && fromBase != 8 && fromBase != 10 && fromBase != 16)
		{
			throw new ArgumentException("Invalid Base.");
		}
		if (value == null)
		{
			return 0L;
		}
		return ParseNumbers.StringToLong(value.AsSpan(), fromBase, 4096);
	}

	[CLSCompliant(false)]
	public static ulong ToUInt64(string value, int fromBase)
	{
		if (fromBase != 2 && fromBase != 8 && fromBase != 10 && fromBase != 16)
		{
			throw new ArgumentException("Invalid Base.");
		}
		if (value == null)
		{
			return 0uL;
		}
		return (ulong)ParseNumbers.StringToLong(value.AsSpan(), fromBase, 4608);
	}

	public static string ToString(byte value, int toBase)
	{
		if (toBase != 2 && toBase != 8 && toBase != 10 && toBase != 16)
		{
			throw new ArgumentException("Invalid Base.");
		}
		return ParseNumbers.IntToString(value, toBase, -1, ' ', 64);
	}

	public static string ToString(short value, int toBase)
	{
		if (toBase != 2 && toBase != 8 && toBase != 10 && toBase != 16)
		{
			throw new ArgumentException("Invalid Base.");
		}
		return ParseNumbers.IntToString(value, toBase, -1, ' ', 128);
	}

	public static string ToString(int value, int toBase)
	{
		if (toBase != 2 && toBase != 8 && toBase != 10 && toBase != 16)
		{
			throw new ArgumentException("Invalid Base.");
		}
		return ParseNumbers.IntToString(value, toBase, -1, ' ', 0);
	}

	public static string ToString(long value, int toBase)
	{
		if (toBase != 2 && toBase != 8 && toBase != 10 && toBase != 16)
		{
			throw new ArgumentException("Invalid Base.");
		}
		return ParseNumbers.LongToString(value, toBase, -1, ' ', 0);
	}

	public static string ToBase64String(byte[] inArray)
	{
		if (inArray == null)
		{
			throw new ArgumentNullException("inArray");
		}
		return ToBase64String(new ReadOnlySpan<byte>(inArray));
	}

	public static string ToBase64String(byte[] inArray, Base64FormattingOptions options)
	{
		if (inArray == null)
		{
			throw new ArgumentNullException("inArray");
		}
		return ToBase64String(new ReadOnlySpan<byte>(inArray), options);
	}

	public static string ToBase64String(byte[] inArray, int offset, int length)
	{
		return ToBase64String(inArray, offset, length, Base64FormattingOptions.None);
	}

	public static string ToBase64String(byte[] inArray, int offset, int length, Base64FormattingOptions options)
	{
		if (inArray == null)
		{
			throw new ArgumentNullException("inArray");
		}
		if (length < 0)
		{
			throw new ArgumentOutOfRangeException("length", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		if (offset < 0)
		{
			throw new ArgumentOutOfRangeException("offset", "Value must be positive.");
		}
		if (offset > inArray.Length - length)
		{
			throw new ArgumentOutOfRangeException("offset", "Offset and length must refer to a position in the string.");
		}
		return ToBase64String(new ReadOnlySpan<byte>(inArray, offset, length), options);
	}

	public unsafe static string ToBase64String(ReadOnlySpan<byte> bytes, Base64FormattingOptions options = Base64FormattingOptions.None)
	{
		if (options < Base64FormattingOptions.None || options > Base64FormattingOptions.InsertLineBreaks)
		{
			throw new ArgumentException($"Illegal enum value: {(int)options}.", "options");
		}
		if (bytes.Length == 0)
		{
			return string.Empty;
		}
		bool insertLineBreaks = options == Base64FormattingOptions.InsertLineBreaks;
		string text = string.FastAllocateString(ToBase64_CalculateAndValidateOutputLength(bytes.Length, insertLineBreaks));
		fixed (byte* reference = &MemoryMarshal.GetReference(bytes))
		{
			fixed (char* outChars = text)
			{
				ConvertToBase64Array(outChars, reference, 0, bytes.Length, insertLineBreaks);
			}
		}
		return text;
	}

	public static int ToBase64CharArray(byte[] inArray, int offsetIn, int length, char[] outArray, int offsetOut)
	{
		return ToBase64CharArray(inArray, offsetIn, length, outArray, offsetOut, Base64FormattingOptions.None);
	}

	public unsafe static int ToBase64CharArray(byte[] inArray, int offsetIn, int length, char[] outArray, int offsetOut, Base64FormattingOptions options)
	{
		if (inArray == null)
		{
			throw new ArgumentNullException("inArray");
		}
		if (outArray == null)
		{
			throw new ArgumentNullException("outArray");
		}
		if (length < 0)
		{
			throw new ArgumentOutOfRangeException("length", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		if (offsetIn < 0)
		{
			throw new ArgumentOutOfRangeException("offsetIn", "Value must be positive.");
		}
		if (offsetOut < 0)
		{
			throw new ArgumentOutOfRangeException("offsetOut", "Value must be positive.");
		}
		if (options < Base64FormattingOptions.None || options > Base64FormattingOptions.InsertLineBreaks)
		{
			throw new ArgumentException($"Illegal enum value: {(int)options}.", "options");
		}
		int num = inArray.Length;
		if (offsetIn > num - length)
		{
			throw new ArgumentOutOfRangeException("offsetIn", "Offset and length must refer to a position in the string.");
		}
		if (num == 0)
		{
			return 0;
		}
		bool insertLineBreaks = options == Base64FormattingOptions.InsertLineBreaks;
		int num2 = outArray.Length;
		int num3 = ToBase64_CalculateAndValidateOutputLength(length, insertLineBreaks);
		if (offsetOut > num2 - num3)
		{
			throw new ArgumentOutOfRangeException("offsetOut", "Either offset did not refer to a position in the string, or there is an insufficient length of destination character array.");
		}
		int result;
		fixed (char* outChars = &outArray[offsetOut])
		{
			fixed (byte* inData = &inArray[0])
			{
				result = ConvertToBase64Array(outChars, inData, offsetIn, length, insertLineBreaks);
			}
		}
		return result;
	}

	public unsafe static bool TryToBase64Chars(ReadOnlySpan<byte> bytes, Span<char> chars, out int charsWritten, Base64FormattingOptions options = Base64FormattingOptions.None)
	{
		if (options < Base64FormattingOptions.None || options > Base64FormattingOptions.InsertLineBreaks)
		{
			throw new ArgumentException($"Illegal enum value: {(int)options}.", "options");
		}
		if (bytes.Length == 0)
		{
			charsWritten = 0;
			return true;
		}
		bool insertLineBreaks = options == Base64FormattingOptions.InsertLineBreaks;
		if (ToBase64_CalculateAndValidateOutputLength(bytes.Length, insertLineBreaks) > chars.Length)
		{
			charsWritten = 0;
			return false;
		}
		fixed (char* reference = &MemoryMarshal.GetReference(chars))
		{
			fixed (byte* reference2 = &MemoryMarshal.GetReference(bytes))
			{
				charsWritten = ConvertToBase64Array(reference, reference2, 0, bytes.Length, insertLineBreaks);
				return true;
			}
		}
	}

	private unsafe static int ConvertToBase64Array(char* outChars, byte* inData, int offset, int length, bool insertLineBreaks)
	{
		int num = length % 3;
		int num2 = offset + (length - num);
		int num3 = 0;
		int num4 = 0;
		fixed (char* ptr = &base64Table[0])
		{
			int i;
			for (i = offset; i < num2; i += 3)
			{
				if (insertLineBreaks)
				{
					if (num4 == 76)
					{
						outChars[num3++] = '\r';
						outChars[num3++] = '\n';
						num4 = 0;
					}
					num4 += 4;
				}
				outChars[num3] = ptr[(inData[i] & 0xFC) >> 2];
				outChars[num3 + 1] = ptr[((inData[i] & 3) << 4) | ((inData[i + 1] & 0xF0) >> 4)];
				outChars[num3 + 2] = ptr[((inData[i + 1] & 0xF) << 2) | ((inData[i + 2] & 0xC0) >> 6)];
				outChars[num3 + 3] = ptr[inData[i + 2] & 0x3F];
				num3 += 4;
			}
			i = num2;
			if (insertLineBreaks && num != 0 && num4 == 76)
			{
				outChars[num3++] = '\r';
				outChars[num3++] = '\n';
			}
			switch (num)
			{
			case 2:
				outChars[num3] = ptr[(inData[i] & 0xFC) >> 2];
				outChars[num3 + 1] = ptr[((inData[i] & 3) << 4) | ((inData[i + 1] & 0xF0) >> 4)];
				outChars[num3 + 2] = ptr[(inData[i + 1] & 0xF) << 2];
				outChars[num3 + 3] = ptr[64];
				num3 += 4;
				break;
			case 1:
				outChars[num3] = ptr[(inData[i] & 0xFC) >> 2];
				outChars[num3 + 1] = ptr[(inData[i] & 3) << 4];
				outChars[num3 + 2] = ptr[64];
				outChars[num3 + 3] = ptr[64];
				num3 += 4;
				break;
			}
		}
		return num3;
	}

	private static int ToBase64_CalculateAndValidateOutputLength(int inputLength, bool insertLineBreaks)
	{
		long num = (long)inputLength / 3L * 4;
		num += ((inputLength % 3 != 0) ? 4 : 0);
		if (num == 0L)
		{
			return 0;
		}
		if (insertLineBreaks)
		{
			long num2 = num / 76;
			if (num % 76 == 0L)
			{
				num2--;
			}
			num += num2 * 2;
		}
		if (num > int.MaxValue)
		{
			throw new OutOfMemoryException();
		}
		return (int)num;
	}

	public unsafe static byte[] FromBase64String(string s)
	{
		if (s == null)
		{
			throw new ArgumentNullException("s");
		}
		fixed (char* inputPtr = s)
		{
			return FromBase64CharPtr(inputPtr, s.Length);
		}
	}

	public static bool TryFromBase64String(string s, Span<byte> bytes, out int bytesWritten)
	{
		if (s == null)
		{
			throw new ArgumentNullException("s");
		}
		return TryFromBase64Chars(s.AsSpan(), bytes, out bytesWritten);
	}

	public static bool TryFromBase64Chars(ReadOnlySpan<char> chars, Span<byte> bytes, out int bytesWritten)
	{
		Span<char> span = stackalloc char[4];
		bytesWritten = 0;
		while (chars.Length != 0)
		{
			bool num = TryDecodeFromUtf16(chars, bytes, out var consumed, out var written);
			bytesWritten += written;
			if (num)
			{
				return true;
			}
			chars = chars.Slice(consumed);
			bytes = bytes.Slice(written);
			if (chars[0].IsSpace())
			{
				int i;
				for (i = 1; i != chars.Length && chars[i].IsSpace(); i++)
				{
				}
				chars = chars.Slice(i);
				if (written % 3 != 0 && chars.Length != 0)
				{
					bytesWritten = 0;
					return false;
				}
				continue;
			}
			CopyToTempBufferWithoutWhiteSpace(chars, span, out var consumed2, out var charsWritten);
			if ((charsWritten & 3) != 0)
			{
				bytesWritten = 0;
				return false;
			}
			span = span.Slice(0, charsWritten);
			if (!TryDecodeFromUtf16(span, bytes, out var _, out var written2))
			{
				bytesWritten = 0;
				return false;
			}
			bytesWritten += written2;
			chars = chars.Slice(consumed2);
			bytes = bytes.Slice(written2);
			if (written2 % 3 == 0)
			{
				continue;
			}
			for (int j = 0; j < chars.Length; j++)
			{
				if (!chars[j].IsSpace())
				{
					bytesWritten = 0;
					return false;
				}
			}
			return true;
		}
		return true;
	}

	private static void CopyToTempBufferWithoutWhiteSpace(ReadOnlySpan<char> chars, Span<char> tempBuffer, out int consumed, out int charsWritten)
	{
		charsWritten = 0;
		for (int i = 0; i < chars.Length; i++)
		{
			char c = chars[i];
			if (!c.IsSpace())
			{
				tempBuffer[charsWritten++] = c;
				if (charsWritten == tempBuffer.Length)
				{
					consumed = i + 1;
					return;
				}
			}
		}
		consumed = chars.Length;
	}

	[MethodImpl((MethodImplOptions)256)]
	private static bool IsSpace(this char c)
	{
		if (c != ' ' && c != '\t' && c != '\r')
		{
			return c == '\n';
		}
		return true;
	}

	public unsafe static byte[] FromBase64CharArray(char[] inArray, int offset, int length)
	{
		if (inArray == null)
		{
			throw new ArgumentNullException("inArray");
		}
		if (length < 0)
		{
			throw new ArgumentOutOfRangeException("length", "Index was out of range. Must be non-negative and less than the size of the collection.");
		}
		if (offset < 0)
		{
			throw new ArgumentOutOfRangeException("offset", "Value must be positive.");
		}
		if (offset > inArray.Length - length)
		{
			throw new ArgumentOutOfRangeException("offset", "Offset and length must refer to a position in the string.");
		}
		if (inArray.Length == 0)
		{
			return Array.Empty<byte>();
		}
		fixed (char* ptr = &inArray[0])
		{
			return FromBase64CharPtr(ptr + offset, length);
		}
	}

	private unsafe static byte[] FromBase64CharPtr(char* inputPtr, int inputLength)
	{
		while (inputLength > 0)
		{
			int num = inputPtr[inputLength - 1];
			if (num != 32 && num != 10 && num != 13 && num != 9)
			{
				break;
			}
			inputLength--;
		}
		byte[] array = new byte[FromBase64_ComputeResultLength(inputPtr, inputLength)];
		if (!TryFromBase64Chars(new ReadOnlySpan<char>(inputPtr, inputLength), array, out var _))
		{
			throw new FormatException("The input is not a valid Base-64 string as it contains a non-base 64 character, more than two padding characters, or an illegal character among the padding characters.");
		}
		return array;
	}

	private unsafe static int FromBase64_ComputeResultLength(char* inputPtr, int inputLength)
	{
		char* ptr = inputPtr + inputLength;
		int num = inputLength;
		int num2 = 0;
		while (inputPtr < ptr)
		{
			uint num3 = *inputPtr;
			inputPtr++;
			switch (num3)
			{
			case 0u:
			case 1u:
			case 2u:
			case 3u:
			case 4u:
			case 5u:
			case 6u:
			case 7u:
			case 8u:
			case 9u:
			case 10u:
			case 11u:
			case 12u:
			case 13u:
			case 14u:
			case 15u:
			case 16u:
			case 17u:
			case 18u:
			case 19u:
			case 20u:
			case 21u:
			case 22u:
			case 23u:
			case 24u:
			case 25u:
			case 26u:
			case 27u:
			case 28u:
			case 29u:
			case 30u:
			case 31u:
			case 32u:
				num--;
				break;
			case 61u:
				num--;
				num2++;
				break;
			}
		}
		switch (num2)
		{
		case 1:
			num2 = 2;
			break;
		case 2:
			num2 = 1;
			break;
		default:
			throw new FormatException("The input is not a valid Base-64 string as it contains a non-base 64 character, more than two padding characters, or an illegal character among the padding characters.");
		case 0:
			break;
		}
		return num / 4 * 3 + num2;
	}
}
