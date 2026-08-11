using System.Collections.Generic;
using System.Linq;
using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public sealed class InterfaceLookupFormatter<TKey, TElement> : MemoryPackFormatter<ILookup<TKey, TElement>> where TKey : notnull
{
	private readonly IEqualityComparer<TKey>? equalityComparer;

	static InterfaceLookupFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<IGrouping<TKey, TElement>>())
		{
			MemoryPackFormatterProvider.Register(new InterfaceGroupingFormatter<TKey, TElement>());
		}
	}

	public InterfaceLookupFormatter()
		: this((IEqualityComparer<TKey>?)null)
	{
	}

	public InterfaceLookupFormatter(IEqualityComparer<TKey>? equalityComparer)
	{
		this.equalityComparer = equalityComparer;
	}

	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref ILookup<TKey, TElement>? value)
	{
		if (value == null)
		{
			writer.WriteNullCollectionHeader();
			return;
		}
		IMemoryPackFormatter<IGrouping<TKey, TElement>> formatter = writer.GetFormatter<IGrouping<TKey, TElement>>();
		writer.WriteCollectionHeader(value.Count);
		foreach (IGrouping<TKey, TElement> item in value)
		{
			IGrouping<TKey, TElement> value2 = item;
			formatter.Serialize(ref writer, ref value2);
		}
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref ILookup<TKey, TElement>? value)
	{
		if (!reader.TryReadCollectionHeader(out var length))
		{
			value = null;
			return;
		}
		Dictionary<TKey, IGrouping<TKey, TElement>> dictionary = new Dictionary<TKey, IGrouping<TKey, TElement>>(equalityComparer);
		IMemoryPackFormatter<IGrouping<TKey, TElement>> formatter = reader.GetFormatter<IGrouping<TKey, TElement>>();
		for (int i = 0; i < length; i++)
		{
			IGrouping<TKey, TElement> value2 = null;
			formatter.Deserialize(ref reader, ref value2);
			if (value2 != null)
			{
				dictionary.Add(value2.Key, value2);
			}
		}
		value = new Lookup<TKey, TElement>(dictionary);
	}
}
