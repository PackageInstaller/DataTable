using UnityEngine;

namespace Sirenix.Serialization;

public class RectFormatter : MinimalBaseFormatter<Rect>
{
	private static readonly Serializer<float> FloatSerializer = Serializer.Get<float>();

	protected override void Read(ref Rect value, IDataReader reader)
	{
		value.x = FloatSerializer.ReadValue(reader);
		value.y = FloatSerializer.ReadValue(reader);
		value.width = FloatSerializer.ReadValue(reader);
		value.height = FloatSerializer.ReadValue(reader);
	}

	protected override void Write(ref Rect value, IDataWriter writer)
	{
		FloatSerializer.WriteValue(value.x, writer);
		FloatSerializer.WriteValue(value.y, writer);
		FloatSerializer.WriteValue(value.width, writer);
		FloatSerializer.WriteValue(value.height, writer);
	}
}
