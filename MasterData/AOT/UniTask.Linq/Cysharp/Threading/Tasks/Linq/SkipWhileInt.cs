using System;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class SkipWhileInt<TSource> : IUniTaskAsyncEnumerable<TSource>
{
	private class _SkipWhileInt : AsyncEnumeratorBase<TSource, TSource>
	{
		private Func<TSource, int, bool> predicate;

		private int index;

		public _SkipWhileInt(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, int, bool> predicate, CancellationToken cancellationToken)
			: base(source, cancellationToken)
		{
			this.predicate = predicate;
		}

		protected override bool TryMoveNextCore(bool sourceHasCurrent, out bool result)
		{
			if (sourceHasCurrent)
			{
				if (predicate == null || !predicate(SourceCurrent, checked(index++)))
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

	private readonly Func<TSource, int, bool> predicate;

	public SkipWhileInt(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, int, bool> predicate)
	{
		this.source = source;
		this.predicate = predicate;
	}

	public IUniTaskAsyncEnumerator<TSource> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _SkipWhileInt(source, predicate, cancellationToken);
	}
}
