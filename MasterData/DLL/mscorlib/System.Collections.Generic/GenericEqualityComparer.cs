namespace System.Collections.Generic;

[Serializable]
internal class GenericEqualityComparer<T> : EqualityComparer<T> where T : IEquatable<T>
{
	public override bool Equals(T x, T y)
	{
		if (x != null)
		{
			if (y != null)
			{
				return x.Equals(y);
			}
			return false;
		}
		if (y != null)
		{
			return false;
		}
		return true;
	}

	public override int GetHashCode(T obj)
	{
		return obj?.GetHashCode() ?? 0;
	}

	internal override int IndexOf(T[] array, T value, int startIndex, int count)
	{
		int num = startIndex + count;
		if (value == null)
		{
			for (int i = startIndex; i < num; i++)
			{
				if (array[i] == null)
				{
					return i;
				}
			}
		}
		else
		{
			for (int j = startIndex; j < num; j++)
			{
				if (array[j] != null && array[j].Equals(value))
				{
					return j;
				}
			}
		}
		return -1;
	}

	internal override int LastIndexOf(T[] array, T value, int startIndex, int count)
	{
		int num = startIndex - count + 1;
		if (value == null)
		{
			for (int num2 = startIndex; num2 >= num; num2--)
			{
				if (array[num2] == null)
				{
					return num2;
				}
			}
		}
		else
		{
			for (int num3 = startIndex; num3 >= num; num3--)
			{
				if (array[num3] != null && array[num3].Equals(value))
				{
					return num3;
				}
			}
		}
		return -1;
	}

	public override bool Equals(object obj)
	{
		return obj is GenericEqualityComparer<T>;
	}

	public override int GetHashCode()
	{
		return GetType().Name.GetHashCode();
	}
}
