using System;

namespace MessagePack.Formatters;

public sealed class VersionFormatter : IMessagePackFormatter<Version>, IMessagePackFormatter
{
	public static readonly IMessagePackFormatter<Version> Instance = new VersionFormatter();

	private VersionFormatter()
	{
	}

	public void Serialize(ref MessagePackWriter writer, Version value, MessagePackSerializerOptions options)
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

	public Version Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		if (reader.TryReadNil())
		{
			return null;
		}
		return new Version(reader.ReadString());
	}
}
