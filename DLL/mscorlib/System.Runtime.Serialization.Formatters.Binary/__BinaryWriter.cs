using System.Collections;
using System.Globalization;
using System.IO;
using System.Text;

namespace System.Runtime.Serialization.Formatters.Binary;

internal sealed class __BinaryWriter
{
	internal Stream sout;

	internal FormatterTypeStyle formatterTypeStyle;

	internal Hashtable objectMapTable;

	internal ObjectWriter objectWriter;

	internal BinaryWriter dataWriter;

	internal int m_nestedObjectCount;

	private int nullCount;

	internal BinaryMethodCall binaryMethodCall;

	internal BinaryMethodReturn binaryMethodReturn;

	internal BinaryObject binaryObject;

	internal BinaryObjectWithMap binaryObjectWithMap;

	internal BinaryObjectWithMapTyped binaryObjectWithMapTyped;

	internal BinaryObjectString binaryObjectString;

	internal BinaryArray binaryArray;

	private byte[] byteBuffer;

	private int chunkSize = 4096;

	internal MemberPrimitiveUnTyped memberPrimitiveUnTyped;

	internal MemberPrimitiveTyped memberPrimitiveTyped;

	internal ObjectNull objectNull;

	internal MemberReference memberReference;

	internal BinaryAssembly binaryAssembly;

	internal __BinaryWriter(Stream sout, ObjectWriter objectWriter, FormatterTypeStyle formatterTypeStyle)
	{
		this.sout = sout;
		this.formatterTypeStyle = formatterTypeStyle;
		this.objectWriter = objectWriter;
		m_nestedObjectCount = 0;
		dataWriter = new BinaryWriter(sout, Encoding.UTF8);
	}

	internal void WriteBegin()
	{
	}

	internal void WriteEnd()
	{
		dataWriter.Flush();
	}

	internal void WriteBoolean(bool value)
	{
		dataWriter.Write(value);
	}

	internal void WriteByte(byte value)
	{
		dataWriter.Write(value);
	}

	private void WriteBytes(byte[] value)
	{
		dataWriter.Write(value);
	}

	private void WriteBytes(byte[] byteA, int offset, int size)
	{
		dataWriter.Write(byteA, offset, size);
	}

	internal void WriteChar(char value)
	{
		dataWriter.Write(value);
	}

	internal void WriteChars(char[] value)
	{
		dataWriter.Write(value);
	}

	internal void WriteDecimal(decimal value)
	{
		WriteString(value.ToString(CultureInfo.InvariantCulture));
	}

	internal void WriteSingle(float value)
	{
		dataWriter.Write(value);
	}

	internal void WriteDouble(double value)
	{
		dataWriter.Write(value);
	}

	internal void WriteInt16(short value)
	{
		dataWriter.Write(value);
	}

	internal void WriteInt32(int value)
	{
		dataWriter.Write(value);
	}

	internal void WriteInt64(long value)
	{
		dataWriter.Write(value);
	}

	internal void WriteSByte(sbyte value)
	{
		WriteByte((byte)value);
	}

	internal void WriteString(string value)
	{
		dataWriter.Write(value);
	}

	internal void WriteTimeSpan(TimeSpan value)
	{
		WriteInt64(value.Ticks);
	}

	internal void WriteDateTime(DateTime value)
	{
		WriteInt64(value.ToBinaryRaw());
	}

	internal void WriteUInt16(ushort value)
	{
		dataWriter.Write(value);
	}

	internal void WriteUInt32(uint value)
	{
		dataWriter.Write(value);
	}

	internal void WriteUInt64(ulong value)
	{
		dataWriter.Write(value);
	}

	internal void WriteObjectEnd(NameInfo memberNameInfo, NameInfo typeNameInfo)
	{
	}

	internal void WriteSerializationHeaderEnd()
	{
		MessageEnd messageEnd = new MessageEnd();
		messageEnd.Dump(sout);
		messageEnd.Write(this);
	}

