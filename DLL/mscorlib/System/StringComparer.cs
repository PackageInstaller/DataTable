using System.Collections;
using System.Collections.Generic;
using System.Globalization;

namespace System;

[Serializable]
public abstract class StringComparer : IComparer, IEqualityComparer, IComparer<string>, IEqualityComparer<string>
{
	private static readonly CultureAwareComparer s_invariantCulture = new CultureAwareComparer(CultureInfo.InvariantCulture, CompareOptions.None);

	private static readonly CultureAwareComparer s_invariantCultureIgnoreCase = new CultureAwareComparer(CultureInfo.InvariantCulture, CompareOptions.IgnoreCase);

	private static readonly OrdinalCaseSensitiveComparer s_ordinal = new OrdinalCaseSensitiveComparer();

	private static readonly OrdinalIgnoreCaseComparer s_ordinalIgnoreCase = new OrdinalIgnoreCaseComparer();

	public static StringComparer InvariantCulture => s_invariantCulture;

	public static StringComparer InvariantCultureIgnoreCase => s_invariantCultureIgnoreCase;

	public static StringComparer CurrentCulture => new CultureAwareComparer(CultureInfo.CurrentCulture, CompareOptions.None);

	public static StringComparer CurrentCultureIgnoreCase => new CultureAwareComparer(CultureInfo.CurrentCulture, CompareOptions.IgnoreCase);

	public static StringComparer Ordinal => s_ordinal;

	public static StringComparer OrdinalIgnoreCase => s_ordinalIgnoreCase;

	public static StringComparer FromComparison(StringComparison comparisonType)
	{
		return comparisonType switch
		{
			StringComparison.CurrentCulture => CurrentCulture, 
			StringComparison.CurrentCultureIgnoreCase => CurrentCultureIgnoreCase, 
			StringComparison.InvariantCulture => InvariantCulture, 
			StringComparison.InvariantCultureIgnoreCase => InvariantCultureIgnoreCase, 
			StringComparison.Ordinal => Ordinal, 
			StringComparison.OrdinalIgnoreCase => OrdinalIgnoreCase, 
			_ => throw new ArgumentException("The string comparison type passed in is currently not supported.", "comparisonType"), 
		};
	}

	public static StringComparer Create(CultureInfo culture, bool ignoreCase)
	{
		if (culture == null)
		{
			throw new ArgumentNullException("culture");
		}
		return new CultureAwareComparer(culture, ignoreCase ? CompareOptions.IgnoreCase : CompareOptions.None);
	}

	public static StringComparer Create(CultureInfo culture, CompareOptions options)
	{
		if (culture == null)
		{
			throw new ArgumentException("culture");
		}
		return new CultureAwareComparer(culture, options);
	}

	public int Compare(object x, object y)
	{
		if (x == y)
		{
			return 0;
		}
		if (x == null)
		{
			return -1;
		}
		if (y == null)
		{
			return 1;
		}
		if (x is string x2 && y is string y2)
		{
			return Compare(x2, y2);
		}
		if (x is IComparable comparable)
		{
			return comparable.CompareTo(y);
		}
		throw new ArgumentException("At least one object must implement IComparable.");
	}

	public new bool Equals(object x, object y)
	{
		if (x == y)
		{
			return true;
		}
		if (x == null || y == null)
		{
			return false;
		}
		if (x is string x2 && y is string y2)
		{
			return Equals(x2, y2);
		}
		return x.Equals(y);
	}

	public int GetHashCode(object obj)
	{
		if (obj == null)
		{
			throw new ArgumentNullException("obj");
		}
		if (obj is string obj2)
		{
			return GetHashCode(obj2);
		}
		return obj.GetHashCode();
	}

	public abstract int Compare(string x, string y);

	public abstract bool Equals(string x, string y);

	public abstract int GetHashCode(string obj);
}
