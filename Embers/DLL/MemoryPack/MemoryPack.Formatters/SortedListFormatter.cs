using System.Collections.Generic;
using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public sealed class SortedListFormatter<TKey, TValue> : MemoryPackFormatter<SortedList<TKey, TValue?>> where TKey : notnull
{
	private readonly IComparer<TKey>? comparer;

	public SortedListFormatter()
		: this((IComparer<TKey>?)null)
	{
	}

	public SortedListFormatter(IComparer<TKey>? comparer)
	{
		this.comparer = comparer;
	}

	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref SortedList<TKey, TValue?>? value)
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
	public override void Deserialize(ref MemoryPackReader reader, ref SortedList<TKey, TValue?>? value)
	{
		if (!reader.TryReadCollectionHeader(out var length))
		{
			value = null;
			return;
		}
		if (value == null)
		{
			value = new SortedList<TKey, TValue>(length, comparer);
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
