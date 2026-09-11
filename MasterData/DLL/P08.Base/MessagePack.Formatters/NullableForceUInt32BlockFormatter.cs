namespace MessagePack.Formatters;

public sealed class NullableForceUInt32BlockFormatter : IMessagePackFormatter<uint?>, IMessagePackFormatter
{
	public static readonly NullableForceUInt32BlockFormatter Instance = new NullableForceUInt32BlockFormatter();

	private NullableForceUInt32BlockFormatter()
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
			writer.WriteUInt32(value.Value);
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
