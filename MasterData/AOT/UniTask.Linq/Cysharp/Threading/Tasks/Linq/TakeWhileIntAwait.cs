using System;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class TakeWhileIntAwait<TSource> : IUniTaskAsyncEnumerable<TSource>
{
	private class _TakeWhileIntAwait : AsyncEnumeratorAwaitSelectorBase<TSource, TSource, bool>
	{
		private readonly Func<TSource, int, UniTask<bool>> predicate;

		private int index;

		public _TakeWhileIntAwait(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, int, UniTask<bool>> predicate, CancellationToken cancellationToken)
			: base(source, cancellationToken)
		{
			this.predicate = predicate;
		}

		protected override UniTask<bool> TransformAsync(TSource sourceCurrent)
		{
			return predicate(sourceCurrent, checked(index++));
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

	private readonly Func<TSource, int, UniTask<bool>> predicate;

	public TakeWhileIntAwait(IUniTaskAsyncEnumerable<TSource> source, Func<TSource, int, UniTask<bool>> predicate)
	{
		this.source = source;
		this.predicate = predicate;
	}

	public IUniTaskAsyncEnumerator<TSource> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _TakeWhileIntAwait(source, predicate, cancellationToken);
	}
}
