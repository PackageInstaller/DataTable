using System;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class TakeWhileIntAwaitWithCancellation<TSource> : IUniTaskAsyncEnumerable<TSource>
{
	private class _TakeWhileIntAwaitWithCancellation : AsyncEnumeratorAwaitSelectorBase<TSource, TSource, bool>
	{
		private readonly Func<TSource, int, CancellationToken, UniTask<bool>> predicate;

		private int index;

		public _TakeWhileIntAwaitWithCancellation(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, int, CancellationToken, UniTask<bool>> predicate, CancellationToken cancellationToken)
			: base(source, cancellationToken)
		{
			this.predicate = predicate;
		}

		protected override UniTask<bool> TransformAsync(TSource sourceCurrent)
		{
			return predicate(sourceCurrent, checked(index++), cancellationToken);
		}

		protected override bool TrySetCurrentCore(bool awaitResult, out bool terminateIteration)
		{
			if (awaitResult)
			{
				Current = SourceCurrent;
				terminateIteration = false;
				return true;
			}
			terminateIteration = true;
			return false;
		}
	}

	private readonly IUniTaskAsyncEnumerable<TSource> source;

	private readonly Func<TSource, int, CancellationToken, UniTask<bool>> predicate;

	public TakeWhileIntAwaitWithCancellation(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, int, CancellationToken, UniTask<bool>> predicate)
	{
		this.source = source;
		this.predicate = predicate;
	}

	public IUniTaskAsyncEnumerator<TSource> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _TakeWhileIntAwaitWithCancellation(source, predicate, cancellationToken);
	}
}
