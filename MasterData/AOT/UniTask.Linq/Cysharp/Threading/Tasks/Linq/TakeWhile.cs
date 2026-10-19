using System;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class TakeWhile<TSource> : IUniTaskAsyncEnumerable<TSource>
{
	private class _TakeWhile : AsyncEnumeratorBase<TSource, TSource>
	{
		private Func<TSource, bool> predicate;

		public _TakeWhile(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, bool> predicate, CancellationToken cancellationToken)
			: base(source, cancellationToken)
		{
			this.predicate = predicate;
		}

		protected override bool TryMoveNextCore(bool sourceHasCurrent, out bool result)
		{
			if (sourceHasCurrent && predicate(SourceCurrent))
			{
				Current = SourceCurrent;
				result = true;
				return true;
			}
			result = false;
			return true;
		}
	}

	private readonly IUniTaskAsyncEnumerable<TSource> source;

	private readonly Func<TSource, bool> predicate;

	public TakeWhile(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, bool> predicate)
	{
		this.source = source;
		this.predicate = predicate;
	}

	public IUniTaskAsyncEnumerator<TSource> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _TakeWhile(source, predicate, cancellationToken);
	}
}
