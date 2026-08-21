using System.Numerics;
using System.Runtime.InteropServices;
using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public sealed class BigIntegerFormatter : MemoryPackFormatter<BigInteger>
{
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref BigInteger value)
	{
		byte[] value2 = value.ToByteArray();
		writer.WriteUnmanagedArray(value2);
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref BigInteger value)
	{
		if (!reader.TryReadCollectionHeader(out var length))
		{
			value = default(BigInteger);
			return;
		}
		value = new BigInteger(MemoryMarshal.CreateReadOnlySpan(ref reader.GetSpanReference(length), length));
		reader.Advance(length);
	}
}
