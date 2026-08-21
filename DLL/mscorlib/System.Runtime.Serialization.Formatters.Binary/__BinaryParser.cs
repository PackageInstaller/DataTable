using System.Globalization;
using System.IO;
using System.Text;

namespace System.Runtime.Serialization.Formatters.Binary;

internal sealed class __BinaryParser
{
	internal ObjectReader objectReader;

	internal Stream input;

	internal long topId;

	internal long headerId;

	internal SizedArray objectMapIdTable;

	internal SizedArray assemIdToAssemblyTable;

	internal SerStack stack = new SerStack("ObjectProgressStack");

	internal BinaryTypeEnum expectedType = BinaryTypeEnum.ObjectUrt;

	internal object expectedTypeInformation;

	internal ParseRecord PRS;

	private BinaryAssemblyInfo systemAssemblyInfo;

	private BinaryReader dataReader;

	private static Encoding encoding = new UTF8Encoding(encoderShouldEmitUTF8Identifier: false, throwOnInvalidBytes: true);

	private SerStack opPool;

	private BinaryObject binaryObject;

	private BinaryObjectWithMap bowm;

	private BinaryObjectWithMapTyped bowmt;

	internal BinaryObjectString objectString;

	internal BinaryCrossAppDomainString crossAppDomainString;

	internal MemberPrimitiveTyped memberPrimitiveTyped;

	private byte[] byteBuffer;

	internal MemberPrimitiveUnTyped memberPrimitiveUnTyped;

	internal MemberReference memberReference;

	internal ObjectNull objectNull;

	internal static volatile MessageEnd messageEnd;

	internal BinaryAssemblyInfo SystemAssemblyInfo
	{
		get
		{
			if (systemAssemblyInfo == null)
			{
				systemAssemblyInfo = new BinaryAssemblyInfo(Converter.urtAssemblyString, Converter.urtAssembly);
			}
			return systemAssemblyInfo;
		}
	}

	internal SizedArray ObjectMapIdTable
	{
		get
		{
			if (objectMapIdTable == null)
			{
				objectMapIdTable = new SizedArray();
			}
			return objectMapIdTable;
		}
	}

	internal SizedArray AssemIdToAssemblyTable
	{
		get
		{
			if (assemIdToAssemblyTable == null)
			{
				assemIdToAssemblyTable = new SizedArray(2);
			}
			return assemIdToAssemblyTable;
		}
	}

	internal ParseRecord prs
	{
		get
		{
			if (PRS == null)
			{
				PRS = new ParseRecord();
			}
			return PRS;
		}
	}

	internal __BinaryParser(Stream stream, ObjectReader objectReader)
	{
		input = stream;
		this.objectReader = objectReader;
		dataReader = new BinaryReader(input, encoding);
	}

