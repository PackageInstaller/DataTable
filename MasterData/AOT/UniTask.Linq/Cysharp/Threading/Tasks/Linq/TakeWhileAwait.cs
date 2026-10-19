using System;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class TakeWhileAwait<TSource> : IUniTaskAsyncEnumerable<TSource>
{
	private class _TakeWhileAwait : AsyncEnumeratorAwaitSelectorBase<TSource, TSource, bool>
	{
		private Func<TSource, UniTask<bool>> predicate;

		public _TakeWhileAwait(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, UniTask<bool>> predicate, CancellationToken cancellationToken)
			: base(source, cancellationToken)
		{
			this.predicate = predicate;
		}

		protected override UniTask<bool> TransformAsync(TSource sourceCurrent)
		{
			return predicate(sourceCurrent);
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

	private readonly Func<TSource, UniTask<bool>> predicate;

	public TakeWhileAwait(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, UniTask<bool>> predicate)
	{
		this.source = source;
		this.predicate = predicate;
	}

	public IUniTaskAsyncEnumerator<TSource> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _TakeWhileAwait(source, predicate, cancellationToken);
	}
}
