namespace System.Collections.Generic;

[Serializable]
internal class ByteEqualityComparer : EqualityComparer<byte>
{
	public override bool Equals(byte x, byte y)
	{
		return x == y;
	}

	public override int GetHashCode(byte b)
	{
		return b.GetHashCode();
	}

	internal unsafe override int IndexOf(byte[] array, byte value, int startIndex, int count)
	{
		if (array == null)
		{
			throw new ArgumentNullException("array");
		}
		if (startIndex < 0)
		{
			throw new ArgumentOutOfRangeException("startIndex", Environment.GetResourceString("Index was out of range. Must be non-negative and less than the size of the collection."));
		}
		if (count < 0)
		{
			throw new ArgumentOutOfRangeException("count", Environment.GetResourceString("Count must be positive and count must refer to a location within the string/array/collection."));
		}
		if (count > array.Length - startIndex)
		{
			throw new ArgumentException(Environment.GetResourceString("Offset and length were out of bounds for the array or count is greater than the number of elements from index to the end of the source collection."));
		}
		if (count == 0)
		{
			return -1;
		}
		fixed (byte* src = array)
		{
			return Buffer.IndexOfByte(src, value, startIndex, count);
		}
	}

	internal override int LastIndexOf(byte[] array, byte value, int startIndex, int count)
	{
		int num = startIndex - count + 1;
		for (int num2 = startIndex; num2 >= num; num2--)
		{
			if (array[num2] == value)
			{
				return num2;
			}
		}
		return -1;
	}

	public override bool Equals(object obj)
	{
		return obj is ByteEqualityComparer;
	}

	public override int GetHashCode()
	{
		return GetType().Name.GetHashCode();
	}
}
