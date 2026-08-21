using System.Buffers;
using System.Collections.Concurrent;
using System.Runtime.CompilerServices;
using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public sealed class ConcurrentStackFormatter<T> : MemoryPackFormatter<ConcurrentStack<T?>>
{
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref ConcurrentStack<T?>? value)
	{
		if (value == null)
		{
			writer.WriteNullCollectionHeader();
			return;
		}
		int count = value.Count;
		T[] array = ArrayPool<T>.Shared.Rent(count);
		try
		{
			int num = 0;
			foreach (T item in value)
			{
				array[num++] = item;
			}
			if (num != count)
			{
				MemoryPackSerializationException.ThrowInvalidConcurrrentCollectionOperation();
			}
			IMemoryPackFormatter<T> formatter = writer.GetFormatter<T>();
			writer.WriteCollectionHeader(count);
			for (num--; num >= 0; num--)
			{
				formatter.Serialize(ref writer, ref array[num]);
			}
		}
		finally
		{
			ArrayPool<T>.Shared.Return(array, RuntimeHelpers.IsReferenceOrContainsReferences<T>());
		}
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref ConcurrentStack<T?>? value)
	{
		if (!reader.TryReadCollectionHeader(out var length))
		{
			value = null;
			return;
		}
		if (value == null)
		{
			value = new ConcurrentStack<T>();
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