	internal void Run()
	{
		try
		{
			bool flag = true;
			ReadBegin();
			ReadSerializationHeaderRecord();
			while (flag)
			{
				BinaryHeaderEnum binaryHeaderEnum = BinaryHeaderEnum.Object;
				switch (expectedType)
				{
				case BinaryTypeEnum.String:
				case BinaryTypeEnum.Object:
				case BinaryTypeEnum.ObjectUrt:
				case BinaryTypeEnum.ObjectUser:
				case BinaryTypeEnum.ObjectArray:
				case BinaryTypeEnum.StringArray:
				case BinaryTypeEnum.PrimitiveArray:
				{
					byte b = dataReader.ReadByte();
					binaryHeaderEnum = (BinaryHeaderEnum)b;
					switch (binaryHeaderEnum)
					{
					case BinaryHeaderEnum.Assembly:
					case BinaryHeaderEnum.CrossAppDomainAssembly:
						ReadAssembly(binaryHeaderEnum);
						break;
					case BinaryHeaderEnum.Object:
						ReadObject();
						break;
					case BinaryHeaderEnum.CrossAppDomainMap:
						ReadCrossAppDomainMap();
						break;
					case BinaryHeaderEnum.ObjectWithMap:
					case BinaryHeaderEnum.ObjectWithMapAssemId:
						ReadObjectWithMap(binaryHeaderEnum);
						break;
					case BinaryHeaderEnum.ObjectWithMapTyped:
					case BinaryHeaderEnum.ObjectWithMapTypedAssemId:
						ReadObjectWithMapTyped(binaryHeaderEnum);
						break;
					case BinaryHeaderEnum.ObjectString:
					case BinaryHeaderEnum.CrossAppDomainString:
						ReadObjectString(binaryHeaderEnum);
						break;
					case BinaryHeaderEnum.Array:
					case BinaryHeaderEnum.ArraySinglePrimitive:
					case BinaryHeaderEnum.ArraySingleObject:
					case BinaryHeaderEnum.ArraySingleString:
						ReadArray(binaryHeaderEnum);
						break;
					case BinaryHeaderEnum.MemberPrimitiveTyped:
						ReadMemberPrimitiveTyped();
						break;
					case BinaryHeaderEnum.MemberReference:
						ReadMemberReference();
						break;
					case BinaryHeaderEnum.ObjectNull:
					case BinaryHeaderEnum.ObjectNullMultiple256:
					case BinaryHeaderEnum.ObjectNullMultiple:
						ReadObjectNull(binaryHeaderEnum);
						break;
					case BinaryHeaderEnum.MessageEnd:
						flag = false;
						ReadMessageEnd();
						ReadEnd();
						break;
					default:
						throw new SerializationException(Environment.GetResourceString("Binary stream '{0}' does not contain a valid BinaryHeader. Possible causes are invalid stream or object version change between serialization and deserialization.", b));
					}
					break;
				}
				case BinaryTypeEnum.Primitive:
					ReadMemberPrimitiveUnTyped();
					break;
				default:
					throw new SerializationException(Environment.GetResourceString("Invalid expected type."));
				}
				if (binaryHeaderEnum == BinaryHeaderEnum.Assembly)
				{
					continue;
				}
				bool flag2 = false;
				while (!flag2)
				{
					ObjectProgress objectProgress = (ObjectProgress)stack.Peek();
					if (objectProgress == null)
					{
						expectedType = BinaryTypeEnum.ObjectUrt;
						expectedTypeInformation = null;
						flag2 = true;
						continue;
					}
					flag2 = objectProgress.GetNext(out objectProgress.expectedType, out objectProgress.expectedTypeInformation);
					expectedType = objectProgress.expectedType;
					expectedTypeInformation = objectProgress.expectedTypeInformation;
					if (!flag2)
					{
						prs.Init();
						if (objectProgress.memberValueEnum == InternalMemberValueE.Nested)
						{
							prs.PRparseTypeEnum = InternalParseTypeE.MemberEnd;
							prs.PRmemberTypeEnum = objectProgress.memberTypeEnum;
							prs.PRmemberValueEnum = objectProgress.memberValueEnum;
							objectReader.Parse(prs);
						}
						else
						{
							prs.PRparseTypeEnum = InternalParseTypeE.ObjectEnd;
							prs.PRmemberTypeEnum = objectProgress.memberTypeEnum;
							prs.PRmemberValueEnum = objectProgress.memberValueEnum;
							objectReader.Parse(prs);
						}
						stack.Pop();
						PutOp(objectProgress);
					}
				}
			}
		}
		catch (EndOfStreamException)
		{
			throw new SerializationException(Environment.GetResourceString("End of Stream encountered before parsing was completed."));
		}
	}

	internal void ReadBegin()
	{
	}

	internal void ReadEnd()
	{
	}

	internal bool ReadBoolean()
	{
		return dataReader.ReadBoolean();
	}

	internal byte ReadByte()
	{
		return dataReader.ReadByte();
	}

	internal byte[] ReadBytes(int length)
	{
		return dataReader.ReadBytes(length);
	}

	internal void ReadBytes(byte[] byteA, int offset, int size)
	{
		while (size > 0)
		{
			int num = dataReader.Read(byteA, offset, size);
			if (num == 0)
			{
				__Error.EndOfFile();
			}
			offset += num;
			size -= num;
		}
	}

	internal char ReadChar()
	{
		return dataReader.ReadChar();
	}

	internal char[] ReadChars(int length)
	{
		return dataReader.ReadChars(length);
	}

	internal decimal ReadDecimal()
	{
		return decimal.Parse(dataReader.ReadString(), CultureInfo.InvariantCulture);
	}

	internal float ReadSingle()
	{
		return dataReader.ReadSingle();
	}

	internal double ReadDouble()
	{
		return dataReader.ReadDouble();
	}

	internal short ReadInt16()
	{
		return dataReader.ReadInt16();
	}

	internal int ReadInt32()
	{
		return dataReader.ReadInt32();
	}

	internal long ReadInt64()
	{
		return dataReader.ReadInt64();
	}

	internal sbyte ReadSByte()
	{
		return (sbyte)ReadByte();
	}

	internal string ReadString()
	{
		return dataReader.ReadString();
	}

	internal TimeSpan ReadTimeSpan()
	{
		return new TimeSpan(ReadInt64());
	}

	internal DateTime ReadDateTime()
	{
		return DateTime.FromBinaryRaw(ReadInt64());
	}

	internal ushort ReadUInt16()
	{
		return dataReader.ReadUInt16();
	}

	internal uint ReadUInt32()
	{
		return dataReader.ReadUInt32();
	}

	internal ulong ReadUInt64()
	{
		return dataReader.ReadUInt64();
	}

	internal void ReadSerializationHeaderRecord()
	{
		SerializationHeaderRecord serializationHeaderRecord = new SerializationHeaderRecord();
		serializationHeaderRecord.Read(this);
		serializationHeaderRecord.Dump();
		topId = ((serializationHeaderRecord.topId > 0) ? objectReader.GetId(serializationHeaderRecord.topId) : serializationHeaderRecord.topId);
		headerId = ((serializationHeaderRecord.headerId > 0) ? objectReader.GetId(serializationHeaderRecord.headerId) : serializationHeaderRecord.headerId);
	}

