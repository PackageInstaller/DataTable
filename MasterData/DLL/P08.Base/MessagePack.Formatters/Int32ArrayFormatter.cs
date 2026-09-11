using System;

namespace MessagePack.Formatters;

public sealed class Int32ArrayFormatter : IMessagePackFormatter<int[]>, IMessagePackFormatter
{
	public static readonly Int32ArrayFormatter Instance = new Int32ArrayFormatter();

	private Int32ArrayFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, int[] value, MessagePackSerializerOptions options)
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

	public int[] Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		int num = reader.ReadArrayHeader();
		if (num == 0)
		{
			return Array.Empty<int>();
		}
		int[] array = new int[num];
		for (int i = 0; i < array.Length; i++)
		{
			array[i] = reader.ReadInt32();
		}
		return array;
	}
}
