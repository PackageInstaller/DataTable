using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class JoinAwaitWithCancellation<TOuter, TInner, TKey, TResult> : IUniTaskAsyncEnumerable<TResult>
{
	private sealed class _JoinAwaitWithCancellation : MoveNextSource, IUniTaskAsyncEnumerator<TResult>, IUniTaskAsyncDisposable
	{
		private static readonly Action<object> MoveNextCoreDelegate = MoveNextCore;

		private static readonly Action<object> OuterSelectCoreDelegate = OuterSelectCore;

		private static readonly Action<object> ResultSelectCoreDelegate = ResultSelectCore;

		private readonly IUniTaskAsyncEnumerable<TOuter> outer;

		private readonly IUniTaskAsyncEnumerable<TInner> inner;

		private readonly Func<TOuter, CancellationToken, UniTask<TKey>> outerKeySelector;

		private readonly Func<TInner, CancellationToken, UniTask<TKey>> innerKeySelector;

		private readonly Func<TOuter, TInner, CancellationToken, UniTask<TResult>> resultSelector;

		private readonly IEqualityComparer<TKey> comparer;

		private CancellationToken cancellationToken;

		private ILookup<TKey, TInner> lookup;

		private IUniTaskAsyncEnumerator<TOuter> enumerator;

		private UniTask<bool>.Awaiter awaiter;

		private TOuter currentOuterValue;

		private IEnumerator<TInner> valueEnumerator;

		private UniTask<TResult>.Awaiter resultAwaiter;

		private UniTask<TKey>.Awaiter outerKeyAwaiter;

		private bool continueNext;

		public TResult Current { get; private set; }

		public _JoinAwaitWithCancellation(IUniTaskAsyncEnumerable<TOuter> outer, IUniTaskAsyncEnumerable<TInner> inner, Func<TOuter, CancellationToken, UniTask<TKey>> outerKeySelector, Func<TInner, CancellationToken, UniTask<TKey>> innerKeySelector, Func<TOuter, TInner, CancellationToken, UniTask<TResult>> resultSelector, IEqualityComparer<TKey> comparer, CancellationToken cancellationToken)
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
				CreateInnerHashSet().Forget();
			}
			else
			{
				SourceMoveNext();
			}
			return new UniTask<bool>(this, completionSource.Version);
		}

		private async UniTaskVoid CreateInnerHashSet()
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
				while (true)
				{
					if (valueEnumerator != null)
					{
						if (valueEnumerator.MoveNext())
						{
							resultAwaiter = resultSelector(currentOuterValue, valueEnumerator.Current, cancellationToken).GetAwaiter();
							if (resultAwaiter.IsCompleted)
							{
								ResultSelectCore(this);
							}
							else
							{
								resultAwaiter.SourceOnCompleted(ResultSelectCoreDelegate, this);
							}
							break;
						}
						valueEnumerator.Dispose();
						valueEnumerator = null;
					}
					awaiter = enumerator.MoveNextAsync().GetAwaiter();
					if (awaiter.IsCompleted)
					{
						continueNext = true;
						MoveNextCore(this);
						if (continueNext)
						{
							continueNext = false;
							continue;
						}
						break;
					}
					awaiter.SourceOnCompleted(MoveNextCoreDelegate, this);
					break;
				}
			}
			catch (Exception error)
			{
				completionSource.TrySetException(error);
			}
		}

		private static void MoveNextCore(object state)
		{
			_JoinAwaitWithCancellation joinAwaitWithCancellation = (_JoinAwaitWithCancellation)state;
			if (joinAwaitWithCancellation.TryGetResult(joinAwaitWithCancellation.awaiter, out var result))
			{
				if (result)
				{
					joinAwaitWithCancellation.currentOuterValue = joinAwaitWithCancellation.enumerator.Current;
					joinAwaitWithCancellation.outerKeyAwaiter = joinAwaitWithCancellation.outerKeySelector(joinAwaitWithCancellation.currentOuterValue, joinAwaitWithCancellation.cancellationToken).GetAwaiter();
					if (joinAwaitWithCancellation.outerKeyAwaiter.IsCompleted)
					{
						OuterSelectCore(joinAwaitWithCancellation);
						return;
					}
					joinAwaitWithCancellation.continueNext = false;
					joinAwaitWithCancellation.outerKeyAwaiter.SourceOnCompleted(OuterSelectCoreDelegate, joinAwaitWithCancellation);
				}
				else
				{
					joinAwaitWithCancellation.continueNext = false;
					joinAwaitWithCancellation.completionSource.TrySetResult(result: false);
				}
			}
			else
			{
				joinAwaitWithCancellation.continueNext = false;
			}
		}

		private static void OuterSelectCore(object state)
		{
			_JoinAwaitWithCancellation joinAwaitWithCancellation = (_JoinAwaitWithCancellation)state;
			if (joinAwaitWithCancellation.TryGetResult(joinAwaitWithCancellation.outerKeyAwaiter, out var result))
			{
				joinAwaitWithCancellation.valueEnumerator = joinAwaitWithCancellation.lookup[result].GetEnumerator();
				if (!joinAwaitWithCancellation.continueNext)
				{
					joinAwaitWithCancellation.SourceMoveNext();
				}
			}
			else
			{
				joinAwaitWithCancellation.continueNext = false;
			}
		}

		private static void ResultSelectCore(object state)
		{
			_JoinAwaitWithCancellation joinAwaitWithCancellation = (_JoinAwaitWithCancellation)state;
			if (joinAwaitWithCancellation.TryGetResult(joinAwaitWithCancellation.resultAwaiter, out var result))
			{
				joinAwaitWithCancellation.Current = result;
				joinAwaitWithCancellation.completionSource.TrySetResult(result: true);
			}
		}

		public UniTask DisposeAsync()
		{
			if (valueEnumerator != null)
			{
				valueEnumerator.Dispose();
			}
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

	private readonly Func<TOuter, TInner, CancellationToken, UniTask<TResult>> resultSelector;

	private readonly IEqualityComparer<TKey> comparer;

	public JoinAwaitWithCancellation(IUniTaskAsyncEnumerable<TOuter> outer, IUniTaskAsyncEnumerable<TInner> inner, Func<TOuter, CancellationToken, UniTask<TKey>> outerKeySelector, Func<TInner, CancellationToken, UniTask<TKey>> innerKeySelector, Func<TOuter, TInner, CancellationToken, UniTask<TResult>> resultSelector, IEqualityComparer<TKey> comparer)
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
		return new _JoinAwaitWithCancellation(outer, inner, outerKeySelector, innerKeySelector, resultSelector, comparer, cancellationToken);
	}
}
