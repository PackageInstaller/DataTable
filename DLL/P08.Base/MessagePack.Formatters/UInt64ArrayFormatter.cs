using System;

namespace MessagePack.Formatters;

public sealed class UInt64ArrayFormatter : IMessagePackFormatter<ulong[]>, IMessagePackFormatter
{
	public static readonly UInt64ArrayFormatter Instance = new UInt64ArrayFormatter();

	private UInt64ArrayFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, ulong[] value, MessagePackSerializerOptions options)
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

	public ulong[] Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		int num = reader.ReadArrayHeader();
		if (num == 0)
		{
			return Array.Empty<ulong>();
		}
		ulong[] array = new ulong[num];
		for (int i = 0; i < array.Length; i++)
		{
			array[i] = reader.ReadUInt64();
		}
		return array;
	}
}
