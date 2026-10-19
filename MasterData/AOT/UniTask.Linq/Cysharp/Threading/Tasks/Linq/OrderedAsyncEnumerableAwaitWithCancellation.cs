using System;
using System.Collections.Generic;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal class OrderedAsyncEnumerableAwaitWithCancellation<TElement, TKey> : OrderedAsyncEnumerable<TElement>
{
	private readonly Func<TElement, CancellationToken, UniTask<TKey>> keySelector;

	private readonly IComparer<TKey> comparer;

	private readonly bool descending;

	private readonly OrderedAsyncEnumerable<TElement> parent;

	public OrderedAsyncEnumerableAwaitWithCancellation(IUniTaskAsyncEnumerable<TElement> source, Func<TElement, CancellationToken, UniTask<TKey>> keySelector, IComparer<TKey> comparer, bool descending, OrderedAsyncEnumerable<TElement> parent)
		: base(source)
	{
		this.keySelector = keySelector;
		this.comparer = comparer;
		this.descending = descending;
		this.parent = parent;
	}

	internal override AsyncEnumerableSorter<TElement> GetAsyncEnumerableSorter(AsyncEnumerableSorter<TElement> next, CancellationToken cancellationToken)
	{
		AsyncEnumerableSorter<TElement> asyncEnumerableSorter = new AsyncSelectorWithCancellationEnumerableSorter<TElement, TKey>(keySelector, comparer, descending, next, cancellationToken);
		if (parent != null)
		{
			asyncEnumerableSorter = parent.GetAsyncEnumerableSorter(asyncEnumerableSorter, cancellationToken);
		}
		return asyncEnumerableSorter;
	}
}
