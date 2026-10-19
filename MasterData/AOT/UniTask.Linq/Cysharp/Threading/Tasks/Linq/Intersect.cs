using System;
using System.Collections.Generic;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class Intersect<TSource> : IUniTaskAsyncEnumerable<TSource>
{
	private class _Intersect : AsyncEnumeratorBase<TSource, TSource>
	{
		private static Action<object> HashSetAsyncCoreDelegate = HashSetAsyncCore;

		private readonly IEqualityComparer<TSource> comparer;

		private readonly IUniTaskAsyncEnumerable<TSource> second;

		private HashSet<TSource> set;

		private UniTask<HashSet<TSource>>.Awaiter awaiter;

		public _Intersect(IUniTaskAsyncEnumerable<TSource> first, IUniTaskAsyncEnumerable<TSource> second, IEqualityComparer<TSource> comparer, CancellationToken cancellationToken)
			: base(first, cancellationToken)
		{
			this.second = second;
			this.comparer = comparer;
		}

		protected override bool OnFirstIteration()
		{
			if (set != null)
			{
				return false;
			}
			awaiter = second.ToHashSetAsync(cancellationToken).GetAwaiter();
			if (awaiter.IsCompleted)
			{
				set = awaiter.GetResult();
				SourceMoveNext();
			}
			else
			{
				awaiter.SourceOnCompleted(HashSetAsyncCoreDelegate, this);
			}
			return true;
		}

		private static void HashSetAsyncCore(object state)
		{
			_Intersect intersect = (_Intersect)state;
			if (intersect.TryGetResult(intersect.awaiter, out var result))
			{
				intersect.set = result;
				intersect.SourceMoveNext();
			}
		}

		protected override bool TryMoveNextCore(bool sourceHasCurrent, out bool result)
		{
			if (sourceHasCurrent)
			{
				TSource sourceCurrent = SourceCurrent;
				if (set.Remove(sourceCurrent))
				{
					Current = sourceCurrent;
					result = true;
					return true;
				}
				result = false;
				return false;
			}
			result = false;
			return true;
		}
	}

	private readonly IUniTaskAsyncEnumerable<TSource> first;

	private readonly IUniTaskAsyncEnumerable<TSource> second;

	private readonly IEqualityComparer<TSource> comparer;

	public Intersect(IUniTaskAsyncEnumerable<TSource> first, IUniTaskAsyncEnumerable<TSource> second, IEqualityComparer<TSource> comparer)
	{
		this.first = first;
		this.second = second;
		this.comparer = comparer;
	}

	public IUniTaskAsyncEnumerator<TSource> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _Intersect(first, second, comparer, cancellationToken);
	}
}
