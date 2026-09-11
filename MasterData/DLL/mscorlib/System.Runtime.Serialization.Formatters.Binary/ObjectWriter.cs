using System.Collections;
using System.Runtime.Remoting.Messaging;

namespace System.Runtime.Serialization.Formatters.Binary;

internal sealed class ObjectWriter
{
	private Queue m_objectQueue;

	private ObjectIDGenerator m_idGenerator;

	private int m_currentId;

	private ISurrogateSelector m_surrogates;

	private StreamingContext m_context;

	private __BinaryWriter serWriter;

	private SerializationObjectManager m_objectManager;

	private long topId;

	private string topName;

	private Header[] headers;

	private InternalFE formatterEnums;

	private SerializationBinder m_binder;

	private SerObjectInfoInit serObjectInfoInit;

	private IFormatterConverter m_formatterConverter;

	internal object[] crossAppDomainArray;

	private object previousObj;

	private long previousId;

	private Type previousType;

	private InternalPrimitiveTypeE previousCode;

	private Hashtable assemblyToIdTable;

	private SerStack niPool = new SerStack("NameInfo Pool");

	internal SerializationObjectManager ObjectManager => m_objectManager;

	internal ObjectWriter(ISurrogateSelector selector, StreamingContext context, InternalFE formatterEnums, SerializationBinder binder)
	{
		m_currentId = 1;
		m_surrogates = selector;
		m_context = context;
		m_binder = binder;
		this.formatterEnums = formatterEnums;
		m_objectManager = new SerializationObjectManager(context);
	}

	internal void Serialize(object graph, Header[] inHeaders, __BinaryWriter serWriter, bool fCheck)
	{
		if (graph == null)
		{
			throw new ArgumentNullException("graph", Environment.GetResourceString("Object Graph cannot be null."));
		}
		if (serWriter == null)
		{
			throw new ArgumentNullException("serWriter", Environment.GetResourceString("Parameter '{0}' cannot be null.", "serWriter"));
		}
		this.serWriter = serWriter;
		headers = inHeaders;
		serWriter.WriteBegin();
		long headerId = 0L;
		bool flag = false;
		bool flag2 = false;
		if (graph == null)
		{
			WriteSerializedStreamHeader(topId, headerId);
			if (flag)
			{
				serWriter.WriteMethodCall();
			}
			else if (flag2)
			{
				serWriter.WriteMethodReturn();
			}
			serWriter.WriteSerializationHeaderEnd();
			serWriter.WriteEnd();
			return;
		}
		m_idGenerator = new ObjectIDGenerator();
		m_objectQueue = new Queue();
		m_formatterConverter = new FormatterConverter();
		serObjectInfoInit = new SerObjectInfoInit();
		topId = InternalGetId(graph, assignUniqueIdToValueType: false, null, out var isNew);
		WriteSerializedStreamHeader(headerId: (headers == null) ? (-1) : InternalGetId(headers, assignUniqueIdToValueType: false, null, out isNew), topId: topId);
		if (flag)
		{
			serWriter.WriteMethodCall();
		}
		else if (flag2)
		{
			serWriter.WriteMethodReturn();
		}
		if (headers != null && headers.Length != 0)
		{
			m_objectQueue.Enqueue(headers);
		}
		if (graph != null)
		{
			m_objectQueue.Enqueue(graph);
		}
		object next;
		long objID;
		while ((next = GetNext(out objID)) != null)
		{
			WriteObjectInfo writeObjectInfo = null;
			if (next is WriteObjectInfo)
			{
				writeObjectInfo = (WriteObjectInfo)next;
			}
			else
			{
				writeObjectInfo = WriteObjectInfo.Serialize(next, m_surrogates, m_context, serObjectInfoInit, m_formatterConverter, this, m_binder);
				writeObjectInfo.assemId = GetAssemblyId(writeObjectInfo);
			}
			writeObjectInfo.objectId = objID;
			NameInfo nameInfo = TypeToNameInfo(writeObjectInfo);
			Write(writeObjectInfo, nameInfo, nameInfo);
			PutNameInfo(nameInfo);
			writeObjectInfo.ObjectEnd();
		}
		serWriter.WriteSerializationHeaderEnd();
		serWriter.WriteEnd();
		m_objectManager.RaiseOnSerializedEvent();
	}

