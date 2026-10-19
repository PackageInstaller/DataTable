using System;
using System.Threading;
using UnityEngine;

namespace Cysharp.Threading.Tasks.Linq;

internal class Timer : IUniTaskAsyncEnumerable<AsyncUnit>
{
	private class _Timer : MoveNextSource, IUniTaskAsyncEnumerator<AsyncUnit>, IUniTaskAsyncDisposable, IPlayerLoopItem
	{
		private readonly float dueTime;

		private readonly float? period;

		private readonly PlayerLoopTiming updateTiming;

		private readonly bool ignoreTimeScale;

		private readonly CancellationToken cancellationToken;

		private readonly CancellationTokenRegistration cancellationTokenRegistration;

		private int initialFrame;

		private float elapsed;

		private bool dueTimePhase;

		private bool completed;

		private bool disposed;

		public AsyncUnit Current => default;

		public _Timer(TimeSpan dueTime, TimeSpan? period, PlayerLoopTiming updateTiming, bool ignoreTimeScale, CancellationToken cancellationToken, bool cancelImmediately)
		{
			this.dueTime = (float)dueTime.TotalSeconds;
			this.period = ((!period.HasValue) ? ((float?)null) : new float?((float)period.Value.TotalSeconds));
			if (this.dueTime <= 0f)
			{
				this.dueTime = 0f;
			}
			if (this.period.HasValue && this.period <= 0f)
			{
				this.period = 1f;
			}
			initialFrame = (PlayerLoopHelper.IsMainThread ? Time.frameCount : (-1));
			dueTimePhase = true;
			this.updateTiming = updateTiming;
			this.ignoreTimeScale = ignoreTimeScale;
			this.cancellationToken = cancellationToken;
			if (cancelImmediately && cancellationToken.CanBeCanceled)
			{
				cancellationTokenRegistration = cancellationToken.RegisterWithoutCaptureExecutionContext((object state) =>
				{
					_Timer timer = (_Timer)state;
					timer.completionSource.TrySetCanceled(timer.cancellationToken);
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
			elapsed = 0f;
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
			if (disposed)
			{
				completionSource.TrySetResult(result: false);
				return false;
			}
			CancellationToken cancellationToken = this.cancellationToken;
			if (cancellationToken.IsCancellationRequested)
			{
				completionSource.TrySetCanceled(this.cancellationToken);
				return false;
			}
			if (dueTimePhase)
			{
				if (elapsed == 0f && initialFrame == Time.frameCount)
				{
					return true;
				}
				elapsed += (ignoreTimeScale ? Time.unscaledDeltaTime : Time.deltaTime);
				if (elapsed >= dueTime)
				{
					dueTimePhase = false;
					completionSource.TrySetResult(result: true);
				}
			}
			else
			{
				if (!period.HasValue)
				{
					completed = true;
					completionSource.TrySetResult(result: false);
					return false;
				}
				elapsed += (ignoreTimeScale ? Time.unscaledDeltaTime : Time.deltaTime);
				if (elapsed >= period)
				{
					completionSource.TrySetResult(result: true);
				}
			}
			return true;
		}
	}

	private readonly PlayerLoopTiming updateTiming;

	private readonly TimeSpan dueTime;

	private readonly TimeSpan? period;

	private readonly bool ignoreTimeScale;

	private readonly bool cancelImmediately;

	public Timer(TimeSpan dueTime, TimeSpan? period, PlayerLoopTiming updateTiming, bool ignoreTimeScale, bool cancelImmediately)
	{
		this.updateTiming = updateTiming;
		this.dueTime = dueTime;
		this.period = period;
		this.ignoreTimeScale = ignoreTimeScale;
		this.cancelImmediately = cancelImmediately;
	}

	public IUniTaskAsyncEnumerator<AsyncUnit> GetAsyncEnumerator(CancellationToken cancellationToken = default(CancellationToken))
	{
		return new _Timer(dueTime, period, updateTiming, ignoreTimeScale, cancellationToken, cancelImmediately);
	}
}
