namespace System.Runtime.Serialization.Formatters.Binary;

internal sealed class BinaryObjectString
{
	internal int objectId;

	internal string value;

	internal BinaryObjectString()
	{
	}

	internal void Set(int objectId, string value)
	{
		this.objectId = objectId;
		this.value = value;
	}

	public void Write(__BinaryWriter sout)
	{
		sout.WriteByte(6);
		sout.WriteInt32(objectId);
		sout.WriteString(value);
	}

	public void Read(__BinaryParser input)
	{
		objectId = input.ReadInt32();
		value = input.ReadString();
	}

	public void Dump()
	{
	}
}
