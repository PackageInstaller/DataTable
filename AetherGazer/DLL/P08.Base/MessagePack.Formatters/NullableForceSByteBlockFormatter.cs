namespace MessagePack.Formatters;

public sealed class NullableForceSByteBlockFormatter : IMessagePackFormatter<sbyte?>, IMessagePackFormatter
{
	public static readonly NullableForceSByteBlockFormatter Instance = new NullableForceSByteBlockFormatter();

	private NullableForceSByteBlockFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, sbyte? value, MessagePackSerializerOptions options)
	{
		if (!value.HasValue)
		{
			writer.WriteNil();
		}
		else
		{
			writer.WriteInt8(value.Value);
		}
	}

	public sbyte? Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		return reader.ReadSByte();
	}
}
