using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class GroupJoinAwaitWithCancellation<TOuter, TInner, TKey, TResult> : IUniTaskAsyncEnumerable<TResult>
{
	private sealed class _GroupJoinAwaitWithCancellation : MoveNextSource, IUniTaskAsyncEnumerator<TResult>, IUniTaskAsyncDisposable
	{
		private static readonly Action<object> MoveNextCoreDelegate = MoveNextCore;

		private static readonly Action<object> ResultSelectCoreDelegate = ResultSelectCore;

		private static readonly Action<object> OuterKeySelectCoreDelegate = OuterKeySelectCore;

		private readonly IUniTaskAsyncEnumerable<TOuter> outer;

		private readonly IUniTaskAsyncEnumerable<TInner> inner;

		private readonly Func<TOuter, CancellationToken, UniTask<TKey>> outerKeySelector;

		private readonly Func<TInner, CancellationToken, UniTask<TKey>> innerKeySelector;

		private readonly Func<TOuter, IEnumerable<TInner>, CancellationToken, UniTask<TResult>> resultSelector;

		private readonly IEqualityComparer<TKey> comparer;

		private CancellationToken cancellationToken;

		private ILookup<TKey, TInner> lookup;

		private IUniTaskAsyncEnumerator<TOuter> enumerator;

		private TOuter outerValue;

		private UniTask<bool>.Awaiter awaiter;

		private UniTask<TKey>.Awaiter outerKeyAwaiter;

		private UniTask<TResult>.Awaiter resultAwaiter;

		public TResult Current { get; private set; }

		public _GroupJoinAwaitWithCancellation(IUniTaskAsyncEnumerable<TOuter> outer, IUniTaskAsyncEnumerable<TInner> inner, Func<TOuter, CancellationToken, UniTask<TKey>> outerKeySelector, Func<TInner, CancellationToken, UniTask<TKey>> innerKeySelector, Func<TOuter, IEnumerable<TInner>, CancellationToken, UniTask<TResult>> resultSelector, IEqualityComparer<TKey> comparer, CancellationToken cancellationToken)
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
				lookup = await inner.ToLookupAwaitWithCancellationAsync(innerKeySelector, comparer, cancellationToken);
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
			_GroupJoinAwaitWithCancellation groupJoinAwaitWithCancellation = (_GroupJoinAwaitWithCancellation)state;
			if (!groupJoinAwaitWithCancellation.TryGetResult(groupJoinAwaitWithCancellation.awaiter, out var result))
			{
				return;
			}
			if (result)
			{
				try
				{
					groupJoinAwaitWithCancellation.outerValue = groupJoinAwaitWithCancellation.enumerator.Current;
					groupJoinAwaitWithCancellation.outerKeyAwaiter = groupJoinAwaitWithCancellation.outerKeySelector(groupJoinAwaitWithCancellation.outerValue, groupJoinAwaitWithCancellation.cancellationToken).GetAwaiter();
					if (groupJoinAwaitWithCancellation.outerKeyAwaiter.IsCompleted)
					{
						OuterKeySelectCore(groupJoinAwaitWithCancellation);
					}
					else
					{
						groupJoinAwaitWithCancellation.outerKeyAwaiter.SourceOnCompleted(OuterKeySelectCoreDelegate, groupJoinAwaitWithCancellation);
					}
					return;
				}
				catch (Exception error)
				{
					groupJoinAwaitWithCancellation.completionSource.TrySetException(error);
					return;
				}
			}
			groupJoinAwaitWithCancellation.completionSource.TrySetResult(result: false);
		}

		private static void OuterKeySelectCore(object state)
		{
			_GroupJoinAwaitWithCancellation groupJoinAwaitWithCancellation = (_GroupJoinAwaitWithCancellation)state;
			if (!groupJoinAwaitWithCancellation.TryGetResult(groupJoinAwaitWithCancellation.outerKeyAwaiter, out var result))
			{
				return;
			}
			try
			{
				IEnumerable<TInner> arg = groupJoinAwaitWithCancellation.lookup[result];
				groupJoinAwaitWithCancellation.resultAwaiter = groupJoinAwaitWithCancellation.resultSelector(groupJoinAwaitWithCancellation.outerValue, arg, groupJoinAwaitWithCancellation.cancellationToken).GetAwaiter();
				if (groupJoinAwaitWithCancellation.resultAwaiter.IsCompleted)
				{
					ResultSelectCore(groupJoinAwaitWithCancellation);
				}
				else
				{
					groupJoinAwaitWithCancellation.resultAwaiter.SourceOnCompleted(ResultSelectCoreDelegate, groupJoinAwaitWithCancellation);
				}
			}
			catch (Exception error)
			{
				groupJoinAwaitWithCancellation.completionSource.TrySetException(error);
			}
		}

		private static void ResultSelectCore(object state)
		{
			_GroupJoinAwaitWithCancellation groupJoinAwaitWithCancellation = (_GroupJoinAwaitWithCancellation)state;
			if (groupJoinAwaitWithCancellation.TryGetResult(groupJoinAwaitWithCancellation.resultAwaiter, out var result))
			{
				groupJoinAwaitWithCancellation.Current = result;
				groupJoinAwaitWithCancellation.completionSource.TrySetResult(result: true);
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

	private readonly Func<TOuter, CancellationToken, UniTask<TKey>> outerKeySelector;

	private readonly Func<TInner, CancellationToken, UniTask<TKey>> innerKeySelector;

	private readonly Func<TOuter, IEnumerable<TInner>, CancellationToken, UniTask<TResult>> resultSelector;

	private readonly IEqualityComparer<TKey> comparer;

	public GroupJoinAwaitWithCancellation(IUniTaskAsyncEnumerable<TOuter> outer, IUniTaskAsyncEnumerable<TInner> inner, Func<TOuter, CancellationToken, UniTask<TKey>> outerKeySelector, Func<TInner, CancellationToken, UniTask<TKey>> innerKeySelector, Func<TOuter, IEnumerable<TInner>, CancellationToken, UniTask<TResult>> resultSelector, IEqualityComparer<TKey> comparer)
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
		return new _GroupJoinAwaitWithCancellation(outer, inner, outerKeySelector, innerKeySelector, resultSelector, comparer, cancellationToken);
	}
}
