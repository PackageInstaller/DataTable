using System;
using System.Collections.Generic;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class DistinctAwaitWithCancellation<TSource, TKey> : IUniTaskAsyncEnumerable<TSource>
{
	private class _DistinctAwaitWithCancellation : AsyncEnumeratorAwaitSelectorBase<TSource, TSource, TKey>
	{
		private readonly HashSet<TKey> set;

		private readonly Func<TSource, CancellationToken, UniTask<TKey>> keySelector;

		public _DistinctAwaitWithCancellation(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, CancellationToken, UniTask<TKey>> keySelector, IEqualityComparer<TKey> comparer, CancellationToken cancellationToken)
			: base(source, cancellationToken)
		{
			set = new HashSet<TKey>(comparer);
			this.keySelector = keySelector;
		}

		protected override UniTask<TKey> TransformAsync(TSource sourceCurrent)
		{
			return keySelector(sourceCurrent, cancellationToken);
		}

		protected override bool TrySetCurrentCore(TKey awaitResult, out bool terminateIteration)
		{
			if (set.Add(awaitResult))
			{
				Current = SourceCurrent;
				terminateIteration = false;
				return true;
			}
			terminateIteration = false;
			return false;
		}
	}

	private readonly IUniTaskAsyncEnumerable<TSource> source;

	private readonly Func<TSource, CancellationToken, UniTask<TKey>> keySelector;

	private readonly IEqualityComparer<TKey> comparer;

	public DistinctAwaitWithCancellation(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, CancellationToken, UniTask<TKey>> keySelector, IEqualityComparer<TKey> comparer)
	{
		this.source = source;
		this.keySelector = keySelector;
		this.comparer = comparer;
	}

	public IUniTaskAsyncEnumerator<TSource> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _DistinctAwaitWithCancellation(source, keySelector, comparer, cancellationToken);
	}
}
