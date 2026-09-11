using System;

namespace MessagePack.Formatters;

public sealed class UInt32ArrayFormatter : IMessagePackFormatter<uint[]>, IMessagePackFormatter
{
	public static readonly UInt32ArrayFormatter Instance = new UInt32ArrayFormatter();

	private UInt32ArrayFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, uint[] value, MessagePackSerializerOptions options)
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

	public uint[] Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		int num = reader.ReadArrayHeader();
		if (num == 0)
		{
			return Array.Empty<uint>();
		}
		uint[] array = new uint[num];
		for (int i = 0; i < array.Length; i++)
		{
			array[i] = reader.ReadUInt32();
		}
		return array;
	}
}
