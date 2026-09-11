using System;

namespace MessagePack.Formatters;

public sealed class ForceInt16BlockArrayFormatter : IMessagePackFormatter<short[]>, IMessagePackFormatter
{
	public static readonly ForceInt16BlockArrayFormatter Instance = new ForceInt16BlockArrayFormatter();

	private ForceInt16BlockArrayFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, short[] value, MessagePackSerializerOptions options)
	{
		if (value == null)
		{
			writer.WriteNil();
			return;
		}
		writer.WriteArrayHeader(value.Length);
		for (int i = 0; i < value.Length; i++)
		{
			writer.WriteInt16(value[i]);
		}
	}

	public short[] Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		int num = reader.ReadArrayHeader();
		if (num == 0)
		{
			return Array.Empty<short>();
		}
		short[] array = new short[num];
		options.Security.DepthStep(ref reader);
		try
		{
			for (int i = 0; i < array.Length; i++)
			{
				array[i] = reader.ReadInt16();
			}
			return array;
		}
		finally
		{
			reader.Depth--;
		}
	}
}
