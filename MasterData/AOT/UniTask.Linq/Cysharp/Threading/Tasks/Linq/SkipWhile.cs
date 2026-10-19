using System;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class SkipWhile<TSource> : IUniTaskAsyncEnumerable<TSource>
{
	private class _SkipWhile : AsyncEnumeratorBase<TSource, TSource>
	{
		private Func<TSource, bool> predicate;

		public _SkipWhile(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, bool> predicate, CancellationToken cancellationToken)
			: base(source, cancellationToken)
		{
			this.predicate = predicate;
		}

		protected override bool TryMoveNextCore(bool sourceHasCurrent, out bool result)
		{
			if (sourceHasCurrent)
			{
				if (predicate == null || !predicate(SourceCurrent))
				{
					predicate = null;
					Current = SourceCurrent;
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

	private readonly Func<TSource, bool> predicate;

	public SkipWhile(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, bool> predicate)
	{
		this.source = source;
		this.predicate = predicate;
	}

	public IUniTaskAsyncEnumerator<TSource> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _SkipWhile(source, predicate, cancellationToken);
	}
}
