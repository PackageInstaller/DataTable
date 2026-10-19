using System;
using System.Collections.Generic;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class SkipLast<TSource> : IUniTaskAsyncEnumerable<TSource>
{
	private sealed class _SkipLast : MoveNextSource, IUniTaskAsyncEnumerator<TSource>, IUniTaskAsyncDisposable
	{
		private static readonly Action<object> MoveNextCoreDelegate = MoveNextCore;

		private readonly IUniTaskAsyncEnumerable<TSource> source;

		private readonly int count;

		private CancellationToken cancellationToken;

		private IUniTaskAsyncEnumerator<TSource> enumerator;

		private UniTask<bool>.Awaiter awaiter;

		private Queue<TSource> queue;

		private bool continueNext;

		public TSource Current { get; private set; }

		public _SkipLast(IUniTaskAsyncEnumerable<TSource> source, int count, CancellationToken cancellationToken)
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
				queue = new Queue<TSource>();
			}
			completionSource.Reset();
			SourceMoveNext();
			return new UniTask<bool>(this, completionSource.Version);
		}

		private void SourceMoveNext()
		{
			try
			{
				while (true)
				{
					awaiter = enumerator.MoveNextAsync().GetAwaiter();
					if (awaiter.IsCompleted)
					{
						continueNext = true;
						MoveNextCore(this);
						if (continueNext)
						{
							continueNext = false;
							continue;
						}
						break;
					}
					awaiter.SourceOnCompleted(MoveNextCoreDelegate, this);
					break;
				}
			}
			catch (Exception error)
			{
				completionSource.TrySetException(error);
			}
		}

		private static void MoveNextCore(object state)
		{
			_SkipLast skipLast = (_SkipLast)state;
			if (skipLast.TryGetResult(skipLast.awaiter, out var result))
			{
				if (result)
				{
					if (skipLast.queue.Count == skipLast.count)
					{
						skipLast.continueNext = false;
						TSource current = skipLast.queue.Dequeue();
						skipLast.Current = current;
						skipLast.queue.Enqueue(skipLast.enumerator.Current);
						skipLast.completionSource.TrySetResult(result: true);
					}
					else
					{
						skipLast.queue.Enqueue(skipLast.enumerator.Current);
						if (!skipLast.continueNext)
						{
							skipLast.SourceMoveNext();
						}
					}
				}
				else
				{
					skipLast.continueNext = false;
					skipLast.completionSource.TrySetResult(result: false);
				}
			}
			else
			{
				skipLast.continueNext = false;
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

	public SkipLast(IUniTaskAsyncEnumerable<TSource> source, int count)
	{
		this.source = source;
		this.count = count;
	}

	public IUniTaskAsyncEnumerator<TSource> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _SkipLast(source, count, cancellationToken);
	}
}
