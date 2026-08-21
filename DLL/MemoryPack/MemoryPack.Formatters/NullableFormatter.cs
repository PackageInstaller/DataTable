using System.Runtime.CompilerServices;
using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public sealed class NullableFormatter<T> : MemoryPackFormatter<T?> where T : struct
{
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref T? value)
	{
		if (!RuntimeHelpers.IsReferenceOrContainsReferences<T>())
		{
			writer.DangerousWriteUnmanaged(in value);
			return;
		}
		if (!value.HasValue)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteObjectHeader(1);
		writer.WriteValue<T>(value.Value);
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref T? value)
	{
		if (!RuntimeHelpers.IsReferenceOrContainsReferences<T>())
		{
			reader.DangerousReadUnmanaged<T?>(out value);
			return;
		}
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		if (memberCount != 1)
		{
			MemoryPackSerializationException.ThrowInvalidPropertyCount(1, memberCount);
		}
		value = reader.ReadValue<T>();
	}
}
