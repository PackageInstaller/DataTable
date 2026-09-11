namespace MessagePack.Formatters;

public sealed class NullableForceUInt16BlockFormatter : IMessagePackFormatter<ushort?>, IMessagePackFormatter
{
	public static readonly NullableForceUInt16BlockFormatter Instance = new NullableForceUInt16BlockFormatter();

	private NullableForceUInt16BlockFormatter()
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
			writer.WriteUInt16(value.Value);
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
