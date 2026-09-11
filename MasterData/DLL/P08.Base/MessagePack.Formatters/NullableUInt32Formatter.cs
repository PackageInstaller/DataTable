namespace MessagePack.Formatters;

public sealed class NullableUInt32Formatter : IMessagePackFormatter<uint?>, IMessagePackFormatter
{
	public static readonly NullableUInt32Formatter Instance = new NullableUInt32Formatter();

	private NullableUInt32Formatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, uint? value, MessagePackSerializerOptions options)
	{
		if (!value.HasValue)
		{
			writer.WriteNil();
		}
		else
		{
			writer.Write(value.Value);
		}
	}

	public uint? Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		return reader.ReadUInt32();
	}
}
