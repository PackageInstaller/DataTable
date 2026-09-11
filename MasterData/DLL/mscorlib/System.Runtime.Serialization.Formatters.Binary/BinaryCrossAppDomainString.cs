namespace System.Runtime.Serialization.Formatters.Binary;

internal sealed class BinaryCrossAppDomainString
{
	internal int objectId;

	internal int value;

	internal BinaryCrossAppDomainString()
	{
	}

	public void Read(__BinaryParser input)
	{
		objectId = input.ReadInt32();
		value = input.ReadInt32();
	}

	public void Dump()
	{
	}
}
