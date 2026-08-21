using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public sealed class ArrayFormatter<T> : MemoryPackFormatter<T?[]>
{
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref T?[]? value)
	{
		writer.WriteArray(value);
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref T?[]? value)
	{
		reader.ReadArray(ref value);
	}
}
