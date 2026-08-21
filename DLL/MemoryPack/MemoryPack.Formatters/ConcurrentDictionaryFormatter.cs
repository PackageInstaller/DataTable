using System.Collections.Concurrent;
using System.Collections.Generic;
using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public sealed class ConcurrentDictionaryFormatter<TKey, TValue> : MemoryPackFormatter<ConcurrentDictionary<TKey, TValue?>> where TKey : notnull
{
	private readonly IEqualityComparer<TKey>? equalityComparer;

	public ConcurrentDictionaryFormatter()
		: this((IEqualityComparer<TKey>?)null)
	{
	}

	public ConcurrentDictionaryFormatter(IEqualityComparer<TKey>? equalityComparer)
	{
		this.equalityComparer = equalityComparer;
	}

	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref ConcurrentDictionary<TKey, TValue?>? value)
	{
		if (value == null)
		{
			writer.WriteNullCollectionHeader();
			return;
		}
		IMemoryPackFormatter<TKey> formatter = writer.GetFormatter<TKey>();
		IMemoryPackFormatter<TValue> formatter2 = writer.GetFormatter<TValue>();
		int count = value.Count;
		writer.WriteCollectionHeader(count);
		int num = 0;
		foreach (KeyValuePair<TKey, TValue> item in value)
		{
			num++;
			KeyValuePairFormatter.Serialize(formatter, formatter2, ref writer, item);
		}
		if (num != count)
		{
			MemoryPackSerializationException.ThrowInvalidConcurrrentCollectionOperation();
		}
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref ConcurrentDictionary<TKey, TValue?>? value)
	{
		if (!reader.TryReadCollectionHeader(out var length))
		{
			value = null;
			return;
		}
		if (value == null)
		{
			value = new ConcurrentDictionary<TKey, TValue>(equalityComparer);
		}
		else
		{
			value.Clear();
		}
		IMemoryPackFormatter<TKey> formatter = reader.GetFormatter<TKey>();
		IMemoryPackFormatter<TValue> formatter2 = reader.GetFormatter<TValue>();
		for (int i = 0; i < length; i++)
		{
			KeyValuePairFormatter.Deserialize(formatter, formatter2, ref reader, out TKey key, out TValue value2);
			value.TryAdd(key, value2);
		}
	}
}
