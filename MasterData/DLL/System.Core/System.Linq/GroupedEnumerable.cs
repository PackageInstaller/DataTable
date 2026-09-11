using System.Collections;
using System.Collections.Generic;

namespace System.Linq;

internal class GroupedEnumerable<TSource, TKey, TElement, TResult> : IEnumerable<TResult>, IEnumerable
{
	private IEnumerable<TSource> source;

	private Func<TSource, TKey> keySelector;

	private Func<TSource, TElement> elementSelector;

	private IEqualityComparer<TKey> comparer;

	private Func<TKey, IEnumerable<TElement>, TResult> resultSelector;

	public GroupedEnumerable(IEnumerable<TSource> source, Func<TSource, TKey> keySelector, Func<TSource, TElement> elementSelector, Func<TKey, IEnumerable<TElement>, TResult> resultSelector, IEqualityComparer<TKey> comparer)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		if (keySelector == null)
		{
			throw Error.ArgumentNull("keySelector");
		}
		if (elementSelector == null)
		{
			throw Error.ArgumentNull("elementSelector");
		}
		if (resultSelector == null)
		{
			throw Error.ArgumentNull("resultSelector");
		}
		this.source = source;
		this.keySelector = keySelector;
		this.elementSelector = elementSelector;
		this.comparer = comparer;
		this.resultSelector = resultSelector;
	}

	public IEnumerator<TResult> GetEnumerator()
	{
		return Lookup<TKey, TElement>.Create(source, keySelector, elementSelector, comparer).ApplyResultSelector(resultSelector).GetEnumerator();
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}
}
internal class GroupedEnumerable<TSource, TKey, TElement> : IEnumerable<IGrouping<TKey, TElement>>, IEnumerable
{
	private IEnumerable<TSource> source;

	private Func<TSource, TKey> keySelector;

	private Func<TSource, TElement> elementSelector;

	private IEqualityComparer<TKey> comparer;

	public GroupedEnumerable(IEnumerable<TSource> source, Func<TSource, TKey> keySelector, Func<TSource, TElement> elementSelector, IEqualityComparer<TKey> comparer)
	{
		if (source == null)
		{
			throw Error.ArgumentNull("source");
		}
		if (keySelector == null)
		{
			throw Error.ArgumentNull("keySelector");
		}
		if (elementSelector == null)
		{
			throw Error.ArgumentNull("elementSelector");
		}
		this.source = source;
		this.keySelector = keySelector;
		this.elementSelector = elementSelector;
		this.comparer = comparer;
	}

	public IEnumerator<IGrouping<TKey, TElement>> GetEnumerator()
	{
		return Lookup<TKey, TElement>.Create(source, keySelector, elementSelector, comparer).GetEnumerator();
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}
}
