using System.Globalization;
using System.Reflection;

namespace System.Runtime.Serialization.Formatters.Binary;

internal sealed class Converter
{
	private static int primitiveTypeEnumLength = 17;

	private static volatile Type[] typeA;

	private static volatile Type[] arrayTypeA;

	private static volatile string[] valueA;

	private static volatile TypeCode[] typeCodeA;

	private static volatile InternalPrimitiveTypeE[] codeA;

	internal static Type typeofISerializable = typeof(ISerializable);

	internal static Type typeofString = typeof(string);

	internal static Type typeofConverter = typeof(Converter);

	internal static Type typeofBoolean = typeof(bool);

	internal static Type typeofByte = typeof(byte);

	internal static Type typeofChar = typeof(char);

	internal static Type typeofDecimal = typeof(decimal);

	internal static Type typeofDouble = typeof(double);

	internal static Type typeofInt16 = typeof(short);

	internal static Type typeofInt32 = typeof(int);

	internal static Type typeofInt64 = typeof(long);

	internal static Type typeofSByte = typeof(sbyte);

	internal static Type typeofSingle = typeof(float);

	internal static Type typeofTimeSpan = typeof(TimeSpan);

	internal static Type typeofDateTime = typeof(DateTime);

	internal static Type typeofUInt16 = typeof(ushort);

	internal static Type typeofUInt32 = typeof(uint);

	internal static Type typeofUInt64 = typeof(ulong);

	internal static Type typeofObject = typeof(object);

	internal static Type typeofSystemVoid = typeof(void);

	internal static Assembly urtAssembly = Assembly.GetAssembly(typeofString);

	internal static string urtAssemblyString = urtAssembly.FullName;

	internal static Type typeofTypeArray = typeof(Type[]);

	internal static Type typeofObjectArray = typeof(object[]);

	internal static Type typeofStringArray = typeof(string[]);

	internal static Type typeofBooleanArray = typeof(bool[]);

	internal static Type typeofByteArray = typeof(byte[]);

	internal static Type typeofCharArray = typeof(char[]);

	internal static Type typeofDecimalArray = typeof(decimal[]);

	internal static Type typeofDoubleArray = typeof(double[]);

	internal static Type typeofInt16Array = typeof(short[]);

	internal static Type typeofInt32Array = typeof(int[]);

	internal static Type typeofInt64Array = typeof(long[]);

	internal static Type typeofSByteArray = typeof(sbyte[]);

	internal static Type typeofSingleArray = typeof(float[]);

	internal static Type typeofTimeSpanArray = typeof(TimeSpan[]);

	internal static Type typeofDateTimeArray = typeof(DateTime[]);

	internal static Type typeofUInt16Array = typeof(ushort[]);

	internal static Type typeofUInt32Array = typeof(uint[]);

	internal static Type typeofUInt64Array = typeof(ulong[]);

	internal static Type typeofMarshalByRefObject = typeof(MarshalByRefObject);

	internal static InternalPrimitiveTypeE ToCode(Type type)
	{
		if ((object)type != null && !type.IsPrimitive)
		{
			if ((object)type == typeofDateTime)
			{
				return InternalPrimitiveTypeE.DateTime;
			}
			if ((object)type == typeofTimeSpan)
			{
				return InternalPrimitiveTypeE.TimeSpan;
			}
			if ((object)type == typeofDecimal)
			{
				return InternalPrimitiveTypeE.Decimal;
			}
			return InternalPrimitiveTypeE.Invalid;
		}
		return ToPrimitiveTypeEnum(Type.GetTypeCode(type));
	}

	internal static bool IsWriteAsByteArray(InternalPrimitiveTypeE code)
	{
		bool result = false;
		switch (code)
		{
		case InternalPrimitiveTypeE.Boolean:
		case InternalPrimitiveTypeE.Byte:
		case InternalPrimitiveTypeE.Char:
		case InternalPrimitiveTypeE.Double:
		case InternalPrimitiveTypeE.Int16:
		case InternalPrimitiveTypeE.Int32:
		case InternalPrimitiveTypeE.Int64:
		case InternalPrimitiveTypeE.SByte:
		case InternalPrimitiveTypeE.Single:
		case InternalPrimitiveTypeE.UInt16:
		case InternalPrimitiveTypeE.UInt32:
		case InternalPrimitiveTypeE.UInt64:
			result = true;
			break;
		}
		return result;
	}

