using System.Collections.Generic;
using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public sealed class GenericCollectionFormatter<TCollection, TElement> : MemoryPackFormatter<TCollection?> where TCollection : ICollection<TElement?>, new()
{
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref TCollection? value)
	{
		if (value == null)
		{
			writer.WriteNullCollectionHeader();
			return;
		}
		IMemoryPackFormatter<TElement> formatter = writer.GetFormatter<TElement>();
		writer.WriteCollectionHeader(value.Count);
		foreach (TElement item in value)
		{
			TElement value2 = item;
			formatter.Serialize(ref writer, ref value2);
		}
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref TCollection? value)
	{
		if (!reader.TryReadCollectionHeader(out var length))
		{
			value = default(TCollection);
			return;
		}
		IMemoryPackFormatter<TElement> formatter = reader.GetFormatter<TElement>();
		TCollection val = new TCollection();
		for (int i = 0; i < length; i++)
		{
			TElement value2 = default(TElement);
			formatter.Deserialize(ref reader, ref value2);
			val.Add(value2);
		}
		value = val;
	}
}