	internal void ReadAssembly(BinaryHeaderEnum binaryHeaderEnum)
	{
		BinaryAssembly binaryAssembly = new BinaryAssembly();
		if (binaryHeaderEnum == BinaryHeaderEnum.CrossAppDomainAssembly)
		{
			BinaryCrossAppDomainAssembly binaryCrossAppDomainAssembly = new BinaryCrossAppDomainAssembly();
			binaryCrossAppDomainAssembly.Read(this);
			binaryCrossAppDomainAssembly.Dump();
			binaryAssembly.assemId = binaryCrossAppDomainAssembly.assemId;
			binaryAssembly.assemblyString = objectReader.CrossAppDomainArray(binaryCrossAppDomainAssembly.assemblyIndex) as string;
			if (binaryAssembly.assemblyString == null)
			{
				throw new SerializationException(Environment.GetResourceString("Cross-AppDomain BinaryFormatter error; expected '{0}' but received '{1}'.", "String", binaryCrossAppDomainAssembly.assemblyIndex));
			}
		}
		else
		{
			binaryAssembly.Read(this);
			binaryAssembly.Dump();
		}
		AssemIdToAssemblyTable[binaryAssembly.assemId] = new BinaryAssemblyInfo(binaryAssembly.assemblyString);
	}

	private void ReadObject()
	{
		if (binaryObject == null)
		{
			binaryObject = new BinaryObject();
		}
		binaryObject.Read(this);
		binaryObject.Dump();
		ObjectMap objectMap = (ObjectMap)ObjectMapIdTable[binaryObject.mapId];
		if (objectMap == null)
		{
			throw new SerializationException(Environment.GetResourceString("No map for object '{0}'.", binaryObject.mapId));
		}
		ObjectProgress op = GetOp();
		ParseRecord pr = op.pr;
		stack.Push(op);
		op.objectTypeEnum = InternalObjectTypeE.Object;
		op.binaryTypeEnumA = objectMap.binaryTypeEnumA;
		op.memberNames = objectMap.memberNames;
		op.memberTypes = objectMap.memberTypes;
		op.typeInformationA = objectMap.typeInformationA;
		op.memberLength = op.binaryTypeEnumA.Length;
		ObjectProgress objectProgress = (ObjectProgress)stack.PeekPeek();
		if (objectProgress == null || objectProgress.isInitial)
		{
			op.name = objectMap.objectName;
			pr.PRparseTypeEnum = InternalParseTypeE.Object;
			op.memberValueEnum = InternalMemberValueE.Empty;
		}
		else
		{
			pr.PRparseTypeEnum = InternalParseTypeE.Member;
			pr.PRmemberValueEnum = InternalMemberValueE.Nested;
			op.memberValueEnum = InternalMemberValueE.Nested;
			switch (objectProgress.objectTypeEnum)
			{
			case InternalObjectTypeE.Object:
				pr.PRname = objectProgress.name;
				pr.PRmemberTypeEnum = InternalMemberTypeE.Field;
				op.memberTypeEnum = InternalMemberTypeE.Field;
				break;
			case InternalObjectTypeE.Array:
				pr.PRmemberTypeEnum = InternalMemberTypeE.Item;
				op.memberTypeEnum = InternalMemberTypeE.Item;
				break;
			default:
				throw new SerializationException(Environment.GetResourceString("No map for object '{0}'.", objectProgress.objectTypeEnum.ToString()));
			}
		}
		pr.PRobjectId = objectReader.GetId(binaryObject.objectId);
		pr.PRobjectInfo = objectMap.CreateObjectInfo(ref pr.PRsi, ref pr.PRmemberData);
		if (pr.PRobjectId == topId)
		{
			pr.PRobjectPositionEnum = InternalObjectPositionE.Top;
		}
		pr.PRobjectTypeEnum = InternalObjectTypeE.Object;
		pr.PRkeyDt = objectMap.objectName;
		pr.PRdtType = objectMap.objectType;
		pr.PRdtTypeCode = InternalPrimitiveTypeE.Invalid;
		objectReader.Parse(pr);
	}

	internal void ReadCrossAppDomainMap()
	{
		BinaryCrossAppDomainMap binaryCrossAppDomainMap = new BinaryCrossAppDomainMap();
		binaryCrossAppDomainMap.Read(this);
		binaryCrossAppDomainMap.Dump();
		object obj = objectReader.CrossAppDomainArray(binaryCrossAppDomainMap.crossAppDomainArrayIndex);
		if (obj is BinaryObjectWithMap binaryObjectWithMap)
		{
			binaryObjectWithMap.Dump();
			ReadObjectWithMap(binaryObjectWithMap);
			return;
		}
		if (obj is BinaryObjectWithMapTyped record)
		{
			ReadObjectWithMapTyped(record);
			return;
		}
		throw new SerializationException(Environment.GetResourceString("Cross-AppDomain BinaryFormatter error; expected '{0}' but received '{1}'.", "BinaryObjectMap", obj));
	}

