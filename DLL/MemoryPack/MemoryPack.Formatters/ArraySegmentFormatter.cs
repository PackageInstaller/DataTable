using System;
using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public sealed class ArraySegmentFormatter<T> : MemoryPackFormatter<ArraySegment<T?>>
{
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref ArraySegment<T?> value)
	{
		writer.WriteSpan(value.AsMemory().Span);
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref ArraySegment<T?> value)
	{
		T[] array = reader.ReadArray<T>();
		value = ((array == null) ? default(ArraySegment<T>) : ((ArraySegment<T>)array));
	}
}
