using UnityEngine;

namespace Sirenix.Serialization;

public class Color32Formatter : MinimalBaseFormatter<Color32>
{
	private static readonly Serializer<byte> ByteSerializer = Serializer.Get<byte>();

	protected override void Read(ref Color32 value, IDataReader reader)
	{
		value.r = ByteSerializer.ReadValue(reader);
		value.g = ByteSerializer.ReadValue(reader);
		value.b = ByteSerializer.ReadValue(reader);
		value.a = ByteSerializer.ReadValue(reader);
	}

	protected override void Write(ref Color32 value, IDataWriter writer)
	{
		ByteSerializer.WriteValue(value.r, writer);
		ByteSerializer.WriteValue(value.g, writer);
		ByteSerializer.WriteValue(value.b, writer);
		ByteSerializer.WriteValue(value.a, writer);
	}
}
