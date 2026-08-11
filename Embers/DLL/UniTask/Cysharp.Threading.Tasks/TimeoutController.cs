using System;
using System.Threading;

namespace Cysharp.Threading.Tasks;

public sealed class TimeoutController : IDisposable
{
	private static readonly Action<object> CancelCancellationTokenSourceStateDelegate = CancelCancellationTokenSourceState;

	private CancellationTokenSource timeoutSource;

	private CancellationTokenSource linkedSource;

	private PlayerLoopTimer timer;

	private bool isDisposed;

	private readonly DelayType delayType;

	private readonly PlayerLoopTiming delayTiming;

	private readonly CancellationTokenSource originalLinkCancellationTokenSource;

	private static void CancelCancellationTokenSourceState(object state)
	{
		((CancellationTokenSource)state).Cancel();
	}

	public TimeoutController(DelayType delayType = DelayType.DeltaTime, PlayerLoopTiming delayTiming = PlayerLoopTiming.Update)
	{
		timeoutSource = new CancellationTokenSource();
		originalLinkCancellationTokenSource = null;
		linkedSource = null;
		this.delayType = delayType;
		this.delayTiming = delayTiming;
	}

	public TimeoutController(CancellationTokenSource linkCancellationTokenSource, DelayType delayType = DelayType.DeltaTime, PlayerLoopTiming delayTiming = PlayerLoopTiming.Update)
	{
		timeoutSource = new CancellationTokenSource();
		originalLinkCancellationTokenSource = linkCancellationTokenSource;
		linkedSource = CancellationTokenSource.CreateLinkedTokenSource(timeoutSource.Token, linkCancellationTokenSource.Token);
		this.delayType = delayType;
		this.delayTiming = delayTiming;
	}

	public CancellationToken Timeout(int millisecondsTimeout)
	{
		return Timeout(TimeSpan.FromMilliseconds(millisecondsTimeout));
	}

	public CancellationToken Timeout(TimeSpan timeout)
	{
		if (originalLinkCancellationTokenSource != null && originalLinkCancellationTokenSource.IsCancellationRequested)
		{
			return originalLinkCancellationTokenSource.Token;
		}
		if (timeoutSource.IsCancellationRequested)
		{
			timeoutSource.Dispose();
			timeoutSource = new CancellationTokenSource();
			if (linkedSource != null)
			{
				linkedSource.Cancel();
				linkedSource.Dispose();
				linkedSource = CancellationTokenSource.CreateLinkedTokenSource(timeoutSource.Token, originalLinkCancellationTokenSource.Token);
			}
			timer?.Dispose();
			timer = null;
		}
		CancellationToken token = ((linkedSource != null) ? linkedSource : timeoutSource).Token;
		if (timer == null)
		{
			timer = PlayerLoopTimer.StartNew(timeout, periodic: false, delayType, delayTiming, token, CancelCancellationTokenSourceStateDelegate, timeoutSource);
		}
		else
		{
			timer.Restart(timeout);
		}
		return token;
	}

	public bool IsTimeout()
	{
		return timeoutSource.IsCancellationRequested;
	}

	public void Reset()
	{
		timer?.Stop();
	}

	public void Dispose()
	{
		if (isDisposed)
		{
			return;
		}
		try
		{
			timer?.Dispose();
			timeoutSource.Cancel();
			timeoutSource.Dispose();
			if (linkedSource != null)
			{
				linkedSource.Cancel();
				linkedSource.Dispose();
			}
		}
		finally
		{
			isDisposed = true;
		}
	}
}
