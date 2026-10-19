using UnityEngine;

namespace Sirenix.Serialization;

public class GradientAlphaKeyFormatter : MinimalBaseFormatter<GradientAlphaKey>
{
	private static readonly Serializer<float> FloatSerializer = Serializer.Get<float>();

	protected override void Read(ref GradientAlphaKey value, IDataReader reader)
	{
		value.alpha = FloatSerializer.ReadValue(reader);
		value.time = FloatSerializer.ReadValue(reader);
	}

	protected override void Write(ref GradientAlphaKey value, IDataWriter writer)
	{
		FloatSerializer.WriteValue(value.alpha, writer);
		FloatSerializer.WriteValue(value.time, writer);
	}
}
