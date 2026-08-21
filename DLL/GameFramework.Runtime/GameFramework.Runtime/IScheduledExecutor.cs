using System;

namespace GameFramework.Runtime;

public interface IScheduledExecutor : IDisposable
{
	void Start();

	void Stop();

	IAsyncResult Schedule<TResult>(Func<TResult> command, long delay);

	IAsyncResult Schedule<TResult>(Func<TResult> command, TimeSpan delay);

	IAsyncResult Schedule(Action command, long delay);

	IAsyncResult Schedule(Action command, TimeSpan delay);

	IAsyncResult ScheduleAtFixedRate(Action command, long initialDelay, long period);

	IAsyncResult ScheduleAtFixedRate(Action command, TimeSpan initialDelay, TimeSpan period);

	IAsyncResult ScheduleWithFixedDelay(Action command, long initialDelay, long delay);

	IAsyncResult ScheduleWithFixedDelay(Action command, TimeSpan initialDelay, TimeSpan delay);
}
