namespace System.Collections.Generic;

internal sealed class SortedSetEqualityComparer<T> : IEqualityComparer<SortedSet<T>>
{
	private readonly IComparer<T> _comparer;

	private readonly IEqualityComparer<T> _memberEqualityComparer;

	public SortedSetEqualityComparer(IEqualityComparer<T> memberEqualityComparer)
		: this((IComparer<T>)null, memberEqualityComparer)
	{
	}

	private SortedSetEqualityComparer(IComparer<T> comparer, IEqualityComparer<T> memberEqualityComparer)
	{
		_comparer = comparer ?? Comparer<T>.Default;
		_memberEqualityComparer = memberEqualityComparer ?? EqualityComparer<T>.Default;
	}

	public bool Equals(SortedSet<T> x, SortedSet<T> y)
	{
		return SortedSet<T>.SortedSetEquals(x, y, _comparer);
	}

	public int GetHashCode(SortedSet<T> obj)
	{
		int num = 0;
		if (obj != null)
		{
			foreach (T item in obj)
			{
				num ^= _memberEqualityComparer.GetHashCode(item) & 0x7FFFFFFF;
			}
		}
		return num;
	}

	public override bool Equals(object obj)
	{
		if (obj is SortedSetEqualityComparer<T> sortedSetEqualityComparer)
		{
			return _comparer == sortedSetEqualityComparer._comparer;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return _comparer.GetHashCode() ^ _memberEqualityComparer.GetHashCode();
	}
}
