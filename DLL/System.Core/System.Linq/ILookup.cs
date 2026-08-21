using System.Collections;
using System.Collections.Generic;

namespace System.Linq;

public interface ILookup<TKey, TElement> : IEnumerable<IGrouping<TKey, TElement>>, IEnumerable
{
	IEnumerable<TElement> this[TKey key] { get; }

	bool Contains(TKey key);
}
