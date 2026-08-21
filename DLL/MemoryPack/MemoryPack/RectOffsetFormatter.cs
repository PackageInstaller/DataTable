using MemoryPack.Internal;
using UnityEngine;

namespace MemoryPack;

[Preserve]
internal sealed class RectOffsetFormatter : MemoryPackFormatter<RectOffset>
{
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref RectOffset? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
		}
		else
		{
			writer.WriteUnmanagedWithObjectHeader<int, int, int, int>(4, value.left, value.right, value.top, value.bottom);
		}
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref RectOffset? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		if (memberCount != 4)
		{
			MemoryPackSerializationException.ThrowInvalidPropertyCount(4, memberCount);
		}
		reader.ReadUnmanaged<int, int, int, int>(out var value2, out var value3, out var value4, out var value5);
		if (value == null)
		{
			value = new RectOffset(value2, value3, value4, value5);
			return;
		}
		value.left = value2;
		value.right = value3;
		value.top = value4;
		value.bottom = value5;
	}
}
