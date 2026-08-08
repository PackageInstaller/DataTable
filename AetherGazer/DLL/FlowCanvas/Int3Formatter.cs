using System;
using MessagePack;
using MessagePack.Formatters;

public sealed class Int3Formatter : IMessagePackFormatter<Int3>, IMessagePackFormatter
{
	public void Serialize(ref MessagePackWriter writer, Int3 value, MessagePackSerializerOptions options)
	{
		writer.Write(value.x);
		writer.Write(value.y);
		writer.Write(value.z);
	}

	public Int3 Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.IsNil)
		{
			throw new InvalidOperationException("typecode is null, struct not supported");
		}
		return new Int3(reader.ReadInt32(), reader.ReadInt32(), reader.ReadInt32());
	}
}
