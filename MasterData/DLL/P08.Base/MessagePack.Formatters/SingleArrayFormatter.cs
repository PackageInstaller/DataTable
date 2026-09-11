using System;

namespace MessagePack.Formatters;

public sealed class SingleArrayFormatter : IMessagePackFormatter<float[]>, IMessagePackFormatter
{
	public static readonly SingleArrayFormatter Instance = new SingleArrayFormatter();

	private SingleArrayFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, float[] value, MessagePackSerializerOptions options)
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

	public float[] Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		int num = reader.ReadArrayHeader();
		if (num == 0)
		{
			return Array.Empty<float>();
		}
		float[] array = new float[num];
		for (int i = 0; i < array.Length; i++)
		{
			array[i] = reader.ReadSingle();
		}
		return array;
	}
}
