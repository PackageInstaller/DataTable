using System.Dynamic.Utils;

namespace System.Linq.Expressions.Interpreter;

internal static class ScriptingRuntimeHelpers
{
	public static object Int32ToObject(int i)
	{
		return i switch
		{
			-1 => Utils.BoxedIntM1, 
			0 => Utils.BoxedInt0, 
			1 => Utils.BoxedInt1, 
			2 => Utils.BoxedInt2, 
			3 => Utils.BoxedInt3, 
			_ => i, 
		};
	}

	internal static object GetPrimitiveDefaultValue(Type type)
	{
		object obj;
		switch (type.GetTypeCode())
		{
		case TypeCode.Boolean:
			obj = Utils.BoxedFalse;
			break;
		case TypeCode.SByte:
			obj = Utils.BoxedDefaultSByte;
			break;
		case TypeCode.Byte:
			obj = Utils.BoxedDefaultByte;
			break;
		case TypeCode.Char:
			obj = Utils.BoxedDefaultChar;
			break;
		case TypeCode.Int16:
			obj = Utils.BoxedDefaultInt16;
			break;
		case TypeCode.Int32:
			obj = Utils.BoxedInt0;
			break;
		case TypeCode.Int64:
			obj = Utils.BoxedDefaultInt64;
			break;
		case TypeCode.UInt16:
			obj = Utils.BoxedDefaultUInt16;
			break;
		case TypeCode.UInt32:
			obj = Utils.BoxedDefaultUInt32;
			break;
		case TypeCode.UInt64:
			obj = Utils.BoxedDefaultUInt64;
			break;
		case TypeCode.Single:
			return Utils.BoxedDefaultSingle;
		case TypeCode.Double:
			return Utils.BoxedDefaultDouble;
		case TypeCode.DateTime:
			return Utils.BoxedDefaultDateTime;
		case TypeCode.Decimal:
			return Utils.BoxedDefaultDecimal;
		default:
			return null;
		}
		if (type.IsEnum)
		{
			obj = Enum.ToObject(type, obj);
		}
		return obj;
	}
}
