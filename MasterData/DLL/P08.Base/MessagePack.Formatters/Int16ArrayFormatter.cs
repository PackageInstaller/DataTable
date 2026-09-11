using System;

namespace MessagePack.Formatters;

public sealed class Int16ArrayFormatter : IMessagePackFormatter<short[]>, IMessagePackFormatter
{
	public static readonly Int16ArrayFormatter Instance = new Int16ArrayFormatter();

	private Int16ArrayFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, short[] value, MessagePackSerializerOptions options)
	{
		if (value == null)
		{
			writer.WriteNil();
			return;
		}
		writer.WriteArrayHeader(value.Length);
		for (int i = 0; i < value.Length; i++)
		{
			writer.Write(value[i]);
		}
	}

	public short[] Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		int num = reader.ReadArrayHeader();
		if (num == 0)
		{
			return Array.Empty<short>();
		}
		short[] array = new short[num];
		for (int i = 0; i < array.Length; i++)
		{
			array[i] = reader.ReadInt16();
		}
		return array;
	}
}