	private void Write(WriteObjectInfo objectInfo, NameInfo memberNameInfo, NameInfo typeNameInfo)
	{
		object obj = objectInfo.obj;
		if (obj == null)
		{
			throw new ArgumentNullException("objectInfo.obj", Environment.GetResourceString("Object cannot be null."));
		}
		Type objectType = objectInfo.objectType;
		long objectId = objectInfo.objectId;
		if ((object)objectType == Converter.typeofString)
		{
			memberNameInfo.NIobjectId = objectId;
			serWriter.WriteObjectString((int)objectId, obj.ToString());
			return;
		}
		if (objectInfo.isArray)
		{
			WriteArray(objectInfo, memberNameInfo, null);
			return;
		}
		objectInfo.GetMemberInfo(out var outMemberNames, out var outMemberTypes, out var outMemberData);
		if (objectInfo.isSi || CheckTypeFormat(formatterEnums.FEtypeFormat, FormatterTypeStyle.TypesAlways))
		{
			memberNameInfo.NItransmitTypeOnObject = true;
			memberNameInfo.NIisParentTypeOnObject = true;
			typeNameInfo.NItransmitTypeOnObject = true;
			typeNameInfo.NIisParentTypeOnObject = true;
		}
		WriteObjectInfo[] array = new WriteObjectInfo[outMemberNames.Length];
		for (int i = 0; i < outMemberTypes.Length; i++)
		{
			Type type = (((object)outMemberTypes[i] != null) ? outMemberTypes[i] : ((outMemberData[i] == null) ? Converter.typeofObject : GetType(outMemberData[i])));
			if (ToCode(type) == InternalPrimitiveTypeE.Invalid && (object)type != Converter.typeofString)
			{
				if (outMemberData[i] != null)
				{
					array[i] = WriteObjectInfo.Serialize(outMemberData[i], m_surrogates, m_context, serObjectInfoInit, m_formatterConverter, this, m_binder);
					array[i].assemId = GetAssemblyId(array[i]);
				}
				else
				{
					array[i] = WriteObjectInfo.Serialize(outMemberTypes[i], m_surrogates, m_context, serObjectInfoInit, m_formatterConverter, m_binder);
					array[i].assemId = GetAssemblyId(array[i]);
				}
			}
		}
		Write(objectInfo, memberNameInfo, typeNameInfo, outMemberNames, outMemberTypes, outMemberData, array);
	}

	private void Write(WriteObjectInfo objectInfo, NameInfo memberNameInfo, NameInfo typeNameInfo, string[] memberNames, Type[] memberTypes, object[] memberData, WriteObjectInfo[] memberObjectInfos)
	{
		int num = memberNames.Length;
		NameInfo nameInfo = null;
		if (memberNameInfo != null)
		{
			memberNameInfo.NIobjectId = objectInfo.objectId;
			serWriter.WriteObject(memberNameInfo, typeNameInfo, num, memberNames, memberTypes, memberObjectInfos);
		}
		else if (objectInfo.objectId == topId && topName != null)
		{
			nameInfo = MemberToNameInfo(topName);
			nameInfo.NIobjectId = objectInfo.objectId;
			serWriter.WriteObject(nameInfo, typeNameInfo, num, memberNames, memberTypes, memberObjectInfos);
		}
		else if ((object)objectInfo.objectType != Converter.typeofString)
		{
			typeNameInfo.NIobjectId = objectInfo.objectId;
			serWriter.WriteObject(typeNameInfo, null, num, memberNames, memberTypes, memberObjectInfos);
		}
		if (memberNameInfo.NIisParentTypeOnObject)
		{
			memberNameInfo.NItransmitTypeOnObject = true;
			memberNameInfo.NIisParentTypeOnObject = false;
		}
		else
		{
			memberNameInfo.NItransmitTypeOnObject = false;
		}
		for (int i = 0; i < num; i++)
		{
			WriteMemberSetup(objectInfo, memberNameInfo, typeNameInfo, memberNames[i], memberTypes[i], memberData[i], memberObjectInfos[i]);
		}
		if (memberNameInfo != null)
		{
			memberNameInfo.NIobjectId = objectInfo.objectId;
			serWriter.WriteObjectEnd(memberNameInfo, typeNameInfo);
		}
		else if (objectInfo.objectId == topId && topName != null)
		{
			serWriter.WriteObjectEnd(nameInfo, typeNameInfo);
			PutNameInfo(nameInfo);
		}
		else if ((object)objectInfo.objectType != Converter.typeofString)
		{
			serWriter.WriteObjectEnd(typeNameInfo, typeNameInfo);
		}
	}

