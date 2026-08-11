using System.Collections.Generic;
using System.Runtime.CompilerServices;
using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public static class KeyValuePairFormatter
{
	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	[Preserve]
	public static void Serialize<TKey, TValue>(IMemoryPackFormatter<TKey> keyFormatter, IMemoryPackFormatter<TValue> valueFormatter, ref MemoryPackWriter writer, KeyValuePair<TKey?, TValue?> value)
	{
		if (!RuntimeHelpers.IsReferenceOrContainsReferences<KeyValuePair<TKey, TValue>>())
		{
			writer.DangerousWriteUnmanaged(in value);
			return;
		}
		value.Deconstruct(out TKey key, out TValue value2);
		keyFormatter.Serialize(ref writer, ref key);
		valueFormatter.Serialize(ref writer, ref value2);
	}

	[MethodImpl(MethodImplOptions.AggressiveInlining)]
	[Preserve]
	public static void Deserialize<TKey, TValue>(IMemoryPackFormatter<TKey> keyFormatter, IMemoryPackFormatter<TValue> valueFormatter, ref MemoryPackReader reader, out TKey? key, out TValue? value)
	{
		if (!RuntimeHelpers.IsReferenceOrContainsReferences<KeyValuePair<TKey, TValue>>())
		{
			reader.DangerousReadUnmanaged<KeyValuePair<TKey, TValue>>(out var value2);
			key = value2.Key;
			value = value2.Value;
		}
		else
		{
			key = default(TKey);
			value = default(TValue);
			keyFormatter.Deserialize(ref reader, ref key);
			valueFormatter.Deserialize(ref reader, ref value);
		}
	}
}
[Preserve]
public sealed class KeyValuePairFormatter<TKey, TValue> : MemoryPackFormatter<KeyValuePair<TKey?, TValue?>>
{
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref KeyValuePair<TKey?, TValue?> value)
	{
		if (!RuntimeHelpers.IsReferenceOrContainsReferences<KeyValuePair<TKey, TValue>>())
		{
			writer.DangerousWriteUnmanaged(in value);
			return;
		}
		writer.WriteValue<TKey>(value.Key);
		writer.WriteValue<TValue>(value.Value);
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref KeyValuePair<TKey?, TValue?> value)
	{
		if (!RuntimeHelpers.IsReferenceOrContainsReferences<KeyValuePair<TKey, TValue>>())
		{
			reader.DangerousReadUnmanaged<KeyValuePair<TKey, TValue>>(out value);
		}
		else
		{
			value = new KeyValuePair<TKey, TValue>(reader.ReadValue<TKey>(), reader.ReadValue<TValue>());
		}
	}
}
