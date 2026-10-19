using System;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class Zip<TFirst, TSecond, TResult> : IUniTaskAsyncEnumerable<TResult>
{
	private sealed class _Zip : MoveNextSource, IUniTaskAsyncEnumerator<TResult>, IUniTaskAsyncDisposable
	{
		private static readonly Action<object> firstMoveNextCoreDelegate = FirstMoveNextCore;

		private static readonly Action<object> secondMoveNextCoreDelegate = SecondMoveNextCore;

		private readonly IUniTaskAsyncEnumerable<TFirst> first;

		private readonly IUniTaskAsyncEnumerable<TSecond> second;

		private readonly Func<TFirst, TSecond, TResult> resultSelector;

		private CancellationToken cancellationToken;

		private IUniTaskAsyncEnumerator<TFirst> firstEnumerator;

		private IUniTaskAsyncEnumerator<TSecond> secondEnumerator;

		private UniTask<bool>.Awaiter firstAwaiter;

		private UniTask<bool>.Awaiter secondAwaiter;

		public TResult Current { get; private set; }

		public _Zip(IUniTaskAsyncEnumerable<TFirst> first, IUniTaskAsyncEnumerable<TSecond> second, Func<TFirst, TSecond, TResult> resultSelector, CancellationToken cancellationToken)
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
			_Zip zip = (_Zip)state;
			if (!zip.TryGetResult(zip.firstAwaiter, out var result))
			{
				return;
			}
			if (result)
			{
				try
				{
					zip.secondAwaiter = zip.secondEnumerator.MoveNextAsync().GetAwaiter();
				}
				catch (Exception error)
				{
					zip.completionSource.TrySetException(error);
					return;
				}
				if (zip.secondAwaiter.IsCompleted)
				{
					SecondMoveNextCore(zip);
				}
				else
				{
					zip.secondAwaiter.SourceOnCompleted(secondMoveNextCoreDelegate, zip);
				}
			}
			else
			{
				zip.completionSource.TrySetResult(result: false);
			}
		}

		private static void SecondMoveNextCore(object state)
		{
			_Zip zip = (_Zip)state;
			if (!zip.TryGetResult(zip.secondAwaiter, out var result))
			{
				return;
			}
			if (result)
			{
				try
				{
					zip.Current = zip.resultSelector(zip.firstEnumerator.Current, zip.secondEnumerator.Current);
				}
				catch (Exception error)
				{
					zip.completionSource.TrySetException(error);
				}
				if (zip.cancellationToken.IsCancellationRequested)
				{
					zip.completionSource.TrySetCanceled(zip.cancellationToken);
				}
				else
				{
					zip.completionSource.TrySetResult(result: true);
				}
			}
			else
			{
				zip.completionSource.TrySetResult(result: false);
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

	private readonly Func<TFirst, TSecond, TResult> resultSelector;

	public Zip(IUniTaskAsyncEnumerable<TFirst> first, IUniTaskAsyncEnumerable<TSecond> second, Func<TFirst, TSecond, TResult> resultSelector)
	{
		this.first = first;
		this.second = second;
		this.resultSelector = resultSelector;
	}

	public IUniTaskAsyncEnumerator<TResult> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _Zip(first, second, resultSelector, cancellationToken);
	}
}
