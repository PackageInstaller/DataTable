namespace System.Collections.Generic;

[Serializable]
internal sealed class InternalStringComparer : EqualityComparer<string>
{
	public override int GetHashCode(string obj)
	{
		return obj?.GetHashCode() ?? 0;
	}

	public override bool Equals(string x, string y)
	{
		if (x == null)
		{
			return y == null;
		}
		if ((object)x == y)
		{
			return true;
		}
		return x.Equals(y);
	}

	internal override int IndexOf(string[] array, string value, int startIndex, int count)
	{
		int num = startIndex + count;
		for (int i = startIndex; i < num; i++)
		{
			if (Array.UnsafeLoad(array, i) == value)
			{
				return i;
			}
		}
		return -1;
	}
}
