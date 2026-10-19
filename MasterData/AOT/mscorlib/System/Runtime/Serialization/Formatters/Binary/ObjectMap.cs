namespace System.Runtime.Serialization.Formatters.Binary;

internal sealed class ObjectMap
{
	internal string objectName;

	internal Type objectType;

	internal BinaryTypeEnum[] binaryTypeEnumA;

	internal object[] typeInformationA;

	internal Type[] memberTypes;

	internal string[] memberNames;

	internal ReadObjectInfo objectInfo;

	internal bool isInitObjectInfo = true;

	internal ObjectReader objectReader;

	internal int objectId;

	internal BinaryAssemblyInfo assemblyInfo;

	internal ObjectMap(string objectName, Type objectType, string[] memberNames, ObjectReader objectReader, int objectId, BinaryAssemblyInfo assemblyInfo)
	{
		this.objectName = objectName;
		this.objectType = objectType;
		this.memberNames = memberNames;
		this.objectReader = objectReader;
		this.objectId = objectId;
		this.assemblyInfo = assemblyInfo;
		objectInfo = objectReader.CreateReadObjectInfo(objectType);
		memberTypes = objectInfo.GetMemberTypes(memberNames, objectType);
		binaryTypeEnumA = new BinaryTypeEnum[memberTypes.Length];
		typeInformationA = new object[memberTypes.Length];
		for (int i = 0; i < memberTypes.Length; i++)
		{
			object typeInformation = null;
			BinaryTypeEnum parserBinaryTypeInfo = BinaryConverter.GetParserBinaryTypeInfo(memberTypes[i], out typeInformation);
			binaryTypeEnumA[i] = parserBinaryTypeInfo;
			typeInformationA[i] = typeInformation;
		}
	}

	internal ObjectMap(string objectName, string[] memberNames, BinaryTypeEnum[] binaryTypeEnumA, object[] typeInformationA, int[] memberAssemIds, ObjectReader objectReader, int objectId, BinaryAssemblyInfo assemblyInfo, SizedArray assemIdToAssemblyTable)
	{
		this.objectName = objectName;
		this.memberNames = memberNames;
		this.binaryTypeEnumA = binaryTypeEnumA;
		this.typeInformationA = typeInformationA;
		this.objectReader = objectReader;
		this.objectId = objectId;
		this.assemblyInfo = assemblyInfo;
		if (assemblyInfo == null)
		{
			throw new SerializationException(Environment.GetResourceString("No assembly information is available for object on the wire, '{0}'.", objectName));
		}
		objectType = objectReader.GetType(assemblyInfo, objectName);
		memberTypes = new Type[memberNames.Length];
		for (int i = 0; i < memberNames.Length; i++)
		{
			BinaryConverter.TypeFromInfo(binaryTypeEnumA[i], typeInformationA[i], objectReader, (BinaryAssemblyInfo)assemIdToAssemblyTable[memberAssemIds[i]], out var _, out var _, out var type, out var _);
			memberTypes[i] = type;
		}
		objectInfo = objectReader.CreateReadObjectInfo(objectType, memberNames, null);
		if (!objectInfo.isSi)
		{
			objectInfo.GetMemberTypes(memberNames, objectInfo.objectType);
		}
	}

	internal ReadObjectInfo CreateObjectInfo(ref SerializationInfo si, ref object[] memberData)
	{
		if (isInitObjectInfo)
		{
			isInitObjectInfo = false;
			objectInfo.InitDataStore(ref si, ref memberData);
			return objectInfo;
		}
		objectInfo.PrepareForReuse();
		objectInfo.InitDataStore(ref si, ref memberData);
		return objectInfo;
	}

	internal static ObjectMap Create(string name, Type objectType, string[] memberNames, ObjectReader objectReader, int objectId, BinaryAssemblyInfo assemblyInfo)
	{
		return new ObjectMap(name, objectType, memberNames, objectReader, objectId, assemblyInfo);
	}

	internal static ObjectMap Create(string name, string[] memberNames, BinaryTypeEnum[] binaryTypeEnumA, object[] typeInformationA, int[] memberAssemIds, ObjectReader objectReader, int objectId, BinaryAssemblyInfo assemblyInfo, SizedArray assemIdToAssemblyTable)
	{
		return new ObjectMap(name, memberNames, binaryTypeEnumA, typeInformationA, memberAssemIds, objectReader, objectId, assemblyInfo, assemIdToAssemblyTable);
	}
}
