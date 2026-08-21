using MemoryPack.Internal;
using UnityEngine;

namespace MemoryPack;

[Preserve]
internal sealed class GradientFormatter : MemoryPackFormatter<Gradient>
{
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref Gradient? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteObjectHeader(3);
		writer.WriteUnmanagedArray(value.colorKeys);
		writer.WriteUnmanagedArray(value.alphaKeys);
		writer.WriteUnmanaged<GradientMode>(value.mode);
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref Gradient? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		if (memberCount != 3)
		{
			MemoryPackSerializationException.ThrowInvalidPropertyCount(3, memberCount);
		}
		GradientColorKey[] colorKeys = reader.ReadUnmanagedArray<GradientColorKey>();
		GradientAlphaKey[] alphaKeys = reader.ReadUnmanagedArray<GradientAlphaKey>();
		reader.ReadUnmanaged<GradientMode>(out var value2);
		if (value == null)
		{
			value = new Gradient();
		}
		value.colorKeys = colorKeys;
		value.alphaKeys = alphaKeys;
		value.mode = value2;
	}
}