	internal void ReadObjectWithMap(BinaryHeaderEnum binaryHeaderEnum)
	{
		if (bowm == null)
		{
			bowm = new BinaryObjectWithMap(binaryHeaderEnum);
		}
		else
		{
			bowm.binaryHeaderEnum = binaryHeaderEnum;
		}
		bowm.Read(this);
		bowm.Dump();
		ReadObjectWithMap(bowm);
	}

	private void ReadObjectWithMap(BinaryObjectWithMap record)
	{
		BinaryAssemblyInfo binaryAssemblyInfo = null;
		ObjectProgress op = GetOp();
		ParseRecord pr = op.pr;
		stack.Push(op);
		if (record.binaryHeaderEnum == BinaryHeaderEnum.ObjectWithMapAssemId)
		{
			if (record.assemId < 1)
			{
				throw new SerializationException(Environment.GetResourceString("No assembly information is available for object on the wire, '{0}'.", record.name));
			}
			binaryAssemblyInfo = (BinaryAssemblyInfo)AssemIdToAssemblyTable[record.assemId];
			if (binaryAssemblyInfo == null)
			{
				throw new SerializationException(Environment.GetResourceString("No assembly information is available for object on the wire, '{0}'.", record.assemId + " " + record.name));
			}
		}
		else if (record.binaryHeaderEnum == BinaryHeaderEnum.ObjectWithMap)
		{
			binaryAssemblyInfo = SystemAssemblyInfo;
		}
		Type type = objectReader.GetType(binaryAssemblyInfo, record.name);
		ObjectMap objectMap = ObjectMap.Create(record.name, type, record.memberNames, objectReader, record.objectId, binaryAssemblyInfo);
		ObjectMapIdTable[record.objectId] = objectMap;
		op.objectTypeEnum = InternalObjectTypeE.Object;
		op.binaryTypeEnumA = objectMap.binaryTypeEnumA;
		op.typeInformationA = objectMap.typeInformationA;
		op.memberLength = op.binaryTypeEnumA.Length;
		op.memberNames = objectMap.memberNames;
		op.memberTypes = objectMap.memberTypes;
		ObjectProgress objectProgress = (ObjectProgress)stack.PeekPeek();
		if (objectProgress == null || objectProgress.isInitial)
		{
			op.name = record.name;
			pr.PRparseTypeEnum = InternalParseTypeE.Object;
			op.memberValueEnum = InternalMemberValueE.Empty;
		}
		else
		{
			pr.PRparseTypeEnum = InternalParseTypeE.Member;
			pr.PRmemberValueEnum = InternalMemberValueE.Nested;
			op.memberValueEnum = InternalMemberValueE.Nested;
			switch (objectProgress.objectTypeEnum)
			{
			case InternalObjectTypeE.Object:
				pr.PRname = objectProgress.name;
				pr.PRmemberTypeEnum = InternalMemberTypeE.Field;
				op.memberTypeEnum = InternalMemberTypeE.Field;
				break;
			case InternalObjectTypeE.Array:
				pr.PRmemberTypeEnum = InternalMemberTypeE.Item;
				op.memberTypeEnum = InternalMemberTypeE.Field;
				break;
			default:
				throw new SerializationException(Environment.GetResourceString("Invalid ObjectTypeEnum {0}.", objectProgress.objectTypeEnum.ToString()));
			}
		}
		pr.PRobjectTypeEnum = InternalObjectTypeE.Object;
		pr.PRobjectId = objectReader.GetId(record.objectId);
		pr.PRobjectInfo = objectMap.CreateObjectInfo(ref pr.PRsi, ref pr.PRmemberData);
		if (pr.PRobjectId == topId)
		{
			pr.PRobjectPositionEnum = InternalObjectPositionE.Top;
		}
		pr.PRkeyDt = record.name;
		pr.PRdtType = objectMap.objectType;
		pr.PRdtTypeCode = InternalPrimitiveTypeE.Invalid;
		objectReader.Parse(pr);
	}

	internal void ReadObjectWithMapTyped(BinaryHeaderEnum binaryHeaderEnum)
	{
		if (bowmt == null)
		{
			bowmt = new BinaryObjectWithMapTyped(binaryHeaderEnum);
		}
		else
		{
			bowmt.binaryHeaderEnum = binaryHeaderEnum;
		}
		bowmt.Read(this);
		ReadObjectWithMapTyped(bowmt);
	}

