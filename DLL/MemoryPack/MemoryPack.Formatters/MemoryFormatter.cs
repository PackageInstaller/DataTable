using System;
using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public sealed class MemoryFormatter<T> : MemoryPackFormatter<Memory<T?>>
{
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref Memory<T?> value)
	{
		writer.WriteSpan(value.Span);
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref Memory<T?> value)
	{
		value = reader.ReadArray<T>();
	}
}
