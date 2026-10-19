using System;
using System.Collections.Generic;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class Distinct<TSource> : IUniTaskAsyncEnumerable<TSource>
{
	private class _Distinct : AsyncEnumeratorBase<TSource, TSource>
	{
		private readonly HashSet<TSource> set;

		public _Distinct(IUniTaskAsyncEnumerable<TSource> source, IEqualityComparer<TSource> comparer, CancellationToken cancellationToken)
			: base(source, cancellationToken)
		{
			set = new HashSet<TSource>(comparer);
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

	private readonly IUniTaskAsyncEnumerable<TSource> source;

	private readonly IEqualityComparer<TSource> comparer;

	public Distinct(IUniTaskAsyncEnumerable<TSource> source, IEqualityComparer<TSource> comparer)
	{
		this.source = source;
		this.comparer = comparer;
	}

	public IUniTaskAsyncEnumerator<TSource> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _Distinct(source, comparer, cancellationToken);
	}
}
internal sealed class Distinct<TSource, TKey> : IUniTaskAsyncEnumerable<TSource>
{
	private class _Distinct : AsyncEnumeratorBase<TSource, TSource>
	{
		private readonly HashSet<TKey> set;

		private readonly Func<TSource, TKey> keySelector;

		public _Distinct(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, TKey> keySelector, IEqualityComparer<TKey> comparer, CancellationToken cancellationToken)
			: base(source, cancellationToken)
		{
			set = new HashSet<TKey>(comparer);
			this.keySelector = keySelector;
		}

		protected override bool TryMoveNextCore(bool sourceHasCurrent, out bool result)
		{
			if (sourceHasCurrent)
			{
				TSource sourceCurrent = SourceCurrent;
				if (set.Add(keySelector(sourceCurrent)))
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

	private readonly IUniTaskAsyncEnumerable<TSource> source;

	private readonly Func<TSource, TKey> keySelector;

	private readonly IEqualityComparer<TKey> comparer;

	public Distinct(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, TKey> keySelector, IEqualityComparer<TKey> comparer)
	{
		this.source = source;
		this.keySelector = keySelector;
		this.comparer = comparer;
	}

	public IUniTaskAsyncEnumerator<TSource> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _Distinct(source, keySelector, comparer, cancellationToken);
	}
}
