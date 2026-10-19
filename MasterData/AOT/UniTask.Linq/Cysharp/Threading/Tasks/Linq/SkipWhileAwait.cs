using System;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class SkipWhileAwait<TSource> : IUniTaskAsyncEnumerable<TSource>
{
	private class _SkipWhileAwait : AsyncEnumeratorAwaitSelectorBase<TSource, TSource, bool>
	{
		private Func<TSource, UniTask<bool>> predicate;

		public _SkipWhileAwait(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, UniTask<bool>> predicate, CancellationToken cancellationToken)
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
			return predicate(sourceCurrent);
		}

		protected override bool TrySetCurrentCore(bool awaitResult, out bool terminateIteration)
		{
			if (!awaitResult)
			{
				predicate = null;
				Current = SourceCurrent;
				terminateIteration = false;
				return true;
			}
			terminateIteration = false;
			return false;
		}
	}

	private readonly IUniTaskAsyncEnumerable<TSource> source;

	private readonly Func<TSource, UniTask<bool>> predicate;

	public SkipWhileAwait(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, UniTask<bool>> predicate)
	{
		this.source = source;
		this.predicate = predicate;
	}

	public IUniTaskAsyncEnumerator<TSource> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _SkipWhileAwait(source, predicate, cancellationToken);
	}
}
