namespace System.Runtime.Serialization.Formatters.Binary;

internal sealed class BinaryCrossAppDomainAssembly
{
	internal int assemId;

	internal int assemblyIndex;

	internal BinaryCrossAppDomainAssembly()
	{
	}

	public void Read(__BinaryParser input)
	{
		assemId = input.ReadInt32();
		assemblyIndex = input.ReadInt32();
	}

	public void Dump()
	{
	}
}
