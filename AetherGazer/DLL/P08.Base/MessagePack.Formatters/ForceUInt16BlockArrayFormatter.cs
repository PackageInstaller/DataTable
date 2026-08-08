using System;

namespace MessagePack.Formatters;

public sealed class ForceUInt16BlockArrayFormatter : IMessagePackFormatter<ushort[]>, IMessagePackFormatter
{
	public static readonly ForceUInt16BlockArrayFormatter Instance = new ForceUInt16BlockArrayFormatter();

	private ForceUInt16BlockArrayFormatter()
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
			writer.WriteUInt16(value[i]);
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
		options.Security.DepthStep(ref reader);
		try
		{
			for (int i = 0; i < array.Length; i++)
			{
				array[i] = reader.ReadUInt16();
			}
			return array;
		}
		finally
		{
			reader.Depth--;
		}
	}
}
