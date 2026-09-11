using System;

namespace MessagePack.Formatters;

public sealed class NullableStringArrayFormatter : IMessagePackFormatter<string[]>, IMessagePackFormatter
{
	public static readonly NullableStringArrayFormatter Instance = new NullableStringArrayFormatter();

	private NullableStringArrayFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, string[] value, MessagePackSerializerOptions options)
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

	public string[] Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		int num = reader.ReadArrayHeader();
		if (num == 0)
		{
			return Array.Empty<string>();
		}
		string[] array = new string[num];
		for (int i = 0; i < array.Length; i++)
		{
			array[i] = reader.ReadString();
		}
		return array;
	}
}
