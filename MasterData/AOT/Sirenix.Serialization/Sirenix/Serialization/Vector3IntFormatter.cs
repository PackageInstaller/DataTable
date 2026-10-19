using UnityEngine;

namespace Sirenix.Serialization;

public class Vector3IntFormatter : MinimalBaseFormatter<Vector3Int>
{
	private static readonly Serializer<int> Serializer = Sirenix.Serialization.Serializer.Get<int>();

	protected override void Read(ref Vector3Int value, IDataReader reader)
	{
		value.x = Serializer.ReadValue(reader);
		value.y = Serializer.ReadValue(reader);
		value.z = Serializer.ReadValue(reader);
	}

	protected override void Write(ref Vector3Int value, IDataWriter writer)
	{
		Serializer.WriteValue(value.x, writer);
		Serializer.WriteValue(value.y, writer);
		Serializer.WriteValue(value.z, writer);
	}
}
