using UnityEngine;

namespace Sirenix.Serialization;

public class QuaternionFormatter : MinimalBaseFormatter<Quaternion>
{
	private static readonly Serializer<float> FloatSerializer = Serializer.Get<float>();

	protected override void Read(ref Quaternion value, IDataReader reader)
	{
		value.x = FloatSerializer.ReadValue(reader);
		value.y = FloatSerializer.ReadValue(reader);
		value.z = FloatSerializer.ReadValue(reader);
		value.w = FloatSerializer.ReadValue(reader);
	}

	protected override void Write(ref Quaternion value, IDataWriter writer)
	{
		FloatSerializer.WriteValue(value.x, writer);
		FloatSerializer.WriteValue(value.y, writer);
		FloatSerializer.WriteValue(value.z, writer);
		FloatSerializer.WriteValue(value.w, writer);
	}
}
