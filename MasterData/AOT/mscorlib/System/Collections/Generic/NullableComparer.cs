namespace System.Collections.Generic;

[Serializable]
internal class NullableComparer<T> : Comparer<T?> where T : struct, IComparable<T>
{
	public override int Compare(T? x, T? y)
	{
		if (x.HasValue)
		{
			if (y.HasValue)
			{
				return x.value.CompareTo(y.value);
			}
			return 1;
		}
		if (y.HasValue)
		{
			return -1;
		}
		return 0;
	}

	public override bool Equals(object obj)
	{
		return obj is NullableComparer<T>;
	}

	public override int GetHashCode()
	{
		return GetType().Name.GetHashCode();
	}
}
