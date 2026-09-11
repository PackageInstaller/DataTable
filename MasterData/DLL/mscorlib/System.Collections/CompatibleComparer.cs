namespace System.Collections;

[Serializable]
internal sealed class CompatibleComparer : IEqualityComparer
{
	private readonly IHashCodeProvider _hcp;

	private readonly IComparer _comparer;

	internal IHashCodeProvider HashCodeProvider => _hcp;

	internal IComparer Comparer => _comparer;

	internal CompatibleComparer(IHashCodeProvider hashCodeProvider, IComparer comparer)
	{
		_hcp = hashCodeProvider;
		_comparer = comparer;
	}

	public new bool Equals(object a, object b)
	{
		return Compare(a, b) == 0;
	}

	public int Compare(object a, object b)
	{
		if (a == b)
		{
			return 0;
		}
		if (a == null)
		{
			return -1;
		}
		if (b == null)
		{
			return 1;
		}
		if (_comparer != null)
		{
			return _comparer.Compare(a, b);
		}
		if (a is IComparable comparable)
		{
			return comparable.CompareTo(b);
		}
		throw new ArgumentException("At least one object must implement IComparable.");
	}

	public int GetHashCode(object obj)
	{
		if (obj == null)
		{
			throw new ArgumentNullException("obj");
		}
		if (_hcp == null)
		{
			return obj.GetHashCode();
		}
		return _hcp.GetHashCode(obj);
	}
}
