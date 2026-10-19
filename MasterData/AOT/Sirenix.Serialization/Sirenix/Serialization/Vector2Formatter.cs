using UnityEngine;

namespace Sirenix.Serialization;

public class Vector2Formatter : MinimalBaseFormatter<Vector2>
{
	private static readonly Serializer<float> FloatSerializer = Serializer.Get<float>();

	protected override void Read(ref Vector2 value, IDataReader reader)
	{
		value.x = FloatSerializer.ReadValue(reader);
		value.y = FloatSerializer.ReadValue(reader);
	}

	protected override void Write(ref Vector2 value, IDataWriter writer)
	{
		FloatSerializer.WriteValue(value.x, writer);
		FloatSerializer.WriteValue(value.y, writer);
	}
}
