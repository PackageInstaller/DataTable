using System.Collections.Generic;
using System.Globalization;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Text;

namespace System;

[Serializable]
[ComVisible(true)]
public abstract class Enum : ValueType, IComparable, IFormattable, IConvertible
{
	private enum ParseFailureKind
	{
		None,
		Argument,
		ArgumentNull,
		ArgumentWithParameter,
		UnhandledException
	}

	private struct EnumResult
	{
		internal object parsedEnum;

		internal bool canThrow;

		internal ParseFailureKind m_failure;

		internal string m_failureMessageID;

		internal string m_failureParameter;

		internal object m_failureMessageFormatArgument;

		internal Exception m_innerException;

		internal void Init(bool canMethodThrow)
		{
			parsedEnum = 0;
			canThrow = canMethodThrow;
		}

		internal void SetFailure(Exception unhandledException)
		{
			m_failure = ParseFailureKind.UnhandledException;
			m_innerException = unhandledException;
		}

		internal void SetFailure(ParseFailureKind failure, string failureParameter)
		{
			m_failure = failure;
			m_failureParameter = failureParameter;
			if (canThrow)
			{
				throw GetEnumParseException();
			}
		}

		internal void SetFailure(ParseFailureKind failure, string failureMessageID, object failureMessageFormatArgument)
		{
			m_failure = failure;
			m_failureMessageID = failureMessageID;
			m_failureMessageFormatArgument = failureMessageFormatArgument;
			if (canThrow)
			{
				throw GetEnumParseException();
			}
		}

		internal Exception GetEnumParseException()
		{
			return m_failure switch
			{
				ParseFailureKind.Argument => new ArgumentException(Environment.GetResourceString(m_failureMessageID)), 
				ParseFailureKind.ArgumentNull => new ArgumentNullException(m_failureParameter), 
				ParseFailureKind.ArgumentWithParameter => new ArgumentException(Environment.GetResourceString(m_failureMessageID, m_failureMessageFormatArgument)), 
				ParseFailureKind.UnhandledException => m_innerException, 
				_ => new ArgumentException(Environment.GetResourceString("Requested value '{0}' was not found.")), 
			};
		}
	}

	private class ValuesAndNames
	{
		public ulong[] Values;

		public string[] Names;

		public ValuesAndNames(ulong[] values, string[] names)
		{
			Values = values;
			Names = names;
		}
	}

	private static readonly char[] enumSeperatorCharArray = new char[1] { ',' };

	private const string enumSeperator = ", ";

	private static ValuesAndNames GetCachedValuesAndNames(RuntimeType enumType, bool getNames)
	{
		ValuesAndNames valuesAndNames = enumType.GenericCache as ValuesAndNames;
		if (valuesAndNames == null || (getNames && valuesAndNames.Names == null))
		{
			ulong[] values = null;
			string[] names = null;
			if (!GetEnumValuesAndNames(enumType, out values, out names))
			{
				Array.Sort(values, names, Comparer<ulong>.Default);
			}
			valuesAndNames = (ValuesAndNames)(enumType.GenericCache = new ValuesAndNames(values, names));
		}
		return valuesAndNames;
	}

	private static string InternalFormattedHexString(object value)
	{
		return Convert.GetTypeCode(value) switch
		{
			TypeCode.SByte => ((byte)(sbyte)value).ToString("X2", null), 
			TypeCode.Byte => ((byte)value).ToString("X2", null), 
			TypeCode.Boolean => Convert.ToByte((bool)value).ToString("X2", null), 
			TypeCode.Int16 => ((ushort)(short)value).ToString("X4", null), 
			TypeCode.UInt16 => ((ushort)value).ToString("X4", null), 
			TypeCode.Char => ((ushort)(char)value).ToString("X4", null), 
			TypeCode.UInt32 => ((uint)value).ToString("X8", null), 
			TypeCode.Int32 => ((uint)(int)value).ToString("X8", null), 
			TypeCode.UInt64 => ((ulong)value).ToString("X16", null), 
			TypeCode.Int64 => ((ulong)(long)value).ToString("X16", null), 
			_ => throw new InvalidOperationException(Environment.GetResourceString("Unknown enum type.")), 
		};
	}

