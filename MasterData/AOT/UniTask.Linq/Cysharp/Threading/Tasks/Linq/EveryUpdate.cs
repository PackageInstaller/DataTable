using System.Threading;

namespace Cysharp.Threading.Tasks.Linq;

internal class EveryUpdate : IUniTaskAsyncEnumerable<AsyncUnit>
{
	private class _EveryUpdate : MoveNextSource, IUniTaskAsyncEnumerator<AsyncUnit>, IUniTaskAsyncDisposable, IPlayerLoopItem
	{
		private readonly PlayerLoopTiming updateTiming;

		private readonly CancellationToken cancellationToken;

		private readonly CancellationTokenRegistration cancellationTokenRegistration;

		private bool disposed;

		public AsyncUnit Current => default;

		public _EveryUpdate(PlayerLoopTiming updateTiming, CancellationToken cancellationToken, bool cancelImmediately)
		{
			this.updateTiming = updateTiming;
			this.cancellationToken = cancellationToken;
			if (cancelImmediately && cancellationToken.CanBeCanceled)
			{
				cancellationTokenRegistration = cancellationToken.RegisterWithoutCaptureExecutionContext((object state) =>
				{
					_EveryUpdate everyUpdate = (_EveryUpdate)state;
					everyUpdate.completionSource.TrySetCanceled(everyUpdate.cancellationToken);
				}, this);
			}
			PlayerLoopHelper.AddAction(updateTiming, this);
		}

		public UniTask<bool> MoveNextAsync()
		{
			if (disposed)
			{
				return CompletedTasks.False;
			}
			completionSource.Reset();
			CancellationToken cancellationToken = this.cancellationToken;
			if (cancellationToken.IsCancellationRequested)
			{
				completionSource.TrySetCanceled(this.cancellationToken);
			}
			return new UniTask<bool>(this, completionSource.Version);
		}

		public UniTask DisposeAsync()
		{
			if (!disposed)
			{
				CancellationTokenRegistration cancellationTokenRegistration = this.cancellationTokenRegistration;
				cancellationTokenRegistration.Dispose();
				disposed = true;
			}
			return default;
		}

		public bool MoveNext()
		{
			CancellationToken cancellationToken = this.cancellationToken;
			if (cancellationToken.IsCancellationRequested)
			{
				completionSource.TrySetCanceled(this.cancellationToken);
				return false;
			}
			if (disposed)
			{
				completionSource.TrySetResult(result: false);
				return false;
			}
			completionSource.TrySetResult(result: true);
			return true;
		}
	}

	private readonly PlayerLoopTiming updateTiming;

	private readonly bool cancelImmediately;

	public EveryUpdate(PlayerLoopTiming updateTiming, bool cancelImmediately)
	{
		this.updateTiming = updateTiming;
		this.cancelImmediately = cancelImmediately;
	}

	public IUniTaskAsyncEnumerator<AsyncUnit> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _EveryUpdate(updateTiming, cancellationToken, cancelImmediately);
	}
}
