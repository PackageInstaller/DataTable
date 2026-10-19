using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class GroupJoinAwait<TOuter, TInner, TKey, TResult> : IUniTaskAsyncEnumerable<TResult>
{
	private sealed class _GroupJoinAwait : MoveNextSource, IUniTaskAsyncEnumerator<TResult>, IUniTaskAsyncDisposable
	{
		private static readonly Action<object> MoveNextCoreDelegate = MoveNextCore;

		private static readonly Action<object> ResultSelectCoreDelegate = ResultSelectCore;

		private static readonly Action<object> OuterKeySelectCoreDelegate = OuterKeySelectCore;

		private readonly IUniTaskAsyncEnumerable<TOuter> outer;

		private readonly IUniTaskAsyncEnumerable<TInner> inner;

		private readonly Func<TOuter, UniTask<TKey>> outerKeySelector;

		private readonly Func<TInner, UniTask<TKey>> innerKeySelector;

		private readonly Func<TOuter, IEnumerable<TInner>, UniTask<TResult>> resultSelector;

		private readonly IEqualityComparer<TKey> comparer;

		private CancellationToken cancellationToken;

		private ILookup<TKey, TInner> lookup;

		private IUniTaskAsyncEnumerator<TOuter> enumerator;

		private TOuter outerValue;

		private UniTask<bool>.Awaiter awaiter;

		private UniTask<TKey>.Awaiter outerKeyAwaiter;

		private UniTask<TResult>.Awaiter resultAwaiter;

		public TResult Current { get; private set; }

		public _GroupJoinAwait(IUniTaskAsyncEnumerable<TOuter> outer, IUniTaskAsyncEnumerable<TInner> inner, Func<TOuter, UniTask<TKey>> outerKeySelector, Func<TInner, UniTask<TKey>> innerKeySelector, Func<TOuter, IEnumerable<TInner>, UniTask<TResult>> resultSelector, IEqualityComparer<TKey> comparer, CancellationToken cancellationToken)
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
				lookup = await inner.ToLookupAwaitAsync(innerKeySelector, comparer, cancellationToken);
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
			_GroupJoinAwait groupJoinAwait = (_GroupJoinAwait)state;
			if (!groupJoinAwait.TryGetResult(groupJoinAwait.awaiter, out var result))
			{
				return;
			}
			if (result)
			{
				try
				{
					groupJoinAwait.outerValue = groupJoinAwait.enumerator.Current;
					groupJoinAwait.outerKeyAwaiter = groupJoinAwait.outerKeySelector(groupJoinAwait.outerValue).GetAwaiter();
					if (groupJoinAwait.outerKeyAwaiter.IsCompleted)
					{
						OuterKeySelectCore(groupJoinAwait);
					}
					else
					{
						groupJoinAwait.outerKeyAwaiter.SourceOnCompleted(OuterKeySelectCoreDelegate, groupJoinAwait);
					}
					return;
				}
				catch (Exception error)
				{
					groupJoinAwait.completionSource.TrySetException(error);
					return;
				}
			}
			groupJoinAwait.completionSource.TrySetResult(result: false);
		}

		private static void OuterKeySelectCore(object state)
		{
			_GroupJoinAwait groupJoinAwait = (_GroupJoinAwait)state;
			if (!groupJoinAwait.TryGetResult(groupJoinAwait.outerKeyAwaiter, out var result))
			{
				return;
			}
			try
			{
				IEnumerable<TInner> arg = groupJoinAwait.lookup[result];
				groupJoinAwait.resultAwaiter = groupJoinAwait.resultSelector(groupJoinAwait.outerValue, arg).GetAwaiter();
				if (groupJoinAwait.resultAwaiter.IsCompleted)
				{
					ResultSelectCore(groupJoinAwait);
				}
				else
				{
					groupJoinAwait.resultAwaiter.SourceOnCompleted(ResultSelectCoreDelegate, groupJoinAwait);
				}
			}
			catch (Exception error)
			{
				groupJoinAwait.completionSource.TrySetException(error);
			}
		}

		private static void ResultSelectCore(object state)
		{
			_GroupJoinAwait groupJoinAwait = (_GroupJoinAwait)state;
			if (groupJoinAwait.TryGetResult(groupJoinAwait.resultAwaiter, out var result))
			{
				groupJoinAwait.Current = result;
				groupJoinAwait.completionSource.TrySetResult(result: true);
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

	private readonly Func<TOuter, UniTask<TKey>> outerKeySelector;

	private readonly Func<TInner, UniTask<TKey>> innerKeySelector;

	private readonly Func<TOuter, IEnumerable<TInner>, UniTask<TResult>> resultSelector;

	private readonly IEqualityComparer<TKey> comparer;

	public GroupJoinAwait(IUniTaskAsyncEnumerable<TOuter> outer, IUniTaskAsyncEnumerable<TInner> inner, Func<TOuter, UniTask<TKey>> outerKeySelector, Func<TInner, UniTask<TKey>> innerKeySelector, Func<TOuter, IEnumerable<TInner>, UniTask<TResult>> resultSelector, IEqualityComparer<TKey> comparer)
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
		return new _GroupJoinAwait(outer, inner, outerKeySelector, innerKeySelector, resultSelector, comparer, cancellationToken);
	}
}
