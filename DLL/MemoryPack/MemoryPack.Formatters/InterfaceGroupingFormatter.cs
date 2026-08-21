using System.Collections.Generic;
using System.Linq;
using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public sealed class InterfaceGroupingFormatter<TKey, TElement> : MemoryPackFormatter<IGrouping<TKey, TElement>> where TKey : notnull
{
	static InterfaceGroupingFormatter()
	{
		if (!MemoryPackFormatterProvider.IsRegistered<IEnumerable<TElement>>())
		{
			MemoryPackFormatterProvider.Register(new InterfaceEnumerableFormatter<TElement>());
		}
	}

	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref IGrouping<TKey, TElement>? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteObjectHeader(2);
		writer.WriteValue<TKey>(value.Key);
		IEnumerable<TElement> value2 = value;
		writer.WriteValue(in value2);
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref IGrouping<TKey, TElement>? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		if (memberCount != 2)
		{
			MemoryPackSerializationException.ThrowInvalidPropertyCount(2, memberCount);
		}
		TKey val = reader.ReadValue<TKey>();
		IEnumerable<TElement> enumerable = reader.ReadArray<TElement>();
		if (val == null)
		{
			MemoryPackSerializationException.ThrowDeserializeObjectIsNull("key");
		}
		if (enumerable == null)
		{
			MemoryPackSerializationException.ThrowDeserializeObjectIsNull("values");
		}
		value = new Grouping<TKey, TElement>(val, enumerable);
	}
}