	internal void WriteSerializationHeader(int topId, int headerId, int minorVersion, int majorVersion)
	{
		SerializationHeaderRecord serializationHeaderRecord = new SerializationHeaderRecord(BinaryHeaderEnum.SerializedStreamHeader, topId, headerId, minorVersion, majorVersion);
		serializationHeaderRecord.Dump();
		serializationHeaderRecord.Write(this);
	}

	internal void WriteMethodCall()
	{
		if (binaryMethodCall == null)
		{
			binaryMethodCall = new BinaryMethodCall();
		}
		binaryMethodCall.Dump();
		binaryMethodCall.Write(this);
	}

	internal void WriteMethodReturn()
	{
		if (binaryMethodReturn == null)
		{
			binaryMethodReturn = new BinaryMethodReturn();
		}
		binaryMethodReturn.Dump();
		binaryMethodReturn.Write(this);
	}

	internal void WriteObject(NameInfo nameInfo, NameInfo typeNameInfo, int numMembers, string[] memberNames, Type[] memberTypes, WriteObjectInfo[] memberObjectInfos)
	{
		InternalWriteItemNull();
		int num = (int)nameInfo.NIobjectId;
		_ = 0;
		string text = null;
		text = ((num >= 0) ? nameInfo.NIname : typeNameInfo.NIname);
		if (objectMapTable == null)
		{
			objectMapTable = new Hashtable();
		}
		ObjectMapInfo objectMapInfo = (ObjectMapInfo)objectMapTable[text];
		if (objectMapInfo != null && objectMapInfo.isCompatible(numMembers, memberNames, memberTypes))
		{
			if (binaryObject == null)
			{
				binaryObject = new BinaryObject();
			}
			binaryObject.Set(num, objectMapInfo.objectId);
			binaryObject.Write(this);
			return;
		}
		int assemId;
		if (!typeNameInfo.NItransmitTypeOnObject)
		{
			if (binaryObjectWithMap == null)
			{
				binaryObjectWithMap = new BinaryObjectWithMap();
			}
			assemId = (int)typeNameInfo.NIassemId;
			binaryObjectWithMap.Set(num, text, numMembers, memberNames, assemId);
			binaryObjectWithMap.Dump();
			binaryObjectWithMap.Write(this);
			if (objectMapInfo == null)
			{
				objectMapTable.Add(text, new ObjectMapInfo(num, numMembers, memberNames, memberTypes));
			}
			return;
		}
		BinaryTypeEnum[] array = new BinaryTypeEnum[numMembers];
		object[] array2 = new object[numMembers];
		int[] array3 = new int[numMembers];
		for (int i = 0; i < numMembers; i++)
		{
			object typeInformation = null;
			array[i] = BinaryConverter.GetBinaryTypeInfo(memberTypes[i], memberObjectInfos[i], null, objectWriter, out typeInformation, out assemId);
			array2[i] = typeInformation;
			array3[i] = assemId;
		}
		if (binaryObjectWithMapTyped == null)
		{
			binaryObjectWithMapTyped = new BinaryObjectWithMapTyped();
		}
		assemId = (int)typeNameInfo.NIassemId;
		binaryObjectWithMapTyped.Set(num, text, numMembers, memberNames, array, array2, array3, assemId);
		binaryObjectWithMapTyped.Write(this);
		if (objectMapInfo == null)
		{
			objectMapTable.Add(text, new ObjectMapInfo(num, numMembers, memberNames, memberTypes));
		}
	}

	internal void WriteObjectString(int objectId, string value)
	{
		InternalWriteItemNull();
		if (binaryObjectString == null)
		{
			binaryObjectString = new BinaryObjectString();
		}
		binaryObjectString.Set(objectId, value);
		binaryObjectString.Write(this);
	}

