using System;
using System.Collections.Generic;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class BufferSkip<TSource> : IUniTaskAsyncEnumerable<IList<TSource>>
{
	private sealed class _BufferSkip : MoveNextSource, IUniTaskAsyncEnumerator<IList<TSource>>, IUniTaskAsyncDisposable
	{
		private static readonly Action<object> MoveNextCoreDelegate = MoveNextCore;

		private readonly IUniTaskAsyncEnumerable<TSource> source;

		private readonly int count;

		private readonly int skip;

		private CancellationToken cancellationToken;

		private IUniTaskAsyncEnumerator<TSource> enumerator;

		private UniTask<bool>.Awaiter awaiter;

		private bool continueNext;

		private bool completed;

		private Queue<List<TSource>> buffers;

		private int index;

		public IList<TSource> Current { get; private set; }

		public _BufferSkip(IUniTaskAsyncEnumerable<TSource> source, int count, int skip, CancellationToken cancellationToken)
		{
			this.source = source;
			this.count = count;
			this.skip = skip;
			this.cancellationToken = cancellationToken;
		}

		public UniTask<bool> MoveNextAsync()
		{
			cancellationToken.ThrowIfCancellationRequested();
			if (enumerator == null)
			{
				enumerator = source.GetAsyncEnumerator(cancellationToken);
				buffers = new Queue<List<TSource>>();
			}
			completionSource.Reset();
			SourceMoveNext();
			return new UniTask<bool>(this, completionSource.Version);
		}

		private void SourceMoveNext()
		{
			if (completed)
			{
				if (buffers.Count > 0)
				{
					Current = buffers.Dequeue();
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
			_BufferSkip bufferSkip = (_BufferSkip)state;
			if (bufferSkip.TryGetResult(bufferSkip.awaiter, out var result))
			{
				if (result)
				{
					if (bufferSkip.index++ % bufferSkip.skip == 0)
					{
						bufferSkip.buffers.Enqueue(new List<TSource>(bufferSkip.count));
					}
					TSource current = bufferSkip.enumerator.Current;
					foreach (List<TSource> buffer in bufferSkip.buffers)
					{
						buffer.Add(current);
					}
					if (bufferSkip.buffers.Count > 0 && bufferSkip.buffers.Peek().Count == bufferSkip.count)
					{
						bufferSkip.Current = bufferSkip.buffers.Dequeue();
						bufferSkip.continueNext = false;
						bufferSkip.completionSource.TrySetResult(result: true);
					}
					else if (!bufferSkip.continueNext)
					{
						bufferSkip.SourceMoveNext();
					}
				}
				else
				{
					bufferSkip.continueNext = false;
					bufferSkip.completed = true;
					bufferSkip.SourceMoveNext();
				}
			}
			else
			{
				bufferSkip.continueNext = false;
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

	private readonly int skip;

	public BufferSkip(IUniTaskAsyncEnumerable<TSource> source, int count, int skip)
	{
		this.source = source;
		this.count = count;
		this.skip = skip;
	}

	public IUniTaskAsyncEnumerator<IList<TSource>> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _BufferSkip(source, count, skip, cancellationToken);
	}
}