	private void ReadObjectWithMapTyped(BinaryObjectWithMapTyped record)
	{
		BinaryAssemblyInfo binaryAssemblyInfo = null;
		ObjectProgress op = GetOp();
		ParseRecord pr = op.pr;
		stack.Push(op);
		if (record.binaryHeaderEnum == BinaryHeaderEnum.ObjectWithMapTypedAssemId)
		{
			if (record.assemId < 1)
			{
				throw new SerializationException(Environment.GetResourceString("No assembly ID for object type '{0}'.", record.name));
			}
			binaryAssemblyInfo = (BinaryAssemblyInfo)AssemIdToAssemblyTable[record.assemId];
			if (binaryAssemblyInfo == null)
			{
				throw new SerializationException(Environment.GetResourceString("No assembly ID for object type '{0}'.", record.assemId + " " + record.name));
			}
		}
		else if (record.binaryHeaderEnum == BinaryHeaderEnum.ObjectWithMapTyped)
		{
			binaryAssemblyInfo = SystemAssemblyInfo;
		}
		ObjectMap objectMap = ObjectMap.Create(record.name, record.memberNames, record.binaryTypeEnumA, record.typeInformationA, record.memberAssemIds, objectReader, record.objectId, binaryAssemblyInfo, AssemIdToAssemblyTable);
		ObjectMapIdTable[record.objectId] = objectMap;
		op.objectTypeEnum = InternalObjectTypeE.Object;
		op.binaryTypeEnumA = objectMap.binaryTypeEnumA;
		op.typeInformationA = objectMap.typeInformationA;
		op.memberLength = op.binaryTypeEnumA.Length;
		op.memberNames = objectMap.memberNames;
		op.memberTypes = objectMap.memberTypes;
		ObjectProgress objectProgress = (ObjectProgress)stack.PeekPeek();
		if (objectProgress == null || objectProgress.isInitial)
		{
			op.name = record.name;
			pr.PRparseTypeEnum = InternalParseTypeE.Object;
			op.memberValueEnum = InternalMemberValueE.Empty;
		}
		else
		{
			pr.PRparseTypeEnum = InternalParseTypeE.Member;
			pr.PRmemberValueEnum = InternalMemberValueE.Nested;
			op.memberValueEnum = InternalMemberValueE.Nested;
			switch (objectProgress.objectTypeEnum)
			{
			case InternalObjectTypeE.Object:
				pr.PRname = objectProgress.name;
				pr.PRmemberTypeEnum = InternalMemberTypeE.Field;
				op.memberTypeEnum = InternalMemberTypeE.Field;
				break;
			case InternalObjectTypeE.Array:
				pr.PRmemberTypeEnum = InternalMemberTypeE.Item;
				op.memberTypeEnum = InternalMemberTypeE.Item;
				break;
			default:
				throw new SerializationException(Environment.GetResourceString("Invalid ObjectTypeEnum {0}.", objectProgress.objectTypeEnum.ToString()));
			}
		}
		pr.PRobjectTypeEnum = InternalObjectTypeE.Object;
		pr.PRobjectInfo = objectMap.CreateObjectInfo(ref pr.PRsi, ref pr.PRmemberData);
		pr.PRobjectId = objectReader.GetId(record.objectId);
		if (pr.PRobjectId == topId)
		{
			pr.PRobjectPositionEnum = InternalObjectPositionE.Top;
		}
		pr.PRkeyDt = record.name;
		pr.PRdtType = objectMap.objectType;
		pr.PRdtTypeCode = InternalPrimitiveTypeE.Invalid;
		objectReader.Parse(pr);
	}

	private void ReadObjectString(BinaryHeaderEnum binaryHeaderEnum)
	{
		if (objectString == null)
		{
			objectString = new BinaryObjectString();
		}
		if (binaryHeaderEnum == BinaryHeaderEnum.ObjectString)
		{
			objectString.Read(this);
			objectString.Dump();
		}
		else
		{
			if (crossAppDomainString == null)
			{
				crossAppDomainString = new BinaryCrossAppDomainString();
			}
			crossAppDomainString.Read(this);
			crossAppDomainString.Dump();
			objectString.value = objectReader.CrossAppDomainArray(crossAppDomainString.value) as string;
			if (objectString.value == null)
			{
				throw new SerializationException(Environment.GetResourceString("Cross-AppDomain BinaryFormatter error; expected '{0}' but received '{1}'.", "String", crossAppDomainString.value));
			}
			objectString.objectId = crossAppDomainString.objectId;
		}
		prs.Init();
		prs.PRparseTypeEnum = InternalParseTypeE.Object;
		prs.PRobjectId = objectReader.GetId(objectString.objectId);
		if (prs.PRobjectId == topId)
		{
			prs.PRobjectPositionEnum = InternalObjectPositionE.Top;
		}
		prs.PRobjectTypeEnum = InternalObjectTypeE.Object;
		ObjectProgress objectProgress = (ObjectProgress)stack.Peek();
		prs.PRvalue = objectString.value;
		prs.PRkeyDt = "System.String";
		prs.PRdtType = Converter.typeofString;
		prs.PRdtTypeCode = InternalPrimitiveTypeE.Invalid;
		prs.PRvarValue = objectString.value;
		if (objectProgress == null)
		{
			prs.PRparseTypeEnum = InternalParseTypeE.Object;
			prs.PRname = "System.String";
		}
		else
		{
			prs.PRparseTypeEnum = InternalParseTypeE.Member;
			prs.PRmemberValueEnum = InternalMemberValueE.InlineValue;
			switch (objectProgress.objectTypeEnum)
			{
			case InternalObjectTypeE.Object:
				prs.PRname = objectProgress.name;
				prs.PRmemberTypeEnum = InternalMemberTypeE.Field;
				break;
			case InternalObjectTypeE.Array:
				prs.PRmemberTypeEnum = InternalMemberTypeE.Item;
				break;
			default:
				throw new SerializationException(Environment.GetResourceString("Invalid ObjectTypeEnum {0}.", objectProgress.objectTypeEnum.ToString()));
			}
		}
		objectReader.Parse(prs);
	}

