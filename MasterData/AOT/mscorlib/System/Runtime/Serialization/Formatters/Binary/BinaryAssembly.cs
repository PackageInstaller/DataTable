namespace System.Runtime.Serialization.Formatters.Binary;

internal sealed class BinaryAssembly
{
	internal int assemId;

	internal string assemblyString;

	internal BinaryAssembly()
	{
	}

	internal void Set(int assemId, string assemblyString)
	{
		this.assemId = assemId;
		this.assemblyString = assemblyString;
	}

	public void Write(__BinaryWriter sout)
	{
		sout.WriteByte(12);
		sout.WriteInt32(assemId);
		sout.WriteString(assemblyString);
	}

	public void Read(__BinaryParser input)
	{
		assemId = input.ReadInt32();
		assemblyString = input.ReadString();
	}

	public void Dump()
	{
	}
}
