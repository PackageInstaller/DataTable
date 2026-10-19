using UnityEngine;

namespace Sirenix.Serialization;

public class ColorFormatter : MinimalBaseFormatter<Color>
{
	private static readonly Serializer<float> FloatSerializer = Serializer.Get<float>();

	protected override void Read(ref Color value, IDataReader reader)
	{
		value.r = FloatSerializer.ReadValue(reader);
		value.g = FloatSerializer.ReadValue(reader);
		value.b = FloatSerializer.ReadValue(reader);
		value.a = FloatSerializer.ReadValue(reader);
	}

	protected override void Write(ref Color value, IDataWriter writer)
	{
		FloatSerializer.WriteValue(value.r, writer);
		FloatSerializer.WriteValue(value.g, writer);
		FloatSerializer.WriteValue(value.b, writer);
		FloatSerializer.WriteValue(value.a, writer);
	}
}
