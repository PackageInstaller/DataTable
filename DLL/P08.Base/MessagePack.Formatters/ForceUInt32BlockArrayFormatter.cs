using System;

namespace MessagePack.Formatters;

public sealed class ForceUInt32BlockArrayFormatter : IMessagePackFormatter<uint[]>, IMessagePackFormatter
{
	public static readonly ForceUInt32BlockArrayFormatter Instance = new ForceUInt32BlockArrayFormatter();

	private ForceUInt32BlockArrayFormatter()
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
			writer.WriteUInt32(value[i]);
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
		options.Security.DepthStep(ref reader);
		try
		{
			for (int i = 0; i < array.Length; i++)
			{
				array[i] = reader.ReadUInt32();
			}
			return array;
		}
		finally
		{
			reader.Depth--;
		}
	}
}
