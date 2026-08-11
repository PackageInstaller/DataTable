using System;

namespace GameFramework.Runtime;

public class PrimitiveTypeEncoder : ITypeEncoder
{
	private int priority = 1000;

	public int Priority
	{
		get
		{
			return priority;
		}
		set
		{
			priority = value;
		}
	}

	public bool IsSupport(Type type)
	{
		TypeCode typeCode = Type.GetTypeCode(type);
		TypeCode typeCode2 = typeCode;
		TypeCode typeCode3 = typeCode2;
		if ((uint)(typeCode3 - 3) <= 13u || typeCode3 == TypeCode.String)
		{
			return true;
		}
		return false;
	}

	public string Encode(object value)
	{
		TypeCode typeCode = Convert.GetTypeCode(value);
		TypeCode typeCode2 = typeCode;
		TypeCode typeCode3 = typeCode2;
		if ((uint)(typeCode3 - 3) <= 13u || typeCode3 == TypeCode.String)
		{
			return Convert.ToString(value);
		}
		throw new NotSupportedException();
	}

	public object Decode(Type type, string input)
	{
		switch (Type.GetTypeCode(type))
		{
		case TypeCode.String:
			return input;
		case TypeCode.Boolean:
		case TypeCode.Char:
		case TypeCode.SByte:
		case TypeCode.Byte:
		case TypeCode.Int16:
		case TypeCode.UInt16:
		case TypeCode.Int32:
		case TypeCode.UInt32:
		case TypeCode.Int64:
		case TypeCode.UInt64:
		case TypeCode.Single:
		case TypeCode.Double:
		case TypeCode.Decimal:
		case TypeCode.DateTime:
			return Convert.ChangeType(input, type);
		default:
			throw new NotSupportedException();
		}
	}
}
