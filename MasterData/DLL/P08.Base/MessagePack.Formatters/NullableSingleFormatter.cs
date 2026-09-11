namespace MessagePack.Formatters;

public sealed class NullableSingleFormatter : IMessagePackFormatter<float?>, IMessagePackFormatter
{
	public static readonly NullableSingleFormatter Instance = new NullableSingleFormatter();

	private NullableSingleFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, float? value, MessagePackSerializerOptions options)
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

	public float? Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		return reader.ReadSingle();
	}
}
