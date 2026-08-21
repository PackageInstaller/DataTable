#define ENABLE_LOG
using System;
using System.Collections;
using System.Collections.Generic;
using System.Threading;
using UnityEngine;

namespace GameFramework.Runtime;

public class CoroutineScheduledExecutor : AbstractExecutor, IScheduledExecutor, IDisposable
{
	private interface IDelayTask : IAsyncResult
	{
		TimeSpan Delay { get; }

		void Run();
	}

	private class OneTimeDelayTask : AsyncResult, IDelayTask, IAsyncResult
	{
		private long startTime;

		private TimeSpan delay;

		private Action command;

		private CoroutineScheduledExecutor executor;

		private ITime time;

		public virtual TimeSpan Delay => new TimeSpan(startTime + delay.Ticks - (long)(time.Time * 10000000f));

		public OneTimeDelayTask(CoroutineScheduledExecutor executor, Action command, TimeSpan delay)
		{
			time = executor.Time;
			startTime = (long)(time.Time * 10000000f);
			this.delay = delay;
			this.executor = executor;
			this.command = command;
			this.executor.Add(this);
		}

		public override bool Cancel()
		{
			if (IsDone)
			{
				return false;
			}
			if (!executor.Remove(this))
			{
				return false;
			}
			cancellationRequested = true;
			SetCancelled();
			return true;
		}

		public virtual void Run()
		{
			try
			{
				if (!IsDone)
				{
					if (IsCancellationRequested)
					{
						SetCancelled();
						return;
					}
					command();
					SetResult();
				}
			}
			catch (Exception ex)
			{
				SetException(ex);
			}
		}
	}

	private class OneTimeDelayTask<TResult> : AsyncResult<TResult>, IDelayTask, IAsyncResult
	{
		private long startTime;

		private TimeSpan delay;

		private Func<TResult> command;

		private CoroutineScheduledExecutor executor;

		private ITime time;

		public virtual TimeSpan Delay => new TimeSpan(startTime + delay.Ticks - (long)(time.Time * 10000000f));

		public OneTimeDelayTask(CoroutineScheduledExecutor executor, Func<TResult> command, TimeSpan delay)
		{
			time = executor.Time;
			startTime = (long)(time.Time * 10000000f);
			this.delay = delay;
			this.executor = executor;
			this.command = command;
			this.executor.Add(this);
		}

		public override bool Cancel()
		{
			if (IsDone)
			{
				return false;
			}
			if (!executor.Remove(this))
			{
				return false;
			}
			cancellationRequested = true;
			SetCancelled();
			return true;
		}

		public virtual void Run()
		{
			try
			{
				if (!IsDone)
				{
					if (IsCancellationRequested)
					{
						SetCancelled();
					}
					else
					{
						SetResult(command());
					}
				}
			}
			catch (Exception message)
			{
				SetException(message);
				Log.Warning(message);
			}
		}
	}

	private class FixedRateDelayTask : AsyncResult, IDelayTask, IAsyncResult
	{
		private long startTime;

		private TimeSpan initialDelay;

		private TimeSpan period;

		private CoroutineScheduledExecutor executor;

		private Action command;

		private int count = 0;

		private ITime time;

		public virtual TimeSpan Delay => new TimeSpan(startTime + initialDelay.Ticks + period.Ticks * count - (long)(time.Time * 10000000f));

		public FixedRateDelayTask(CoroutineScheduledExecutor executor, Action command, TimeSpan initialDelay, TimeSpan period)
		{
			time = executor.Time;
			startTime = (long)(time.Time * 10000000f);
			this.initialDelay = initialDelay;
			this.period = period;
			this.executor = executor;
			this.command = command;
			this.executor.Add(this);
		}

		public override bool Cancel()
		{
			if (IsDone)
			{
				return false;
			}
			executor.Remove(this);
			cancellationRequested = true;
			SetCancelled();
			return true;
		}

		public virtual void Run()
		{
			try
			{
				if (!IsDone)
				{
					if (IsCancellationRequested)
					{
						SetCancelled();
						return;
					}
					Interlocked.Increment(ref count);
					executor.Add(this);
					command();
				}
			}
			catch (Exception message)
			{
				Log.Warning(message);
			}
		}
	}

	private class FixedDelayDelayTask : AsyncResult, IDelayTask, IAsyncResult
	{
		private TimeSpan delay;

		private long nextTime;

		private CoroutineScheduledExecutor executor;

		private Action command;

		private ITime time;

		public virtual TimeSpan Delay => new TimeSpan(nextTime - (long)(time.Time * 10000000f));

		public FixedDelayDelayTask(CoroutineScheduledExecutor executor, Action command, TimeSpan initialDelay, TimeSpan delay)
		{
			time = executor.Time;
			this.delay = delay;
			this.executor = executor;
			this.command = command;
			nextTime = (long)(time.Time * 10000000f + (float)initialDelay.Ticks);
			this.executor.Add(this);
		}

		public override bool Cancel()
		{
			if (IsDone)
			{
				return false;
			}
			executor.Remove(this);
			cancellationRequested = true;
			SetCancelled();
			return true;
		}

