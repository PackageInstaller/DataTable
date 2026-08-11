#define ENABLE_ERROR_AND_ABOVE_LOG
#define ENABLE_LOG
using System;
using System.Collections.Generic;
using System.Threading;

namespace GameFramework.Runtime;

public class ThreadScheduledExecutor : AbstractExecutor, IScheduledExecutor, IDisposable
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

		private Action wrappedAction;

		private ThreadScheduledExecutor executor;

		public virtual TimeSpan Delay => new TimeSpan(startTime + delay.Ticks - DateTime.Now.Ticks);

		public OneTimeDelayTask(ThreadScheduledExecutor executor, Action command, TimeSpan delay)
			: base(cancelable: true)
		{
			OneTimeDelayTask oneTimeDelayTask = this;
			startTime = DateTime.Now.Ticks;
			this.delay = delay;
			this.executor = executor;
			wrappedAction = delegate
			{
				try
				{
					if (!oneTimeDelayTask.IsDone)
					{
						if (oneTimeDelayTask.IsCancellationRequested)
						{
							oneTimeDelayTask.SetCancelled();
						}
						else
						{
							command();
							oneTimeDelayTask.SetResult();
						}
					}
				}
				catch (Exception ex)
				{
					oneTimeDelayTask.SetException(ex);
				}
			};
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
				Executors.RunAsyncNoReturn(wrappedAction);
			}
			catch (Exception message)
			{
				Log.Error(message);
			}
		}
	}

	private class OneTimeDelayTask<TResult> : AsyncResult<TResult>, IDelayTask, IAsyncResult
	{
		private long startTime;

		private TimeSpan delay;

		private Action wrappedAction;

		private ThreadScheduledExecutor executor;

		public virtual TimeSpan Delay => new TimeSpan(startTime + delay.Ticks - DateTime.Now.Ticks);

		public OneTimeDelayTask(ThreadScheduledExecutor executor, Func<TResult> command, TimeSpan delay)
		{
			OneTimeDelayTask<TResult> oneTimeDelayTask = this;
			startTime = DateTime.Now.Ticks;
			this.delay = delay;
			this.executor = executor;
			wrappedAction = delegate
			{
				try
				{
					if (!oneTimeDelayTask.IsDone)
					{
						if (oneTimeDelayTask.IsCancellationRequested)
						{
							oneTimeDelayTask.SetCancelled();
						}
						else
						{
							oneTimeDelayTask.SetResult(command());
						}
					}
				}
				catch (Exception message)
				{
					oneTimeDelayTask.SetException(message);
					Log.Warning(message);
				}
			};
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
				Executors.RunAsyncNoReturn(wrappedAction);
			}
			catch (Exception message)
			{
				Log.Error(message);
			}
		}
	}

	private class FixedRateDelayTask : AsyncResult, IDelayTask, IAsyncResult
	{
		private long startTime;

		private TimeSpan initialDelay;

		private TimeSpan period;

		private ThreadScheduledExecutor executor;

		private Action wrappedAction;

		private int count = 0;

		public virtual TimeSpan Delay => new TimeSpan(startTime + initialDelay.Ticks + period.Ticks * count - DateTime.Now.Ticks);

		public FixedRateDelayTask(ThreadScheduledExecutor executor, Action command, TimeSpan initialDelay, TimeSpan period)
		{
			FixedRateDelayTask fixedRateDelayTask = this;
			startTime = DateTime.Now.Ticks;
			this.initialDelay = initialDelay;
			this.period = period;
			this.executor = executor;
			wrappedAction = delegate
			{
				try
				{
					if (!fixedRateDelayTask.IsDone)
					{
						if (fixedRateDelayTask.IsCancellationRequested)
						{
							fixedRateDelayTask.SetCancelled();
						}
						else
						{
							Interlocked.Increment(ref fixedRateDelayTask.count);
							fixedRateDelayTask.executor.Add(fixedRateDelayTask);
							command();
						}
					}
				}
				catch (Exception message)
				{
					Log.Error(message);
				}
			};
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
				Executors.RunAsyncNoReturn(wrappedAction);
			}
			catch (Exception message)
			{
				Log.Error(message);
			}
		}
	}

	private class FixedDelayDelayTask : AsyncResult, IDelayTask, IAsyncResult
	{
		private TimeSpan delay;

		private DateTime nextTime;

		private ThreadScheduledExecutor executor;

		private Action wrappedAction;

		public virtual TimeSpan Delay => nextTime - DateTime.Now;

		public FixedDelayDelayTask(ThreadScheduledExecutor executor, Action command, TimeSpan initialDelay, TimeSpan delay)
		{
			FixedDelayDelayTask fixedDelayDelayTask = this;
			this.delay = delay;
			this.executor = executor;
			nextTime = DateTime.Now + initialDelay;
			wrappedAction = delegate
			{
				try
				{
					if (!fixedDelayDelayTask.IsDone)
					{
						if (fixedDelayDelayTask.IsCancellationRequested)
						{
							fixedDelayDelayTask.SetCancelled();
						}
						else
						{
							command();
						}
					}
				}
				catch (Exception message)
				{
					Log.Error(message);
				}
				finally
				{
					if (fixedDelayDelayTask.IsCancellationRequested)
					{
						fixedDelayDelayTask.SetCancelled();
					}
					else
					{
						fixedDelayDelayTask.nextTime = DateTime.Now + fixedDelayDelayTask.delay;
						fixedDelayDelayTask.executor.Add(fixedDelayDelayTask);
					}
				}
			};
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
				Executors.RunAsyncNoReturn(wrappedAction);
			}
			catch (Exception message)
			{
				Log.Error(message);
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

	private IComparer<IDelayTask> comparer = new ComparerImpl<IDelayTask>();

	private List<IDelayTask> queue = new List<IDelayTask>();

	private object _lock = new object();

	private bool running = false;

	public void Start()
	{
		if (running)
		{
			return;
		}
		running = true;
		Executors.RunAsyncNoReturn(delegate
		{
			IDelayTask delayTask = null;
			while (running)
			{
				lock (_lock)
				{
					if (queue.Count <= 0)
					{
						Monitor.Wait(_lock);
						continue;
					}
					delayTask = queue[0];
					if (delayTask.Delay.Ticks > 0)
					{
						Monitor.Wait(_lock, delayTask.Delay);
						continue;
					}
					queue.RemoveAt(0);
				}
				delayTask.Run();
			}
		});
	}

	public void Stop()
	{
		if (!running)
		{
			return;
		}
		lock (_lock)
		{
			running = false;
			Monitor.PulseAll(_lock);
		}
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

	private void Add(IDelayTask task)
	{
		lock (_lock)
		{
			queue.Add(task);
			queue.Sort(comparer);
			Monitor.PulseAll(_lock);
		}
	}

	private bool Remove(IDelayTask task)
	{
		lock (_lock)
		{
			if (queue.Remove(task))
			{
				queue.Sort(comparer);
				Monitor.PulseAll(_lock);
				return true;
			}
		}
		return false;
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
