using System.IO;

namespace System.Runtime.Serialization.Formatters.Binary;

internal sealed class MessageEnd
{
	internal MessageEnd()
	{
	}

	public void Write(__BinaryWriter sout)
	{
		sout.WriteByte(11);
	}

	public void Read(__BinaryParser input)
	{
	}

	public void Dump()
	{
	}

	public void Dump(Stream sout)
	{
	}
}
