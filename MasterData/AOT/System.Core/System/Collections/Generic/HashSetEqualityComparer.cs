namespace System.Collections.Generic;

[Serializable]
internal sealed class HashSetEqualityComparer<T> : IEqualityComparer<HashSet<T>>
{
	private readonly IEqualityComparer<T> _comparer;

	public HashSetEqualityComparer()
	{
		_comparer = EqualityComparer<T>.Default;
	}

	public bool Equals(HashSet<T> x, HashSet<T> y)
	{
		return HashSet<T>.HashSetEquals(x, y, _comparer);
	}

	public int GetHashCode(HashSet<T> obj)
	{
		int num = 0;
		if (obj != null)
		{
			foreach (T item in obj)
			{
				num ^= _comparer.GetHashCode(item) & 0x7FFFFFFF;
			}
		}
		return num;
	}

	public override bool Equals(object obj)
	{
		if (!(obj is HashSetEqualityComparer<T> hashSetEqualityComparer))
		{
			return false;
		}
		return _comparer == hashSetEqualityComparer._comparer;
	}

	public override int GetHashCode()
	{
		return _comparer.GetHashCode();
	}
}