		public virtual void Run()
		{
			try
			{
				if (!IsDone)
				{
					if (IsCancellationRequested)
					{
						SetCancelled();
					}
					else
					{
						command();
					}
				}
			}
			catch (Exception message)
			{
				Log.Warning(message);
			}
			finally
			{
				if (IsCancellationRequested)
				{
					SetCancelled();
				}
				else
				{
					nextTime = (long)(time.Time * 10000000f + (float)delay.Ticks);
					executor.Add(this);
				}
			}
		}
	}

	private class ComparerImpl<T> : IComparer<T> where T : IDelayTask
	{
		public int Compare(T x, T y)
		{
			if (x.Delay.Ticks == y.Delay.Ticks)
			{
				return 0;
			}
			return (x.Delay.Ticks > y.Delay.Ticks) ? 1 : (-1);
		}
	}

	public class ScaledTime : ITime
	{
		public float Time => UnityEngine.Time.time;
	}

	public class UnscaledTime : ITime
	{
		public float Time => UnityEngine.Time.unscaledTime;
	}

	private ComparerImpl<IDelayTask> comparer = new ComparerImpl<IDelayTask>();

	private List<IDelayTask> queue = new List<IDelayTask>();

	private bool running = false;

	internal ITime Time { get; private set; }

	public CoroutineScheduledExecutor()
		: this(timeScaled: false)
	{
	}

	public CoroutineScheduledExecutor(bool timeScaled)
	{
		ITime time2;
		if (!timeScaled)
		{
			ITime time = new UnscaledTime();
			time2 = time;
		}
		else
		{
			ITime time = new ScaledTime();
			time2 = time;
		}
		Time = time2;
	}

	public CoroutineScheduledExecutor(ITime time)
	{
		ITime time3;
		if (time == null)
		{
			ITime time2 = new UnscaledTime();
			time3 = time2;
		}
		else
		{
			time3 = time;
		}
		Time = time3;
	}

	private void Add(IDelayTask task)
	{
		queue.Add(task);
		queue.Sort(comparer);
	}

	private bool Remove(IDelayTask task)
	{
		if (queue.Remove(task))
		{
			queue.Sort(comparer);
			return true;
		}
		return false;
	}

	public void Start()
	{
		if (!running)
		{
			running = true;
			InterceptableEnumerator interceptableEnumerator = InterceptableEnumerator.Create(DoStart());
			interceptableEnumerator.RegisterCatchBlock(delegate
			{
				running = false;
			});
			Executors.RunOnCoroutineNoReturn(interceptableEnumerator);
		}
	}

	protected virtual IEnumerator DoStart()
	{
		while (running)
		{
			while (running && (queue.Count <= 0 || queue[0].Delay.Ticks > 0))
			{
				yield return null;
			}
			if (!running)
			{
				break;
			}
			IDelayTask task = queue[0];
			queue.RemoveAt(0);
			task.Run();
		}
	}

	public void Stop()
	{
		if (!running)
		{
			return;
		}
		running = false;
		List<IDelayTask> list = new List<IDelayTask>(queue);
		foreach (IDelayTask item in list)
		{
			if (item != null && !item.IsDone)
			{
				item.Cancel();
			}
		}
		queue.Clear();
	}

	protected virtual void Check()
	{
		if (!running)
		{
			throw new RejectedExecutionException("The ScheduledExecutor isn't started.");
		}
	}

	public virtual IAsyncResult Schedule(Action command, long delay)
	{
		return Schedule(command, new TimeSpan(delay * 10000));
	}

	public virtual IAsyncResult Schedule(Action command, TimeSpan delay)
	{
		Check();
		return new OneTimeDelayTask(this, command, delay);
	}

	public virtual IAsyncResult Schedule<TResult>(Func<TResult> command, long delay)
	{
		return Schedule(command, new TimeSpan(delay * 10000));
	}

	public virtual IAsyncResult Schedule<TResult>(Func<TResult> command, TimeSpan delay)
	{
		Check();
		return new OneTimeDelayTask<TResult>(this, command, delay);
	}

	public virtual IAsyncResult ScheduleAtFixedRate(Action command, long initialDelay, long period)
	{
		return ScheduleAtFixedRate(command, new TimeSpan(initialDelay * 10000), new TimeSpan(period * 10000));
	}

	public virtual IAsyncResult ScheduleAtFixedRate(Action command, TimeSpan initialDelay, TimeSpan period)
	{
		Check();
		return new FixedRateDelayTask(this, command, initialDelay, period);
	}

	public virtual IAsyncResult ScheduleWithFixedDelay(Action command, long initialDelay, long delay)
	{
		return ScheduleWithFixedDelay(command, new TimeSpan(initialDelay * 10000), new TimeSpan(delay * 10000));
	}

	public virtual IAsyncResult ScheduleWithFixedDelay(Action command, TimeSpan initialDelay, TimeSpan delay)
	{
		Check();
		return new FixedDelayDelayTask(this, command, initialDelay, delay);
	}

	public virtual void Dispose()
	{
		Stop();
	}
}
