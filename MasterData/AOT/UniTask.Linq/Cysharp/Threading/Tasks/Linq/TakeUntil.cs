using System;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class TakeUntil<TSource> : IUniTaskAsyncEnumerable<TSource>
{
	private sealed class _TakeUntil : MoveNextSource, IUniTaskAsyncEnumerator<TSource>, IUniTaskAsyncDisposable
	{
		private static readonly Action<object> CancelDelegate1 = OnCanceled1;

		private static readonly Action<object> MoveNextCoreDelegate = MoveNextCore;

		private readonly IUniTaskAsyncEnumerable<TSource> source;

		private CancellationToken cancellationToken1;

		private CancellationTokenRegistration cancellationTokenRegistration1;

		private bool completed;

		private Exception exception;

		private IUniTaskAsyncEnumerator<TSource> enumerator;

		private UniTask<bool>.Awaiter awaiter;

		public TSource Current { get; private set; }

		public _TakeUntil(IUniTaskAsyncEnumerable<TSource> source, UniTask other, CancellationToken cancellationToken1)
		{
			this.source = source;
			this.cancellationToken1 = cancellationToken1;
			if (cancellationToken1.CanBeCanceled)
			{
				cancellationTokenRegistration1 = cancellationToken1.RegisterWithoutCaptureExecutionContext(CancelDelegate1, this);
			}
			RunOther(other).Forget();
		}

		public UniTask<bool> MoveNextAsync()
		{
			if (completed)
			{
				return CompletedTasks.False;
			}
			if (exception != null)
			{
				return UniTask.FromException<bool>(exception);
			}
			if (cancellationToken1.IsCancellationRequested)
			{
				return UniTask.FromCanceled<bool>(cancellationToken1);
			}
			if (enumerator == null)
			{
				enumerator = source.GetAsyncEnumerator(cancellationToken1);
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
			_TakeUntil takeUntil = (_TakeUntil)state;
			if (!takeUntil.TryGetResult(takeUntil.awaiter, out var result))
			{
				return;
			}
			if (result)
			{
				if (takeUntil.exception != null)
				{
					takeUntil.completionSource.TrySetException(takeUntil.exception);
					return;
				}
				if (takeUntil.cancellationToken1.IsCancellationRequested)
				{
					takeUntil.completionSource.TrySetCanceled(takeUntil.cancellationToken1);
					return;
				}
				takeUntil.Current = takeUntil.enumerator.Current;
				takeUntil.completionSource.TrySetResult(result: true);
			}
			else
			{
				takeUntil.completionSource.TrySetResult(result: false);
			}
		}

		private async UniTaskVoid RunOther(UniTask other)
		{
			try
			{
				await other;
				completed = true;
				completionSource.TrySetResult(result: false);
			}
			catch (Exception ex)
			{
				Exception error = (exception = ex);
				completionSource.TrySetException(error);
			}
		}

		private static void OnCanceled1(object state)
		{
			_TakeUntil takeUntil = (_TakeUntil)state;
			takeUntil.completionSource.TrySetCanceled(takeUntil.cancellationToken1);
		}

		public UniTask DisposeAsync()
		{
			cancellationTokenRegistration1.Dispose();
			if (enumerator != null)
			{
				return enumerator.DisposeAsync();
			}
			return default;
		}
	}

	private readonly IUniTaskAsyncEnumerable<TSource> source;

	private readonly UniTask other;

	private readonly Func<CancellationToken, UniTask> other2;

	public TakeUntil(IUniTaskAsyncEnumerable<TSource> source, UniTask other, Func<CancellationToken, UniTask> other2)
	{
		this.source = source;
		this.other = other;
		this.other2 = other2;
	}

	public IUniTaskAsyncEnumerator<TSource> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		if (other2 != null)
		{
			return new _TakeUntil(source, other2(cancellationToken), cancellationToken);
		}
		return new _TakeUntil(source, other, cancellationToken);
	}
}
