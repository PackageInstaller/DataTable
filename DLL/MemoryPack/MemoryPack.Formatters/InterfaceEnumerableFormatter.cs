using System.Buffers;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public sealed class InterfaceEnumerableFormatter<T> : MemoryPackFormatter<IEnumerable<T?>>
{
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref IEnumerable<T?>? value)
	{
		if (InterfaceCollectionFormatterUtils.TrySerializeOptimized<IEnumerable<T>, T>(ref writer, ref value))
		{
			return;
		}
		if (value.TryGetNonEnumeratedCountEx(out var count))
		{
			IMemoryPackFormatter<T> formatter = writer.GetFormatter<T>();
			writer.WriteCollectionHeader(count);
			{
				foreach (T item in value)
				{
					T value2 = item;
					formatter.Serialize(ref writer, ref value2);
				}
				return;
			}
		}
		ReusableLinkedArrayBufferWriter source = ReusableLinkedArrayBufferWriterPool.Rent();
		try
		{
			MemoryPackWriter writer2 = new MemoryPackWriter(ref Unsafe.As<ReusableLinkedArrayBufferWriter, IBufferWriter<byte>>(ref source), writer.OptionalState);
			count = 0;
			IMemoryPackFormatter<T> formatter2 = writer.GetFormatter<T>();
			foreach (T item2 in value)
			{
				count++;
				T value3 = item2;
				formatter2.Serialize(ref writer2, ref value3);
			}
			writer2.Flush();
			writer.WriteCollectionHeader(count);
			source.WriteToAndReset(ref writer);
		}
		finally
		{
			ReusableLinkedArrayBufferWriterPool.Return(source);
		}
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref IEnumerable<T?>? value)
	{
		value = reader.ReadArray<T>();
	}
}
