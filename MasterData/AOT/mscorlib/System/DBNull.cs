using System.Runtime.Serialization;

namespace System;

[Serializable]
public sealed class DBNull : ISerializable, IConvertible
{
	public static readonly DBNull Value = new DBNull();

	private DBNull()
	{
	}

	private DBNull(SerializationInfo info, StreamingContext context)
	{
		throw new NotSupportedException("Only one DBNull instance may exist, and calls to DBNull deserialization methods are not allowed.");
	}

	public void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		UnitySerializationHolder.GetUnitySerializationInfo(info, 2);
	}

	public override string ToString()
	{
		return string.Empty;
	}

	public string ToString(IFormatProvider provider)
	{
		return string.Empty;
	}

	public TypeCode GetTypeCode()
	{
		return TypeCode.DBNull;
	}

	bool IConvertible.ToBoolean(IFormatProvider provider)
	{
		throw new InvalidCastException("Object cannot be cast from DBNull to other types.");
	}

	char IConvertible.ToChar(IFormatProvider provider)
	{
		throw new InvalidCastException("Object cannot be cast from DBNull to other types.");
	}

	sbyte IConvertible.ToSByte(IFormatProvider provider)
	{
		throw new InvalidCastException("Object cannot be cast from DBNull to other types.");
	}

	byte IConvertible.ToByte(IFormatProvider provider)
	{
		throw new InvalidCastException("Object cannot be cast from DBNull to other types.");
	}

	short IConvertible.ToInt16(IFormatProvider provider)
	{
		throw new InvalidCastException("Object cannot be cast from DBNull to other types.");
	}

	ushort IConvertible.ToUInt16(IFormatProvider provider)
	{
		throw new InvalidCastException("Object cannot be cast from DBNull to other types.");
	}

	int IConvertible.ToInt32(IFormatProvider provider)
	{
		throw new InvalidCastException("Object cannot be cast from DBNull to other types.");
	}

	uint IConvertible.ToUInt32(IFormatProvider provider)
	{
		throw new InvalidCastException("Object cannot be cast from DBNull to other types.");
	}

	long IConvertible.ToInt64(IFormatProvider provider)
	{
		throw new InvalidCastException("Object cannot be cast from DBNull to other types.");
	}

	ulong IConvertible.ToUInt64(IFormatProvider provider)
	{
		throw new InvalidCastException("Object cannot be cast from DBNull to other types.");
	}

	float IConvertible.ToSingle(IFormatProvider provider)
	{
		throw new InvalidCastException("Object cannot be cast from DBNull to other types.");
	}

	double IConvertible.ToDouble(IFormatProvider provider)
	{
		throw new InvalidCastException("Object cannot be cast from DBNull to other types.");
	}

	decimal IConvertible.ToDecimal(IFormatProvider provider)
	{
		throw new InvalidCastException("Object cannot be cast from DBNull to other types.");
	}

	DateTime IConvertible.ToDateTime(IFormatProvider provider)
	{
		throw new InvalidCastException("Object cannot be cast from DBNull to other types.");
	}

	object IConvertible.ToType(Type type, IFormatProvider provider)
	{
		return Convert.DefaultToType(this, type, provider);
	}
}