	internal void WriteSingleArray(NameInfo memberNameInfo, NameInfo arrayNameInfo, WriteObjectInfo objectInfo, NameInfo arrayElemTypeNameInfo, int length, int lowerBound, Array array)
	{
		InternalWriteItemNull();
		int[] lengthA = new int[1] { length };
		int[] lowerBoundA = null;
		object typeInformation = null;
		BinaryArrayTypeEnum binaryArrayTypeEnum;
		if (lowerBound == 0)
		{
			binaryArrayTypeEnum = BinaryArrayTypeEnum.Single;
		}
		else
		{
			binaryArrayTypeEnum = BinaryArrayTypeEnum.SingleOffset;
			lowerBoundA = new int[1] { lowerBound };
		}
		BinaryTypeEnum binaryTypeInfo = BinaryConverter.GetBinaryTypeInfo(arrayElemTypeNameInfo.NItype, objectInfo, arrayElemTypeNameInfo.NIname, objectWriter, out typeInformation, out var assemId);
		if (binaryArray == null)
		{
			binaryArray = new BinaryArray();
		}
		binaryArray.Set((int)arrayNameInfo.NIobjectId, 1, lengthA, lowerBoundA, binaryTypeInfo, typeInformation, binaryArrayTypeEnum, assemId);
		_ = arrayNameInfo.NIobjectId;
		_ = 0;
		binaryArray.Write(this);
		if (Converter.IsWriteAsByteArray(arrayElemTypeNameInfo.NIprimitiveTypeEnum) && lowerBound == 0)
		{
			if (arrayElemTypeNameInfo.NIprimitiveTypeEnum == InternalPrimitiveTypeE.Byte)
			{
				WriteBytes((byte[])array);
			}
			else if (arrayElemTypeNameInfo.NIprimitiveTypeEnum == InternalPrimitiveTypeE.Char)
			{
				WriteChars((char[])array);
			}
			else
			{
				WriteArrayAsBytes(array, Converter.TypeLength(arrayElemTypeNameInfo.NIprimitiveTypeEnum));
			}
		}
	}

	private void WriteArrayAsBytes(Array array, int typeLength)
	{
		InternalWriteItemNull();
		int i = 0;
		if (byteBuffer == null)
		{
			byteBuffer = new byte[chunkSize];
		}
		int num;
		for (; i < array.Length; i += num)
		{
			num = Math.Min(chunkSize / typeLength, array.Length - i);
			int num2 = num * typeLength;
			Buffer.InternalBlockCopy(array, i * typeLength, byteBuffer, 0, num2);
			if (!BitConverter.IsLittleEndian)
			{
				for (int j = 0; j < num2; j += typeLength)
				{
					for (int k = 0; k < typeLength / 2; k++)
					{
						byte b = byteBuffer[j + k];
						byteBuffer[j + k] = byteBuffer[j + typeLength - 1 - k];
						byteBuffer[j + typeLength - 1 - k] = b;
					}
				}
			}
			WriteBytes(byteBuffer, 0, num2);
		}
	}

	internal void WriteJaggedArray(NameInfo memberNameInfo, NameInfo arrayNameInfo, WriteObjectInfo objectInfo, NameInfo arrayElemTypeNameInfo, int length, int lowerBound)
	{
		InternalWriteItemNull();
		int[] lengthA = new int[1] { length };
		int[] lowerBoundA = null;
		object typeInformation = null;
		int assemId = 0;
		BinaryArrayTypeEnum binaryArrayTypeEnum;
		if (lowerBound == 0)
		{
			binaryArrayTypeEnum = BinaryArrayTypeEnum.Jagged;
		}
		else
		{
			binaryArrayTypeEnum = BinaryArrayTypeEnum.JaggedOffset;
			lowerBoundA = new int[1] { lowerBound };
		}
		BinaryTypeEnum binaryTypeInfo = BinaryConverter.GetBinaryTypeInfo(arrayElemTypeNameInfo.NItype, objectInfo, arrayElemTypeNameInfo.NIname, objectWriter, out typeInformation, out assemId);
		if (binaryArray == null)
		{
			binaryArray = new BinaryArray();
		}
		binaryArray.Set((int)arrayNameInfo.NIobjectId, 1, lengthA, lowerBoundA, binaryTypeInfo, typeInformation, binaryArrayTypeEnum, assemId);
		_ = arrayNameInfo.NIobjectId;
		_ = 0;
		binaryArray.Write(this);
	}

