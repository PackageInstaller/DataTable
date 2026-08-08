using MessagePack.Formatters;
using UnityEngine;

namespace MessagePack.Unity;

public sealed class GradientModeFormatter : IMessagePackFormatter<GradientMode>, IMessagePackFormatter
{
	public void Serialize(ref MessagePackWriter writer, GradientMode value, MessagePackSerializerOptions options)
	{
		writer.Write((int)value);
	}

	public GradientMode Deserialize(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		return (GradientMode)reader.ReadInt32();
	}
}
