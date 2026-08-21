using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public sealed class ThreeDimensionalArrayFormatter<T> : MemoryPackFormatter<T?[,,]>
{
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref T?[,,]? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteObjectHeader(4);
		writer.WriteUnmanaged<int, int, int>(value.GetLength(0), value.GetLength(1), value.GetLength(2));
		writer.WriteCollectionHeader(value.Length);
		IMemoryPackFormatter<T> formatter = writer.GetFormatter<T>();
		T[,,] array = value;
		int upperBound = array.GetUpperBound(0);
		int upperBound2 = array.GetUpperBound(1);
		int upperBound3 = array.GetUpperBound(2);
		for (int i = array.GetLowerBound(0); i <= upperBound; i++)
		{
			for (int j = array.GetLowerBound(1); j <= upperBound2; j++)
			{
				for (int k = array.GetLowerBound(2); k <= upperBound3; k++)
				{
					T value2 = array[i, j, k];
					formatter.Serialize(ref writer, ref value2);
				}
			}
		}
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref T?[,,]? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		if (memberCount != 4)
		{
			MemoryPackSerializationException.ThrowInvalidPropertyCount(4, memberCount);
		}
		reader.ReadUnmanaged<int, int, int>(out var value2, out var value3, out var value4);
		if (!reader.TryReadCollectionHeader(out var length))
		{
			MemoryPackSerializationException.ThrowInvalidCollection();
		}
		if (value == null || value.GetLength(0) != value2 || value.GetLength(1) != value3 || value.GetLength(2) != value4 || value.Length != length)
		{
			value = new T[value2, value3, value4];
		}
		IMemoryPackFormatter<T> formatter = reader.GetFormatter<T>();
		int num = 0;
		int num2 = 0;
		int num3 = -1;
		int num4 = 0;
		while (num4++ < length)
		{
			if (num3 < value4 - 1)
			{
				num3++;
			}
			else if (num2 < value3 - 1)
			{
				num3 = 0;
				num2++;
			}
			else
			{
				num3 = 0;
				num2 = 0;
				num++;
			}
			formatter.Deserialize(ref reader, ref value[num, num2, num3]);
		}
	}
}
