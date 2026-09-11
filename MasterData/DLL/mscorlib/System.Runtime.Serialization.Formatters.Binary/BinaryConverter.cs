using System.Reflection;

namespace System.Runtime.Serialization.Formatters.Binary;

internal static class BinaryConverter
{
	internal static BinaryTypeEnum GetBinaryTypeInfo(Type type, WriteObjectInfo objectInfo, string typeName, ObjectWriter objectWriter, out object typeInformation, out int assemId)
	{
		assemId = 0;
		typeInformation = null;
		BinaryTypeEnum result;
		if ((object)type == Converter.typeofString)
		{
			result = BinaryTypeEnum.String;
		}
		else if ((objectInfo == null || (objectInfo != null && !objectInfo.isSi)) && (object)type == Converter.typeofObject)
		{
			result = BinaryTypeEnum.Object;
		}
		else if ((object)type == Converter.typeofStringArray)
		{
			result = BinaryTypeEnum.StringArray;
		}
		else if ((object)type == Converter.typeofObjectArray)
		{
			result = BinaryTypeEnum.ObjectArray;
		}
		else if (Converter.IsPrimitiveArray(type, out typeInformation))
		{
			result = BinaryTypeEnum.PrimitiveArray;
		}
		else
		{
			InternalPrimitiveTypeE internalPrimitiveTypeE = objectWriter.ToCode(type);
			if (internalPrimitiveTypeE == InternalPrimitiveTypeE.Invalid)
			{
				string text = null;
				if (objectInfo == null)
				{
					text = type.Assembly.FullName;
					typeInformation = type.FullName;
				}
				else
				{
					text = objectInfo.GetAssemblyString();
					typeInformation = objectInfo.GetTypeFullName();
				}
				if (text.Equals(Converter.urtAssemblyString))
				{
					result = BinaryTypeEnum.ObjectUrt;
					assemId = 0;
				}
				else
				{
					result = BinaryTypeEnum.ObjectUser;
					assemId = (int)objectInfo.assemId;
					if (assemId == 0)
					{
						throw new SerializationException(Environment.GetResourceString("No assembly ID for object type '{0}'.", typeInformation));
					}
				}
			}
			else
			{
				result = BinaryTypeEnum.Primitive;
				typeInformation = internalPrimitiveTypeE;
			}
		}
		return result;
	}

	internal static BinaryTypeEnum GetParserBinaryTypeInfo(Type type, out object typeInformation)
	{
		typeInformation = null;
		BinaryTypeEnum result;
		if ((object)type == Converter.typeofString)
		{
			result = BinaryTypeEnum.String;
		}
		else if ((object)type == Converter.typeofObject)
		{
			result = BinaryTypeEnum.Object;
		}
		else if ((object)type == Converter.typeofObjectArray)
		{
			result = BinaryTypeEnum.ObjectArray;
		}
		else if ((object)type == Converter.typeofStringArray)
		{
			result = BinaryTypeEnum.StringArray;
		}
		else if (Converter.IsPrimitiveArray(type, out typeInformation))
		{
			result = BinaryTypeEnum.PrimitiveArray;
		}
		else
		{
			InternalPrimitiveTypeE internalPrimitiveTypeE = Converter.ToCode(type);
			if (internalPrimitiveTypeE == InternalPrimitiveTypeE.Invalid)
			{
				result = ((!(Assembly.GetAssembly(type) == Converter.urtAssembly)) ? BinaryTypeEnum.ObjectUser : BinaryTypeEnum.ObjectUrt);
				typeInformation = type.FullName;
			}
			else
			{
				result = BinaryTypeEnum.Primitive;
				typeInformation = internalPrimitiveTypeE;
			}
		}
		return result;
	}

	internal static void WriteTypeInfo(BinaryTypeEnum binaryTypeEnum, object typeInformation, int assemId, __BinaryWriter sout)
	{
		switch (binaryTypeEnum)
		{
		case BinaryTypeEnum.Primitive:
		case BinaryTypeEnum.PrimitiveArray:
			sout.WriteByte((byte)(InternalPrimitiveTypeE)typeInformation);
			break;
		case BinaryTypeEnum.ObjectUrt:
			sout.WriteString(typeInformation.ToString());
			break;
		case BinaryTypeEnum.ObjectUser:
			sout.WriteString(typeInformation.ToString());
			sout.WriteInt32(assemId);
			break;
		default:
			throw new SerializationException(Environment.GetResourceString("Invalid write type request '{0}'.", binaryTypeEnum.ToString()));
		case BinaryTypeEnum.String:
		case BinaryTypeEnum.Object:
		case BinaryTypeEnum.ObjectArray:
		case BinaryTypeEnum.StringArray:
			break;
		}
	}

	internal static object ReadTypeInfo(BinaryTypeEnum binaryTypeEnum, __BinaryParser input, out int assemId)
	{
		object result = null;
		int num = 0;
		switch (binaryTypeEnum)
		{
		case BinaryTypeEnum.Primitive:
		case BinaryTypeEnum.PrimitiveArray:
			result = (InternalPrimitiveTypeE)input.ReadByte();
			break;
		case BinaryTypeEnum.ObjectUrt:
			result = input.ReadString();
			break;
		case BinaryTypeEnum.ObjectUser:
			result = input.ReadString();
			num = input.ReadInt32();
			break;
		default:
			throw new SerializationException(Environment.GetResourceString("Invalid read type request '{0}'.", binaryTypeEnum.ToString()));
		case BinaryTypeEnum.String:
		case BinaryTypeEnum.Object:
		case BinaryTypeEnum.ObjectArray:
		case BinaryTypeEnum.StringArray:
			break;
		}
		assemId = num;
		return result;
	}

	internal static void TypeFromInfo(BinaryTypeEnum binaryTypeEnum, object typeInformation, ObjectReader objectReader, BinaryAssemblyInfo assemblyInfo, out InternalPrimitiveTypeE primitiveTypeEnum, out string typeString, out Type type, out bool isVariant)
	{
		isVariant = false;
		primitiveTypeEnum = InternalPrimitiveTypeE.Invalid;
		typeString = null;
		type = null;
		switch (binaryTypeEnum)
		{
		case BinaryTypeEnum.Primitive:
			primitiveTypeEnum = (InternalPrimitiveTypeE)typeInformation;
			typeString = Converter.ToComType(primitiveTypeEnum);
			type = Converter.ToType(primitiveTypeEnum);
			break;
		case BinaryTypeEnum.String:
			type = Converter.typeofString;
			break;
		case BinaryTypeEnum.Object:
			type = Converter.typeofObject;
			isVariant = true;
			break;
		case BinaryTypeEnum.ObjectArray:
			type = Converter.typeofObjectArray;
			break;
		case BinaryTypeEnum.StringArray:
			type = Converter.typeofStringArray;
			break;
		case BinaryTypeEnum.PrimitiveArray:
			primitiveTypeEnum = (InternalPrimitiveTypeE)typeInformation;
			type = Converter.ToArrayType(primitiveTypeEnum);
			break;
		case BinaryTypeEnum.ObjectUrt:
		case BinaryTypeEnum.ObjectUser:
			if (typeInformation != null)
			{
				typeString = typeInformation.ToString();
				type = objectReader.GetType(assemblyInfo, typeString);
				if ((object)type == Converter.typeofObject)
				{
					isVariant = true;
				}
			}
			break;
		default:
			throw new SerializationException(Environment.GetResourceString("Invalid read type request '{0}'.", binaryTypeEnum.ToString()));
		}
	}
}
