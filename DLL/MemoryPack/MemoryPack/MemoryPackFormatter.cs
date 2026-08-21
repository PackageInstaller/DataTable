using MemoryPack.Internal;

namespace MemoryPack;

[Preserve]
public abstract class MemoryPackFormatter<T> : IMemoryPackFormatter<T>, IMemoryPackFormatter
{
	[Preserve]
	public abstract void Serialize(ref MemoryPackWriter writer, ref T? value);

	[Preserve]
	public abstract void Deserialize(ref MemoryPackReader reader, ref T? value);

	[Preserve]
	void IMemoryPackFormatter.Serialize(ref MemoryPackWriter writer, ref object? value)
	{
		T value2 = ((value == null) ? default(T) : ((T)value));
		Serialize(ref writer, ref value2);
	}

	[Preserve]
	void IMemoryPackFormatter.Deserialize(ref MemoryPackReader reader, ref object? value)
	{
		T value2 = ((value == null) ? default(T) : ((T)value));
		Deserialize(ref reader, ref value2);
		value = value2;
	}
}
