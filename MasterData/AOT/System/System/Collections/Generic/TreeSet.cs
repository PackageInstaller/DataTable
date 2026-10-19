using System.Runtime.Serialization;

namespace System.Collections.Generic;

[Serializable]
internal sealed class TreeSet<T> : SortedSet<T>
{
	public TreeSet()
	{
	}

	public TreeSet(IComparer<T> comparer)
		: base(comparer)
	{
	}

	public TreeSet(SerializationInfo siInfo, StreamingContext context)
		: base(siInfo, context)
	{
	}

	internal override bool AddIfNotPresent(T item)
	{
		bool flag = base.AddIfNotPresent(item);
		if (!flag)
		{
			throw new ArgumentException(SR.Format("An item with the same key has already been added. Key: {0}", item));
		}
		return flag;
	}
}
