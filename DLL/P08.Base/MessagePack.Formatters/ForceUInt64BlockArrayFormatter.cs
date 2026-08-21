using System;

namespace MessagePack.Formatters;

public sealed class ForceUInt64BlockArrayFormatter : IMessagePackFormatter<ulong[]>, IMessagePackFormatter
{
	public static readonly ForceUInt64BlockArrayFormatter Instance = new ForceUInt64BlockArrayFormatter();

	private ForceUInt64BlockArrayFormatter()
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
			writer.WriteUInt64(value[i]);
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
		options.Security.DepthStep(ref reader);
		try
		{
			for (int i = 0; i < array.Length; i++)
			{
				array[i] = reader.ReadUInt64();
			}
			return array;
		}
		finally
		{
			reader.Depth--;
		}
	}
}
