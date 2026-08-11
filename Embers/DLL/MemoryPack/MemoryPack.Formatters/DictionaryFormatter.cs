using System.Collections.Generic;
using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public sealed class DictionaryFormatter<TKey, TValue> : MemoryPackFormatter<Dictionary<TKey, TValue?>> where TKey : notnull
{
	private readonly IEqualityComparer<TKey>? equalityComparer;

	public DictionaryFormatter()
		: this((IEqualityComparer<TKey>?)null)
	{
	}

	public DictionaryFormatter(IEqualityComparer<TKey>? equalityComparer)
	{
		this.equalityComparer = equalityComparer;
	}

	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref Dictionary<TKey, TValue?>? value)
	{
		if (value == null)
		{
			writer.WriteNullCollectionHeader();
			return;
		}
		IMemoryPackFormatter<TKey> formatter = writer.GetFormatter<TKey>();
		IMemoryPackFormatter<TValue> formatter2 = writer.GetFormatter<TValue>();
		writer.WriteCollectionHeader(value.Count);
		foreach (KeyValuePair<TKey, TValue> item in value)
		{
			KeyValuePairFormatter.Serialize(formatter, formatter2, ref writer, item);
		}
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref Dictionary<TKey, TValue?>? value)
	{
		if (!reader.TryReadCollectionHeader(out var length))
		{
			value = null;
			return;
		}
		if (value == null)
		{
			value = new Dictionary<TKey, TValue>(length, equalityComparer);
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
			value.Add(key, value2);
		}
	}
}
