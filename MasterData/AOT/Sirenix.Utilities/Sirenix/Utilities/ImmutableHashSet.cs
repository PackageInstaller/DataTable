using System;
using System.Collections;
using System.Collections.Generic;

namespace Sirenix.Utilities;

[Serializable]
public class ImmutableHashSet<T> : IEnumerable<T>, IEnumerable
{
	private readonly HashSet<T> hashSet;

	public ImmutableHashSet(HashSet<T> hashSet)
	{
		this.hashSet = hashSet;
	}

	public bool Contains(T item)
	{
		return hashSet.Contains(item);
	}

	public IEnumerator<T> GetEnumerator()
	{
		return hashSet.GetEnumerator();
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return hashSet.GetEnumerator();
	}
}
