using System;
using System.Collections.Generic;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class TakeLast<TSource> : IUniTaskAsyncEnumerable<TSource>
{
	private sealed class _TakeLast : MoveNextSource, IUniTaskAsyncEnumerator<TSource>, IUniTaskAsyncDisposable
	{
		private static readonly Action<object> MoveNextCoreDelegate = MoveNextCore;

		private readonly IUniTaskAsyncEnumerable<TSource> source;

		private readonly int count;

		private CancellationToken cancellationToken;

		private IUniTaskAsyncEnumerator<TSource> enumerator;

		private UniTask<bool>.Awaiter awaiter;

		private Queue<TSource> queue;

		private bool iterateCompleted;

		private bool continueNext;

		public TSource Current { get; private set; }

		public _TakeLast(IUniTaskAsyncEnumerable<TSource> source, int count, CancellationToken cancellationToken)
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
			if (iterateCompleted)
			{
				if (queue.Count > 0)
				{
					Current = queue.Dequeue();
					completionSource.TrySetResult(result: true);
				}
				else
				{
					completionSource.TrySetResult(result: false);
				}
				return;
			}
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
			_TakeLast takeLast = (_TakeLast)state;
			if (takeLast.TryGetResult(takeLast.awaiter, out var result))
			{
				if (result)
				{
					if (takeLast.queue.Count < takeLast.count)
					{
						takeLast.queue.Enqueue(takeLast.enumerator.Current);
						if (!takeLast.continueNext)
						{
							takeLast.SourceMoveNext();
						}
						return;
					}
					takeLast.queue.Dequeue();
					takeLast.queue.Enqueue(takeLast.enumerator.Current);
					if (!takeLast.continueNext)
					{
						takeLast.SourceMoveNext();
					}
				}
				else
				{
					takeLast.continueNext = false;
					takeLast.iterateCompleted = true;
					takeLast.SourceMoveNext();
				}
			}
			else
			{
				takeLast.continueNext = false;
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

	public TakeLast(IUniTaskAsyncEnumerable<TSource> source, int count)
	{
		this.source = source;
		this.count = count;
	}

	public IUniTaskAsyncEnumerator<TSource> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _TakeLast(source, count, cancellationToken);
	}
}
