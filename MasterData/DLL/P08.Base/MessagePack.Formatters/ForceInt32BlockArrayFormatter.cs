using System;

namespace MessagePack.Formatters;

public sealed class ForceInt32BlockArrayFormatter : IMessagePackFormatter<int[]>, IMessagePackFormatter
{
	public static readonly ForceInt32BlockArrayFormatter Instance = new ForceInt32BlockArrayFormatter();

	private ForceInt32BlockArrayFormatter()
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
			writer.WriteInt32(value[i]);
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
		options.Security.DepthStep(ref reader);
		try
		{
			for (int i = 0; i < array.Length; i++)
			{
				array[i] = reader.ReadInt32();
			}
			return array;
		}
		finally
		{
			reader.Depth--;
		}
	}
}
