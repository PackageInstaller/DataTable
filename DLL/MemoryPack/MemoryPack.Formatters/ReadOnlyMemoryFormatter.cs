using System;
using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public sealed class ReadOnlyMemoryFormatter<T> : MemoryPackFormatter<ReadOnlyMemory<T?>>
{
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref ReadOnlyMemory<T?> value)
	{
		writer.WriteSpan(value.Span);
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref ReadOnlyMemory<T?> value)
	{
		value = reader.ReadArray<T>();
	}
}
