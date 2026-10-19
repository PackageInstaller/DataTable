using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class GroupByAwaitWithCancellation<TSource, TKey, TElement> : IUniTaskAsyncEnumerable<IGrouping<TKey, TElement>>
{
	private sealed class _GroupByAwaitWithCancellation : MoveNextSource, IUniTaskAsyncEnumerator<IGrouping<TKey, TElement>>, IUniTaskAsyncDisposable
	{
		private readonly IUniTaskAsyncEnumerable<TSource> source;

		private readonly Func<TSource, CancellationToken, UniTask<TKey>> keySelector;

		private readonly Func<TSource, CancellationToken, UniTask<TElement>> elementSelector;

		private readonly IEqualityComparer<TKey> comparer;

		private CancellationToken cancellationToken;

		private IEnumerator<IGrouping<TKey, TElement>> groupEnumerator;

		public IGrouping<TKey, TElement> Current { get; private set; }

		public _GroupByAwaitWithCancellation(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, CancellationToken, UniTask<TKey>> keySelector, Func<TSource, CancellationToken, UniTask<TElement>> elementSelector, IEqualityComparer<TKey> comparer, CancellationToken cancellationToken)
		{
			this.source = source;
			this.keySelector = keySelector;
			this.elementSelector = elementSelector;
			this.comparer = comparer;
			this.cancellationToken = cancellationToken;
		}

		public UniTask<bool> MoveNextAsync()
		{
			cancellationToken.ThrowIfCancellationRequested();
			completionSource.Reset();
			if (groupEnumerator == null)
			{
				CreateLookup().Forget();
			}
			else
			{
				SourceMoveNext();
			}
			return new UniTask<bool>(this, completionSource.Version);
		}

		private async UniTaskVoid CreateLookup()
		{
			try
			{
				groupEnumerator = (await source.ToLookupAwaitWithCancellationAsync(keySelector, elementSelector, comparer, cancellationToken)).GetEnumerator();
			}
			catch (Exception error)
			{
				completionSource.TrySetException(error);
				return;
			}
			SourceMoveNext();
		}

		private void SourceMoveNext()
		{
			try
			{
				if (groupEnumerator.MoveNext())
				{
					Current = groupEnumerator.Current;
					completionSource.TrySetResult(result: true);
				}
				else
				{
					completionSource.TrySetResult(result: false);
				}
			}
			catch (Exception error)
			{
				completionSource.TrySetException(error);
			}
		}

		public UniTask DisposeAsync()
		{
			if (groupEnumerator != null)
			{
				groupEnumerator.Dispose();
			}
			return default;
		}
	}

	private readonly IUniTaskAsyncEnumerable<TSource> source;

	private readonly Func<TSource, CancellationToken, UniTask<TKey>> keySelector;

	private readonly Func<TSource, CancellationToken, UniTask<TElement>> elementSelector;

	private readonly IEqualityComparer<TKey> comparer;

	public GroupByAwaitWithCancellation(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, CancellationToken, UniTask<TKey>> keySelector, Func<TSource, CancellationToken, UniTask<TElement>> elementSelector, IEqualityComparer<TKey> comparer)
	{
		this.source = source;
		this.keySelector = keySelector;
		this.elementSelector = elementSelector;
		this.comparer = comparer;
	}

	public IUniTaskAsyncEnumerator<IGrouping<TKey, TElement>> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _GroupByAwaitWithCancellation(source, keySelector, elementSelector, comparer, cancellationToken);
	}
}
internal sealed class GroupByAwaitWithCancellation<TSource, TKey, TElement, TResult> : IUniTaskAsyncEnumerable<TResult>
{
	private sealed class _GroupByAwaitWithCancellation : MoveNextSource, IUniTaskAsyncEnumerator<TResult>, IUniTaskAsyncDisposable
	{
		private static readonly Action<object> ResultSelectCoreDelegate = ResultSelectCore;

		private readonly IUniTaskAsyncEnumerable<TSource> source;

		private readonly Func<TSource, CancellationToken, UniTask<TKey>> keySelector;

		private readonly Func<TSource, CancellationToken, UniTask<TElement>> elementSelector;

