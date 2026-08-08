using System;

namespace MessagePack.Formatters;

public sealed class UInt16ArrayFormatter : IMessagePackFormatter<ushort[]>, IMessagePackFormatter
{
	public static readonly UInt16ArrayFormatter Instance = new UInt16ArrayFormatter();

	private UInt16ArrayFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, ushort[] value, MessagePackSerializerOptions options)
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

	public ushort[] Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		int num = reader.ReadArrayHeader();
		if (num == 0)
		{
			return Array.Empty<ushort>();
		}
		ushort[] array = new ushort[num];
		for (int i = 0; i < array.Length; i++)
		{
			array[i] = reader.ReadUInt16();
		}
		return array;
	}
}