	private static string InternalFormat(RuntimeType eT, object value)
	{
		if (!eT.IsDefined(typeof(FlagsAttribute), inherit: false))
		{
			string name = GetName(eT, value);
			if (name == null)
			{
				return value.ToString();
			}
			return name;
		}
		return InternalFlagsFormat(eT, value);
	}

	private static string InternalFlagsFormat(RuntimeType eT, object value)
	{
		ulong num = ToUInt64(value);
		ValuesAndNames cachedValuesAndNames = GetCachedValuesAndNames(eT, getNames: true);
		string[] names = cachedValuesAndNames.Names;
		ulong[] values = cachedValuesAndNames.Values;
		int num2 = values.Length - 1;
		StringBuilder stringBuilder = new StringBuilder();
		bool flag = true;
		ulong num3 = num;
		while (num2 >= 0 && (num2 != 0 || values[num2] != 0L))
		{
			if ((num & values[num2]) == values[num2])
			{
				num -= values[num2];
				if (!flag)
				{
					stringBuilder.Insert(0, ", ");
				}
				stringBuilder.Insert(0, names[num2]);
				flag = false;
			}
			num2--;
		}
		if (num != 0L)
		{
			return value.ToString();
		}
		if (num3 == 0L)
		{
			if (values.Length != 0 && values[0] == 0L)
			{
				return names[0];
			}
			return "0";
		}
		return stringBuilder.ToString();
	}

