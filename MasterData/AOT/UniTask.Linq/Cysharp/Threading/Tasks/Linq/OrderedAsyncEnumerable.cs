using System;
using System.Collections.Generic;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal abstract class OrderedAsyncEnumerable<TElement> : IUniTaskOrderedAsyncEnumerable<TElement>, IUniTaskAsyncEnumerable<TElement>
{
	private class _OrderedAsyncEnumerator : MoveNextSource, IUniTaskAsyncEnumerator<TElement>, IUniTaskAsyncDisposable
	{
		protected readonly OrderedAsyncEnumerable<TElement> parent;

		private CancellationToken cancellationToken;

		private TElement[] buffer;

		private int[] map;

		private int index;

		public TElement Current { get; private set; }

		public _OrderedAsyncEnumerator(OrderedAsyncEnumerable<TElement> parent, CancellationToken cancellationToken)
		{
			this.parent = parent;
			this.cancellationToken = cancellationToken;
		}

		public UniTask<bool> MoveNextAsync()
		{
			cancellationToken.ThrowIfCancellationRequested();
			if (map == null)
			{
				completionSource.Reset();
				CreateSortSource().Forget();
				return new UniTask<bool>(this, completionSource.Version);
			}
			if (index < buffer.Length)
			{
				Current = buffer[map[index++]];
				return CompletedTasks.True;
			}
			return CompletedTasks.False;
		}

		private async UniTaskVoid CreateSortSource()
		{
			_ = 1;
			try
			{
				buffer = await parent.source.ToArrayAsync();
				if (buffer.Length == 0)
				{
					completionSource.TrySetResult(result: false);
					return;
				}
				map = await parent.GetAsyncEnumerableSorter(null, cancellationToken).SortAsync(buffer, buffer.Length);
				Current = buffer[map[index++]];
			}
			catch (Exception error)
			{
				completionSource.TrySetException(error);
				return;
			}
			completionSource.TrySetResult(result: true);
		}

		public UniTask DisposeAsync()
		{
			return default;
		}
	}

	protected readonly IUniTaskAsyncEnumerable<TElement> source;

	public OrderedAsyncEnumerable(IUniTaskAsyncEnumerable<TElement> source)
	{
		this.source = source;
	}

	public IUniTaskOrderedAsyncEnumerable<TElement> CreateOrderedEnumerable<TKey>(Func<TElement, TKey> keySelector, IComparer<TKey> comparer, bool descending)
	{
		return new OrderedAsyncEnumerable<TElement, TKey>(source, keySelector, comparer, descending, this);
	}

	public IUniTaskOrderedAsyncEnumerable<TElement> CreateOrderedEnumerable<TKey>(Func<TElement, UniTask<TKey>> keySelector, IComparer<TKey> comparer, bool descending)
	{
		return new OrderedAsyncEnumerableAwait<TElement, TKey>(source, keySelector, comparer, descending, this);
	}

	public IUniTaskOrderedAsyncEnumerable<TElement> CreateOrderedEnumerable<TKey>(Func<TElement, CancellationToken, UniTask<TKey>> keySelector, IComparer<TKey> comparer, bool descending)
	{
		return new OrderedAsyncEnumerableAwaitWithCancellation<TElement, TKey>(source, keySelector, comparer, descending, this);
	}

	internal abstract AsyncEnumerableSorter<TElement> GetAsyncEnumerableSorter(AsyncEnumerableSorter<TElement> next, CancellationToken cancellationToken);

	public IUniTaskAsyncEnumerator<TElement> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _OrderedAsyncEnumerator(this, cancellationToken);
	}
}
internal class OrderedAsyncEnumerable<TElement, TKey> : OrderedAsyncEnumerable<TElement>
{
	private readonly Func<TElement, TKey> keySelector;

	private readonly IComparer<TKey> comparer;

	private readonly bool descending;

	private readonly OrderedAsyncEnumerable<TElement> parent;

	public OrderedAsyncEnumerable(IUniTaskAsyncEnumerable<TElement> source, Func<TElement, TKey> keySelector, IComparer<TKey> comparer, bool descending, OrderedAsyncEnumerable<TElement> parent)
		: base(source)
	{
		this.keySelector = keySelector;
		this.comparer = comparer;
		this.descending = descending;
		this.parent = parent;
	}

	internal override AsyncEnumerableSorter<TElement> GetAsyncEnumerableSorter(AsyncEnumerableSorter<TElement> next, CancellationToken cancellationToken)
	{
		AsyncEnumerableSorter<TElement> asyncEnumerableSorter = new SyncSelectorAsyncEnumerableSorter<TElement, TKey>(keySelector, comparer, descending, next);
		if (parent != null)
		{
			asyncEnumerableSorter = parent.GetAsyncEnumerableSorter(asyncEnumerableSorter, cancellationToken);
		}
		return asyncEnumerableSorter;
	}
}
