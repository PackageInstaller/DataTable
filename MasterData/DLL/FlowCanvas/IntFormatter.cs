using System;
using MessagePack;
using MessagePack.Formatters;

public sealed class IntFormatter : IMessagePackFormatter<Int>, IMessagePackFormatter
{
	public void Serialize(ref MessagePackWriter writer, Int value, MessagePackSerializerOptions options)
	{
		writer.Write(value.i);
	}

	public Int Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.IsNil)
		{
			throw new InvalidOperationException("typecode is null, struct not supported");
		}
		int num = 0;
		num = reader.ReadInt32();
		return new Int
		{
			i = num
		};
	}
}
