using System;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class Take<TSource> : IUniTaskAsyncEnumerable<TSource>
{
	private sealed class _Take : MoveNextSource, IUniTaskAsyncEnumerator<TSource>, IUniTaskAsyncDisposable
	{
		private static readonly Action<object> MoveNextCoreDelegate = MoveNextCore;

		private readonly IUniTaskAsyncEnumerable<TSource> source;

		private readonly int count;

		private CancellationToken cancellationToken;

		private IUniTaskAsyncEnumerator<TSource> enumerator;

		private UniTask<bool>.Awaiter awaiter;

		private int index;

		public TSource Current { get; private set; }

		public _Take(IUniTaskAsyncEnumerable<TSource> source, int count, CancellationToken cancellationToken)
		{
			this.source = source;
			this.count = count;
			this.cancellationToken = cancellationToken;
		}

		public UniTask<bool> MoveNextAsync()
		{
			cancellationToken.ThrowIfCancellationRequested();
			if (enumerator == null)
			{
				enumerator = source.GetAsyncEnumerator(cancellationToken);
			}
			if (index >= count)
			{
				return CompletedTasks.False;
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
			_Take take = (_Take)state;
			if (take.TryGetResult(take.awaiter, out var result))
			{
				if (result)
				{
					take.index++;
					take.Current = take.enumerator.Current;
					take.completionSource.TrySetResult(result: true);
				}
				else
				{
					take.completionSource.TrySetResult(result: false);
				}
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

	private readonly int count;

	public Take(IUniTaskAsyncEnumerable<TSource> source, int count)
	{
		this.source = source;
		this.count = count;
	}

	public IUniTaskAsyncEnumerator<TSource> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _Take(source, count, cancellationToken);
	}
}
