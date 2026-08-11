using System.Globalization;

namespace System.Collections.Specialized;

[Serializable]
internal class CompatibleComparer : IEqualityComparer
{
	private IComparer _comparer;

	private static volatile IComparer defaultComparer;

	private IHashCodeProvider _hcp;

	private static volatile IHashCodeProvider defaultHashProvider;

	public IComparer Comparer => _comparer;

	public IHashCodeProvider HashCodeProvider => _hcp;

	public static IComparer DefaultComparer
	{
		get
		{
			if (defaultComparer == null)
			{
				defaultComparer = new CaseInsensitiveComparer(CultureInfo.InvariantCulture);
			}
			return defaultComparer;
		}
	}

	public static IHashCodeProvider DefaultHashCodeProvider
	{
		get
		{
			if (defaultHashProvider == null)
			{
				defaultHashProvider = new CaseInsensitiveHashCodeProvider(CultureInfo.InvariantCulture);
			}
			return defaultHashProvider;
		}
	}

	internal CompatibleComparer(IComparer comparer, IHashCodeProvider hashCodeProvider)
	{
		_comparer = comparer;
		_hcp = hashCodeProvider;
	}

	public new bool Equals(object a, object b)
	{
		if (a == b)
		{
			return true;
		}
		if (a == null || b == null)
		{
			return false;
		}
		try
		{
			if (_comparer != null)
			{
				return _comparer.Compare(a, b) == 0;
			}
			if (a is IComparable comparable)
			{
				return comparable.CompareTo(b) == 0;
			}
		}
		catch (ArgumentException)
		{
			return false;
		}
		return a.Equals(b);
	}

	public int GetHashCode(object obj)
	{
		if (obj == null)
		{
			throw new ArgumentNullException("obj");
		}
		if (_hcp != null)
		{
			return _hcp.GetHashCode(obj);
		}
		return obj.GetHashCode();
	}
}