	private void ReadMemberPrimitiveTyped()
	{
		if (memberPrimitiveTyped == null)
		{
			memberPrimitiveTyped = new MemberPrimitiveTyped();
		}
		memberPrimitiveTyped.Read(this);
		memberPrimitiveTyped.Dump();
		prs.PRobjectTypeEnum = InternalObjectTypeE.Object;
		ObjectProgress objectProgress = (ObjectProgress)stack.Peek();
		prs.Init();
		prs.PRvarValue = memberPrimitiveTyped.value;
		prs.PRkeyDt = Converter.ToComType(memberPrimitiveTyped.primitiveTypeEnum);
		prs.PRdtType = Converter.ToType(memberPrimitiveTyped.primitiveTypeEnum);
		prs.PRdtTypeCode = memberPrimitiveTyped.primitiveTypeEnum;
		if (objectProgress == null)
		{
			prs.PRparseTypeEnum = InternalParseTypeE.Object;
			prs.PRname = "System.Variant";
		}
		else
		{
			prs.PRparseTypeEnum = InternalParseTypeE.Member;
			prs.PRmemberValueEnum = InternalMemberValueE.InlineValue;
			switch (objectProgress.objectTypeEnum)
			{
			case InternalObjectTypeE.Object:
				prs.PRname = objectProgress.name;
				prs.PRmemberTypeEnum = InternalMemberTypeE.Field;
				break;
			case InternalObjectTypeE.Array:
				prs.PRmemberTypeEnum = InternalMemberTypeE.Item;
				break;
			default:
				throw new SerializationException(Environment.GetResourceString("Invalid ObjectTypeEnum {0}.", objectProgress.objectTypeEnum.ToString()));
			}
		}
		objectReader.Parse(prs);
	}

