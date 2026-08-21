using MemoryPack.Internal;

namespace MemoryPack;

[Preserve]
public interface IMemoryPackFormatter
{
	[Preserve]
	void Serialize(ref MemoryPackWriter writer, ref object? value);

	[Preserve]
	void Deserialize(ref MemoryPackReader reader, ref object? value);
}
[Preserve]
public interface IMemoryPackFormatter<T>
{
	[Preserve]
	void Serialize(ref MemoryPackWriter writer, ref T? value);

	[Preserve]
	void Deserialize(ref MemoryPackReader reader, ref T? value);
}