	private void WriteMemberSetup(WriteObjectInfo objectInfo, NameInfo memberNameInfo, NameInfo typeNameInfo, string memberName, Type memberType, object memberData, WriteObjectInfo memberObjectInfo)
	{
		NameInfo nameInfo = MemberToNameInfo(memberName);
		if (memberObjectInfo != null)
		{
			nameInfo.NIassemId = memberObjectInfo.assemId;
		}
		nameInfo.NItype = memberType;
		NameInfo nameInfo2 = null;
		nameInfo2 = ((memberObjectInfo != null) ? TypeToNameInfo(memberObjectInfo) : TypeToNameInfo(memberType));
		nameInfo.NItransmitTypeOnObject = memberNameInfo.NItransmitTypeOnObject;
		nameInfo.NIisParentTypeOnObject = memberNameInfo.NIisParentTypeOnObject;
		WriteMembers(nameInfo, nameInfo2, memberData, objectInfo, typeNameInfo, memberObjectInfo);
		PutNameInfo(nameInfo);
		PutNameInfo(nameInfo2);
	}

	private void WriteMembers(NameInfo memberNameInfo, NameInfo memberTypeNameInfo, object memberData, WriteObjectInfo objectInfo, NameInfo typeNameInfo, WriteObjectInfo memberObjectInfo)
	{
		Type nItype = memberNameInfo.NItype;
		bool assignUniqueIdToValueType = false;
		if ((object)nItype == Converter.typeofObject || (object)Nullable.GetUnderlyingType(nItype) != null)
		{
			memberTypeNameInfo.NItransmitTypeOnMember = true;
			memberNameInfo.NItransmitTypeOnMember = true;
		}
		if (CheckTypeFormat(formatterEnums.FEtypeFormat, FormatterTypeStyle.TypesAlways) || objectInfo.isSi)
		{
			memberTypeNameInfo.NItransmitTypeOnObject = true;
			memberNameInfo.NItransmitTypeOnObject = true;
			memberNameInfo.NIisParentTypeOnObject = true;
		}
		if (CheckForNull(objectInfo, memberNameInfo, memberTypeNameInfo, memberData))
		{
			return;
		}
		Type type = null;
		if (memberTypeNameInfo.NIprimitiveTypeEnum == InternalPrimitiveTypeE.Invalid)
		{
			type = GetType(memberData);
			if ((object)nItype != type)
			{
				memberTypeNameInfo.NItransmitTypeOnMember = true;
				memberNameInfo.NItransmitTypeOnMember = true;
			}
		}
		if ((object)nItype == Converter.typeofObject)
		{
			assignUniqueIdToValueType = true;
			nItype = GetType(memberData);
			if (memberObjectInfo == null)
			{
				TypeToNameInfo(nItype, memberTypeNameInfo);
			}
			else
			{
				TypeToNameInfo(memberObjectInfo, memberTypeNameInfo);
			}
		}
		if (memberObjectInfo != null && memberObjectInfo.isArray)
		{
			long num = 0L;
			if ((object)type == null)
			{
				type = GetType(memberData);
			}
			num = Schedule(memberData, assignUniqueIdToValueType: false, null, memberObjectInfo);
			if (num > 0)
			{
				memberNameInfo.NIobjectId = num;
				WriteObjectRef(memberNameInfo, num);
				return;
			}
			serWriter.WriteMemberNested(memberNameInfo);
			memberObjectInfo.objectId = num;
			memberNameInfo.NIobjectId = num;
			WriteArray(memberObjectInfo, memberNameInfo, memberObjectInfo);
			objectInfo.ObjectEnd();
		}
		else if (!WriteKnownValueClass(memberNameInfo, memberTypeNameInfo, memberData))
		{
			if ((object)type == null)
			{
				type = GetType(memberData);
			}
			long num2 = Schedule(memberData, assignUniqueIdToValueType, type, memberObjectInfo);
			if (num2 < 0)
			{
				memberObjectInfo.objectId = num2;
				NameInfo nameInfo = TypeToNameInfo(memberObjectInfo);
				nameInfo.NIobjectId = num2;
				Write(memberObjectInfo, memberNameInfo, nameInfo);
				PutNameInfo(nameInfo);
				memberObjectInfo.ObjectEnd();
			}
			else
			{
				memberNameInfo.NIobjectId = num2;
				WriteObjectRef(memberNameInfo, num2);
			}
		}
	}

