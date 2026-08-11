using System;
using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public sealed class LazyFormatter<T> : MemoryPackFormatter<Lazy<T?>>
{
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref Lazy<T?>? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteObjectHeader(1);
		writer.WriteValue<T>(value.Value);
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref Lazy<T?>? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		if (memberCount != 1)
		{
			MemoryPackSerializationException.ThrowInvalidPropertyCount(1, memberCount);
		}
		T value2 = reader.ReadValue<T>();
		value = new Lazy<T>(value2);
	}
}
