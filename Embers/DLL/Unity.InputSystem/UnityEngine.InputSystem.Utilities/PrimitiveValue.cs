using System;
using System.Globalization;
using System.Runtime.InteropServices;
using Unity.Collections.LowLevel.Unsafe;

namespace UnityEngine.InputSystem.Utilities;

[StructLayout(LayoutKind.Explicit)]
public struct PrimitiveValue : IEquatable<PrimitiveValue>, IConvertible
{
	[FieldOffset(0)]
	private TypeCode m_Type;

	[FieldOffset(4)]
	private bool m_BoolValue;

	[FieldOffset(4)]
	private char m_CharValue;

	[FieldOffset(4)]
	private byte m_ByteValue;

	[FieldOffset(4)]
	private sbyte m_SByteValue;

	[FieldOffset(4)]
	private short m_ShortValue;

	[FieldOffset(4)]
	private ushort m_UShortValue;

	[FieldOffset(4)]
	private int m_IntValue;

	[FieldOffset(4)]
	private uint m_UIntValue;

	[FieldOffset(4)]
	private long m_LongValue;

	[FieldOffset(4)]
	private ulong m_ULongValue;

	[FieldOffset(4)]
	private float m_FloatValue;

	[FieldOffset(4)]
	private double m_DoubleValue;

	internal unsafe byte* valuePtr => (byte*)UnsafeUtility.AddressOf(ref this) + 4;

	public TypeCode type => m_Type;

	public bool isEmpty => type == TypeCode.Empty;

	public PrimitiveValue(bool value)
	{
		this = default(PrimitiveValue);
		m_Type = TypeCode.Boolean;
		m_BoolValue = value;
	}

	public PrimitiveValue(char value)
	{
		this = default(PrimitiveValue);
		m_Type = TypeCode.Char;
		m_CharValue = value;
	}

	public PrimitiveValue(byte value)
	{
		this = default(PrimitiveValue);
		m_Type = TypeCode.Byte;
		m_ByteValue = value;
	}

	public PrimitiveValue(sbyte value)
	{
		this = default(PrimitiveValue);
		m_Type = TypeCode.SByte;
		m_SByteValue = value;
	}

	public PrimitiveValue(short value)
	{
		this = default(PrimitiveValue);
		m_Type = TypeCode.Int16;
		m_ShortValue = value;
	}

	public PrimitiveValue(ushort value)
	{
		this = default(PrimitiveValue);
		m_Type = TypeCode.UInt16;
		m_UShortValue = value;
	}

	public PrimitiveValue(int value)
	{
		this = default(PrimitiveValue);
		m_Type = TypeCode.Int32;
		m_IntValue = value;
	}

	public PrimitiveValue(uint value)
	{
		this = default(PrimitiveValue);
		m_Type = TypeCode.UInt32;
		m_UIntValue = value;
	}

	public PrimitiveValue(long value)
	{
		this = default(PrimitiveValue);
		m_Type = TypeCode.Int64;
		m_LongValue = value;
	}

	public PrimitiveValue(ulong value)
	{
		this = default(PrimitiveValue);
		m_Type = TypeCode.UInt64;
		m_ULongValue = value;
	}

	public PrimitiveValue(float value)
	{
		this = default(PrimitiveValue);
		m_Type = TypeCode.Single;
		m_FloatValue = value;
	}

	public PrimitiveValue(double value)
	{
		this = default(PrimitiveValue);
		m_Type = TypeCode.Double;
		m_DoubleValue = value;
	}

	public PrimitiveValue ConvertTo(TypeCode type)
	{
		return type switch
		{
			TypeCode.Boolean => ToBoolean(), 
			TypeCode.Char => ToChar(), 
			TypeCode.Byte => ToByte(), 
			TypeCode.SByte => ToSByte(), 
			TypeCode.Int16 => ToInt16(), 
			TypeCode.Int32 => ToInt32(), 
			TypeCode.Int64 => ToInt64(), 
			TypeCode.UInt16 => ToInt16(), 
			TypeCode.UInt32 => ToInt32(), 
			TypeCode.UInt64 => ToUInt64(), 
			TypeCode.Single => ToSingle(), 
			TypeCode.Double => ToDouble(), 
			TypeCode.Empty => default(PrimitiveValue), 
			_ => throw new ArgumentException($"Don't know how to convert PrimitiveValue to '{type}'", "type"), 
		};
	}

