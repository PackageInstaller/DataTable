namespace System.Runtime.Serialization.Formatters.Binary;

internal sealed class BinaryObjectWithMapTyped
{
	internal BinaryHeaderEnum binaryHeaderEnum;

	internal int objectId;

	internal string name;

	internal int numMembers;

	internal string[] memberNames;

	internal BinaryTypeEnum[] binaryTypeEnumA;

	internal object[] typeInformationA;

	internal int[] memberAssemIds;

	internal int assemId;

	internal BinaryObjectWithMapTyped()
	{
	}

	internal BinaryObjectWithMapTyped(BinaryHeaderEnum binaryHeaderEnum)
	{
		this.binaryHeaderEnum = binaryHeaderEnum;
	}

	internal void Set(int objectId, string name, int numMembers, string[] memberNames, BinaryTypeEnum[] binaryTypeEnumA, object[] typeInformationA, int[] memberAssemIds, int assemId)
	{
		this.objectId = objectId;
		this.assemId = assemId;
		this.name = name;
		this.numMembers = numMembers;
		this.memberNames = memberNames;
		this.binaryTypeEnumA = binaryTypeEnumA;
		this.typeInformationA = typeInformationA;
		this.memberAssemIds = memberAssemIds;
		this.assemId = assemId;
		if (assemId > 0)
		{
			binaryHeaderEnum = BinaryHeaderEnum.ObjectWithMapTypedAssemId;
		}
		else
		{
			binaryHeaderEnum = BinaryHeaderEnum.ObjectWithMapTyped;
		}
	}

	public void Write(__BinaryWriter sout)
	{
		sout.WriteByte((byte)binaryHeaderEnum);
		sout.WriteInt32(objectId);
		sout.WriteString(name);
		sout.WriteInt32(numMembers);
		for (int i = 0; i < numMembers; i++)
		{
			sout.WriteString(memberNames[i]);
		}
		for (int j = 0; j < numMembers; j++)
		{
			sout.WriteByte((byte)binaryTypeEnumA[j]);
		}
		for (int k = 0; k < numMembers; k++)
		{
			BinaryConverter.WriteTypeInfo(binaryTypeEnumA[k], typeInformationA[k], memberAssemIds[k], sout);
		}
		if (assemId > 0)
		{
			sout.WriteInt32(assemId);
		}
	}

	public void Read(__BinaryParser input)
	{
		objectId = input.ReadInt32();
		name = input.ReadString();
		numMembers = input.ReadInt32();
		memberNames = new string[numMembers];
		binaryTypeEnumA = new BinaryTypeEnum[numMembers];
		typeInformationA = new object[numMembers];
		memberAssemIds = new int[numMembers];
		for (int i = 0; i < numMembers; i++)
		{
			memberNames[i] = input.ReadString();
		}
		for (int j = 0; j < numMembers; j++)
		{
			binaryTypeEnumA[j] = (BinaryTypeEnum)input.ReadByte();
		}
		for (int k = 0; k < numMembers; k++)
		{
			if (binaryTypeEnumA[k] != BinaryTypeEnum.ObjectUrt && binaryTypeEnumA[k] != BinaryTypeEnum.ObjectUser)
			{
				typeInformationA[k] = BinaryConverter.ReadTypeInfo(binaryTypeEnumA[k], input, out memberAssemIds[k]);
			}
			else
			{
				BinaryConverter.ReadTypeInfo(binaryTypeEnumA[k], input, out memberAssemIds[k]);
			}
		}
		if (binaryHeaderEnum == BinaryHeaderEnum.ObjectWithMapTypedAssemId)
		{
			assemId = input.ReadInt32();
		}
	}
}
