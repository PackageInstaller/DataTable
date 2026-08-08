namespace MessagePack.Formatters;

public sealed class NullableBooleanFormatter : IMessagePackFormatter<bool?>, IMessagePackFormatter
{
	public static readonly NullableBooleanFormatter Instance = new NullableBooleanFormatter();

	private NullableBooleanFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, bool? value, MessagePackSerializerOptions options)
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

	public bool? Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		return reader.ReadBoolean();
	}
}
