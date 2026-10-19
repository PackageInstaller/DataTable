using UnityEngine;

namespace Sirenix.Serialization;

public class LayerMaskFormatter : MinimalBaseFormatter<LayerMask>
{
	private static readonly Serializer<int> IntSerializer = Serializer.Get<int>();

	protected override void Read(ref LayerMask value, IDataReader reader)
	{
		value.value = IntSerializer.ReadValue(reader);
	}

	protected override void Write(ref LayerMask value, IDataWriter writer)
	{
		IntSerializer.WriteValue(value.value, writer);
	}
}
