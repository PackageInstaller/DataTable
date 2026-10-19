using System;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class TakeUntilCanceled<TSource> : IUniTaskAsyncEnumerable<TSource>
{
	private sealed class _TakeUntilCanceled : MoveNextSource, IUniTaskAsyncEnumerator<TSource>, IUniTaskAsyncDisposable
	{
		private static readonly Action<object> CancelDelegate1 = OnCanceled1;

		private static readonly Action<object> CancelDelegate2 = OnCanceled2;

		private static readonly Action<object> MoveNextCoreDelegate = MoveNextCore;

		private readonly IUniTaskAsyncEnumerable<TSource> source;

		private CancellationToken cancellationToken1;

		private CancellationToken cancellationToken2;

		private CancellationTokenRegistration cancellationTokenRegistration1;

		private CancellationTokenRegistration cancellationTokenRegistration2;

		private bool isCanceled;

		private IUniTaskAsyncEnumerator<TSource> enumerator;

		private UniTask<bool>.Awaiter awaiter;

		public TSource Current { get; private set; }

		public _TakeUntilCanceled(IUniTaskAsyncEnumerable<TSource> source, CancellationToken cancellationToken1, CancellationToken cancellationToken2)
		{
			this.source = source;
			this.cancellationToken1 = cancellationToken1;
			this.cancellationToken2 = cancellationToken2;
			if (cancellationToken1.CanBeCanceled)
			{
				cancellationTokenRegistration1 = cancellationToken1.RegisterWithoutCaptureExecutionContext(CancelDelegate1, this);
			}
			if (cancellationToken1 != cancellationToken2 && cancellationToken2.CanBeCanceled)
			{
				cancellationTokenRegistration2 = cancellationToken2.RegisterWithoutCaptureExecutionContext(CancelDelegate2, this);
			}
		}

		public UniTask<bool> MoveNextAsync()
		{
			if (cancellationToken1.IsCancellationRequested)
			{
				isCanceled = true;
			}
			if (cancellationToken2.IsCancellationRequested)
			{
				isCanceled = true;
			}
			if (enumerator == null)
			{
				enumerator = source.GetAsyncEnumerator(cancellationToken2);
			}
			if (isCanceled)
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
			_TakeUntilCanceled takeUntilCanceled = (_TakeUntilCanceled)state;
			if (!takeUntilCanceled.TryGetResult(takeUntilCanceled.awaiter, out var result))
			{
				return;
			}
			if (result)
			{
				if (takeUntilCanceled.isCanceled)
				{
					takeUntilCanceled.completionSource.TrySetResult(result: false);
					return;
				}
				takeUntilCanceled.Current = takeUntilCanceled.enumerator.Current;
				takeUntilCanceled.completionSource.TrySetResult(result: true);
			}
			else
			{
				takeUntilCanceled.completionSource.TrySetResult(result: false);
			}
		}

		private static void OnCanceled1(object state)
		{
			_TakeUntilCanceled takeUntilCanceled = (_TakeUntilCanceled)state;
			if (!takeUntilCanceled.isCanceled)
			{
				takeUntilCanceled.cancellationTokenRegistration2.Dispose();
				takeUntilCanceled.completionSource.TrySetResult(result: false);
			}
		}

		private static void OnCanceled2(object state)
		{
			_TakeUntilCanceled takeUntilCanceled = (_TakeUntilCanceled)state;
			if (!takeUntilCanceled.isCanceled)
			{
				takeUntilCanceled.cancellationTokenRegistration1.Dispose();
				takeUntilCanceled.completionSource.TrySetResult(result: false);
			}
		}

		public UniTask DisposeAsync()
		{
			cancellationTokenRegistration1.Dispose();
			cancellationTokenRegistration2.Dispose();
			if (enumerator != null)
			{
				return enumerator.DisposeAsync();
			}
			return default;
		}
	}

	private readonly IUniTaskAsyncEnumerable<TSource> source;

	private readonly CancellationToken cancellationToken;

	public TakeUntilCanceled(IUniTaskAsyncEnumerable<TSource> source, CancellationToken cancellationToken)
	{
		this.source = source;
		this.cancellationToken = cancellationToken;
	}

	public IUniTaskAsyncEnumerator<TSource> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _TakeUntilCanceled(source, this.cancellationToken, cancellationToken);
	}
}
