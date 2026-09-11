namespace System.Runtime.Serialization.Formatters.Binary;

internal sealed class BinaryCrossAppDomainMap
{
	internal int crossAppDomainArrayIndex;

	internal BinaryCrossAppDomainMap()
	{
	}

	public void Read(__BinaryParser input)
	{
		crossAppDomainArrayIndex = input.ReadInt32();
	}

	public void Dump()
	{
	}
}
