using System;

namespace MessagePack.Formatters;

public sealed class BooleanArrayFormatter : IMessagePackFormatter<bool[]>, IMessagePackFormatter
{
	public static readonly BooleanArrayFormatter Instance = new BooleanArrayFormatter();

	private BooleanArrayFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, bool[] value, MessagePackSerializerOptions options)
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

	public bool[] Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		int num = reader.ReadArrayHeader();
		if (num == 0)
		{
			return Array.Empty<bool>();
		}
		bool[] array = new bool[num];
		for (int i = 0; i < array.Length; i++)
		{
			array[i] = reader.ReadBoolean();
		}
		return array;
	}
}
