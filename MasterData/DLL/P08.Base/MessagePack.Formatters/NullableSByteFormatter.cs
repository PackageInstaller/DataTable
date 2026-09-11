namespace MessagePack.Formatters;

public sealed class NullableSByteFormatter : IMessagePackFormatter<sbyte?>, IMessagePackFormatter
{
	public static readonly NullableSByteFormatter Instance = new NullableSByteFormatter();

	private NullableSByteFormatter()
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
			writer.Write(value.Value);
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
