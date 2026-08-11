using System.Runtime.CompilerServices;
using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public sealed class UnmanagedFormatter<T> : MemoryPackFormatter<T> where T : unmanaged
{
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref T value)
	{
		Unsafe.WriteUnaligned(ref writer.GetSpanReference(Unsafe.SizeOf<T>()), value);
		writer.Advance(Unsafe.SizeOf<T>());
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref T value)
	{
		value = Unsafe.ReadUnaligned<T>(ref reader.GetSpanReference(Unsafe.SizeOf<T>()));
		reader.Advance(Unsafe.SizeOf<T>());
	}
}
