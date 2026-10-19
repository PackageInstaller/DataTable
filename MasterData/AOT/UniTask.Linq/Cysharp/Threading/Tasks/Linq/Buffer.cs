using System;
using System.Collections.Generic;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class Buffer<TSource> : IUniTaskAsyncEnumerable<IList<TSource>>
{
	private sealed class _Buffer : MoveNextSource, IUniTaskAsyncEnumerator<IList<TSource>>, IUniTaskAsyncDisposable
	{
		private static readonly Action<object> MoveNextCoreDelegate = MoveNextCore;

		private readonly IUniTaskAsyncEnumerable<TSource> source;

		private readonly int count;

		private CancellationToken cancellationToken;

		private IUniTaskAsyncEnumerator<TSource> enumerator;

		private UniTask<bool>.Awaiter awaiter;

		private bool continueNext;

		private bool completed;

		private List<TSource> buffer;

		public IList<TSource> Current { get; private set; }

		public _Buffer(IUniTaskAsyncEnumerable<TSource> source, int count, CancellationToken cancellationToken)
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
				buffer = new List<TSource>(count);
			}
			completionSource.Reset();
			SourceMoveNext();
			return new UniTask<bool>(this, completionSource.Version);
		}

		private void SourceMoveNext()
		{
			if (completed)
			{
				if (buffer != null && buffer.Count > 0)
				{
					List<TSource> current = buffer;
					buffer = null;
					Current = current;
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
			_Buffer buffer = (_Buffer)state;
			if (buffer.TryGetResult(buffer.awaiter, out var result))
			{
				if (result)
				{
					buffer.buffer.Add(buffer.enumerator.Current);
					if (buffer.buffer.Count == buffer.count)
					{
						buffer.Current = buffer.buffer;
						buffer.buffer = new List<TSource>(buffer.count);
						buffer.continueNext = false;
						buffer.completionSource.TrySetResult(result: true);
					}
					else if (!buffer.continueNext)
					{
						buffer.SourceMoveNext();
					}
				}
				else
				{
					buffer.continueNext = false;
					buffer.completed = true;
					buffer.SourceMoveNext();
				}
			}
			else
			{
				buffer.continueNext = false;
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

	public Buffer(IUniTaskAsyncEnumerable<TSource> source, int count)
	{
		this.source = source;
		this.count = count;
	}

	public IUniTaskAsyncEnumerator<IList<TSource>> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _Buffer(source, count, cancellationToken);
	}
}
