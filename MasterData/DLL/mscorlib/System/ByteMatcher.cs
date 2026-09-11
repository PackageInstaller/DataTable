using System.Collections;

namespace System;

internal class ByteMatcher
{
	private Hashtable map = new Hashtable();

	private Hashtable starts = new Hashtable();

	public void AddMapping(TermInfoStrings key, byte[] val)
	{
		if (val.Length != 0)
		{
			map[val] = key;
			starts[(int)val[0]] = true;
		}
	}

	public void Sort()
	{
	}

	public bool StartsWith(int c)
	{
		return starts[c] != null;
	}

	public TermInfoStrings Match(char[] buffer, int offset, int length, out int used)
	{
		foreach (byte[] key in map.Keys)
		{
			for (int i = 0; i < key.Length && i < length && key[i] == buffer[offset + i]; i++)
			{
				if (key.Length - 1 == i)
				{
					used = key.Length;
					return (TermInfoStrings)map[key];
				}
			}
		}
		used = 0;
		return (TermInfoStrings)(-1);
	}
}
