using System.Collections.Concurrent;
using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public sealed class ConcurrentQueueFormatter<T> : MemoryPackFormatter<ConcurrentQueue<T?>>
{
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref ConcurrentQueue<T?>? value)
	{
		if (value == null)
		{
			writer.WriteNullCollectionHeader();
			return;
		}
		IMemoryPackFormatter<T> formatter = writer.GetFormatter<T>();
		int count = value.Count;
		writer.WriteCollectionHeader(count);
		int num = 0;
		foreach (T item in value)
		{
			num++;
			T value2 = item;
			formatter.Serialize(ref writer, ref value2);
		}
		if (num != count)
		{
			MemoryPackSerializationException.ThrowInvalidConcurrrentCollectionOperation();
		}
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref ConcurrentQueue<T?>? value)
	{
		if (!reader.TryReadCollectionHeader(out var length))
		{
			value = null;
			return;
		}
		if (value == null)
		{
			value = new ConcurrentQueue<T>();
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
			value.Enqueue(value2);
		}
	}
}
