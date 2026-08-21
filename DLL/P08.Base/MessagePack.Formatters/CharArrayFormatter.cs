using System;

namespace MessagePack.Formatters;

public sealed class CharArrayFormatter : IMessagePackFormatter<char[]>, IMessagePackFormatter
{
	public static readonly CharArrayFormatter Instance = new CharArrayFormatter();

	private CharArrayFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, char[] value, MessagePackSerializerOptions options)
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

	public char[] Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		int num = reader.ReadArrayHeader();
		if (num == 0)
		{
			return Array.Empty<char>();
		}
		char[] array = new char[num];
		for (int i = 0; i < array.Length; i++)
		{
			array[i] = reader.ReadChar();
		}
		return array;
	}
}
