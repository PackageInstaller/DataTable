using System;
using MessagePack;
using MessagePack.Formatters;

public sealed class SimVarFormatter : IMessagePackFormatter<SimVar>, IMessagePackFormatter
{
	public void Serialize(ref MessagePackWriter writer, SimVar value, MessagePackSerializerOptions options)
	{
		writer.Write(value.int3Var.x);
		writer.Write(value.int3Var.y);
		writer.Write(value.int3Var.z);
	}

	public SimVar Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.IsNil)
		{
			throw new InvalidOperationException("typecode is null, struct not supported");
		}
		return new SimVar
		{
			int3Var = new Int3(reader.ReadInt32(), reader.ReadInt32(), reader.ReadInt32())
		};
	}
}
