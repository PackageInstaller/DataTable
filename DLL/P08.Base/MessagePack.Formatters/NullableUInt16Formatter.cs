namespace MessagePack.Formatters;

public sealed class NullableUInt16Formatter : IMessagePackFormatter<ushort?>, IMessagePackFormatter
{
	public static readonly NullableUInt16Formatter Instance = new NullableUInt16Formatter();

	private NullableUInt16Formatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, ushort? value, MessagePackSerializerOptions options)
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

	public ushort? Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		return reader.ReadUInt16();
	}
}
