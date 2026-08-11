using MemoryPack.Internal;

namespace MemoryPack.Formatters;

[Preserve]
public sealed class FourDimensionalArrayFormatter<T> : MemoryPackFormatter<T?[,,,]>
{
	[Preserve]
	public override void Serialize(ref MemoryPackWriter writer, ref T?[,,,]? value)
	{
		if (value == null)
		{
			writer.WriteNullObjectHeader();
			return;
		}
		writer.WriteObjectHeader(5);
		writer.WriteUnmanaged<int, int, int, int>(value.GetLength(0), value.GetLength(1), value.GetLength(2), value.GetLength(3));
		writer.WriteCollectionHeader(value.Length);
		IMemoryPackFormatter<T> formatter = writer.GetFormatter<T>();
		T[,,,] array = value;
		int upperBound = array.GetUpperBound(0);
		int upperBound2 = array.GetUpperBound(1);
		int upperBound3 = array.GetUpperBound(2);
		int upperBound4 = array.GetUpperBound(3);
		for (int i = array.GetLowerBound(0); i <= upperBound; i++)
		{
			for (int j = array.GetLowerBound(1); j <= upperBound2; j++)
			{
				for (int k = array.GetLowerBound(2); k <= upperBound3; k++)
				{
					for (int l = array.GetLowerBound(3); l <= upperBound4; l++)
					{
						T value2 = array[i, j, k, l];
						formatter.Serialize(ref writer, ref value2);
					}
				}
			}
		}
	}

	[Preserve]
	public override void Deserialize(ref MemoryPackReader reader, ref T?[,,,]? value)
	{
		if (!reader.TryReadObjectHeader(out var memberCount))
		{
			value = null;
			return;
		}
		if (memberCount != 5)
		{
			MemoryPackSerializationException.ThrowInvalidPropertyCount(5, memberCount);
		}
		reader.ReadUnmanaged<int, int, int, int>(out var value2, out var value3, out var value4, out var value5);
		if (!reader.TryReadCollectionHeader(out var length))
		{
			MemoryPackSerializationException.ThrowInvalidCollection();
		}
		if (value == null || value.GetLength(0) != value2 || value.GetLength(1) != value3 || value.GetLength(2) != value4 || value.GetLength(3) != value5 || value.Length != length)
		{
			value = new T[value2, value3, value4, value5];
		}
		IMemoryPackFormatter<T> formatter = reader.GetFormatter<T>();
		int num = 0;
		int num2 = 0;
		int num3 = 0;
		int num4 = -1;
		int num5 = 0;
		while (num5++ < length)
		{
			if (num4 < value5 - 1)
			{
				num4++;
			}
			else if (num3 < value4 - 1)
			{
				num4 = 0;
				num3++;
			}
			else if (num2 < value3 - 1)
			{
				num4 = 0;
				num3 = 0;
				num2++;
			}
			else
			{
				num4 = 0;
				num3 = 0;
				num2 = 0;
				num++;
			}
			formatter.Deserialize(ref reader, ref value[num, num2, num3, num4]);
		}
	}
}
