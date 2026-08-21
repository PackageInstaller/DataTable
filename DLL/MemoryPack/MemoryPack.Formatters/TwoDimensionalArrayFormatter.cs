using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public sealed class TwoDimensionalArrayFormatter<T> : MemoryPackFormatter<T?[,]>
{
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref T?[,]? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteObjectHeader(3);
		writer.WriteUnmanaged<int, int>(value.GetLength(0), value.GetLength(1));
		writer.WriteCollectionHeader(value.Length);
		IMemoryPackFormatter<T> formatter = writer.GetFormatter<T>();
		T[,] array = value;
		int upperBound = array.GetUpperBound(0);
		int upperBound2 = array.GetUpperBound(1);
		for (int i = array.GetLowerBound(0); i <= upperBound; i++)
		{
			for (int j = array.GetLowerBound(1); j <= upperBound2; j++)
			{
				T value2 = array[i, j];
				formatter.Serialize(ref writer, ref value2);
			}
		}
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref T?[,]? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		if (memberCount != 3)
		{
			MemoryPackSerializationException.ThrowInvalidPropertyCount(3, memberCount);
		}
		reader.ReadUnmanaged<int, int>(out var value2, out var value3);
		if (!reader.TryReadCollectionHeader(out var length))
		{
			MemoryPackSerializationException.ThrowInvalidCollection();
		}
		if (value == null || value.GetLength(0) != value2 || value.GetLength(1) != value3 || value.Length != length)
		{
			value = new T[value2, value3];
		}
		IMemoryPackFormatter<T> formatter = reader.GetFormatter<T>();
		int num = 0;
		int num2 = -1;
		int num3 = 0;
		while (num3++ < length)
		{
			if (num2 < value3 - 1)
			{
				num2++;
			}
			else
			{
				num2 = 0;
				num++;
			}
			formatter.Deserialize(ref reader, ref value[num, num2]);
		}
	}
}
