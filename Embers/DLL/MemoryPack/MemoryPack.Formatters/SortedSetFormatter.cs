using System.Collections.Generic;
using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public sealed class SortedSetFormatter<T> : MemoryPackFormatter<SortedSet<T?>>
{
	private readonly IComparer<T?>? comparer;

	public SortedSetFormatter()
		: this((IComparer<T?>?)null)
	{
	}

	public SortedSetFormatter(IComparer<T?>? comparer)
	{
		this.comparer = comparer;
	}

	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref SortedSet<T?>? value)
	{
		if (value == null)
		{
			writer.WriteNullCollectionHeader();
			return;
		}
		IMemoryPackFormatter<T> formatter = writer.GetFormatter<T>();
		writer.WriteCollectionHeader(value.Count);
		foreach (T item in value)
		{
			T value2 = item;
			formatter.Serialize(ref writer, ref value2);
		}
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref SortedSet<T?>? value)
	{
		if (!reader.TryReadCollectionHeader(out var length))
		{
			value = null;
			return;
		}
		if (value == null)
		{
			value = new SortedSet<T>(comparer);
		}
		else
		{
			value.Clear();
		}
		IMemoryPackFormatter<T> formatter = reader.GetFormatter<T>();
		for (int i = 0; i < length; i++)
		{
			T value2 = default(T);
			formatter.Deserialize(ref reader, ref value2);
			value.Add(value2);
		}
	}
}