	private void WriteArray(WriteObjectInfo objectInfo, NameInfo memberNameInfo, WriteObjectInfo memberObjectInfo)
	{
		bool flag = false;
		if (memberNameInfo == null)
		{
			memberNameInfo = TypeToNameInfo(objectInfo);
			flag = true;
		}
		memberNameInfo.NIisArray = true;
		long objectId = objectInfo.objectId;
		memberNameInfo.NIobjectId = objectInfo.objectId;
		Array array = (Array)objectInfo.obj;
		Type elementType = objectInfo.objectType.GetElementType();
		WriteObjectInfo writeObjectInfo = null;
		if (!elementType.IsPrimitive)
		{
			writeObjectInfo = WriteObjectInfo.Serialize(elementType, m_surrogates, m_context, serObjectInfoInit, m_formatterConverter, m_binder);
			writeObjectInfo.assemId = GetAssemblyId(writeObjectInfo);
		}
		NameInfo nameInfo = null;
		nameInfo = ((writeObjectInfo != null) ? TypeToNameInfo(writeObjectInfo) : TypeToNameInfo(elementType));
		nameInfo.NIisArray = nameInfo.NItype.IsArray;
		NameInfo nameInfo2 = memberNameInfo;
		nameInfo2.NIobjectId = objectId;
		nameInfo2.NIisArray = true;
		nameInfo.NIobjectId = objectId;
		nameInfo.NItransmitTypeOnMember = memberNameInfo.NItransmitTypeOnMember;
		nameInfo.NItransmitTypeOnObject = memberNameInfo.NItransmitTypeOnObject;
		nameInfo.NIisParentTypeOnObject = memberNameInfo.NIisParentTypeOnObject;
		int rank = array.Rank;
		int[] array2 = new int[rank];
		int[] array3 = new int[rank];
		int[] array4 = new int[rank];
		for (int i = 0; i < rank; i++)
		{
			array2[i] = array.GetLength(i);
			array3[i] = array.GetLowerBound(i);
			array4[i] = array.GetUpperBound(i);
		}
		InternalArrayTypeE internalArrayTypeE = (nameInfo.NIarrayEnum = (nameInfo.NIisArray ? ((rank != 1) ? InternalArrayTypeE.Rectangular : InternalArrayTypeE.Jagged) : ((rank == 1) ? InternalArrayTypeE.Single : InternalArrayTypeE.Rectangular)));
		if ((object)elementType == Converter.typeofByte && rank == 1 && array3[0] == 0)
		{
			serWriter.WriteObjectByteArray(memberNameInfo, nameInfo2, writeObjectInfo, nameInfo, array2[0], array3[0], (byte[])array);
			return;
		}
		if ((object)elementType == Converter.typeofObject || (object)Nullable.GetUnderlyingType(elementType) != null)
		{
			memberNameInfo.NItransmitTypeOnMember = true;
			nameInfo.NItransmitTypeOnMember = true;
		}
		if (CheckTypeFormat(formatterEnums.FEtypeFormat, FormatterTypeStyle.TypesAlways))
		{
			memberNameInfo.NItransmitTypeOnObject = true;
			nameInfo.NItransmitTypeOnObject = true;
		}
		switch (internalArrayTypeE)
		{
		case InternalArrayTypeE.Single:
		{
			serWriter.WriteSingleArray(memberNameInfo, nameInfo2, writeObjectInfo, nameInfo, array2[0], array3[0], array);
			if (Converter.IsWriteAsByteArray(nameInfo.NIprimitiveTypeEnum) && array3[0] == 0)
			{
				break;
			}
			object[] array5 = null;
			if (!elementType.IsValueType)
			{
				array5 = (object[])array;
			}
			int num = array4[0] + 1;
			for (int k = array3[0]; k < num; k++)
			{
				if (array5 == null)
				{
					WriteArrayMember(objectInfo, nameInfo, array.GetValue(k));
				}
				else
				{
					WriteArrayMember(objectInfo, nameInfo, array5[k]);
				}
			}
			serWriter.WriteItemEnd();
			break;
		}
		case InternalArrayTypeE.Jagged:
		{
			nameInfo2.NIobjectId = objectId;
			serWriter.WriteJaggedArray(memberNameInfo, nameInfo2, writeObjectInfo, nameInfo, array2[0], array3[0]);
			object[] array6 = (object[])array;
			for (int l = array3[0]; l < array4[0] + 1; l++)
			{
				WriteArrayMember(objectInfo, nameInfo, array6[l]);
			}
			serWriter.WriteItemEnd();
			break;
		}
		default:
		{
			nameInfo2.NIobjectId = objectId;
			serWriter.WriteRectangleArray(memberNameInfo, nameInfo2, writeObjectInfo, nameInfo, rank, array2, array3);
			bool flag2 = false;
			for (int j = 0; j < rank; j++)
			{
				if (array2[j] == 0)
				{
					flag2 = true;
					break;
				}
			}
			if (!flag2)
			{
				WriteRectangle(objectInfo, rank, array2, array, nameInfo, array3);
			}
			serWriter.WriteItemEnd();
			break;
		}
		}
		serWriter.WriteObjectEnd(memberNameInfo, nameInfo2);
		PutNameInfo(nameInfo);
		if (flag)
		{
			PutNameInfo(memberNameInfo);
		}
	}

