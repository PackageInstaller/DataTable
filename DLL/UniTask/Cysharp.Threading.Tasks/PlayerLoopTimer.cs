using System;
using System.Threading;

namespace Cysharp.Threading.Tasks;

public abstract class PlayerLoopTimer : IDisposable, IPlayerLoopItem
{
	private readonly CancellationToken cancellationToken;

	private readonly Action<object> timerCallback;

	private readonly object state;

	private readonly PlayerLoopTiming playerLoopTiming;

	private readonly bool periodic;

	private bool isRunning;

	private bool tryStop;

	private bool isDisposed;

	protected PlayerLoopTimer(bool periodic, PlayerLoopTiming playerLoopTiming, CancellationToken cancellationToken, Action<object> timerCallback, object state)
	{
		this.periodic = periodic;
		this.playerLoopTiming = playerLoopTiming;
		this.cancellationToken = cancellationToken;
		this.timerCallback = timerCallback;
		this.state = state;
	}

	public static PlayerLoopTimer Create(TimeSpan interval, bool periodic, DelayType delayType, PlayerLoopTiming playerLoopTiming, CancellationToken cancellationToken, Action<object> timerCallback, object state)
	{
		return delayType switch
		{
			DelayType.UnscaledDeltaTime => new IgnoreTimeScalePlayerLoopTimer(interval, periodic, playerLoopTiming, cancellationToken, timerCallback, state), 
			DelayType.Realtime => new RealtimePlayerLoopTimer(interval, periodic, playerLoopTiming, cancellationToken, timerCallback, state), 
			_ => new DeltaTimePlayerLoopTimer(interval, periodic, playerLoopTiming, cancellationToken, timerCallback, state), 
		};
	}

	public static PlayerLoopTimer StartNew(TimeSpan interval, bool periodic, DelayType delayType, PlayerLoopTiming playerLoopTiming, CancellationToken cancellationToken, Action<object> timerCallback, object state)
	{
		PlayerLoopTimer playerLoopTimer = Create(interval, periodic, delayType, playerLoopTiming, cancellationToken, timerCallback, state);
		playerLoopTimer.Restart();
		return playerLoopTimer;
	}

	public void Restart()
	{
		if (isDisposed)
		{
			throw new ObjectDisposedException(null);
		}
		ResetCore(null);
		if (!isRunning)
		{
			isRunning = true;
			PlayerLoopHelper.AddAction(playerLoopTiming, this);
		}
		tryStop = false;
	}

	public void Restart(TimeSpan interval)
	{
		if (isDisposed)
		{
			throw new ObjectDisposedException(null);
		}
		ResetCore(interval);
		if (!isRunning)
		{
			isRunning = true;
			PlayerLoopHelper.AddAction(playerLoopTiming, this);
		}
		tryStop = false;
	}

	public void Stop()
	{
		tryStop = true;
	}

	protected abstract void ResetCore(TimeSpan? newInterval);

	public void Dispose()
	{
		isDisposed = true;
	}

	bool IPlayerLoopItem.MoveNext()
	{
		if (isDisposed)
		{
			isRunning = false;
			return false;
		}
		if (tryStop)
		{
			isRunning = false;
			return false;
		}
		CancellationToken cancellationToken = this.cancellationToken;
		if (cancellationToken.IsCancellationRequested)
		{
			isRunning = false;
			return false;
		}
		if (!MoveNextCore())
		{
			timerCallback(state);
			if (periodic)
			{
				ResetCore(null);
				return true;
			}
			isRunning = false;
			return false;
		}
		return true;
	}

	protected abstract bool MoveNextCore();
}
