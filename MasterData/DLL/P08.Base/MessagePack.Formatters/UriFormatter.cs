using System;

namespace MessagePack.Formatters;

public sealed class UriFormatter : IMessagePackFormatter<Uri>, IMessagePackFormatter
{
	public static readonly IMessagePackFormatter<Uri> Instance = new UriFormatter();

	private UriFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, Uri value, MessagePackSerializerOptions options)
	{
		if (value == null)
		{
			writer.WriteNil();
		}
		else
		{
			writer.Write(value.OriginalString);
		}
	}

	public Uri Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		return new Uri(reader.ReadString(), UriKind.RelativeOrAbsolute);
	}
}
