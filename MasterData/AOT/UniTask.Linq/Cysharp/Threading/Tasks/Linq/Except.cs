using System;
using System.Collections.Generic;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class Except<TSource> : IUniTaskAsyncEnumerable<TSource>
{
	private class _Except : AsyncEnumeratorBase<TSource, TSource>
	{
		private static Action<object> HashSetAsyncCoreDelegate = HashSetAsyncCore;

		private readonly IEqualityComparer<TSource> comparer;

		private readonly IUniTaskAsyncEnumerable<TSource> second;

		private HashSet<TSource> set;

		private UniTask<HashSet<TSource>>.Awaiter awaiter;

		public _Except(IUniTaskAsyncEnumerable<TSource> first, IUniTaskAsyncEnumerable<TSource> second, IEqualityComparer<TSource> comparer, CancellationToken cancellationToken)
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
			_Except except = (_Except)state;
			if (except.TryGetResult(except.awaiter, out var result))
			{
				except.set = result;
				except.SourceMoveNext();
			}
		}

		protected override bool TryMoveNextCore(bool sourceHasCurrent, out bool result)
		{
			if (sourceHasCurrent)
			{
				TSource sourceCurrent = SourceCurrent;
				if (set.Add(sourceCurrent))
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

	public Except(IUniTaskAsyncEnumerable<TSource> first, IUniTaskAsyncEnumerable<TSource> second, IEqualityComparer<TSource> comparer)
	{
		this.first = first;
		this.second = second;
		this.comparer = comparer;
	}

	public IUniTaskAsyncEnumerator<TSource> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _Except(first, second, comparer, cancellationToken);
	}
}
