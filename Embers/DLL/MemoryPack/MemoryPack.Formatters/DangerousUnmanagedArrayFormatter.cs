using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public sealed class DangerousUnmanagedArrayFormatter<T> : MemoryPackFormatter<T[]>
{
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref T[]? value)
	{
		writer.DangerousWriteUnmanagedArray(value);
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref T[]? value)
	{
		reader.DangerousReadUnmanagedArray(ref value);
	}
}
