namespace System.Runtime.Serialization.Formatters.Binary;

internal sealed class MemberReference
{
	internal int idRef;

	internal MemberReference()
	{
	}

	internal void Set(int idRef)
	{
		this.idRef = idRef;
	}

	public void Write(__BinaryWriter sout)
	{
		sout.WriteByte(9);
		sout.WriteInt32(idRef);
	}

	public void Read(__BinaryParser input)
	{
		idRef = input.ReadInt32();
	}

	public void Dump()
	{
	}
}
