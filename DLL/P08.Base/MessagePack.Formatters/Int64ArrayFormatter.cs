using System;

namespace MessagePack.Formatters;

public sealed class Int64ArrayFormatter : IMessagePackFormatter<long[]>, IMessagePackFormatter
{
	public static readonly Int64ArrayFormatter Instance = new Int64ArrayFormatter();

	private Int64ArrayFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, long[] value, MessagePackSerializerOptions options)
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

	public long[] Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		int num = reader.ReadArrayHeader();
		if (num == 0)
		{
			return Array.Empty<long>();
		}
		long[] array = new long[num];
		for (int i = 0; i < array.Length; i++)
		{
			array[i] = reader.ReadInt64();
		}
		return array;
	}
}
