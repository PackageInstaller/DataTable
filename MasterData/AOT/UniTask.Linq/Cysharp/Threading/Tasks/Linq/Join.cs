using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class Join<TOuter, TInner, TKey, TResult> : IUniTaskAsyncEnumerable<TResult>
{
	private sealed class _Join : MoveNextSource, IUniTaskAsyncEnumerator<TResult>, IUniTaskAsyncDisposable
	{
		private static readonly Action<object> MoveNextCoreDelegate = MoveNextCore;

		private readonly IUniTaskAsyncEnumerable<TOuter> outer;

		private readonly IUniTaskAsyncEnumerable<TInner> inner;

		private readonly Func<TOuter, TKey> outerKeySelector;

		private readonly Func<TInner, TKey> innerKeySelector;

		private readonly Func<TOuter, TInner, TResult> resultSelector;

		private readonly IEqualityComparer<TKey> comparer;

		private CancellationToken cancellationToken;

		private ILookup<TKey, TInner> lookup;

		private IUniTaskAsyncEnumerator<TOuter> enumerator;

		private UniTask<bool>.Awaiter awaiter;

		private TOuter currentOuterValue;

		private IEnumerator<TInner> valueEnumerator;

		private bool continueNext;

		public TResult Current { get; private set; }

		public _Join(IUniTaskAsyncEnumerable<TOuter> outer, IUniTaskAsyncEnumerable<TInner> inner, Func<TOuter, TKey> outerKeySelector, Func<TInner, TKey> innerKeySelector, Func<TOuter, TInner, TResult> resultSelector, IEqualityComparer<TKey> comparer, CancellationToken cancellationToken)
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
				while (true)
				{
					if (valueEnumerator != null)
					{
						if (valueEnumerator.MoveNext())
						{
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
						return;
					}
					awaiter.SourceOnCompleted(MoveNextCoreDelegate, this);
					return;
				}
				Current = resultSelector(currentOuterValue, valueEnumerator.Current);
			}
			catch (Exception error)
			{
				completionSource.TrySetException(error);
				return;
			}
			completionSource.TrySetResult(result: true);
		}

		private static void MoveNextCore(object state)
		{
			_Join obj = (_Join)state;
			if (obj.TryGetResult(obj.awaiter, out var result))
			{
				if (result)
				{
					obj.currentOuterValue = obj.enumerator.Current;
					TKey key = obj.outerKeySelector(obj.currentOuterValue);
					obj.valueEnumerator = obj.lookup[key].GetEnumerator();
					if (!obj.continueNext)
					{
						obj.SourceMoveNext();
					}
				}
				else
				{
					obj.continueNext = false;
					obj.completionSource.TrySetResult(result: false);
				}
			}
			else
			{
				obj.continueNext = false;
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

	private readonly Func<TOuter, TKey> outerKeySelector;

	private readonly Func<TInner, TKey> innerKeySelector;

	private readonly Func<TOuter, TInner, TResult> resultSelector;

	private readonly IEqualityComparer<TKey> comparer;

	public Join(IUniTaskAsyncEnumerable<TOuter> outer, IUniTaskAsyncEnumerable<TInner> inner, Func<TOuter, TKey> outerKeySelector, Func<TInner, TKey> innerKeySelector, Func<TOuter, TInner, TResult> resultSelector, IEqualityComparer<TKey> comparer)
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
		return new _Join(outer, inner, outerKeySelector, innerKeySelector, resultSelector, comparer, cancellationToken);
	}
}
