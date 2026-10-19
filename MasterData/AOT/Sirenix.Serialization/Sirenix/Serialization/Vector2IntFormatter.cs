using UnityEngine;

namespace Sirenix.Serialization;

public class Vector2IntFormatter : MinimalBaseFormatter<Vector2Int>
{
	private static readonly Serializer<int> Serializer = Sirenix.Serialization.Serializer.Get<int>();

	protected override void Read(ref Vector2Int value, IDataReader reader)
	{
		value.x = Serializer.ReadValue(reader);
		value.y = Serializer.ReadValue(reader);
	}

	protected override void Write(ref Vector2Int value, IDataWriter writer)
	{
		Serializer.WriteValue(value.x, writer);
		Serializer.WriteValue(value.y, writer);
	}
}
