using System;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class ZipAwaitWithCancellation<TFirst, TSecond, TResult> : IUniTaskAsyncEnumerable<TResult>
{
	private sealed class _ZipAwaitWithCancellation : MoveNextSource, IUniTaskAsyncEnumerator<TResult>, IUniTaskAsyncDisposable
	{
		private static readonly Action<object> firstMoveNextCoreDelegate = FirstMoveNextCore;

		private static readonly Action<object> secondMoveNextCoreDelegate = SecondMoveNextCore;

		private static readonly Action<object> resultAwaitCoreDelegate = ResultAwaitCore;

		private readonly IUniTaskAsyncEnumerable<TFirst> first;

		private readonly IUniTaskAsyncEnumerable<TSecond> second;

		private readonly Func<TFirst, TSecond, CancellationToken, UniTask<TResult>> resultSelector;

		private CancellationToken cancellationToken;

		private IUniTaskAsyncEnumerator<TFirst> firstEnumerator;

		private IUniTaskAsyncEnumerator<TSecond> secondEnumerator;

		private UniTask<bool>.Awaiter firstAwaiter;

		private UniTask<bool>.Awaiter secondAwaiter;

		private UniTask<TResult>.Awaiter resultAwaiter;

		public TResult Current { get; private set; }

		public _ZipAwaitWithCancellation(IUniTaskAsyncEnumerable<TFirst> first, IUniTaskAsyncEnumerable<TSecond> second, Func<TFirst, TSecond, CancellationToken, UniTask<TResult>> resultSelector, CancellationToken cancellationToken)
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
			_ZipAwaitWithCancellation zipAwaitWithCancellation = (_ZipAwaitWithCancellation)state;
			if (!zipAwaitWithCancellation.TryGetResult(zipAwaitWithCancellation.firstAwaiter, out var result))
			{
				return;
			}
			if (result)
			{
				try
				{
					zipAwaitWithCancellation.secondAwaiter = zipAwaitWithCancellation.secondEnumerator.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error)
				{
					zipAwaitWithCancellation.completionSource.TrySetException(error);
					return;
				}
				if (zipAwaitWithCancellation.secondAwaiter.IsCompleted)
				{
					SecondMoveNextCore(zipAwaitWithCancellation);
				}
				else
				{
					zipAwaitWithCancellation.secondAwaiter.SourceOnCompleted(secondMoveNextCoreDelegate, zipAwaitWithCancellation);
				}
			}
			else
			{
				zipAwaitWithCancellation.completionSource.TrySetResult(result: false);
			}
		}

		private static void SecondMoveNextCore(object state)
		{
			_ZipAwaitWithCancellation zipAwaitWithCancellation = (_ZipAwaitWithCancellation)state;
			if (!zipAwaitWithCancellation.TryGetResult(zipAwaitWithCancellation.secondAwaiter, out var result))
			{
				return;
			}
			if (result)
			{
				try
				{
					zipAwaitWithCancellation.resultAwaiter = zipAwaitWithCancellation.resultSelector(zipAwaitWithCancellation.firstEnumerator.Current, zipAwaitWithCancellation.secondEnumerator.Current, zipAwaitWithCancellation.cancellationToken).GetAwaiter();
					if (zipAwaitWithCancellation.resultAwaiter.IsCompleted)
					{
						ResultAwaitCore(zipAwaitWithCancellation);
					}
					else
					{
						zipAwaitWithCancellation.resultAwaiter.SourceOnCompleted(resultAwaitCoreDelegate, zipAwaitWithCancellation);
					}
					return;
				}
				catch (Exception error)
				{
					zipAwaitWithCancellation.completionSource.TrySetException(error);
					return;
				}
			}
			zipAwaitWithCancellation.completionSource.TrySetResult(result: false);
		}

		private static void ResultAwaitCore(object state)
		{
			_ZipAwaitWithCancellation zipAwaitWithCancellation = (_ZipAwaitWithCancellation)state;
			if (zipAwaitWithCancellation.TryGetResult(zipAwaitWithCancellation.resultAwaiter, out var result))
			{
				zipAwaitWithCancellation.Current = result;
				if (zipAwaitWithCancellation.cancellationToken.IsCancellationRequested)
				{
					zipAwaitWithCancellation.completionSource.TrySetCanceled(zipAwaitWithCancellation.cancellationToken);
				}
				else
				{
					zipAwaitWithCancellation.completionSource.TrySetResult(result: true);
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

	private readonly Func<TFirst, TSecond, CancellationToken, UniTask<TResult>> resultSelector;

	public ZipAwaitWithCancellation(IUniTaskAsyncEnumerable<TFirst> first, IUniTaskAsyncEnumerable<TSecond> second, Func<TFirst, TSecond, CancellationToken, UniTask<TResult>> resultSelector)
	{
		this.first = first;
		this.second = second;
		this.resultSelector = resultSelector;
	}

	public IUniTaskAsyncEnumerator<TResult> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _ZipAwaitWithCancellation(first, second, resultSelector, cancellationToken);
	}
}