	private void WriteArrayMember(WriteObjectInfo objectInfo, NameInfo arrayElemTypeNameInfo, object data)
	{
		arrayElemTypeNameInfo.NIisArrayItem = true;
		if (CheckForNull(objectInfo, arrayElemTypeNameInfo, arrayElemTypeNameInfo, data))
		{
			return;
		}
		NameInfo nameInfo = null;
		Type type = null;
		bool flag = false;
		if (arrayElemTypeNameInfo.NItransmitTypeOnMember)
		{
			flag = true;
		}
		if (!flag && !arrayElemTypeNameInfo.IsSealed)
		{
			type = GetType(data);
			if ((object)arrayElemTypeNameInfo.NItype != type)
			{
				flag = true;
			}
		}
		if (flag)
		{
			if ((object)type == null)
			{
				type = GetType(data);
			}
			nameInfo = TypeToNameInfo(type);
			nameInfo.NItransmitTypeOnMember = true;
			nameInfo.NIobjectId = arrayElemTypeNameInfo.NIobjectId;
			nameInfo.NIassemId = arrayElemTypeNameInfo.NIassemId;
			nameInfo.NIisArrayItem = true;
		}
		else
		{
			nameInfo = arrayElemTypeNameInfo;
			nameInfo.NIisArrayItem = true;
		}
		if (!WriteKnownValueClass(arrayElemTypeNameInfo, nameInfo, data))
		{
			bool assignUniqueIdToValueType = false;
			if ((object)arrayElemTypeNameInfo.NItype == Converter.typeofObject)
			{
				assignUniqueIdToValueType = true;
			}
			long num = (nameInfo.NIobjectId = (arrayElemTypeNameInfo.NIobjectId = Schedule(data, assignUniqueIdToValueType, nameInfo.NItype)));
			if (num < 1)
			{
				WriteObjectInfo writeObjectInfo = WriteObjectInfo.Serialize(data, m_surrogates, m_context, serObjectInfoInit, m_formatterConverter, this, m_binder);
				writeObjectInfo.objectId = num;
				if ((object)arrayElemTypeNameInfo.NItype != Converter.typeofObject && (object)Nullable.GetUnderlyingType(arrayElemTypeNameInfo.NItype) == null)
				{
					writeObjectInfo.assemId = nameInfo.NIassemId;
				}
				else
				{
					writeObjectInfo.assemId = GetAssemblyId(writeObjectInfo);
				}
				NameInfo nameInfo2 = TypeToNameInfo(writeObjectInfo);
				nameInfo2.NIobjectId = num;
				writeObjectInfo.objectId = num;
				Write(writeObjectInfo, nameInfo, nameInfo2);
				writeObjectInfo.ObjectEnd();
			}
			else
			{
				serWriter.WriteItemObjectRef(arrayElemTypeNameInfo, (int)num);
			}
		}
		if (arrayElemTypeNameInfo.NItransmitTypeOnMember)
		{
			PutNameInfo(nameInfo);
		}
	}