	internal static ulong ToUInt64(object value)
	{
		switch (Convert.GetTypeCode(value))
		{
		case TypeCode.SByte:
		case TypeCode.Int16:
		case TypeCode.Int32:
		case TypeCode.Int64:
			return (ulong)Convert.ToInt64(value, CultureInfo.InvariantCulture);
		case TypeCode.Boolean:
		case TypeCode.Char:
		case TypeCode.Byte:
		case TypeCode.UInt16:
		case TypeCode.UInt32:
		case TypeCode.UInt64:
			return Convert.ToUInt64(value, CultureInfo.InvariantCulture);
		default:
			throw new InvalidOperationException(Environment.GetResourceString("Unknown enum type."));
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern int InternalCompareTo(object o1, object o2);

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern RuntimeType InternalGetUnderlyingType(RuntimeType enumType);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool GetEnumValuesAndNames(RuntimeType enumType, out ulong[] values, out string[] names);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern object InternalBoxEnum(RuntimeType enumType, long value);

	public static bool TryParse<TEnum>(string value, out TEnum result) where TEnum : struct
	{
		return TryParse<TEnum>(value, ignoreCase: false, out result);
	}

	public static bool TryParse<TEnum>(string value, bool ignoreCase, out TEnum result) where TEnum : struct
	{
		result = default(TEnum);
		EnumResult parseResult = default(EnumResult);
		parseResult.Init(canMethodThrow: false);
		bool num = TryParseEnum(typeof(TEnum), value, ignoreCase, ref parseResult);
		if (num)
		{
			result = (TEnum)parseResult.parsedEnum;
		}
		return num;
	}

	[ComVisible(true)]
	public static object Parse(Type enumType, string value)
	{
		return Parse(enumType, value, ignoreCase: false);
	}

	[ComVisible(true)]
	public static object Parse(Type enumType, string value, bool ignoreCase)
	{
		EnumResult parseResult = default(EnumResult);
		parseResult.Init(canMethodThrow: true);
		if (TryParseEnum(enumType, value, ignoreCase, ref parseResult))
		{
			return parseResult.parsedEnum;
		}
		throw parseResult.GetEnumParseException();
	}

	private static bool TryParseEnum(Type enumType, string value, bool ignoreCase, ref EnumResult parseResult)
	{
		if (enumType == null)
		{
			throw new ArgumentNullException("enumType");
		}
		RuntimeType runtimeType = enumType as RuntimeType;
		if (runtimeType == null)
		{
			throw new ArgumentException(Environment.GetResourceString("Type must be a type provided by the runtime."), "enumType");
		}
		if (!enumType.IsEnum)
		{
			throw new ArgumentException(Environment.GetResourceString("Type provided must be an Enum."), "enumType");
		}
		if (value == null)
		{
			parseResult.SetFailure(ParseFailureKind.ArgumentNull, "value");
			return false;
		}
		value = value.Trim();
		if (value.Length == 0)
		{
			parseResult.SetFailure(ParseFailureKind.Argument, "Must specify valid information for parsing in the string.", null);
			return false;
		}
		ulong num = 0uL;
		if (char.IsDigit(value[0]) || value[0] == '-' || value[0] == '+')
		{
			Type underlyingType = GetUnderlyingType(enumType);
			try
			{
				object value2 = Convert.ChangeType(value, underlyingType, CultureInfo.InvariantCulture);
				parseResult.parsedEnum = ToObject(enumType, value2);
				return true;
			}
			catch (FormatException)
			{
			}
			catch (Exception failure)
			{
				if (parseResult.canThrow)
				{
					throw;
				}
				parseResult.SetFailure(failure);
				return false;
			}
		}
		string[] array = value.Split(enumSeperatorCharArray);
		ValuesAndNames cachedValuesAndNames = GetCachedValuesAndNames(runtimeType, getNames: true);
		string[] names = cachedValuesAndNames.Names;
		ulong[] values = cachedValuesAndNames.Values;
		for (int i = 0; i < array.Length; i++)
		{
			array[i] = array[i].Trim();
			bool flag = false;
			for (int j = 0; j < names.Length; j++)
			{
				if (ignoreCase)
				{
					if (string.Compare(names[j], array[i], StringComparison.OrdinalIgnoreCase) != 0)
					{
						continue;
					}
				}
				else if (!names[j].Equals(array[i]))
				{
					continue;
				}
				ulong num2 = values[j];
				num |= num2;
				flag = true;
				break;
			}
			if (!flag)
			{
				parseResult.SetFailure(ParseFailureKind.ArgumentWithParameter, "Requested value '{0}' was not found.", value);
				return false;
			}
		}
		try
		{
			parseResult.parsedEnum = ToObject(enumType, num);
			return true;
		}
		catch (Exception failure2)
		{
			if (parseResult.canThrow)
			{
				throw;
			}
			parseResult.SetFailure(failure2);
			return false;
		}
	}

	[ComVisible(true)]
	public static Type GetUnderlyingType(Type enumType)
	{
		if (enumType == null)
		{
			throw new ArgumentNullException("enumType");
		}
		return enumType.GetEnumUnderlyingType();
	}

	[ComVisible(true)]
	public static Array GetValues(Type enumType)
	{
		if (enumType == null)
		{
			throw new ArgumentNullException("enumType");
		}
		return enumType.GetEnumValues();
	}

	internal static ulong[] InternalGetValues(RuntimeType enumType)
	{
		return GetCachedValuesAndNames(enumType, getNames: false).Values;
	}

	[ComVisible(true)]
	public static string GetName(Type enumType, object value)
	{
		if (enumType == null)
		{
			throw new ArgumentNullException("enumType");
		}
		return enumType.GetEnumName(value);
	}

	[ComVisible(true)]
	public static string[] GetNames(Type enumType)
	{
		if (enumType == null)
		{
			throw new ArgumentNullException("enumType");
		}
		return enumType.GetEnumNames();
	}

	internal static string[] InternalGetNames(RuntimeType enumType)
	{
		return GetCachedValuesAndNames(enumType, getNames: true).Names;
	}

	[ComVisible(true)]
	public static object ToObject(Type enumType, object value)
	{
		if (value == null)
		{
			throw new ArgumentNullException("value");
		}
		return Convert.GetTypeCode(value) switch
		{
			TypeCode.Int32 => ToObject(enumType, (int)value), 
			TypeCode.SByte => ToObject(enumType, (sbyte)value), 
			TypeCode.Int16 => ToObject(enumType, (short)value), 
			TypeCode.Int64 => ToObject(enumType, (long)value), 
			TypeCode.UInt32 => ToObject(enumType, (uint)value), 
			TypeCode.Byte => ToObject(enumType, (byte)value), 
			TypeCode.UInt16 => ToObject(enumType, (ushort)value), 
			TypeCode.UInt64 => ToObject(enumType, (ulong)value), 
			TypeCode.Char => ToObject(enumType, (char)value), 
			TypeCode.Boolean => ToObject(enumType, (bool)value), 
			_ => throw new ArgumentException(Environment.GetResourceString("The value passed in must be an enum base or an underlying type for an enum, such as an Int32."), "value"), 
		};
	}

	[ComVisible(true)]
	public static bool IsDefined(Type enumType, object value)
	{
		if (enumType == null)
		{
			throw new ArgumentNullException("enumType");
		}
		return enumType.IsEnumDefined(value);
	}

	[ComVisible(true)]
	public static string Format(Type enumType, object value, string format)
	{
		if (enumType == null)
		{
			throw new ArgumentNullException("enumType");
		}
		if (!enumType.IsEnum)
		{
			throw new ArgumentException(Environment.GetResourceString("Type provided must be an Enum."), "enumType");
		}
		if (value == null)
		{
			throw new ArgumentNullException("value");
		}
		if (format == null)
		{
			throw new ArgumentNullException("format");
		}
		RuntimeType runtimeType = enumType as RuntimeType;
		if (runtimeType == null)
		{
			throw new ArgumentException(Environment.GetResourceString("Type must be a type provided by the runtime."), "enumType");
		}
		Type type = value.GetType();
		Type underlyingType = GetUnderlyingType(enumType);
		if (type.IsEnum)
		{
			Type underlyingType2 = GetUnderlyingType(type);
			if (!type.IsEquivalentTo(enumType))
			{
				throw new ArgumentException(Environment.GetResourceString("Object must be the same type as the enum. The type passed in was '{0}'; the enum type was '{1}'.", type.ToString(), enumType.ToString()));
			}
			type = underlyingType2;
			value = ((Enum)value).GetValue();
		}
		else if (type != underlyingType)
		{
			throw new ArgumentException(Environment.GetResourceString("Enum underlying type and the object must be same type or object. Type passed in was '{0}'; the enum underlying type was '{1}'.", type.ToString(), underlyingType.ToString()));
		}
		if (format.Length != 1)
		{
			throw new FormatException(Environment.GetResourceString("Format String can be only \"G\", \"g\", \"X\", \"x\", \"F\", \"f\", \"D\" or \"d\"."));
		}
		switch (format[0])
		{
		case 'D':
		case 'd':
			return value.ToString();
		case 'X':
		case 'x':
			return InternalFormattedHexString(value);
		case 'G':
		case 'g':
			return InternalFormat(runtimeType, value);
		case 'F':
		case 'f':
			return InternalFlagsFormat(runtimeType, value);
		default:
			throw new FormatException(Environment.GetResourceString("Format String can be only \"G\", \"g\", \"X\", \"x\", \"F\", \"f\", \"D\" or \"d\"."));
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private extern object get_value();

	internal object GetValue()
	{
		return get_value();
	}

	[MethodImpl((MethodImplOptions)4096)]
	private extern bool InternalHasFlag(Enum flags);

	[MethodImpl((MethodImplOptions)4096)]
	private extern int get_hashcode();

	public override bool Equals(object obj)
	{
		return ValueType.DefaultEquals(this, obj);
	}

	public override int GetHashCode()
	{
		return get_hashcode();
	}

	public override string ToString()
	{
		return InternalFormat((RuntimeType)GetType(), GetValue());
	}

	[Obsolete("The provider argument is not used. Please use ToString(String).")]
	public string ToString(string format, IFormatProvider provider)
	{
		return ToString(format);
	}

	public int CompareTo(object target)
	{
		if (this == null)
		{
			throw new NullReferenceException();
		}
		int num = InternalCompareTo(this, target);
		if (num < 2)
		{
			return num;
		}
		if (num == 2)
		{
			Type type = GetType();
			Type type2 = target.GetType();
			throw new ArgumentException(Environment.GetResourceString("Object must be the same type as the enum. The type passed in was '{0}'; the enum type was '{1}'.", type2.ToString(), type.ToString()));
		}
		throw new InvalidOperationException(Environment.GetResourceString("Unknown enum type."));
	}

	public string ToString(string format)
	{
		if (format == null || format.Length == 0)
		{
			format = "G";
		}
		if (string.Compare(format, "G", StringComparison.OrdinalIgnoreCase) == 0)
		{
			return ToString();
		}
		if (string.Compare(format, "D", StringComparison.OrdinalIgnoreCase) == 0)
		{
			return GetValue().ToString();
		}
		if (string.Compare(format, "X", StringComparison.OrdinalIgnoreCase) == 0)
		{
			return InternalFormattedHexString(GetValue());
		}
		if (string.Compare(format, "F", StringComparison.OrdinalIgnoreCase) == 0)
		{
			return InternalFlagsFormat((RuntimeType)GetType(), GetValue());
		}
		throw new FormatException(Environment.GetResourceString("Format String can be only \"G\", \"g\", \"X\", \"x\", \"F\", \"f\", \"D\" or \"d\"."));
	}

	[Obsolete("The provider argument is not used. Please use ToString().")]
	public string ToString(IFormatProvider provider)
	{
		return ToString();
	}

	public bool HasFlag(Enum flag)
	{
		if (flag == null)
		{
			throw new ArgumentNullException("flag");
		}
		if (!GetType().IsEquivalentTo(flag.GetType()))
		{
			throw new ArgumentException(Environment.GetResourceString("The argument type, '{0}', is not the same as the enum type '{1}'.", flag.GetType(), GetType()));
		}
		return InternalHasFlag(flag);
	}

	public TypeCode GetTypeCode()
	{
		Type underlyingType = GetUnderlyingType(GetType());
		if (underlyingType == typeof(int))
		{
			return TypeCode.Int32;
		}
		if (underlyingType == typeof(sbyte))
		{
			return TypeCode.SByte;
		}
		if (underlyingType == typeof(short))
		{
			return TypeCode.Int16;
		}
		if (underlyingType == typeof(long))
		{
			return TypeCode.Int64;
		}
		if (underlyingType == typeof(uint))
		{
			return TypeCode.UInt32;
		}
		if (underlyingType == typeof(byte))
		{
			return TypeCode.Byte;
		}
		if (underlyingType == typeof(ushort))
		{
			return TypeCode.UInt16;
		}
		if (underlyingType == typeof(ulong))
		{
			return TypeCode.UInt64;
		}
		if (underlyingType == typeof(bool))
		{
			return TypeCode.Boolean;
		}
		if (underlyingType == typeof(char))
		{
			return TypeCode.Char;
		}
		throw new InvalidOperationException(Environment.GetResourceString("Unknown enum type."));
	}

	bool IConvertible.ToBoolean(IFormatProvider provider)
	{
		return Convert.ToBoolean(GetValue(), CultureInfo.CurrentCulture);
	}

	char IConvertible.ToChar(IFormatProvider provider)
	{
		return Convert.ToChar(GetValue(), CultureInfo.CurrentCulture);
	}

	sbyte IConvertible.ToSByte(IFormatProvider provider)
	{
		return Convert.ToSByte(GetValue(), CultureInfo.CurrentCulture);
	}

	byte IConvertible.ToByte(IFormatProvider provider)
	{
		return Convert.ToByte(GetValue(), CultureInfo.CurrentCulture);
	}

	short IConvertible.ToInt16(IFormatProvider provider)
	{
		return Convert.ToInt16(GetValue(), CultureInfo.CurrentCulture);
	}

	ushort IConvertible.ToUInt16(IFormatProvider provider)
	{
		return Convert.ToUInt16(GetValue(), CultureInfo.CurrentCulture);
	}

	int IConvertible.ToInt32(IFormatProvider provider)
	{
		return Convert.ToInt32(GetValue(), CultureInfo.CurrentCulture);
	}

	uint IConvertible.ToUInt32(IFormatProvider provider)
	{
		return Convert.ToUInt32(GetValue(), CultureInfo.CurrentCulture);
	}

	long IConvertible.ToInt64(IFormatProvider provider)
	{
		return Convert.ToInt64(GetValue(), CultureInfo.CurrentCulture);
	}

	ulong IConvertible.ToUInt64(IFormatProvider provider)
	{
		return Convert.ToUInt64(GetValue(), CultureInfo.CurrentCulture);
	}

	float IConvertible.ToSingle(IFormatProvider provider)
	{
		return Convert.ToSingle(GetValue(), CultureInfo.CurrentCulture);
	}

	double IConvertible.ToDouble(IFormatProvider provider)
	{
		return Convert.ToDouble(GetValue(), CultureInfo.CurrentCulture);
	}

	decimal IConvertible.ToDecimal(IFormatProvider provider)
	{
		return Convert.ToDecimal(GetValue(), CultureInfo.CurrentCulture);
	}

	DateTime IConvertible.ToDateTime(IFormatProvider provider)
	{
		throw new InvalidCastException(Environment.GetResourceString("Invalid cast from '{0}' to '{1}'.", "Enum", "DateTime"));
	}

	object IConvertible.ToType(Type type, IFormatProvider provider)
	{
		return Convert.DefaultToType(this, type, provider);
	}

	[ComVisible(true)]
	[CLSCompliant(false)]
	public static object ToObject(Type enumType, sbyte value)
	{
		if (enumType == null)
		{
			throw new ArgumentNullException("enumType");
		}
		if (!enumType.IsEnum)
		{
			throw new ArgumentException(Environment.GetResourceString("Type provided must be an Enum."), "enumType");
		}
		RuntimeType obj = enumType as RuntimeType;
		if (obj == null)
		{
			throw new ArgumentException(Environment.GetResourceString("Type must be a type provided by the runtime."), "enumType");
		}
		return InternalBoxEnum(obj, value);
	}

	[ComVisible(true)]
	public static object ToObject(Type enumType, short value)
	{
		if (enumType == null)
		{
			throw new ArgumentNullException("enumType");
		}
		if (!enumType.IsEnum)
		{
			throw new ArgumentException(Environment.GetResourceString("Type provided must be an Enum."), "enumType");
		}
		RuntimeType obj = enumType as RuntimeType;
		if (obj == null)
		{
			throw new ArgumentException(Environment.GetResourceString("Type must be a type provided by the runtime."), "enumType");
		}
		return InternalBoxEnum(obj, value);
	}

	[ComVisible(true)]
	public static object ToObject(Type enumType, int value)
	{
		if (enumType == null)
		{
			throw new ArgumentNullException("enumType");
		}
		if (!enumType.IsEnum)
		{
			throw new ArgumentException(Environment.GetResourceString("Type provided must be an Enum."), "enumType");
		}
		RuntimeType obj = enumType as RuntimeType;
		if (obj == null)
		{
			throw new ArgumentException(Environment.GetResourceString("Type must be a type provided by the runtime."), "enumType");
		}
		return InternalBoxEnum(obj, value);
	}

	[ComVisible(true)]
	public static object ToObject(Type enumType, byte value)
	{
		if (enumType == null)
		{
			throw new ArgumentNullException("enumType");
		}
		if (!enumType.IsEnum)
		{
			throw new ArgumentException(Environment.GetResourceString("Type provided must be an Enum."), "enumType");
		}
		RuntimeType obj = enumType as RuntimeType;
		if (obj == null)
		{
			throw new ArgumentException(Environment.GetResourceString("Type must be a type provided by the runtime."), "enumType");
		}
		return InternalBoxEnum(obj, value);
	}

	[CLSCompliant(false)]
	[ComVisible(true)]
	public static object ToObject(Type enumType, ushort value)
	{
		if (enumType == null)
		{
			throw new ArgumentNullException("enumType");
		}
		if (!enumType.IsEnum)
		{
			throw new ArgumentException(Environment.GetResourceString("Type provided must be an Enum."), "enumType");
		}
		RuntimeType obj = enumType as RuntimeType;
		if (obj == null)
		{
			throw new ArgumentException(Environment.GetResourceString("Type must be a type provided by the runtime."), "enumType");
		}
		return InternalBoxEnum(obj, value);
	}

	[CLSCompliant(false)]
	[ComVisible(true)]
	public static object ToObject(Type enumType, uint value)
	{
		if (enumType == null)
		{
			throw new ArgumentNullException("enumType");
		}
		if (!enumType.IsEnum)
		{
			throw new ArgumentException(Environment.GetResourceString("Type provided must be an Enum."), "enumType");
		}
		RuntimeType obj = enumType as RuntimeType;
		if (obj == null)
		{
			throw new ArgumentException(Environment.GetResourceString("Type must be a type provided by the runtime."), "enumType");
		}
		return InternalBoxEnum(obj, value);
	}

	[ComVisible(true)]
	public static object ToObject(Type enumType, long value)
	{
		if (enumType == null)
		{
			throw new ArgumentNullException("enumType");
		}
		if (!enumType.IsEnum)
		{
			throw new ArgumentException(Environment.GetResourceString("Type provided must be an Enum."), "enumType");
		}
		RuntimeType obj = enumType as RuntimeType;
		if (obj == null)
		{
			throw new ArgumentException(Environment.GetResourceString("Type must be a type provided by the runtime."), "enumType");
		}
		return InternalBoxEnum(obj, value);
	}

	[ComVisible(true)]
	[CLSCompliant(false)]
	public static object ToObject(Type enumType, ulong value)
	{
		if (enumType == null)
		{
			throw new ArgumentNullException("enumType");
		}
		if (!enumType.IsEnum)
		{
			throw new ArgumentException(Environment.GetResourceString("Type provided must be an Enum."), "enumType");
		}
		RuntimeType obj = enumType as RuntimeType;
		if (obj == null)
		{
			throw new ArgumentException(Environment.GetResourceString("Type must be a type provided by the runtime."), "enumType");
		}
		return InternalBoxEnum(obj, (long)value);
	}

	private static object ToObject(Type enumType, char value)
	{
		if (enumType == null)
		{
			throw new ArgumentNullException("enumType");
		}
		if (!enumType.IsEnum)
		{
			throw new ArgumentException(Environment.GetResourceString("Type provided must be an Enum."), "enumType");
		}
		RuntimeType obj = enumType as RuntimeType;
		if (obj == null)
		{
			throw new ArgumentException(Environment.GetResourceString("Type must be a type provided by the runtime."), "enumType");
		}
		return InternalBoxEnum(obj, value);
	}

	private static object ToObject(Type enumType, bool value)
	{
		if (enumType == null)
		{
			throw new ArgumentNullException("enumType");
		}
		if (!enumType.IsEnum)
		{
			throw new ArgumentException(Environment.GetResourceString("Type provided must be an Enum."), "enumType");
		}
		RuntimeType obj = enumType as RuntimeType;
		if (obj == null)
		{
			throw new ArgumentException(Environment.GetResourceString("Type must be a type provided by the runtime."), "enumType");
		}
		return InternalBoxEnum(obj, value ? 1 : 0);
	}

	public static TEnum Parse<TEnum>(string value) where TEnum : struct
	{
		return Parse<TEnum>(value, ignoreCase: false);
	}

	public static TEnum Parse<TEnum>(string value, bool ignoreCase) where TEnum : struct
	{
		EnumResult parseResult = new EnumResult
		{
			canThrow = true
		};
		if (TryParseEnum(typeof(TEnum), value, ignoreCase, ref parseResult))
		{
			return (TEnum)parseResult.parsedEnum;
		}
		throw parseResult.GetEnumParseException();
	}

	public static bool TryParse(Type enumType, string value, bool ignoreCase, out object result)
	{
		result = null;
		EnumResult parseResult = default(EnumResult);
		bool num = TryParseEnum(enumType, value, ignoreCase, ref parseResult);
		if (num)
		{
			result = parseResult.parsedEnum;
		}
		return num;
	}

	public static bool TryParse(Type enumType, string value, out object result)
	{
		return TryParse(enumType, value, ignoreCase: false, out result);
	}
}
