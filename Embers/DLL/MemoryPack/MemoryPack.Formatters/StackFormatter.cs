using System.Collections.Generic;
using System.Linq;
using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public sealed class StackFormatter<T> : MemoryPackFormatter<Stack<T?>>
{
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref Stack<T?>? value)
	{
		if (value == null)
		{
			writer.WriteNullCollectionHeader();
			return;
		}
		IMemoryPackFormatter<T> formatter = writer.GetFormatter<T>();
		writer.WriteCollectionHeader(value.Count);
		foreach (T item in value.Reverse())
		{
			T value2 = item;
			formatter.Serialize(ref writer, ref value2);
		}
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref Stack<T?>? value)
	{
		if (!reader.TryReadCollectionHeader(out var length))
		{
			value = null;
			return;
		}
		if (value == null)
		{
			value = new Stack<T>(length);
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
			value.Push(value2);
		}
	}
}
