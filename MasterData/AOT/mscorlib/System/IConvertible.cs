namespace System;

[CLSCompliant(false)]
public interface IConvertible
{
	TypeCode GetTypeCode();

	bool ToBoolean(IFormatProvider provider);

	char ToChar(IFormatProvider provider);

	sbyte ToSByte(IFormatProvider provider);

	byte ToByte(IFormatProvider provider);

	short ToInt16(IFormatProvider provider);

	ushort ToUInt16(IFormatProvider provider);

	int ToInt32(IFormatProvider provider);

	uint ToUInt32(IFormatProvider provider);

	long ToInt64(IFormatProvider provider);

	ulong ToUInt64(IFormatProvider provider);

	float ToSingle(IFormatProvider provider);

	double ToDouble(IFormatProvider provider);

	decimal ToDecimal(IFormatProvider provider);

	DateTime ToDateTime(IFormatProvider provider);

	string ToString(IFormatProvider provider);

	object ToType(Type conversionType, IFormatProvider provider);
}