	internal static int TypeLength(InternalPrimitiveTypeE code)
	{
		int result = 0;
		switch (code)
		{
		case InternalPrimitiveTypeE.Boolean:
			result = 1;
			break;
		case InternalPrimitiveTypeE.Char:
			result = 2;
			break;
		case InternalPrimitiveTypeE.Byte:
			result = 1;
			break;
		case InternalPrimitiveTypeE.Double:
			result = 8;
			break;
		case InternalPrimitiveTypeE.Int16:
			result = 2;
			break;
		case InternalPrimitiveTypeE.Int32:
			result = 4;
			break;
		case InternalPrimitiveTypeE.Int64:
			result = 8;
			break;
		case InternalPrimitiveTypeE.SByte:
			result = 1;
			break;
		case InternalPrimitiveTypeE.Single:
			result = 4;
			break;
		case InternalPrimitiveTypeE.UInt16:
			result = 2;
			break;
		case InternalPrimitiveTypeE.UInt32:
			result = 4;
			break;
		case InternalPrimitiveTypeE.UInt64:
			result = 8;
			break;
		}
		return result;
	}

	internal static Type ToArrayType(InternalPrimitiveTypeE code)
	{
		if (arrayTypeA == null)
		{
			InitArrayTypeA();
		}
		return arrayTypeA[(int)code];
	}

	private static void InitTypeA()
	{
		Type[] array = new Type[primitiveTypeEnumLength];
		array[0] = null;
		array[1] = typeofBoolean;
		array[2] = typeofByte;
		array[3] = typeofChar;
		array[5] = typeofDecimal;
		array[6] = typeofDouble;
		array[7] = typeofInt16;
		array[8] = typeofInt32;
		array[9] = typeofInt64;
		array[10] = typeofSByte;
		array[11] = typeofSingle;
		array[12] = typeofTimeSpan;
		array[13] = typeofDateTime;
		array[14] = typeofUInt16;
		array[15] = typeofUInt32;
		array[16] = typeofUInt64;
		typeA = array;
	}

	private static void InitArrayTypeA()
	{
		Type[] array = new Type[primitiveTypeEnumLength];
		array[0] = null;
		array[1] = typeofBooleanArray;
		array[2] = typeofByteArray;
		array[3] = typeofCharArray;
		array[5] = typeofDecimalArray;
		array[6] = typeofDoubleArray;
		array[7] = typeofInt16Array;
		array[8] = typeofInt32Array;
		array[9] = typeofInt64Array;
		array[10] = typeofSByteArray;
		array[11] = typeofSingleArray;
		array[12] = typeofTimeSpanArray;
		array[13] = typeofDateTimeArray;
		array[14] = typeofUInt16Array;
		array[15] = typeofUInt32Array;
		array[16] = typeofUInt64Array;
		arrayTypeA = array;
	}

	internal static Type ToType(InternalPrimitiveTypeE code)
	{
		if (typeA == null)
		{
			InitTypeA();
		}
		return typeA[(int)code];
	}

	internal static Array CreatePrimitiveArray(InternalPrimitiveTypeE code, int length)
	{
		Array result = null;
		switch (code)
		{
		case InternalPrimitiveTypeE.Boolean:
			result = new bool[length];
			break;
		case InternalPrimitiveTypeE.Byte:
			result = new byte[length];
			break;
		case InternalPrimitiveTypeE.Char:
			result = new char[length];
			break;
		case InternalPrimitiveTypeE.Decimal:
			result = new decimal[length];
			break;
		case InternalPrimitiveTypeE.Double:
			result = new double[length];
			break;
		case InternalPrimitiveTypeE.Int16:
			result = new short[length];
			break;
		case InternalPrimitiveTypeE.Int32:
			result = new int[length];
			break;
		case InternalPrimitiveTypeE.Int64:
			result = new long[length];
			break;
		case InternalPrimitiveTypeE.SByte:
			result = new sbyte[length];
			break;
		case InternalPrimitiveTypeE.Single:
			result = new float[length];
			break;
		case InternalPrimitiveTypeE.TimeSpan:
			result = new TimeSpan[length];
			break;
		case InternalPrimitiveTypeE.DateTime:
			result = new DateTime[length];
			break;
		case InternalPrimitiveTypeE.UInt16:
			result = new ushort[length];
			break;
		case InternalPrimitiveTypeE.UInt32:
			result = new uint[length];
			break;
		case InternalPrimitiveTypeE.UInt64:
			result = new ulong[length];
			break;
		}
		return result;
	}

