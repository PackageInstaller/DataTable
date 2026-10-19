using System;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class Pairwise<TSource> : IUniTaskAsyncEnumerable<(TSource, TSource)>
{
	private sealed class _Pairwise : MoveNextSource, IUniTaskAsyncEnumerator<(TSource, TSource)>, IUniTaskAsyncDisposable
	{
		private static readonly Action<object> MoveNextCoreDelegate = MoveNextCore;

		private readonly IUniTaskAsyncEnumerable<TSource> source;

		private CancellationToken cancellationToken;

		private IUniTaskAsyncEnumerator<TSource> enumerator;

		private UniTask<bool>.Awaiter awaiter;

		private TSource prev;

		private bool isFirst;

		public (TSource, TSource) Current { get; private set; }

		public _Pairwise(IUniTaskAsyncEnumerable<TSource> source, CancellationToken cancellationToken)
		{
			this.source = source;
			this.cancellationToken = cancellationToken;
		}

		public UniTask<bool> MoveNextAsync()
		{
			cancellationToken.ThrowIfCancellationRequested();
			if (enumerator == null)
			{
				isFirst = true;
				enumerator = source.GetAsyncEnumerator(cancellationToken);
			}
			completionSource.Reset();
			SourceMoveNext();
			return new UniTask<bool>(this, completionSource.Version);
		}

		private void SourceMoveNext()
		{
			try
			{
				awaiter = enumerator.MoveNextAsync().GetAwaiter();
				if (awaiter.IsCompleted)
				{
					MoveNextCore(this);
				}
				else
				{
					awaiter.SourceOnCompleted(MoveNextCoreDelegate, this);
				}
			}
			catch (Exception error)
			{
				completionSource.TrySetException(error);
			}
		}

		private static void MoveNextCore(object state)
		{
			_Pairwise pairwise = (_Pairwise)state;
			if (!pairwise.TryGetResult(pairwise.awaiter, out var result))
			{
				return;
			}
			if (result)
			{
				if (pairwise.isFirst)
				{
					pairwise.isFirst = false;
					pairwise.prev = pairwise.enumerator.Current;
					pairwise.SourceMoveNext();
				}
				else
				{
					TSource item = pairwise.prev;
					pairwise.prev = pairwise.enumerator.Current;
					pairwise.Current = (item, pairwise.prev);
					pairwise.completionSource.TrySetResult(result: true);
				}
			}
			else
			{
				pairwise.completionSource.TrySetResult(result: false);
			}
		}

		public UniTask DisposeAsync()
		{
			if (enumerator != null)
			{
				return enumerator.DisposeAsync();
			}
			return default;
		}
	}

	private readonly IUniTaskAsyncEnumerable<TSource> source;

	public Pairwise(IUniTaskAsyncEnumerable<TSource> source)
	{
		this.source = source;
	}

	public IUniTaskAsyncEnumerator<(TSource, TSource)> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _Pairwise(source, cancellationToken);
	}
}
