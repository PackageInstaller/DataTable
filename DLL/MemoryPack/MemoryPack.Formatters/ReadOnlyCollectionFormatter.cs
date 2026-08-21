using System.Collections.ObjectModel;
using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public sealed class ReadOnlyCollectionFormatter<T> : MemoryPackFormatter<ReadOnlyCollection<T?>>
{
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref ReadOnlyCollection<T?>? value)
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
	public override void Deserialize(ref MemoryPackReader reader, ref ReadOnlyCollection<T?>? value)
	{
		T[] array = reader.ReadArray<T>();
		if (array == null)
		{
			value = null;
		}
		else
		{
			value = new ReadOnlyCollection<T>(array);
		}
	}
}