	private void WriteRectangle(WriteObjectInfo objectInfo, int rank, int[] maxA, Array array, NameInfo arrayElemNameTypeInfo, int[] lowerBoundA)
	{
		int[] array2 = new int[rank];
		int[] array3 = null;
		bool flag = false;
		if (lowerBoundA != null)
		{
			for (int i = 0; i < rank; i++)
			{
				if (lowerBoundA[i] != 0)
				{
					flag = true;
				}
			}
		}
		if (flag)
		{
			array3 = new int[rank];
		}
		bool flag2 = true;
		while (flag2)
		{
			flag2 = false;
			if (flag)
			{
				for (int j = 0; j < rank; j++)
				{
					array3[j] = array2[j] + lowerBoundA[j];
				}
				WriteArrayMember(objectInfo, arrayElemNameTypeInfo, array.GetValue(array3));
			}
			else
			{
				WriteArrayMember(objectInfo, arrayElemNameTypeInfo, array.GetValue(array2));
			}
			for (int num = rank - 1; num > -1; num--)
			{
				if (array2[num] < maxA[num] - 1)
				{
					array2[num]++;
					if (num < rank - 1)
					{
						for (int k = num + 1; k < rank; k++)
						{
							array2[k] = 0;
						}
					}
					flag2 = true;
					break;
				}
			}
		}
	}

	private object GetNext(out long objID)
	{
		if (m_objectQueue.Count == 0)
		{
			objID = 0L;
			return null;
		}
		object obj = m_objectQueue.Dequeue();
		object obj2 = null;
		obj2 = ((!(obj is WriteObjectInfo)) ? obj : ((WriteObjectInfo)obj).obj);
		objID = m_idGenerator.HasId(obj2, out var firstTime);
		if (firstTime)
		{
			throw new SerializationException(Environment.GetResourceString("Object {0} has never been assigned an objectID.", obj2));
		}
		return obj;
	}