	internal void WriteRectangleArray(NameInfo memberNameInfo, NameInfo arrayNameInfo, WriteObjectInfo objectInfo, NameInfo arrayElemTypeNameInfo, int rank, int[] lengthA, int[] lowerBoundA)
	{
		InternalWriteItemNull();
		BinaryArrayTypeEnum binaryArrayTypeEnum = BinaryArrayTypeEnum.Rectangular;
		object typeInformation = null;
		int assemId = 0;
		BinaryTypeEnum binaryTypeInfo = BinaryConverter.GetBinaryTypeInfo(arrayElemTypeNameInfo.NItype, objectInfo, arrayElemTypeNameInfo.NIname, objectWriter, out typeInformation, out assemId);
		if (binaryArray == null)
		{
			binaryArray = new BinaryArray();
		}
		for (int i = 0; i < rank; i++)
		{
			if (lowerBoundA[i] != 0)
			{
				binaryArrayTypeEnum = BinaryArrayTypeEnum.RectangularOffset;
				break;
			}
		}
		binaryArray.Set((int)arrayNameInfo.NIobjectId, rank, lengthA, lowerBoundA, binaryTypeInfo, typeInformation, binaryArrayTypeEnum, assemId);
		_ = arrayNameInfo.NIobjectId;
		_ = 0;
		binaryArray.Write(this);
	}

	internal void WriteObjectByteArray(NameInfo memberNameInfo, NameInfo arrayNameInfo, WriteObjectInfo objectInfo, NameInfo arrayElemTypeNameInfo, int length, int lowerBound, byte[] byteA)
	{
		InternalWriteItemNull();
		WriteSingleArray(memberNameInfo, arrayNameInfo, objectInfo, arrayElemTypeNameInfo, length, lowerBound, byteA);
	}

	internal void WriteMember(NameInfo memberNameInfo, NameInfo typeNameInfo, object value)
	{
		InternalWriteItemNull();
		InternalPrimitiveTypeE nIprimitiveTypeEnum = typeNameInfo.NIprimitiveTypeEnum;
		if (memberNameInfo.NItransmitTypeOnMember)
		{
			if (memberPrimitiveTyped == null)
			{
				memberPrimitiveTyped = new MemberPrimitiveTyped();
			}
			memberPrimitiveTyped.Set(nIprimitiveTypeEnum, value);
			_ = memberNameInfo.NIisArrayItem;
			memberPrimitiveTyped.Dump();
			memberPrimitiveTyped.Write(this);
		}
		else
		{
			if (memberPrimitiveUnTyped == null)
			{
				memberPrimitiveUnTyped = new MemberPrimitiveUnTyped();
			}
			memberPrimitiveUnTyped.Set(nIprimitiveTypeEnum, value);
			_ = memberNameInfo.NIisArrayItem;
			memberPrimitiveUnTyped.Dump();
			memberPrimitiveUnTyped.Write(this);
		}
	}

	internal void WriteNullMember(NameInfo memberNameInfo, NameInfo typeNameInfo)
	{
		InternalWriteItemNull();
		if (objectNull == null)
		{
			objectNull = new ObjectNull();
		}
		if (!memberNameInfo.NIisArrayItem)
		{
			objectNull.SetNullCount(1);
			objectNull.Dump();
			objectNull.Write(this);
			nullCount = 0;
		}
	}

	internal void WriteMemberObjectRef(NameInfo memberNameInfo, int idRef)
	{
		InternalWriteItemNull();
		if (memberReference == null)
		{
			memberReference = new MemberReference();
		}
		memberReference.Set(idRef);
		_ = memberNameInfo.NIisArrayItem;
		memberReference.Dump();
		memberReference.Write(this);
	}

	internal void WriteMemberNested(NameInfo memberNameInfo)
	{
		InternalWriteItemNull();
		_ = memberNameInfo.NIisArrayItem;
	}

	internal void WriteMemberString(NameInfo memberNameInfo, NameInfo typeNameInfo, string value)
	{
		InternalWriteItemNull();
		_ = memberNameInfo.NIisArrayItem;
		WriteObjectString((int)typeNameInfo.NIobjectId, value);
	}

