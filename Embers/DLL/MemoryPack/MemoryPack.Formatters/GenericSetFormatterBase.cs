using System.Collections.Generic;
using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public abstract class GenericSetFormatterBase<TSet, TElement> : MemoryPackFormatter<TSet?> where TSet : ISet<TElement?>
{
	[Preserve]
	protected abstract TSet CreateSet();

	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref TSet? value)
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
	public override void Deserialize(ref MemoryPackReader reader, ref TSet? value)
	{
		if (!reader.TryReadCollectionHeader(out var length))
		{
			value = default(TSet);
			return;
		}
		IMemoryPackFormatter<TElement> formatter = reader.GetFormatter<TElement>();
		TSet val = CreateSet();
		for (int i = 0; i < length; i++)
		{
			TElement value2 = default(TElement);
			formatter.Deserialize(ref reader, ref value2);
			val.Add(value2);
		}
		value = val;
	}
}
