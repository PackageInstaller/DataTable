using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public sealed class UnmanagedArrayFormatter<T> : MemoryPackFormatter<T[]> where T : unmanaged
{
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref T[]? value)
	{
		writer.WriteUnmanagedArray(value);
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref T[]? value)
	{
		reader.ReadUnmanagedArray(ref value);
	}
}
