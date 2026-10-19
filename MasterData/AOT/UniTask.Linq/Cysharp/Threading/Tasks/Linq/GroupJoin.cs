using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class GroupJoin<TOuter, TInner, TKey, TResult> : IUniTaskAsyncEnumerable<TResult>
{
	private sealed class _GroupJoin : MoveNextSource, IUniTaskAsyncEnumerator<TResult>, IUniTaskAsyncDisposable
	{
		private static readonly Action<object> MoveNextCoreDelegate = MoveNextCore;

		private readonly IUniTaskAsyncEnumerable<TOuter> outer;

		private readonly IUniTaskAsyncEnumerable<TInner> inner;

		private readonly Func<TOuter, TKey> outerKeySelector;

		private readonly Func<TInner, TKey> innerKeySelector;

		private readonly Func<TOuter, IEnumerable<TInner>, TResult> resultSelector;

		private readonly IEqualityComparer<TKey> comparer;

		private CancellationToken cancellationToken;

		private ILookup<TKey, TInner> lookup;

		private IUniTaskAsyncEnumerator<TOuter> enumerator;

		private UniTask<bool>.Awaiter awaiter;

		public TResult Current { get; private set; }

		public _GroupJoin(IUniTaskAsyncEnumerable<TOuter> outer, IUniTaskAsyncEnumerable<TInner> inner, Func<TOuter, TKey> outerKeySelector, Func<TInner, TKey> innerKeySelector, Func<TOuter, IEnumerable<TInner>, TResult> resultSelector, IEqualityComparer<TKey> comparer, CancellationToken cancellationToken)
		{
			this.outer = outer;
			this.inner = inner;
			this.outerKeySelector = outerKeySelector;
			this.innerKeySelector = innerKeySelector;
			this.resultSelector = resultSelector;
			this.comparer = comparer;
			this.cancellationToken = cancellationToken;
		}

		public UniTask<bool> MoveNextAsync()
		{
			cancellationToken.ThrowIfCancellationRequested();
			completionSource.Reset();
			if (lookup == null)
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
				lookup = await inner.ToLookupAsync(innerKeySelector, comparer, cancellationToken);
				enumerator = outer.GetAsyncEnumerator(cancellationToken);
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
				awaiter = enumerator.MoveNextAsync().GetAwaiter();
				if (awaiter.IsCompleted)
				{
					MoveNextCore(this);
				}
				else
				{
					awaiter.SourceOnCompleted(MoveNextCoreDelegate, this);
				}
			}
			catch (Exception error)
			{
				completionSource.TrySetException(error);
			}
		}

		private static void MoveNextCore(object state)
		{
			_GroupJoin groupJoin = (_GroupJoin)state;
			if (groupJoin.TryGetResult(groupJoin.awaiter, out var result))
			{
				if (result)
				{
					TOuter current = groupJoin.enumerator.Current;
					TKey key = groupJoin.outerKeySelector(current);
					IEnumerable<TInner> arg = groupJoin.lookup[key];
					groupJoin.Current = groupJoin.resultSelector(current, arg);
					groupJoin.completionSource.TrySetResult(result: true);
				}
				else
				{
					groupJoin.completionSource.TrySetResult(result: false);
				}
			}
		}

		public UniTask DisposeAsync()
		{
			if (enumerator != null)
			{
				return enumerator.DisposeAsync();
			}
			return default;
		}
	}

	private readonly IUniTaskAsyncEnumerable<TOuter> outer;

	private readonly IUniTaskAsyncEnumerable<TInner> inner;

	private readonly Func<TOuter, TKey> outerKeySelector;

	private readonly Func<TInner, TKey> innerKeySelector;

	private readonly Func<TOuter, IEnumerable<TInner>, TResult> resultSelector;

	private readonly IEqualityComparer<TKey> comparer;

	public GroupJoin(IUniTaskAsyncEnumerable<TOuter> outer, IUniTaskAsyncEnumerable<TInner> inner, Func<TOuter, TKey> outerKeySelector, Func<TInner, TKey> innerKeySelector, Func<TOuter, IEnumerable<TInner>, TResult> resultSelector, IEqualityComparer<TKey> comparer)
	{
		this.outer = outer;
		this.inner = inner;
		this.outerKeySelector = outerKeySelector;
		this.innerKeySelector = innerKeySelector;
		this.resultSelector = resultSelector;
		this.comparer = comparer;
	}

	public IUniTaskAsyncEnumerator<TResult> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _GroupJoin(outer, inner, outerKeySelector, innerKeySelector, resultSelector, comparer, cancellationToken);
	}
}
