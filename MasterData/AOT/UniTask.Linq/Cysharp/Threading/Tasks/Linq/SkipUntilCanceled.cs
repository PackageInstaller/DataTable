using System;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class SkipUntilCanceled<TSource> : IUniTaskAsyncEnumerable<TSource>
{
	private sealed class _SkipUntilCanceled : MoveNextSource, IUniTaskAsyncEnumerator<TSource>, IUniTaskAsyncDisposable
	{
		private static readonly Action<object> CancelDelegate1 = OnCanceled1;

		private static readonly Action<object> CancelDelegate2 = OnCanceled2;

		private static readonly Action<object> MoveNextCoreDelegate = MoveNextCore;

		private readonly IUniTaskAsyncEnumerable<TSource> source;

		private CancellationToken cancellationToken1;

		private CancellationToken cancellationToken2;

		private CancellationTokenRegistration cancellationTokenRegistration1;

		private CancellationTokenRegistration cancellationTokenRegistration2;

		private int isCanceled;

		private IUniTaskAsyncEnumerator<TSource> enumerator;

		private UniTask<bool>.Awaiter awaiter;

		private bool continueNext;

		public TSource Current { get; private set; }

		public _SkipUntilCanceled(IUniTaskAsyncEnumerable<TSource> source, CancellationToken cancellationToken1, CancellationToken cancellationToken2)
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
			if (enumerator == null)
			{
				if (cancellationToken1.IsCancellationRequested)
				{
					isCanceled = 1;
				}
				if (cancellationToken2.IsCancellationRequested)
				{
					isCanceled = 1;
				}
				enumerator = source.GetAsyncEnumerator(cancellationToken2);
			}
			completionSource.Reset();
			if (isCanceled != 0)
			{
				SourceMoveNext();
			}
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
			_SkipUntilCanceled skipUntilCanceled = (_SkipUntilCanceled)state;
			if (!skipUntilCanceled.TryGetResult(skipUntilCanceled.awaiter, out var result))
			{
				return;
			}
			if (result)
			{
				skipUntilCanceled.Current = skipUntilCanceled.enumerator.Current;
				skipUntilCanceled.completionSource.TrySetResult(result: true);
				if (skipUntilCanceled.continueNext)
				{
					skipUntilCanceled.SourceMoveNext();
				}
			}
			else
			{
				skipUntilCanceled.completionSource.TrySetResult(result: false);
			}
		}

		private static void OnCanceled1(object state)
		{
			_SkipUntilCanceled skipUntilCanceled = (_SkipUntilCanceled)state;
			if (skipUntilCanceled.isCanceled == 0 && Interlocked.Increment(ref skipUntilCanceled.isCanceled) == 1)
			{
				skipUntilCanceled.cancellationTokenRegistration2.Dispose();
				skipUntilCanceled.SourceMoveNext();
			}
		}

		private static void OnCanceled2(object state)
		{
			_SkipUntilCanceled skipUntilCanceled = (_SkipUntilCanceled)state;
			if (skipUntilCanceled.isCanceled == 0 && Interlocked.Increment(ref skipUntilCanceled.isCanceled) == 1)
			{
				skipUntilCanceled.cancellationTokenRegistration2.Dispose();
				skipUntilCanceled.SourceMoveNext();
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

	public SkipUntilCanceled(IUniTaskAsyncEnumerable<TSource> source, CancellationToken cancellationToken)
	{
		this.source = source;
		this.cancellationToken = cancellationToken;
	}

	public IUniTaskAsyncEnumerator<TSource> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _SkipUntilCanceled(source, this.cancellationToken, cancellationToken);
	}
}
