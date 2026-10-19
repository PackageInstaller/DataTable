using System;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class TakeWhileInt<TSource> : IUniTaskAsyncEnumerable<TSource>
{
	private class _TakeWhileInt : AsyncEnumeratorBase<TSource, TSource>
	{
		private readonly Func<TSource, int, bool> predicate;

		private int index;

		public _TakeWhileInt(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, int, bool> predicate, CancellationToken cancellationToken)
			: base(source, cancellationToken)
		{
			this.predicate = predicate;
		}

		protected override bool TryMoveNextCore(bool sourceHasCurrent, out bool result)
		{
			if (sourceHasCurrent && predicate(SourceCurrent, checked(index++)))
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

	private readonly Func<TSource, int, bool> predicate;

	public TakeWhileInt(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, int, bool> predicate)
	{
		this.source = source;
		this.predicate = predicate;
	}

	public IUniTaskAsyncEnumerator<TSource> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _TakeWhileInt(source, predicate, cancellationToken);
	}
}