	private void ReadArray(BinaryHeaderEnum binaryHeaderEnum)
	{
		BinaryAssemblyInfo binaryAssemblyInfo = null;
		BinaryArray binaryArray = new BinaryArray(binaryHeaderEnum);
		binaryArray.Read(this);
		if (binaryArray.binaryTypeEnum == BinaryTypeEnum.ObjectUser)
		{
			if (binaryArray.assemId < 1)
			{
				throw new SerializationException(Environment.GetResourceString("No assembly ID for object type '{0}'.", binaryArray.typeInformation));
			}
			binaryAssemblyInfo = (BinaryAssemblyInfo)AssemIdToAssemblyTable[binaryArray.assemId];
		}
		else
		{
			binaryAssemblyInfo = SystemAssemblyInfo;
		}
		ObjectProgress op = GetOp();
		ParseRecord pr = op.pr;
		op.objectTypeEnum = InternalObjectTypeE.Array;
		op.binaryTypeEnum = binaryArray.binaryTypeEnum;
		op.typeInformation = binaryArray.typeInformation;
		ObjectProgress objectProgress = (ObjectProgress)stack.PeekPeek();
		if (objectProgress == null || binaryArray.objectId > 0)
		{
			op.name = "System.Array";
			pr.PRparseTypeEnum = InternalParseTypeE.Object;
			op.memberValueEnum = InternalMemberValueE.Empty;
		}
		else
		{
			pr.PRparseTypeEnum = InternalParseTypeE.Member;
			pr.PRmemberValueEnum = InternalMemberValueE.Nested;
			op.memberValueEnum = InternalMemberValueE.Nested;
			switch (objectProgress.objectTypeEnum)
			{
			case InternalObjectTypeE.Object:
				pr.PRname = objectProgress.name;
				pr.PRmemberTypeEnum = InternalMemberTypeE.Field;
				op.memberTypeEnum = InternalMemberTypeE.Field;
				pr.PRkeyDt = objectProgress.name;
				pr.PRdtType = objectProgress.dtType;
				break;
			case InternalObjectTypeE.Array:
				pr.PRmemberTypeEnum = InternalMemberTypeE.Item;
				op.memberTypeEnum = InternalMemberTypeE.Item;
				break;
			default:
				throw new SerializationException(Environment.GetResourceString("Invalid ObjectTypeEnum {0}.", objectProgress.objectTypeEnum.ToString()));
			}
		}
		pr.PRobjectId = objectReader.GetId(binaryArray.objectId);
		if (pr.PRobjectId == topId)
		{
			pr.PRobjectPositionEnum = InternalObjectPositionE.Top;
		}
		else if (headerId > 0 && pr.PRobjectId == headerId)
		{
			pr.PRobjectPositionEnum = InternalObjectPositionE.Headers;
		}
		else
		{
			pr.PRobjectPositionEnum = InternalObjectPositionE.Child;
		}
		pr.PRobjectTypeEnum = InternalObjectTypeE.Array;
		BinaryConverter.TypeFromInfo(binaryArray.binaryTypeEnum, binaryArray.typeInformation, objectReader, binaryAssemblyInfo, out pr.PRarrayElementTypeCode, out pr.PRarrayElementTypeString, out pr.PRarrayElementType, out pr.PRisArrayVariant);
		pr.PRdtTypeCode = InternalPrimitiveTypeE.Invalid;
		pr.PRrank = binaryArray.rank;
		pr.PRlengthA = binaryArray.lengthA;
		pr.PRlowerBoundA = binaryArray.lowerBoundA;
		bool flag = false;
		switch (binaryArray.binaryArrayTypeEnum)
		{
		case BinaryArrayTypeEnum.Single:
		case BinaryArrayTypeEnum.SingleOffset:
			op.numItems = binaryArray.lengthA[0];
			pr.PRarrayTypeEnum = InternalArrayTypeE.Single;
			if (Converter.IsWriteAsByteArray(pr.PRarrayElementTypeCode) && binaryArray.lowerBoundA[0] == 0)
			{
				flag = true;
				ReadArrayAsBytes(pr);
			}
			break;
		case BinaryArrayTypeEnum.Jagged:
		case BinaryArrayTypeEnum.JaggedOffset:
			op.numItems = binaryArray.lengthA[0];
			pr.PRarrayTypeEnum = InternalArrayTypeE.Jagged;
			break;
		case BinaryArrayTypeEnum.Rectangular:
		case BinaryArrayTypeEnum.RectangularOffset:
		{
			int num = 1;
			for (int i = 0; i < binaryArray.rank; i++)
			{
				num *= binaryArray.lengthA[i];
			}
			op.numItems = num;
			pr.PRarrayTypeEnum = InternalArrayTypeE.Rectangular;
			break;
		}
		default:
			throw new SerializationException(Environment.GetResourceString("Invalid array type '{0}'.", binaryArray.binaryArrayTypeEnum.ToString()));
		}
		if (!flag)
		{
			stack.Push(op);
		}
		else
		{
			PutOp(op);
		}
		objectReader.Parse(pr);
		if (flag)
		{
			pr.PRparseTypeEnum = InternalParseTypeE.ObjectEnd;
			objectReader.Parse(pr);
		}
	}

	private void ReadArrayAsBytes(ParseRecord pr)
	{
		if (pr.PRarrayElementTypeCode == InternalPrimitiveTypeE.Byte)
		{
			pr.PRnewObj = ReadBytes(pr.PRlengthA[0]);
			return;
		}
		if (pr.PRarrayElementTypeCode == InternalPrimitiveTypeE.Char)
		{
			pr.PRnewObj = ReadChars(pr.PRlengthA[0]);
			return;
		}
		int num = Converter.TypeLength(pr.PRarrayElementTypeCode);
		pr.PRnewObj = Converter.CreatePrimitiveArray(pr.PRarrayElementTypeCode, pr.PRlengthA[0]);
		Array array = (Array)pr.PRnewObj;
		int i = 0;
		if (byteBuffer == null)
		{
			byteBuffer = new byte[4096];
		}
		int num2;
		for (; i < array.Length; i += num2)
		{
			num2 = Math.Min(4096 / num, array.Length - i);
			int num3 = num2 * num;
			ReadBytes(byteBuffer, 0, num3);
			if (!BitConverter.IsLittleEndian)
			{
				for (int j = 0; j < num3; j += num)
				{
					for (int k = 0; k < num / 2; k++)
					{
						byte b = byteBuffer[j + k];
						byteBuffer[j + k] = byteBuffer[j + num - 1 - k];
						byteBuffer[j + num - 1 - k] = b;
					}
				}
			}
			Buffer.InternalBlockCopy(byteBuffer, 0, array, i * num, num3);
		}
	}