	internal static bool IsPrimitiveArray(Type type, out object typeInformation)
	{
		typeInformation = null;
		bool result = true;
		if ((object)type == typeofBooleanArray)
		{
			typeInformation = InternalPrimitiveTypeE.Boolean;
		}
		else if ((object)type == typeofByteArray)
		{
			typeInformation = InternalPrimitiveTypeE.Byte;
		}
		else if ((object)type == typeofCharArray)
		{
			typeInformation = InternalPrimitiveTypeE.Char;
		}
		else if ((object)type == typeofDoubleArray)
		{
			typeInformation = InternalPrimitiveTypeE.Double;
		}
		else if ((object)type == typeofInt16Array)
		{
			typeInformation = InternalPrimitiveTypeE.Int16;
		}
		else if ((object)type == typeofInt32Array)
		{
			typeInformation = InternalPrimitiveTypeE.Int32;
		}
		else if ((object)type == typeofInt64Array)
		{
			typeInformation = InternalPrimitiveTypeE.Int64;
		}
		else if ((object)type == typeofSByteArray)
		{
			typeInformation = InternalPrimitiveTypeE.SByte;
		}
		else if ((object)type == typeofSingleArray)
		{
			typeInformation = InternalPrimitiveTypeE.Single;
		}
		else if ((object)type == typeofUInt16Array)
		{
			typeInformation = InternalPrimitiveTypeE.UInt16;
		}
		else if ((object)type == typeofUInt32Array)
		{
			typeInformation = InternalPrimitiveTypeE.UInt32;
		}
		else if ((object)type == typeofUInt64Array)
		{
			typeInformation = InternalPrimitiveTypeE.UInt64;
		}
		else
		{
			result = false;
		}
		return result;
	}

	private static void InitValueA()
	{
		string[] array = new string[primitiveTypeEnumLength];
		array[0] = null;
		array[1] = "Boolean";
		array[2] = "Byte";
		array[3] = "Char";
		array[5] = "Decimal";
		array[6] = "Double";
		array[7] = "Int16";
		array[8] = "Int32";
		array[9] = "Int64";
		array[10] = "SByte";
		array[11] = "Single";
		array[12] = "TimeSpan";
		array[13] = "DateTime";
		array[14] = "UInt16";
		array[15] = "UInt32";
		array[16] = "UInt64";
		valueA = array;
	}

	internal static string ToComType(InternalPrimitiveTypeE code)
	{
		if (valueA == null)
		{
			InitValueA();
		}
		return valueA[(int)code];
	}

	private static void InitTypeCodeA()
	{
		TypeCode[] array = new TypeCode[primitiveTypeEnumLength];
		array[0] = TypeCode.Object;
		array[1] = TypeCode.Boolean;
		array[2] = TypeCode.Byte;
		array[3] = TypeCode.Char;
		array[5] = TypeCode.Decimal;
		array[6] = TypeCode.Double;
		array[7] = TypeCode.Int16;
		array[8] = TypeCode.Int32;
		array[9] = TypeCode.Int64;
		array[10] = TypeCode.SByte;
		array[11] = TypeCode.Single;
		array[12] = TypeCode.Object;
		array[13] = TypeCode.DateTime;
		array[14] = TypeCode.UInt16;
		array[15] = TypeCode.UInt32;
		array[16] = TypeCode.UInt64;
		typeCodeA = array;
	}

	internal static TypeCode ToTypeCode(InternalPrimitiveTypeE code)
	{
		if (typeCodeA == null)
		{
			InitTypeCodeA();
		}
		return typeCodeA[(int)code];
	}

	private static void InitCodeA()
	{
		codeA = new InternalPrimitiveTypeE[19]
		{
			InternalPrimitiveTypeE.Invalid,
			InternalPrimitiveTypeE.Invalid,
			InternalPrimitiveTypeE.Invalid,
			InternalPrimitiveTypeE.Boolean,
			InternalPrimitiveTypeE.Char,
			InternalPrimitiveTypeE.SByte,
			InternalPrimitiveTypeE.Byte,
			InternalPrimitiveTypeE.Int16,
			InternalPrimitiveTypeE.UInt16,
			InternalPrimitiveTypeE.Int32,
			InternalPrimitiveTypeE.UInt32,
			InternalPrimitiveTypeE.Int64,
			InternalPrimitiveTypeE.UInt64,
			InternalPrimitiveTypeE.Single,
			InternalPrimitiveTypeE.Double,
			InternalPrimitiveTypeE.Decimal,
			InternalPrimitiveTypeE.DateTime,
			InternalPrimitiveTypeE.Invalid,
			InternalPrimitiveTypeE.Invalid
		};
	}

	internal static InternalPrimitiveTypeE ToPrimitiveTypeEnum(TypeCode typeCode)
	{
		if (codeA == null)
		{
			InitCodeA();
		}
		return codeA[(int)typeCode];
	}

	internal static object FromString(string value, InternalPrimitiveTypeE code)
	{
		if (code != InternalPrimitiveTypeE.Invalid)
		{
			return Convert.ChangeType(value, ToTypeCode(code), CultureInfo.InvariantCulture);
		}
		return value;
	}
}
