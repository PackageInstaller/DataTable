using System;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class TakeWhileAwaitWithCancellation<TSource> : IUniTaskAsyncEnumerable<TSource>
{
	private class _TakeWhileAwaitWithCancellation : AsyncEnumeratorAwaitSelectorBase<TSource, TSource, bool>
	{
		private Func<TSource, CancellationToken, UniTask<bool>> predicate;

		public _TakeWhileAwaitWithCancellation(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, CancellationToken, UniTask<bool>> predicate, CancellationToken cancellationToken)
			: base(source, cancellationToken)
		{
			this.predicate = predicate;
		}

		protected override UniTask<bool> TransformAsync(TSource sourceCurrent)
		{
			return predicate(sourceCurrent, cancellationToken);
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

	private readonly Func<TSource, CancellationToken, UniTask<bool>> predicate;

	public TakeWhileAwaitWithCancellation(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, CancellationToken, UniTask<bool>> predicate)
	{
		this.source = source;
		this.predicate = predicate;
	}

	public IUniTaskAsyncEnumerator<TSource> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _TakeWhileAwaitWithCancellation(source, predicate, cancellationToken);
	}
}
