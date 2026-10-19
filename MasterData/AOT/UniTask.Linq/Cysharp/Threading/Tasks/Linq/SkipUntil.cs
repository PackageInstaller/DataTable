using System;
using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal sealed class SkipUntil<TSource> : IUniTaskAsyncEnumerable<TSource>
{
	private sealed class _SkipUntil : MoveNextSource, IUniTaskAsyncEnumerator<TSource>, IUniTaskAsyncDisposable
	{
		private static readonly Action<object> CancelDelegate1 = OnCanceled1;

		private static readonly Action<object> MoveNextCoreDelegate = MoveNextCore;

		private readonly IUniTaskAsyncEnumerable<TSource> source;

		private CancellationToken cancellationToken1;

		private bool completed;

		private CancellationTokenRegistration cancellationTokenRegistration1;

		private IUniTaskAsyncEnumerator<TSource> enumerator;

		private UniTask<bool>.Awaiter awaiter;

		private bool continueNext;

		private Exception exception;

		public TSource Current { get; private set; }

		public _SkipUntil(IUniTaskAsyncEnumerable<TSource> source, UniTask other, CancellationToken cancellationToken1)
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
			if (completed)
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
			_SkipUntil skipUntil = (_SkipUntil)state;
			if (!skipUntil.TryGetResult(skipUntil.awaiter, out var result))
			{
				return;
			}
			if (result)
			{
				skipUntil.Current = skipUntil.enumerator.Current;
				skipUntil.completionSource.TrySetResult(result: true);
				if (skipUntil.continueNext)
				{
					skipUntil.SourceMoveNext();
				}
			}
			else
			{
				skipUntil.completionSource.TrySetResult(result: false);
			}
		}

		private async UniTaskVoid RunOther(UniTask other)
		{
			try
			{
				await other;
				completed = true;
				SourceMoveNext();
			}
			catch (Exception ex)
			{
				Exception error = (exception = ex);
				completionSource.TrySetException(error);
			}
		}

		private static void OnCanceled1(object state)
		{
			_SkipUntil skipUntil = (_SkipUntil)state;
			skipUntil.completionSource.TrySetCanceled(skipUntil.cancellationToken1);
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

	public SkipUntil(IUniTaskAsyncEnumerable<TSource> source, UniTask other, Func<CancellationToken, UniTask> other2)
	{
		this.source = source;
		this.other = other;
		this.other2 = other2;
	}

	public IUniTaskAsyncEnumerator<TSource> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		if (other2 != null)
		{
			return new _SkipUntil(source, other2(cancellationToken), cancellationToken);
		}
		return new _SkipUntil(source, other, cancellationToken);
	}
}
