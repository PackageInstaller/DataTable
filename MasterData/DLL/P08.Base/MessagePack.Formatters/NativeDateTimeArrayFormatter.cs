using System;

namespace MessagePack.Formatters;

public sealed class NativeDateTimeArrayFormatter : IMessagePackFormatter<DateTime[]>, IMessagePackFormatter
{
	public static readonly NativeDateTimeArrayFormatter Instance = new NativeDateTimeArrayFormatter();

	public void Serialize(ref MessagePackWriter writer, DateTime[] value, MessagePackSerializerOptions options)
	{
		if (value == null)
		{
			writer.WriteNil();
			return;
		}
		writer.WriteArrayHeader(value.Length);
		for (int i = 0; i < value.Length; i++)
		{
			writer.Write(value[i].ToBinary());
		}
	}

	public DateTime[] Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		int num = reader.ReadArrayHeader();
		if (num == 0)
		{
			return Array.Empty<DateTime>();
		}
		DateTime[] array = new DateTime[num];
		for (int i = 0; i < array.Length; i++)
		{
			long dateData = reader.ReadInt64();
			array[i] = DateTime.FromBinary(dateData);
		}
		return array;
	}
}
