using System;

namespace MessagePack.Formatters;

public sealed class ForceSByteBlockArrayFormatter : IMessagePackFormatter<sbyte[]>, IMessagePackFormatter
{
	public static readonly ForceSByteBlockArrayFormatter Instance = new ForceSByteBlockArrayFormatter();

	private ForceSByteBlockArrayFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, sbyte[] value, MessagePackSerializerOptions options)
	{
		if (value == null)
		{
			writer.WriteNil();
			return;
		}
		writer.WriteArrayHeader(value.Length);
		for (int i = 0; i < value.Length; i++)
		{
			writer.WriteInt8(value[i]);
		}
	}

	public sbyte[] Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		int num = reader.ReadArrayHeader();
		if (num == 0)
		{
			return Array.Empty<sbyte>();
		}
		sbyte[] array = new sbyte[num];
		options.Security.DepthStep(ref reader);
		try
		{
			for (int i = 0; i < array.Length; i++)
			{
				array[i] = reader.ReadSByte();
			}
			return array;
		}
		finally
		{
			reader.Depth--;
		}
	}
}
