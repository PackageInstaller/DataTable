namespace System.Collections.Generic;

[Serializable]
internal class NullableEqualityComparer<T> : EqualityComparer<T?> where T : struct, IEquatable<T>
{
	public override bool Equals(T? x, T? y)
	{
		if (x.HasValue)
		{
			if (y.HasValue)
			{
				return x.value.Equals(y.value);
			}
			return false;
		}
		if (y.HasValue)
		{
			return false;
		}
		return true;
	}

	public override int GetHashCode(T? obj)
	{
		return obj.GetHashCode();
	}

	internal override int IndexOf(T?[] array, T? value, int startIndex, int count)
	{
		int num = startIndex + count;
		if (!value.HasValue)
		{
			for (int i = startIndex; i < num; i++)
			{
				if (!array[i].HasValue)
				{
					return i;
				}
			}
		}
		else
		{
			for (int j = startIndex; j < num; j++)
			{
				if (array[j].HasValue && array[j].value.Equals(value.value))
				{
					return j;
				}
			}
		}
		return -1;
	}

	internal override int LastIndexOf(T?[] array, T? value, int startIndex, int count)
	{
		int num = startIndex - count + 1;
		if (!value.HasValue)
		{
			for (int num2 = startIndex; num2 >= num; num2--)
			{
				if (!array[num2].HasValue)
				{
					return num2;
				}
			}
		}
		else
		{
			for (int num3 = startIndex; num3 >= num; num3--)
			{
				if (array[num3].HasValue && array[num3].value.Equals(value.value))
				{
					return num3;
				}
			}
		}
		return -1;
	}

	public override bool Equals(object obj)
	{
		return obj is NullableEqualityComparer<T>;
	}

	public override int GetHashCode()
	{
		return GetType().Name.GetHashCode();
	}
}
