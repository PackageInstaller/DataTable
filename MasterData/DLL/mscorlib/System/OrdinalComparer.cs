using System.Globalization;

namespace System;

[Serializable]
public class OrdinalComparer : StringComparer
{
	private readonly bool _ignoreCase;

	internal OrdinalComparer(bool ignoreCase)
	{
		_ignoreCase = ignoreCase;
	}

	public override int Compare(string x, string y)
	{
		if ((object)x == y)
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
		if (_ignoreCase)
		{
			return string.Compare(x, y, StringComparison.OrdinalIgnoreCase);
		}
		return string.CompareOrdinal(x, y);
	}

	public override bool Equals(string x, string y)
	{
		if ((object)x == y)
		{
			return true;
		}
		if (x == null || y == null)
		{
			return false;
		}
		if (_ignoreCase)
		{
			if (x.Length != y.Length)
			{
				return false;
			}
			return string.Compare(x, y, StringComparison.OrdinalIgnoreCase) == 0;
		}
		return x.Equals(y);
	}

	public override int GetHashCode(string obj)
	{
		if (obj == null)
		{
			ThrowHelper.ThrowArgumentNullException(ExceptionArgument.obj);
		}
		if (_ignoreCase)
		{
			return CompareInfo.GetIgnoreCaseHash(obj);
		}
		return obj.GetHashCode();
	}

	public override bool Equals(object obj)
	{
		if (!(obj is OrdinalComparer ordinalComparer))
		{
			return false;
		}
		return _ignoreCase == ordinalComparer._ignoreCase;
	}

	public override int GetHashCode()
	{
		int hashCode = "OrdinalComparer".GetHashCode();
		if (!_ignoreCase)
		{
			return hashCode;
		}
		return ~hashCode;
	}
}
