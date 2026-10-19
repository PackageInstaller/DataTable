using UnityEngine;

namespace Sirenix.Serialization;

public class BoundsFormatter : MinimalBaseFormatter<Bounds>
{
	private static readonly Serializer<Vector3> Vector3Serializer = Serializer.Get<Vector3>();

	protected override void Read(ref Bounds value, IDataReader reader)
	{
		value.center = Vector3Serializer.ReadValue(reader);
		value.size = Vector3Serializer.ReadValue(reader);
	}

	protected override void Write(ref Bounds value, IDataWriter writer)
	{
		Vector3Serializer.WriteValue(value.center, writer);
		Vector3Serializer.WriteValue(value.size, writer);
	}
}
