using System.Text;

namespace MessagePack.Formatters;

public sealed class StringBuilderFormatter : IMessagePackFormatter<StringBuilder>, IMessagePackFormatter
{
	public static readonly IMessagePackFormatter<StringBuilder> Instance = new StringBuilderFormatter();

	private StringBuilderFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, StringBuilder value, MessagePackSerializerOptions options)
	{
		if (value == null)
		{
			writer.WriteNil();
		}
		else
		{
			writer.Write(value.ToString());
		}
	}

	public StringBuilder Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		return new StringBuilder(reader.ReadString());
	}
}
