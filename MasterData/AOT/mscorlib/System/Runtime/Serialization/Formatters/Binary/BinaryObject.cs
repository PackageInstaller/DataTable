namespace System.Runtime.Serialization.Formatters.Binary;

internal sealed class BinaryObject
{
	internal int objectId;

	internal int mapId;

	internal BinaryObject()
	{
	}

	internal void Set(int objectId, int mapId)
	{
		this.objectId = objectId;
		this.mapId = mapId;
	}

	public void Write(__BinaryWriter sout)
	{
		sout.WriteByte(1);
		sout.WriteInt32(objectId);
		sout.WriteInt32(mapId);
	}

	public void Read(__BinaryParser input)
	{
		objectId = input.ReadInt32();
		mapId = input.ReadInt32();
	}

	public void Dump()
	{
	}
}
