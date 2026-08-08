using System;

namespace MessagePack.Formatters;

public sealed class ForceInt64BlockArrayFormatter : IMessagePackFormatter<long[]>, IMessagePackFormatter
{
	public static readonly ForceInt64BlockArrayFormatter Instance = new ForceInt64BlockArrayFormatter();

	private ForceInt64BlockArrayFormatter()
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
			writer.WriteInt64(value[i]);
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
		options.Security.DepthStep(ref reader);
		try
		{
			for (int i = 0; i < array.Length; i++)
			{
				array[i] = reader.ReadInt64();
			}
			return array;
		}
		finally
		{
			reader.Depth--;
		}
	}
}
