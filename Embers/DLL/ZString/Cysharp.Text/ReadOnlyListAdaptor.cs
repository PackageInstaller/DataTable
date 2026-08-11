using System.Collections;
using System.Collections.Generic;

namespace Cysharp.Text;

internal readonly struct ReadOnlyListAdaptor<T>(IList<T> list) : IReadOnlyList<T>, IEnumerable<T>, IEnumerable, IReadOnlyCollection<T>
{
	private readonly IList<T> _list = list;

	public T this[int index] => _list[index];

	public int Count => _list.Count;

	public IEnumerator<T> GetEnumerator()
	{
		return _list.GetEnumerator();
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}
}