	internal void WriteItem(NameInfo itemNameInfo, NameInfo typeNameInfo, object value)
	{
		InternalWriteItemNull();
		WriteMember(itemNameInfo, typeNameInfo, value);
	}

	internal void WriteNullItem(NameInfo itemNameInfo, NameInfo typeNameInfo)
	{
		nullCount++;
		InternalWriteItemNull();
	}

	internal void WriteDelayedNullItem()
	{
		nullCount++;
	}

	internal void WriteItemEnd()
	{
		InternalWriteItemNull();
	}

	private void InternalWriteItemNull()
	{
		if (nullCount > 0)
		{
			if (objectNull == null)
			{
				objectNull = new ObjectNull();
			}
			objectNull.SetNullCount(nullCount);
			objectNull.Dump();
			objectNull.Write(this);
			nullCount = 0;
		}
	}

	internal void WriteItemObjectRef(NameInfo nameInfo, int idRef)
	{
		InternalWriteItemNull();
		WriteMemberObjectRef(nameInfo, idRef);
	}

	internal void WriteAssembly(Type type, string assemblyString, int assemId, bool isNew)
	{
		InternalWriteItemNull();
		if (assemblyString == null)
		{
			assemblyString = string.Empty;
		}
		if (isNew)
		{
			if (binaryAssembly == null)
			{
				binaryAssembly = new BinaryAssembly();
			}
			binaryAssembly.Set(assemId, assemblyString);
			binaryAssembly.Dump();
			binaryAssembly.Write(this);
		}
	}

	internal void WriteValue(InternalPrimitiveTypeE code, object value)
	{
		switch (code)
		{
		case InternalPrimitiveTypeE.Boolean:
			WriteBoolean(Convert.ToBoolean(value, CultureInfo.InvariantCulture));
			break;
		case InternalPrimitiveTypeE.Byte:
			WriteByte(Convert.ToByte(value, CultureInfo.InvariantCulture));
			break;
		case InternalPrimitiveTypeE.Char:
			WriteChar(Convert.ToChar(value, CultureInfo.InvariantCulture));
			break;
		case InternalPrimitiveTypeE.Double:
			WriteDouble(Convert.ToDouble(value, CultureInfo.InvariantCulture));
			break;
		case InternalPrimitiveTypeE.Int16:
			WriteInt16(Convert.ToInt16(value, CultureInfo.InvariantCulture));
			break;
		case InternalPrimitiveTypeE.Int32:
			WriteInt32(Convert.ToInt32(value, CultureInfo.InvariantCulture));
			break;
		case InternalPrimitiveTypeE.Int64:
			WriteInt64(Convert.ToInt64(value, CultureInfo.InvariantCulture));
			break;
		case InternalPrimitiveTypeE.SByte:
			WriteSByte(Convert.ToSByte(value, CultureInfo.InvariantCulture));
			break;
		case InternalPrimitiveTypeE.Single:
			WriteSingle(Convert.ToSingle(value, CultureInfo.InvariantCulture));
			break;
		case InternalPrimitiveTypeE.UInt16:
			WriteUInt16(Convert.ToUInt16(value, CultureInfo.InvariantCulture));
			break;
		case InternalPrimitiveTypeE.UInt32:
			WriteUInt32(Convert.ToUInt32(value, CultureInfo.InvariantCulture));
			break;
		case InternalPrimitiveTypeE.UInt64:
			WriteUInt64(Convert.ToUInt64(value, CultureInfo.InvariantCulture));
			break;
		case InternalPrimitiveTypeE.Decimal:
			WriteDecimal(Convert.ToDecimal(value, CultureInfo.InvariantCulture));
			break;
		case InternalPrimitiveTypeE.TimeSpan:
			WriteTimeSpan((TimeSpan)value);
			break;
		case InternalPrimitiveTypeE.DateTime:
			WriteDateTime((DateTime)value);
			break;
		default:
			throw new SerializationException(Environment.GetResourceString("Invalid type code in stream '{0}'.", code.ToString()));
		}
	}
}
