using MessagePack.Formatters;
using UnityEngine;

namespace MessagePack.Unity;

public sealed class WrapModeFormatter : IMessagePackFormatter<WrapMode>, IMessagePackFormatter
{
	public void Serialize(ref MessagePackWriter writer, WrapMode value, MessagePackSerializerOptions options)
	{
		writer.Write((int)value);
	}

	public WrapMode Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		return (WrapMode)reader.ReadInt32();
	}
}