		private readonly Func<TKey, IEnumerable<TElement>, CancellationToken, UniTask<TResult>> resultSelector;

		private readonly IEqualityComparer<TKey> comparer;

		private CancellationToken cancellationToken;

		private IEnumerator<IGrouping<TKey, TElement>> groupEnumerator;

		private UniTask<TResult>.Awaiter awaiter;

		public TResult Current { get; private set; }

		public _GroupByAwaitWithCancellation(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, CancellationToken, UniTask<TKey>> keySelector, Func<TSource, CancellationToken, UniTask<TElement>> elementSelector, Func<TKey, IEnumerable<TElement>, CancellationToken, UniTask<TResult>> resultSelector, IEqualityComparer<TKey> comparer, CancellationToken cancellationToken)
		{
			this.source = source;
			this.keySelector = keySelector;
			this.elementSelector = elementSelector;
			this.resultSelector = resultSelector;
			this.comparer = comparer;
			this.cancellationToken = cancellationToken;
		}

		public UniTask<bool> MoveNextAsync()
		{
			cancellationToken.ThrowIfCancellationRequested();
			completionSource.Reset();
			if (groupEnumerator == null)
			{
				CreateLookup().Forget();
			}
			else
			{
				SourceMoveNext();
			}
			return new UniTask<bool>(this, completionSource.Version);
		}

		private async UniTaskVoid CreateLookup()
		{
			try
			{
				groupEnumerator = (await source.ToLookupAwaitWithCancellationAsync(keySelector, elementSelector, comparer, cancellationToken)).GetEnumerator();
			}
			catch (Exception error)
			{
				completionSource.TrySetException(error);
				return;
			}
			SourceMoveNext();
		}

		private void SourceMoveNext()
		{
			try
			{
				if (groupEnumerator.MoveNext())
				{
					IGrouping<TKey, TElement> current = groupEnumerator.Current;
					awaiter = resultSelector(current.Key, current, cancellationToken).GetAwaiter();
					if (awaiter.IsCompleted)
					{
						ResultSelectCore(this);
					}
					else
					{
						awaiter.SourceOnCompleted(ResultSelectCoreDelegate, this);
					}
				}
				else
				{
					completionSource.TrySetResult(result: false);
				}
			}
			catch (Exception error)
			{
				completionSource.TrySetException(error);
			}
		}

		private static void ResultSelectCore(object state)
		{
			_GroupByAwaitWithCancellation groupByAwaitWithCancellation = (_GroupByAwaitWithCancellation)state;
			if (groupByAwaitWithCancellation.TryGetResult(groupByAwaitWithCancellation.awaiter, out var result))
			{
				groupByAwaitWithCancellation.Current = result;
				groupByAwaitWithCancellation.completionSource.TrySetResult(result: true);
			}
		}

		public UniTask DisposeAsync()
		{
			if (groupEnumerator != null)
			{
				groupEnumerator.Dispose();
			}
			return default;
		}
	}

	private readonly IUniTaskAsyncEnumerable<TSource> source;

	private readonly Func<TSource, CancellationToken, UniTask<TKey>> keySelector;

	private readonly Func<TSource, CancellationToken, UniTask<TElement>> elementSelector;

	private readonly Func<TKey, IEnumerable<TElement>, CancellationToken, UniTask<TResult>> resultSelector;

	private readonly IEqualityComparer<TKey> comparer;

	public GroupByAwaitWithCancellation(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, CancellationToken, UniTask<TKey>> keySelector, Func<TSource, CancellationToken, UniTask<TElement>> elementSelector, Func<TKey, IEnumerable<TElement>, CancellationToken, UniTask<TResult>> resultSelector, IEqualityComparer<TKey> comparer)
	{
		this.source = source;
		this.keySelector = keySelector;
		this.elementSelector = elementSelector;
		this.resultSelector = resultSelector;
		this.comparer = comparer;
	}

	public IUniTaskAsyncEnumerator<TResult> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _GroupByAwaitWithCancellation(source, keySelector, elementSelector, resultSelector, comparer, cancellationToken);
	}
}
