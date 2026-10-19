using UnityEngine;

namespace Sirenix.Serialization;

public class GradientColorKeyFormatter : MinimalBaseFormatter<GradientColorKey>
{
	private static readonly Serializer<Color> ColorSerializer = Serializer.Get<Color>();

	private static readonly Serializer<float> FloatSerializer = Serializer.Get<float>();

	protected override void Read(ref GradientColorKey value, IDataReader reader)
	{
		value.color = ColorSerializer.ReadValue(reader);
		value.time = FloatSerializer.ReadValue(reader);
	}

	protected override void Write(ref GradientColorKey value, IDataWriter writer)
	{
		ColorSerializer.WriteValue(value.color, writer);
		FloatSerializer.WriteValue(value.time, writer);
	}
}
