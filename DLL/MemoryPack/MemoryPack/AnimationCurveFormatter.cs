using MemoryPack.Internal;
using UnityEngine;

namespace MemoryPack;

[Preserve]
internal sealed class AnimationCurveFormatter : MemoryPackFormatter<AnimationCurve>
{
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref AnimationCurve? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteUnmanagedWithObjectHeader<WrapMode, WrapMode>(3, value.preWrapMode, value.postWrapMode);
		writer.WriteUnmanagedArray(value.keys);
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref AnimationCurve? value)
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
		reader.ReadUnmanaged<WrapMode, WrapMode>(out var value2, out var value3);
		Keyframe[] keys = reader.ReadUnmanagedArray<Keyframe>();
		if (value == null)
		{
			value = new AnimationCurve();
		}
		value.preWrapMode = value2;
		value.postWrapMode = value3;
		value.keys = keys;
	}
}
