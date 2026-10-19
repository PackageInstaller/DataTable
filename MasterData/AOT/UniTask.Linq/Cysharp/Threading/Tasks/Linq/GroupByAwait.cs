using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class GroupByAwait<TSource, TKey, TElement> : IUniTaskAsyncEnumerable<IGrouping<TKey, TElement>>
{
	private sealed class _GroupByAwait : MoveNextSource, IUniTaskAsyncEnumerator<IGrouping<TKey, TElement>>, IUniTaskAsyncDisposable
	{
		private readonly IUniTaskAsyncEnumerable<TSource> source;

		private readonly Func<TSource, UniTask<TKey>> keySelector;

		private readonly Func<TSource, UniTask<TElement>> elementSelector;

		private readonly IEqualityComparer<TKey> comparer;

		private CancellationToken cancellationToken;

		private IEnumerator<IGrouping<TKey, TElement>> groupEnumerator;

		public IGrouping<TKey, TElement> Current { get; private set; }

		public _GroupByAwait(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, UniTask<TKey>> keySelector, Func<TSource, UniTask<TElement>> elementSelector, IEqualityComparer<TKey> comparer, CancellationToken cancellationToken)
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
				groupEnumerator = (await source.ToLookupAwaitAsync(keySelector, elementSelector, comparer, cancellationToken)).GetEnumerator();
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

	private readonly Func<TSource, UniTask<TKey>> keySelector;

	private readonly Func<TSource, UniTask<TElement>> elementSelector;

	private readonly IEqualityComparer<TKey> comparer;

	public GroupByAwait(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, UniTask<TKey>> keySelector, Func<TSource, UniTask<TElement>> elementSelector, IEqualityComparer<TKey> comparer)
	{
		this.source = source;
		this.keySelector = keySelector;
		this.elementSelector = elementSelector;
		this.comparer = comparer;
	}

	public IUniTaskAsyncEnumerator<IGrouping<TKey, TElement>> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _GroupByAwait(source, keySelector, elementSelector, comparer, cancellationToken);
	}
}
internal sealed class GroupByAwait<TSource, TKey, TElement, TResult> : IUniTaskAsyncEnumerable<TResult>
{
	private sealed class _GroupByAwait : MoveNextSource, IUniTaskAsyncEnumerator<TResult>, IUniTaskAsyncDisposable
	{
		private static readonly Action<object> ResultSelectCoreDelegate = ResultSelectCore;

		private readonly IUniTaskAsyncEnumerable<TSource> source;

		private readonly Func<TSource, UniTask<TKey>> keySelector;

		private readonly Func<TSource, UniTask<TElement>> elementSelector;

		private readonly Func<TKey, IEnumerable<TElement>, UniTask<TResult>> resultSelector;

		private readonly IEqualityComparer<TKey> comparer;

		private CancellationToken cancellationToken;

		private IEnumerator<IGrouping<TKey, TElement>> groupEnumerator;

		private UniTask<TResult>.Awaiter awaiter;

		public TResult Current { get; private set; }

		public _GroupByAwait(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, UniTask<TKey>> keySelector, Func<TSource, UniTask<TElement>> elementSelector, Func<TKey, IEnumerable<TElement>, UniTask<TResult>> resultSelector, IEqualityComparer<TKey> comparer, CancellationToken cancellationToken)
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
				groupEnumerator = (await source.ToLookupAwaitAsync(keySelector, elementSelector, comparer, cancellationToken)).GetEnumerator();
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
					awaiter = resultSelector(current.Key, current).GetAwaiter();
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
			_GroupByAwait groupByAwait = (_GroupByAwait)state;
			if (groupByAwait.TryGetResult(groupByAwait.awaiter, out var result))
			{
				groupByAwait.Current = result;
				groupByAwait.completionSource.TrySetResult(result: true);
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

	private readonly Func<TSource, UniTask<TKey>> keySelector;

	private readonly Func<TSource, UniTask<TElement>> elementSelector;

	private readonly Func<TKey, IEnumerable<TElement>, UniTask<TResult>> resultSelector;

	private readonly IEqualityComparer<TKey> comparer;

	public GroupByAwait(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, UniTask<TKey>> keySelector, Func<TSource, UniTask<TElement>> elementSelector, Func<TKey, IEnumerable<TElement>, UniTask<TResult>> resultSelector, IEqualityComparer<TKey> comparer)
	{
		this.source = source;
		this.keySelector = keySelector;
		this.elementSelector = elementSelector;
		this.resultSelector = resultSelector;
		this.comparer = comparer;
	}

	public IUniTaskAsyncEnumerator<TResult> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _GroupByAwait(source, keySelector, elementSelector, resultSelector, comparer, cancellationToken);
	}
}
