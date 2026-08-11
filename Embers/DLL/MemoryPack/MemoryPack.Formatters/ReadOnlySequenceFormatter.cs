using System;
using System.Buffers;
using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public sealed class ReadOnlySequenceFormatter<T> : MemoryPackFormatter<ReadOnlySequence<T?>>
{
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref ReadOnlySequence<T?> value)
	{
		if (value.IsSingleSegment)
		{
			writer.WriteSpan(value.FirstSpan);
			return;
		}
		writer.WriteCollectionHeader(checked((int)value.Length));
		foreach (ReadOnlyMemory<T> item in value)
		{
			writer.WriteSpanWithoutLengthHeader(item.Span);
		}
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref ReadOnlySequence<T?> value)
	{
		T[] array = reader.ReadArray<T>();
		value = ((array == null) ? default(ReadOnlySequence<T>) : new ReadOnlySequence<T>(array));
	}
}