	public unsafe bool Equals(PrimitiveValue other)
	{
		if (m_Type != other.m_Type)
		{
			return false;
		}
		void* ptr = UnsafeUtility.AddressOf(ref m_DoubleValue);
		void* ptr2 = UnsafeUtility.AddressOf(ref other.m_DoubleValue);
		return UnsafeUtility.MemCmp(ptr, ptr2, 8L) == 0;
	}

	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		if (obj is PrimitiveValue other)
		{
			return Equals(other);
		}
		if (obj is bool || obj is char || obj is byte || obj is sbyte || obj is short || obj is ushort || obj is int || obj is uint || obj is long || obj is ulong || obj is float || obj is double)
		{
			return Equals(FromObject(obj));
		}
		return false;
	}

	public static bool operator ==(PrimitiveValue left, PrimitiveValue right)
	{
		return left.Equals(right);
	}

	public static bool operator !=(PrimitiveValue left, PrimitiveValue right)
	{
		return !left.Equals(right);
	}

	public unsafe override int GetHashCode()
	{
		fixed (double* doubleValue = &m_DoubleValue)
		{
			return (m_Type.GetHashCode() * 397) ^ doubleValue->GetHashCode();
		}
	}

	public override string ToString()
	{
		switch (type)
		{
		case TypeCode.Boolean:
			if (!m_BoolValue)
			{
				return "false";
			}
			return "true";
		case TypeCode.Char:
			return "'" + m_CharValue + "'";
		case TypeCode.Byte:
			return m_ByteValue.ToString(CultureInfo.InvariantCulture.NumberFormat);
		case TypeCode.SByte:
			return m_SByteValue.ToString(CultureInfo.InvariantCulture.NumberFormat);
		case TypeCode.Int16:
			return m_ShortValue.ToString(CultureInfo.InvariantCulture.NumberFormat);
		case TypeCode.UInt16:
			return m_UShortValue.ToString(CultureInfo.InvariantCulture.NumberFormat);
		case TypeCode.Int32:
			return m_IntValue.ToString(CultureInfo.InvariantCulture.NumberFormat);
		case TypeCode.UInt32:
			return m_UIntValue.ToString(CultureInfo.InvariantCulture.NumberFormat);
		case TypeCode.Int64:
			return m_LongValue.ToString(CultureInfo.InvariantCulture.NumberFormat);
		case TypeCode.UInt64:
			return m_ULongValue.ToString(CultureInfo.InvariantCulture.NumberFormat);
		case TypeCode.Single:
			return m_FloatValue.ToString(CultureInfo.InvariantCulture.NumberFormat);
		case TypeCode.Double:
			return m_DoubleValue.ToString(CultureInfo.InvariantCulture.NumberFormat);
		default:
			return string.Empty;
		}
	}

	public static PrimitiveValue FromString(string value)
	{
		if (string.IsNullOrEmpty(value))
		{
			return default(PrimitiveValue);
		}
		if (value.Equals("true", StringComparison.InvariantCultureIgnoreCase))
		{
			return new PrimitiveValue(value: true);
		}
		if (value.Equals("false", StringComparison.InvariantCultureIgnoreCase))
		{
			return new PrimitiveValue(value: false);
		}
		if ((value.Contains('.') || value.Contains("e") || value.Contains("E") || value.Contains("infinity", StringComparison.InvariantCultureIgnoreCase)) && double.TryParse(value, NumberStyles.Float, CultureInfo.InvariantCulture, out var result))
		{
			return new PrimitiveValue(result);
		}
		if (long.TryParse(value, NumberStyles.Integer, CultureInfo.InvariantCulture, out var result2))
		{
			return new PrimitiveValue(result2);
		}
		if (value.IndexOf("0x", StringComparison.InvariantCultureIgnoreCase) != -1)
		{
			string text = value.TrimStart();
			if (text.StartsWith("0x"))
			{
				text = text.Substring(2);
			}
			if (long.TryParse(text, NumberStyles.HexNumber, CultureInfo.InvariantCulture, out var result3))
			{
				return new PrimitiveValue(result3);
			}
		}
		throw new NotImplementedException();
	}

	public TypeCode GetTypeCode()
	{
		return type;
	}

	public bool ToBoolean(IFormatProvider provider = null)
	{
		return type switch
		{
			TypeCode.Boolean => m_BoolValue, 
			TypeCode.Char => m_CharValue != '\0', 
			TypeCode.Byte => m_ByteValue != 0, 
			TypeCode.SByte => m_SByteValue != 0, 
			TypeCode.Int16 => m_ShortValue != 0, 
			TypeCode.UInt16 => m_UShortValue != 0, 
			TypeCode.Int32 => m_IntValue != 0, 
			TypeCode.UInt32 => m_UIntValue != 0, 
			TypeCode.Int64 => m_LongValue != 0, 
			TypeCode.UInt64 => m_ULongValue != 0, 
			TypeCode.Single => !Mathf.Approximately(m_FloatValue, 0f), 
			TypeCode.Double => NumberHelpers.Approximately(m_DoubleValue, 0.0), 
			_ => false, 
		};
	}

	public byte ToByte(IFormatProvider provider = null)
	{
		return (byte)ToInt64(provider);
	}

	public char ToChar(IFormatProvider provider = null)
	{
		switch (type)
		{
		case TypeCode.Char:
			return m_CharValue;
		case TypeCode.Int16:
		case TypeCode.UInt16:
		case TypeCode.Int32:
		case TypeCode.UInt32:
		case TypeCode.Int64:
		case TypeCode.UInt64:
			return (char)ToInt64(provider);
		default:
			return '\0';
		}
	}

	public DateTime ToDateTime(IFormatProvider provider = null)
	{
		throw new NotSupportedException("Converting PrimitiveValue to DateTime");
	}

	public decimal ToDecimal(IFormatProvider provider = null)
	{
		return new decimal(ToDouble(provider));
	}

	public double ToDouble(IFormatProvider provider = null)
	{
		switch (type)
		{
		case TypeCode.Boolean:
			if (m_BoolValue)
			{
				return 1.0;
			}
			return 0.0;
		case TypeCode.Char:
			return (int)m_CharValue;
		case TypeCode.Byte:
			return (int)m_ByteValue;
		case TypeCode.SByte:
			return m_SByteValue;
		case TypeCode.Int16:
			return m_ShortValue;
		case TypeCode.UInt16:
			return (int)m_UShortValue;
		case TypeCode.Int32:
			return m_IntValue;
		case TypeCode.UInt32:
			return m_UIntValue;
		case TypeCode.Int64:
			return m_LongValue;
		case TypeCode.UInt64:
			return m_ULongValue;
		case TypeCode.Single:
			return m_FloatValue;
		case TypeCode.Double:
			return m_DoubleValue;
		default:
			return 0.0;
		}
	}

	public short ToInt16(IFormatProvider provider = null)
	{
		return (short)ToInt64(provider);
	}

	public int ToInt32(IFormatProvider provider = null)
	{
		return (int)ToInt64(provider);
	}

	public long ToInt64(IFormatProvider provider = null)
	{
		switch (type)
		{
		case TypeCode.Boolean:
			if (m_BoolValue)
			{
				return 1L;
			}
			return 0L;
		case TypeCode.Char:
			return m_CharValue;
		case TypeCode.Byte:
			return m_ByteValue;
		case TypeCode.SByte:
			return m_SByteValue;
		case TypeCode.Int16:
			return m_ShortValue;
		case TypeCode.UInt16:
			return m_UShortValue;
		case TypeCode.Int32:
			return m_IntValue;
		case TypeCode.UInt32:
			return m_UIntValue;
		case TypeCode.Int64:
			return m_LongValue;
		case TypeCode.UInt64:
			return (long)m_ULongValue;
		case TypeCode.Single:
			return (long)m_FloatValue;
		case TypeCode.Double:
			return (long)m_DoubleValue;
		default:
			return 0L;
		}
	}

	public sbyte ToSByte(IFormatProvider provider = null)
	{
		return (sbyte)ToInt64(provider);
	}

	public float ToSingle(IFormatProvider provider = null)
	{
		return (float)ToDouble(provider);
	}

	public string ToString(IFormatProvider provider)
	{
		return ToString();
	}

	public object ToType(Type conversionType, IFormatProvider provider)
	{
		throw new NotSupportedException();
	}

	public ushort ToUInt16(IFormatProvider provider = null)
	{
		return (ushort)ToUInt64();
	}

	public uint ToUInt32(IFormatProvider provider = null)
	{
		return (uint)ToUInt64();
	}

	public ulong ToUInt64(IFormatProvider provider = null)
	{
		switch (type)
		{
		case TypeCode.Boolean:
			if (m_BoolValue)
			{
				return 1uL;
			}
			return 0uL;
		case TypeCode.Char:
			return m_CharValue;
		case TypeCode.Byte:
			return m_ByteValue;
		case TypeCode.SByte:
			return (ulong)m_SByteValue;
		case TypeCode.Int16:
			return (ulong)m_ShortValue;
		case TypeCode.UInt16:
			return m_UShortValue;
		case TypeCode.Int32:
			return (ulong)m_IntValue;
		case TypeCode.UInt32:
			return m_UIntValue;
		case TypeCode.Int64:
			return (ulong)m_LongValue;
		case TypeCode.UInt64:
			return m_ULongValue;
		case TypeCode.Single:
			return (ulong)m_FloatValue;
		case TypeCode.Double:
			return (ulong)m_DoubleValue;
		default:
			return 0uL;
		}
	}

	public object ToObject()
	{
		return m_Type switch
		{
			TypeCode.Boolean => m_BoolValue, 
			TypeCode.Char => m_CharValue, 
			TypeCode.Byte => m_ByteValue, 
			TypeCode.SByte => m_SByteValue, 
			TypeCode.Int16 => m_ShortValue, 
			TypeCode.UInt16 => m_UShortValue, 
			TypeCode.Int32 => m_IntValue, 
			TypeCode.UInt32 => m_UIntValue, 
			TypeCode.Int64 => m_LongValue, 
			TypeCode.UInt64 => m_ULongValue, 
			TypeCode.Single => m_FloatValue, 
			TypeCode.Double => m_DoubleValue, 
			_ => null, 
		};
	}

	public static PrimitiveValue From<TValue>(TValue value) where TValue : struct
	{
		Type type = typeof(TValue);
		if (type.IsEnum)
		{
			type = type.GetEnumUnderlyingType();
		}
		return Type.GetTypeCode(type) switch
		{
			TypeCode.Boolean => new PrimitiveValue(Convert.ToBoolean(value)), 
			TypeCode.Char => new PrimitiveValue(Convert.ToChar(value)), 
			TypeCode.Byte => new PrimitiveValue(Convert.ToByte(value)), 
			TypeCode.SByte => new PrimitiveValue(Convert.ToSByte(value)), 
			TypeCode.Int16 => new PrimitiveValue(Convert.ToInt16(value)), 
			TypeCode.Int32 => new PrimitiveValue(Convert.ToInt32(value)), 
			TypeCode.Int64 => new PrimitiveValue(Convert.ToInt64(value)), 
			TypeCode.UInt16 => new PrimitiveValue(Convert.ToUInt16(value)), 
			TypeCode.UInt32 => new PrimitiveValue(Convert.ToUInt32(value)), 
			TypeCode.UInt64 => new PrimitiveValue(Convert.ToUInt64(value)), 
			TypeCode.Single => new PrimitiveValue(Convert.ToSingle(value)), 
			TypeCode.Double => new PrimitiveValue(Convert.ToDouble(value)), 
			_ => throw new ArgumentException($"Cannot convert value '{value}' of type '{typeof(TValue).Name}' to PrimitiveValue", "value"), 
		};
	}

	public static PrimitiveValue FromObject(object value)
	{
		if (value == null)
		{
			return default(PrimitiveValue);
		}
		if (value is string value2)
		{
			return FromString(value2);
		}
		if (value is bool value3)
		{
			return new PrimitiveValue(value3);
		}
		if (value is char value4)
		{
			return new PrimitiveValue(value4);
		}
		if (value is byte value5)
		{
			return new PrimitiveValue(value5);
		}
		if (value is sbyte value6)
		{
			return new PrimitiveValue(value6);
		}
		if (value is short value7)
		{
			return new PrimitiveValue(value7);
		}
		if (value is ushort value8)
		{
			return new PrimitiveValue(value8);
		}
		if (value is int value9)
		{
			return new PrimitiveValue(value9);
		}
		if (value is uint value10)
		{
			return new PrimitiveValue(value10);
		}
		if (value is long value11)
		{
			return new PrimitiveValue(value11);
		}
		if (value is ulong value12)
		{
			return new PrimitiveValue(value12);
		}
		if (value is float value13)
		{
			return new PrimitiveValue(value13);
		}
		if (value is double value14)
		{
			return new PrimitiveValue(value14);
		}
		if (value is Enum)
		{
			switch (Type.GetTypeCode(value.GetType().GetEnumUnderlyingType()))
			{
			case TypeCode.Byte:
				return new PrimitiveValue((byte)value);
			case TypeCode.SByte:
				return new PrimitiveValue((sbyte)value);
			case TypeCode.Int16:
				return new PrimitiveValue((short)value);
			case TypeCode.Int32:
				return new PrimitiveValue((int)value);
			case TypeCode.Int64:
				return new PrimitiveValue((long)value);
			case TypeCode.UInt16:
				return new PrimitiveValue((ushort)value);
			case TypeCode.UInt32:
				return new PrimitiveValue((uint)value);
			case TypeCode.UInt64:
				return new PrimitiveValue((ulong)value);
			}
		}
		throw new ArgumentException($"Cannot convert '{value}' to primitive value", "value");
	}

	public static implicit operator PrimitiveValue(bool value)
	{
		return new PrimitiveValue(value);
	}

	public static implicit operator PrimitiveValue(char value)
	{
		return new PrimitiveValue(value);
	}

	public static implicit operator PrimitiveValue(byte value)
	{
		return new PrimitiveValue(value);
	}

	public static implicit operator PrimitiveValue(sbyte value)
	{
		return new PrimitiveValue(value);
	}

	public static implicit operator PrimitiveValue(short value)
	{
		return new PrimitiveValue(value);
	}

	public static implicit operator PrimitiveValue(ushort value)
	{
		return new PrimitiveValue(value);
	}

	public static implicit operator PrimitiveValue(int value)
	{
		return new PrimitiveValue(value);
	}

	public static implicit operator PrimitiveValue(uint value)
	{
		return new PrimitiveValue(value);
	}

	public static implicit operator PrimitiveValue(long value)
	{
		return new PrimitiveValue(value);
	}

	public static implicit operator PrimitiveValue(ulong value)
	{
		return new PrimitiveValue(value);
	}

	public static implicit operator PrimitiveValue(float value)
	{
		return new PrimitiveValue(value);
	}

	public static implicit operator PrimitiveValue(double value)
	{
		return new PrimitiveValue(value);
	}

	public static PrimitiveValue FromBoolean(bool value)
	{
		return new PrimitiveValue(value);
	}

	public static PrimitiveValue FromChar(char value)
	{
		return new PrimitiveValue(value);
	}

	public static PrimitiveValue FromByte(byte value)
	{
		return new PrimitiveValue(value);
	}

	public static PrimitiveValue FromSByte(sbyte value)
	{
		return new PrimitiveValue(value);
	}

	public static PrimitiveValue FromInt16(short value)
	{
		return new PrimitiveValue(value);
	}

	public static PrimitiveValue FromUInt16(ushort value)
	{
		return new PrimitiveValue(value);
	}

	public static PrimitiveValue FromInt32(int value)
	{
		return new PrimitiveValue(value);
	}

	public static PrimitiveValue FromUInt32(uint value)
	{
		return new PrimitiveValue(value);
	}

	public static PrimitiveValue FromInt64(long value)
	{
		return new PrimitiveValue(value);
	}

	public static PrimitiveValue FromUInt64(ulong value)
	{
		return new PrimitiveValue(value);
	}

	public static PrimitiveValue FromSingle(float value)
	{
		return new PrimitiveValue(value);
	}

	public static PrimitiveValue FromDouble(double value)
	{
		return new PrimitiveValue(value);
	}
}
