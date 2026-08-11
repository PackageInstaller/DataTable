using System.Collections.Generic;
using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public abstract class GenericDictionaryFormatterBase<TDictionary, TKey, TValue> : MemoryPackFormatter<TDictionary?> where TDictionary : IDictionary<TKey, TValue?> where TKey : notnull
{
	[Preserve]
	protected abstract TDictionary CreateDictionary();

	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref TDictionary? value)
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
	public override void Deserialize(ref MemoryPackReader reader, ref TDictionary? value)
	{
		if (!reader.TryReadCollectionHeader(out var length))
		{
			value = default(TDictionary);
			return;
		}
		IMemoryPackFormatter<TKey> formatter = reader.GetFormatter<TKey>();
		IMemoryPackFormatter<TValue> formatter2 = reader.GetFormatter<TValue>();
		TDictionary val = CreateDictionary();
		for (int i = 0; i < length; i++)
		{
			KeyValuePairFormatter.Deserialize(formatter, formatter2, ref reader, out TKey key, out TValue value2);
			val.Add(key, value2);
		}
		value = val;
	}
}
