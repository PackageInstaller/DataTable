using System.Threading;
using UnityEngine;

namespace Cysharp.Threading.Tasks.Linq;

internal class TimerFrame : IUniTaskAsyncEnumerable<AsyncUnit>
{
	private class _TimerFrame : MoveNextSource, IUniTaskAsyncEnumerator<AsyncUnit>, IUniTaskAsyncDisposable, IPlayerLoopItem
	{
		private readonly int dueTimeFrameCount;

		private readonly int? periodFrameCount;

		private readonly CancellationToken cancellationToken;

		private readonly CancellationTokenRegistration cancellationTokenRegistration;

		private int initialFrame;

		private int currentFrame;

		private bool dueTimePhase;

		private bool completed;

		private bool disposed;

		public AsyncUnit Current => default;

		public _TimerFrame(int dueTimeFrameCount, int? periodFrameCount, PlayerLoopTiming updateTiming, CancellationToken cancellationToken, bool cancelImmediately)
		{
			if (dueTimeFrameCount <= 0)
			{
				dueTimeFrameCount = 0;
			}
			if (periodFrameCount.HasValue && periodFrameCount <= 0)
			{
				periodFrameCount = 1;
			}
			initialFrame = (PlayerLoopHelper.IsMainThread ? Time.frameCount : (-1));
			dueTimePhase = true;
			this.dueTimeFrameCount = dueTimeFrameCount;
			this.periodFrameCount = periodFrameCount;
			this.cancellationToken = cancellationToken;
			if (cancelImmediately && cancellationToken.CanBeCanceled)
			{
				cancellationTokenRegistration = cancellationToken.RegisterWithoutCaptureExecutionContext((object state) =>
				{
					_TimerFrame timerFrame = (_TimerFrame)state;
					timerFrame.completionSource.TrySetCanceled(timerFrame.cancellationToken);
				}, this);
			}
			PlayerLoopHelper.AddAction(updateTiming, this);
		}

		public UniTask<bool> MoveNextAsync()
		{
			if (disposed || completed)
			{
				return CompletedTasks.False;
			}
			CancellationToken cancellationToken = this.cancellationToken;
			if (cancellationToken.IsCancellationRequested)
			{
				completionSource.TrySetCanceled(this.cancellationToken);
			}
			currentFrame = 0;
			completionSource.Reset();
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
			if (dueTimePhase)
			{
				if (currentFrame == 0)
				{
					if (dueTimeFrameCount == 0)
					{
						dueTimePhase = false;
						completionSource.TrySetResult(result: true);
						return true;
					}
					if (initialFrame == Time.frameCount)
					{
						return true;
					}
				}
				if (++currentFrame >= dueTimeFrameCount)
				{
					dueTimePhase = false;
					completionSource.TrySetResult(result: true);
				}
			}
			else
			{
				if (!periodFrameCount.HasValue)
				{
					completed = true;
					completionSource.TrySetResult(result: false);
					return false;
				}
				if (++currentFrame >= periodFrameCount)
				{
					completionSource.TrySetResult(result: true);
				}
			}
			return true;
		}
	}

	private readonly PlayerLoopTiming updateTiming;

	private readonly int dueTimeFrameCount;

	private readonly int? periodFrameCount;

	private readonly bool cancelImmediately;

	public TimerFrame(int dueTimeFrameCount, int? periodFrameCount, PlayerLoopTiming updateTiming, bool cancelImmediately)
	{
		this.updateTiming = updateTiming;
		this.dueTimeFrameCount = dueTimeFrameCount;
		this.periodFrameCount = periodFrameCount;
		this.cancelImmediately = cancelImmediately;
	}

	public IUniTaskAsyncEnumerator<AsyncUnit> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _TimerFrame(dueTimeFrameCount, periodFrameCount, updateTiming, cancellationToken, cancelImmediately);
	}
}
