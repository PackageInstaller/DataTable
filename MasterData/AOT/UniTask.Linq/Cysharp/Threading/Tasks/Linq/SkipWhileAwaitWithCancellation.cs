using System;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class SkipWhileAwaitWithCancellation<TSource> : IUniTaskAsyncEnumerable<TSource>
{
	private class _SkipWhileAwaitWithCancellation : AsyncEnumeratorAwaitSelectorBase<TSource, TSource, bool>
	{
		private Func<TSource, CancellationToken, UniTask<bool>> predicate;

		public _SkipWhileAwaitWithCancellation(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, CancellationToken, UniTask<bool>> predicate, CancellationToken cancellationToken)
			: base(source, cancellationToken)
		{
			this.predicate = predicate;
		}

		protected override UniTask<bool> TransformAsync(TSource sourceCurrent)
		{
			if (predicate == null)
			{
				return CompletedTasks.False;
			}
			return predicate(sourceCurrent, cancellationToken);
		}

		protected override bool TrySetCurrentCore(bool awaitResult, out bool terminateIteration)
		{
			terminateIteration = false;
			if (!awaitResult)
			{
				predicate = null;
				Current = SourceCurrent;
				return true;
			}
			return false;
		}
	}

	private readonly IUniTaskAsyncEnumerable<TSource> source;

	private readonly Func<TSource, CancellationToken, UniTask<bool>> predicate;

	public SkipWhileAwaitWithCancellation(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, CancellationToken, UniTask<bool>> predicate)
	{
		this.source = source;
		this.predicate = predicate;
	}

	public IUniTaskAsyncEnumerator<TSource> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _SkipWhileAwaitWithCancellation(source, predicate, cancellationToken);
	}
}
