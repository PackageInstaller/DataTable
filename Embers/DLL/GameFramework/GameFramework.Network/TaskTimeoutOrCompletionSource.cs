using System;
using System.Threading;
using System.Threading.Tasks;

namespace GameFramework.Network;

public class TaskTimeoutOrCompletionSource<TResult> : TaskCompletionSource<TResult>
{
	private readonly long endTime;

	private readonly CancellationToken cancellationToken;

	private TResult result;

	public TResult Result
	{
		get
		{
			return result;
		}
		set
		{
			result = value;
		}
	}

	public TimeSpan Delay => TimeSpan.FromTicks(endTime - DateTime.Now.Ticks);

	public bool IsTimeout => endTime - DateTime.Now.Ticks <= 0;

	public bool IsComplete => result != null;

	public bool IsCanceled
	{
		get
		{
			CancellationToken cancellationToken = this.cancellationToken;
			return cancellationToken.IsCancellationRequested;
		}
	}

	public TaskTimeoutOrCompletionSource(int timeoutMilliseconds, CancellationToken cancellationToken)
	{
		this.cancellationToken = cancellationToken;
		endTime = DateTime.Now.Ticks + (long)timeoutMilliseconds * 10000L;
	}

	public void SetTimeout()
	{
		SetException(new TimeoutException("The operation has timed out."));
	}

	public bool TrySetTimeout()
	{
		return TrySetException(new TimeoutException("The operation has timed out."));
	}

	public new bool TrySetCanceled()
	{
		return TrySetCanceled(cancellationToken);
	}
}