	private void ReadMemberPrimitiveUnTyped()
	{
		ObjectProgress objectProgress = (ObjectProgress)stack.Peek();
		if (memberPrimitiveUnTyped == null)
		{
			memberPrimitiveUnTyped = new MemberPrimitiveUnTyped();
		}
		memberPrimitiveUnTyped.Set((InternalPrimitiveTypeE)expectedTypeInformation);
		memberPrimitiveUnTyped.Read(this);
		memberPrimitiveUnTyped.Dump();
		prs.Init();
		prs.PRvarValue = memberPrimitiveUnTyped.value;
		prs.PRdtTypeCode = (InternalPrimitiveTypeE)expectedTypeInformation;
		prs.PRdtType = Converter.ToType(prs.PRdtTypeCode);
		prs.PRparseTypeEnum = InternalParseTypeE.Member;
		prs.PRmemberValueEnum = InternalMemberValueE.InlineValue;
		if (objectProgress.objectTypeEnum == InternalObjectTypeE.Object)
		{
			prs.PRmemberTypeEnum = InternalMemberTypeE.Field;
			prs.PRname = objectProgress.name;
		}
		else
		{
			prs.PRmemberTypeEnum = InternalMemberTypeE.Item;
		}
		objectReader.Parse(prs);
	}

	private void ReadMemberReference()
	{
		if (memberReference == null)
		{
			memberReference = new MemberReference();
		}
		memberReference.Read(this);
		memberReference.Dump();
		ObjectProgress objectProgress = (ObjectProgress)stack.Peek();
		prs.Init();
		prs.PRidRef = objectReader.GetId(memberReference.idRef);
		prs.PRparseTypeEnum = InternalParseTypeE.Member;
		prs.PRmemberValueEnum = InternalMemberValueE.Reference;
		if (objectProgress.objectTypeEnum == InternalObjectTypeE.Object)
		{
			prs.PRmemberTypeEnum = InternalMemberTypeE.Field;
			prs.PRname = objectProgress.name;
			prs.PRdtType = objectProgress.dtType;
		}
		else
		{
			prs.PRmemberTypeEnum = InternalMemberTypeE.Item;
		}
		objectReader.Parse(prs);
	}

	private void ReadObjectNull(BinaryHeaderEnum binaryHeaderEnum)
	{
		if (objectNull == null)
		{
			objectNull = new ObjectNull();
		}
		objectNull.Read(this, binaryHeaderEnum);
		objectNull.Dump();
		ObjectProgress objectProgress = (ObjectProgress)stack.Peek();
		prs.Init();
		prs.PRparseTypeEnum = InternalParseTypeE.Member;
		prs.PRmemberValueEnum = InternalMemberValueE.Null;
		if (objectProgress.objectTypeEnum == InternalObjectTypeE.Object)
		{
			prs.PRmemberTypeEnum = InternalMemberTypeE.Field;
			prs.PRname = objectProgress.name;
			prs.PRdtType = objectProgress.dtType;
		}
		else
		{
			prs.PRmemberTypeEnum = InternalMemberTypeE.Item;
			prs.PRnullCount = objectNull.nullCount;
			objectProgress.ArrayCountIncrement(objectNull.nullCount - 1);
		}
		objectReader.Parse(prs);
	}

	private void ReadMessageEnd()
	{
		if (messageEnd == null)
		{
			messageEnd = new MessageEnd();
		}
		messageEnd.Read(this);
		messageEnd.Dump();
		if (!stack.IsEmpty())
		{
			throw new SerializationException(Environment.GetResourceString("End of Stream encountered before parsing was completed."));
		}
	}

	internal object ReadValue(InternalPrimitiveTypeE code)
	{
		object obj = null;
		return code switch
		{
			InternalPrimitiveTypeE.Boolean => ReadBoolean(), 
			InternalPrimitiveTypeE.Byte => ReadByte(), 
			InternalPrimitiveTypeE.Char => ReadChar(), 
			InternalPrimitiveTypeE.Double => ReadDouble(), 
			InternalPrimitiveTypeE.Int16 => ReadInt16(), 
			InternalPrimitiveTypeE.Int32 => ReadInt32(), 
			InternalPrimitiveTypeE.Int64 => ReadInt64(), 
			InternalPrimitiveTypeE.SByte => ReadSByte(), 
			InternalPrimitiveTypeE.Single => ReadSingle(), 
			InternalPrimitiveTypeE.UInt16 => ReadUInt16(), 
			InternalPrimitiveTypeE.UInt32 => ReadUInt32(), 
			InternalPrimitiveTypeE.UInt64 => ReadUInt64(), 
			InternalPrimitiveTypeE.Decimal => ReadDecimal(), 
			InternalPrimitiveTypeE.TimeSpan => ReadTimeSpan(), 
			InternalPrimitiveTypeE.DateTime => ReadDateTime(), 
			_ => throw new SerializationException(Environment.GetResourceString("Invalid type code in stream '{0}'.", code.ToString())), 
		};
	}

	private ObjectProgress GetOp()
	{
		ObjectProgress objectProgress = null;
		if (opPool != null && !opPool.IsEmpty())
		{
			objectProgress = (ObjectProgress)opPool.Pop();
			objectProgress.Init();
		}
		else
		{
			objectProgress = new ObjectProgress();
		}
		return objectProgress;
	}

	private void PutOp(ObjectProgress op)
	{
		if (opPool == null)
		{
			opPool = new SerStack("opPool");
		}
		opPool.Push(op);
	}
}