	private long InternalGetId(object obj, bool assignUniqueIdToValueType, Type type, out bool isNew)
	{
		if (obj == previousObj)
		{
			isNew = false;
			return previousId;
		}
		m_idGenerator.m_currentCount = m_currentId;
		if ((object)type != null && type.IsValueType && !assignUniqueIdToValueType)
		{
			isNew = false;
			return -1 * m_currentId++;
		}
		m_currentId++;
		long id = m_idGenerator.GetId(obj, out isNew);
		previousObj = obj;
		previousId = id;
		return id;
	}

	private long Schedule(object obj, bool assignUniqueIdToValueType, Type type)
	{
		return Schedule(obj, assignUniqueIdToValueType, type, null);
	}

	private long Schedule(object obj, bool assignUniqueIdToValueType, Type type, WriteObjectInfo objectInfo)
	{
		if (obj == null)
		{
			return 0L;
		}
		long num = InternalGetId(obj, assignUniqueIdToValueType, type, out var isNew);
		if (isNew && num > 0)
		{
			if (objectInfo == null)
			{
				m_objectQueue.Enqueue(obj);
			}
			else
			{
				m_objectQueue.Enqueue(objectInfo);
			}
		}
		return num;
	}

	private bool WriteKnownValueClass(NameInfo memberNameInfo, NameInfo typeNameInfo, object data)
	{
		if ((object)typeNameInfo.NItype == Converter.typeofString)
		{
			WriteString(memberNameInfo, typeNameInfo, data);
		}
		else
		{
			if (typeNameInfo.NIprimitiveTypeEnum == InternalPrimitiveTypeE.Invalid)
			{
				return false;
			}
			if (typeNameInfo.NIisArray)
			{
				serWriter.WriteItem(memberNameInfo, typeNameInfo, data);
			}
			else
			{
				serWriter.WriteMember(memberNameInfo, typeNameInfo, data);
			}
		}
		return true;
	}

	private void WriteObjectRef(NameInfo nameInfo, long objectId)
	{
		serWriter.WriteMemberObjectRef(nameInfo, (int)objectId);
	}

	private void WriteString(NameInfo memberNameInfo, NameInfo typeNameInfo, object stringObject)
	{
		bool isNew = true;
		long num = -1L;
		if (!CheckTypeFormat(formatterEnums.FEtypeFormat, FormatterTypeStyle.XsdString))
		{
			num = InternalGetId(stringObject, assignUniqueIdToValueType: false, null, out isNew);
		}
		typeNameInfo.NIobjectId = num;
		if (isNew || num < 0)
		{
			serWriter.WriteMemberString(memberNameInfo, typeNameInfo, (string)stringObject);
		}
		else
		{
			WriteObjectRef(memberNameInfo, num);
		}
	}

	private bool CheckForNull(WriteObjectInfo objectInfo, NameInfo memberNameInfo, NameInfo typeNameInfo, object data)
	{
		bool flag = false;
		if (data == null)
		{
			flag = true;
		}
		if (flag && (formatterEnums.FEserializerTypeEnum == InternalSerializerTypeE.Binary || memberNameInfo.NIisArrayItem || memberNameInfo.NItransmitTypeOnObject || memberNameInfo.NItransmitTypeOnMember || objectInfo.isSi || CheckTypeFormat(formatterEnums.FEtypeFormat, FormatterTypeStyle.TypesAlways)))
		{
			if (typeNameInfo.NIisArrayItem)
			{
				if (typeNameInfo.NIarrayEnum == InternalArrayTypeE.Single)
				{
					serWriter.WriteDelayedNullItem();
				}
				else
				{
					serWriter.WriteNullItem(memberNameInfo, typeNameInfo);
				}
			}
			else
			{
				serWriter.WriteNullMember(memberNameInfo, typeNameInfo);
			}
		}
		return flag;
	}

