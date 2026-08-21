using System;
using System.Buffers;
using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public sealed class ReadOnlyMemoryPoolFormatter<T> : MemoryPackFormatter<ReadOnlyMemory<T?>>
{
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref ReadOnlyMemory<T?> value)
	{
		writer.WriteSpan(value.Span);
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref ReadOnlyMemory<T?> value)
	{
		if (!reader.TryReadCollectionHeader(out var length))
		{
			value = null;
			return;
		}
		if (length == 0)
		{
			value = Memory<T>.Empty;
			return;
		}
		Memory<T> memory = MemoryExtensions.AsMemory(ArrayPool<T>.Shared.Rent(length), 0, length);
		Span<T> value2 = memory.Span;
		reader.ReadSpanWithoutReadLengthHeader(length, ref value2);
		value = memory;
	}
}
