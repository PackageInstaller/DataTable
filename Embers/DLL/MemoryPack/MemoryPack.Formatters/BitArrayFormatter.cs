using System.Collections;
using System.Runtime.CompilerServices;
using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public sealed class BitArrayFormatter : MemoryPackFormatter<BitArray>
{
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref BitArray? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		ref BitArrayView reference = ref Unsafe.As<BitArray, BitArrayView>(ref value);
		writer.WriteUnmanagedWithObjectHeader(2, in reference.m_length);
		writer.WriteUnmanagedArray(reference.m_array);
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref BitArray? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		if (memberCount != 2)
		{
			MemoryPackSerializationException.ThrowInvalidPropertyCount(2, memberCount);
		}
		reader.ReadUnmanaged<int>(out var value2);
		BitArray source = new BitArray(value2, defaultValue: false);
		reader.ReadUnmanagedArray(ref Unsafe.As<BitArray, BitArrayView>(ref source).m_array);
		value = source;
	}
}