	private void WriteSerializedStreamHeader(long topId, long headerId)
	{
		serWriter.WriteSerializationHeader((int)topId, (int)headerId, 1, 0);
	}

	private NameInfo TypeToNameInfo(Type type, WriteObjectInfo objectInfo, InternalPrimitiveTypeE code, NameInfo nameInfo)
	{
		if (nameInfo == null)
		{
			nameInfo = GetNameInfo();
		}
		else
		{
			nameInfo.Init();
		}
		if (code == InternalPrimitiveTypeE.Invalid && objectInfo != null)
		{
			nameInfo.NIname = objectInfo.GetTypeFullName();
			nameInfo.NIassemId = objectInfo.assemId;
		}
		nameInfo.NIprimitiveTypeEnum = code;
		nameInfo.NItype = type;
		return nameInfo;
	}

	private NameInfo TypeToNameInfo(Type type)
	{
		return TypeToNameInfo(type, null, ToCode(type), null);
	}

	private NameInfo TypeToNameInfo(WriteObjectInfo objectInfo)
	{
		return TypeToNameInfo(objectInfo.objectType, objectInfo, ToCode(objectInfo.objectType), null);
	}

	private NameInfo TypeToNameInfo(WriteObjectInfo objectInfo, NameInfo nameInfo)
	{
		return TypeToNameInfo(objectInfo.objectType, objectInfo, ToCode(objectInfo.objectType), nameInfo);
	}

	private void TypeToNameInfo(Type type, NameInfo nameInfo)
	{
		TypeToNameInfo(type, null, ToCode(type), nameInfo);
	}

	private NameInfo MemberToNameInfo(string name)
	{
		NameInfo nameInfo = GetNameInfo();
		nameInfo.NIname = name;
		return nameInfo;
	}

	internal InternalPrimitiveTypeE ToCode(Type type)
	{
		if ((object)previousType == type)
		{
			return previousCode;
		}
		InternalPrimitiveTypeE internalPrimitiveTypeE = Converter.ToCode(type);
		if (internalPrimitiveTypeE != InternalPrimitiveTypeE.Invalid)
		{
			previousType = type;
			previousCode = internalPrimitiveTypeE;
		}
		return internalPrimitiveTypeE;
	}

	private long GetAssemblyId(WriteObjectInfo objectInfo)
	{
		if (assemblyToIdTable == null)
		{
			assemblyToIdTable = new Hashtable(5);
		}
		long num = 0L;
		bool isNew = false;
		string assemblyString = objectInfo.GetAssemblyString();
		string assemblyString2 = assemblyString;
		if (assemblyString.Length == 0)
		{
			num = 0L;
		}
		else if (assemblyString.Equals(Converter.urtAssemblyString))
		{
			num = 0L;
		}
		else
		{
			if (assemblyToIdTable.ContainsKey(assemblyString))
			{
				num = (long)assemblyToIdTable[assemblyString];
				isNew = false;
			}
			else
			{
				num = InternalGetId("___AssemblyString___" + assemblyString, assignUniqueIdToValueType: false, null, out isNew);
				assemblyToIdTable[assemblyString] = num;
			}
			serWriter.WriteAssembly(objectInfo.objectType, assemblyString2, (int)num, isNew);
		}
		return num;
	}

	private Type GetType(object obj)
	{
		return obj.GetType();
	}

	private NameInfo GetNameInfo()
	{
		NameInfo nameInfo = null;
		if (!niPool.IsEmpty())
		{
			nameInfo = (NameInfo)niPool.Pop();
			nameInfo.Init();
		}
		else
		{
			nameInfo = new NameInfo();
		}
		return nameInfo;
	}

	private bool CheckTypeFormat(FormatterTypeStyle test, FormatterTypeStyle want)
	{
		return (test & want) == want;
	}

	private void PutNameInfo(NameInfo nameInfo)
	{
		niPool.Push(nameInfo);
	}
}
