using System;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class ZipAwait<TFirst, TSecond, TResult> : IUniTaskAsyncEnumerable<TResult>
{
	private sealed class _ZipAwait : MoveNextSource, IUniTaskAsyncEnumerator<TResult>, IUniTaskAsyncDisposable
	{
		private static readonly Action<object> firstMoveNextCoreDelegate = FirstMoveNextCore;

		private static readonly Action<object> secondMoveNextCoreDelegate = SecondMoveNextCore;

		private static readonly Action<object> resultAwaitCoreDelegate = ResultAwaitCore;

		private readonly IUniTaskAsyncEnumerable<TFirst> first;

		private readonly IUniTaskAsyncEnumerable<TSecond> second;

		private readonly Func<TFirst, TSecond, UniTask<TResult>> resultSelector;

		private CancellationToken cancellationToken;

		private IUniTaskAsyncEnumerator<TFirst> firstEnumerator;

		private IUniTaskAsyncEnumerator<TSecond> secondEnumerator;

		private UniTask<bool>.Awaiter firstAwaiter;

		private UniTask<bool>.Awaiter secondAwaiter;

		private UniTask<TResult>.Awaiter resultAwaiter;

		public TResult Current { get; private set; }

		public _ZipAwait(IUniTaskAsyncEnumerable<TFirst> first, IUniTaskAsyncEnumerable<TSecond> second, Func<TFirst, TSecond, UniTask<TResult>> resultSelector, CancellationToken cancellationToken)
		{
			this.first = first;
			this.second = second;
			this.resultSelector = resultSelector;
			this.cancellationToken = cancellationToken;
		}

		public UniTask<bool> MoveNextAsync()
		{
			completionSource.Reset();
			if (firstEnumerator == null)
			{
				firstEnumerator = first.GetAsyncEnumerator(cancellationToken);
				secondEnumerator = second.GetAsyncEnumerator(cancellationToken);
			}
			firstAwaiter = firstEnumerator.MoveNextAsync().GetAwaiter();
			if (firstAwaiter.IsCompleted)
			{
				FirstMoveNextCore(this);
			}
			else
			{
				firstAwaiter.SourceOnCompleted(firstMoveNextCoreDelegate, this);
			}
			return new UniTask<bool>(this, completionSource.Version);
		}

		private static void FirstMoveNextCore(object state)
		{
			_ZipAwait zipAwait = (_ZipAwait)state;
			if (!zipAwait.TryGetResult(zipAwait.firstAwaiter, out var result))
			{
				return;
			}
			if (result)
			{
				try
				{
					zipAwait.secondAwaiter = zipAwait.secondEnumerator.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error)
				{
					zipAwait.completionSource.TrySetException(error);
					return;
				}
				if (zipAwait.secondAwaiter.IsCompleted)
				{
					SecondMoveNextCore(zipAwait);
				}
				else
				{
					zipAwait.secondAwaiter.SourceOnCompleted(secondMoveNextCoreDelegate, zipAwait);
				}
			}
			else
			{
				zipAwait.completionSource.TrySetResult(result: false);
			}
		}

		private static void SecondMoveNextCore(object state)
		{
			_ZipAwait zipAwait = (_ZipAwait)state;
			if (!zipAwait.TryGetResult(zipAwait.secondAwaiter, out var result))
			{
				return;
			}
			if (result)
			{
				try
				{
					zipAwait.resultAwaiter = zipAwait.resultSelector(zipAwait.firstEnumerator.Current, zipAwait.secondEnumerator.Current).GetAwaiter();
					if (zipAwait.resultAwaiter.IsCompleted)
					{
						ResultAwaitCore(zipAwait);
					}
					else
					{
						zipAwait.resultAwaiter.SourceOnCompleted(resultAwaitCoreDelegate, zipAwait);
					}
					return;
				}
				catch (Exception error)
				{
					zipAwait.completionSource.TrySetException(error);
					return;
				}
			}
			zipAwait.completionSource.TrySetResult(result: false);
		}

		private static void ResultAwaitCore(object state)
		{
			_ZipAwait zipAwait = (_ZipAwait)state;
			if (zipAwait.TryGetResult(zipAwait.resultAwaiter, out var result))
			{
				zipAwait.Current = result;
				if (zipAwait.cancellationToken.IsCancellationRequested)
				{
					zipAwait.completionSource.TrySetCanceled(zipAwait.cancellationToken);
				}
				else
				{
					zipAwait.completionSource.TrySetResult(result: true);
				}
			}
		}

		public async UniTask DisposeAsync()
		{
			if (firstEnumerator != null)
			{
				await firstEnumerator.DisposeAsync();
			}
			if (secondEnumerator != null)
			{
				await secondEnumerator.DisposeAsync();
			}
		}
	}

	private readonly IUniTaskAsyncEnumerable<TFirst> first;

	private readonly IUniTaskAsyncEnumerable<TSecond> second;

	private readonly Func<TFirst, TSecond, UniTask<TResult>> resultSelector;

	public ZipAwait(IUniTaskAsyncEnumerable<TFirst> first, IUniTaskAsyncEnumerable<TSecond> second, Func<TFirst, TSecond, UniTask<TResult>> resultSelector)
	{
		this.first = first;
		this.second = second;
		this.resultSelector = resultSelector;
	}

	public IUniTaskAsyncEnumerator<TResult> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _ZipAwait(first, second, resultSelector, cancellationToken);
	}
}
