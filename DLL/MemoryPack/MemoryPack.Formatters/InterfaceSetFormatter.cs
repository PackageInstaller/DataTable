using System.Collections.Generic;
using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public sealed class InterfaceSetFormatter<T> : MemoryPackFormatter<ISet<T?>>
{
	private readonly IEqualityComparer<T?>? equalityComparer;

	static InterfaceSetFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<HashSet<T>>())
		{
			MemoryPackFormatterProvider.Register(new HashSetFormatter<T>());
		}
	}

	public InterfaceSetFormatter()
		: this((IEqualityComparer<T?>?)null)
	{
	}

	public InterfaceSetFormatter(IEqualityComparer<T?>? equalityComparer)
	{
		this.equalityComparer = equalityComparer;
	}

	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref ISet<T?>? value)
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
	public override void Deserialize(ref MemoryPackReader reader, ref ISet<T?>? value)
	{
		if (!reader.TryReadCollectionHeader(out var length))
		{
			value = null;
			return;
		}
		HashSet<T> hashSet = new HashSet<T>(length, equalityComparer);
		IMemoryPackFormatter<T> formatter = reader.GetFormatter<T>();
		for (int i = 0; i < length; i++)
		{
			T value2 = default(T);
			formatter.Deserialize(ref reader, ref value2);
			hashSet.Add(value2);
		}
		value = hashSet;
	}
}
