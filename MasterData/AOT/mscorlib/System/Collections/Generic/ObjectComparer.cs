namespace System.Collections.Generic;

[Serializable]
internal class ObjectComparer<T> : Comparer<T>
{
	public override int Compare(T x, T y)
	{
		return Comparer.Default.Compare(x, y);
	}

	public override bool Equals(object obj)
	{
		return obj is ObjectComparer<T>;
	}

	public override int GetHashCode()
	{
		return GetType().Name.GetHashCode();
	}
}
