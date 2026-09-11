namespace System.Runtime.Serialization.Formatters.Binary;

internal sealed class BinaryObjectWithMap
{
	internal BinaryHeaderEnum binaryHeaderEnum;

	internal int objectId;

	internal string name;

	internal int numMembers;

	internal string[] memberNames;

	internal int assemId;

	internal BinaryObjectWithMap()
	{
	}

	internal BinaryObjectWithMap(BinaryHeaderEnum binaryHeaderEnum)
	{
		this.binaryHeaderEnum = binaryHeaderEnum;
	}

	internal void Set(int objectId, string name, int numMembers, string[] memberNames, int assemId)
	{
		this.objectId = objectId;
		this.name = name;
		this.numMembers = numMembers;
		this.memberNames = memberNames;
		this.assemId = assemId;
		if (assemId > 0)
		{
			binaryHeaderEnum = BinaryHeaderEnum.ObjectWithMapAssemId;
		}
		else
		{
			binaryHeaderEnum = BinaryHeaderEnum.ObjectWithMap;
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
		for (int i = 0; i < numMembers; i++)
		{
			memberNames[i] = input.ReadString();
		}
		if (binaryHeaderEnum == BinaryHeaderEnum.ObjectWithMapAssemId)
		{
			assemId = input.ReadInt32();
		}
	}

	public void Dump()
	{
	}
}
