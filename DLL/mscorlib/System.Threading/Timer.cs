using System.Collections;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;

namespace System.Threading;

[ComVisible(true)]
public sealed class Timer : MarshalByRefObject, IDisposable, IAsyncDisposable
{
	[StructLayout(LayoutKind.Sequential, Size = 1)]
	private struct TimerComparer : IComparer, IComparer<Timer>
	{
		int IComparer.Compare(object x, object y)
		{
			if (x == y)
			{
				return 0;
			}
			if (!(x is Timer tx))
			{
				return -1;
			}
			if (!(y is Timer ty))
			{
				return 1;
			}
			return Compare(tx, ty);
		}

		public int Compare(Timer tx, Timer ty)
		{
			return Math.Sign(tx.next_run - ty.next_run);
		}
	}

	private sealed class Scheduler
	{
		private static readonly Scheduler instance = new Scheduler();

		private volatile bool needReSort = true;

		private List<Timer> list;

		private long current_next_run = long.MaxValue;

		private ManualResetEvent changed;

		public static Scheduler Instance => instance;

		private void InitScheduler()
		{
			changed = new ManualResetEvent(initialState: false);
			Thread thread = new Thread(SchedulerThread);
			thread.IsBackground = true;
			thread.Start();
		}

		private void WakeupScheduler()
		{
			changed.Set();
		}

		private void SchedulerThread()
		{
			Thread.CurrentThread.Name = "Timer-Scheduler";
			while (true)
			{
				int millisecondsTimeout = -1;
				lock (this)
				{
					changed.Reset();
					millisecondsTimeout = RunSchedulerLoop();
				}
				changed.WaitOne(millisecondsTimeout);
			}
		}

		private Scheduler()
		{
			list = new List<Timer>(1024);
			InitScheduler();
		}

		public void Remove(Timer timer)
		{
			lock (this)
			{
				InternalRemove(timer);
			}
		}

		public void Change(Timer timer, long new_next_run)
		{
			if (timer.is_dead)
			{
				timer.is_dead = false;
			}
			bool flag = false;
			lock (this)
			{
				needReSort = true;
				if (!timer.is_added)
				{
					timer.next_run = new_next_run;
					Add(timer);
					flag = current_next_run > new_next_run;
				}
				else
				{
					if (new_next_run == long.MaxValue)
					{
						timer.next_run = new_next_run;
						InternalRemove(timer);
						return;
					}
					if (!timer.disposed)
					{
						timer.next_run = new_next_run;
						flag = current_next_run > new_next_run;
					}
				}
			}
			if (flag)
			{
				WakeupScheduler();
			}
		}

		private void Add(Timer timer)
		{
			timer.is_added = true;
			needReSort = true;
			list.Add(timer);
			if (list.Count == 1)
			{
				WakeupScheduler();
			}
		}

		private void InternalRemove(Timer timer)
		{
			timer.is_dead = true;
			needReSort = true;
		}

		private static void TimerCB(object o)
		{
			Timer timer = (Timer)o;
			timer.callback(timer.state);
		}

		private void FireTimer(Timer timer)
		{
			long period_ms = timer.period_ms;
			long due_time_ms = timer.due_time_ms;
			if (period_ms == -1 || ((period_ms == 0L || period_ms == -1) && due_time_ms != -1))
			{
				timer.next_run = long.MaxValue;
				timer.is_dead = true;
			}
			else
			{
				timer.next_run = GetTimeMonotonic() + 10000 * timer.period_ms;
				timer.is_dead = false;
			}
			ThreadPool.UnsafeQueueUserWorkItem(TimerCB, timer);
		}

		private int RunSchedulerLoop()
		{
			int num = -1;
			long timeMonotonic = GetTimeMonotonic();
			TimerComparer timerComparer = default(TimerComparer);
			if (needReSort)
			{
				list.Sort(((TimerComparer)timerComparer).Compare);
				needReSort = false;
			}
			long num2 = long.MaxValue;
			for (int i = 0; i < list.Count; i++)
			{
				Timer timer = list[i];
				if (!timer.is_dead)
				{
					if (timer.next_run <= timeMonotonic)
					{
						FireTimer(timer);
					}
					num2 = Math.Min(num2, timer.next_run);
					if (timer.next_run > timeMonotonic && timer.next_run < long.MaxValue)
					{
						timer.is_dead = false;
					}
				}
			}
			for (int i = 0; i < list.Count; i++)
			{
				Timer timer2 = list[i];
				if (timer2.is_dead)
				{
					timer2.is_added = false;
					needReSort = true;
					list[i] = list[list.Count - 1];
					i--;
					list.RemoveAt(list.Count - 1);
					if (list.Count == 0)
					{
						break;
					}
				}
			}
			if (needReSort)
			{
				list.Sort(((TimerComparer)timerComparer).Compare);
				needReSort = false;
			}
			num = -1;
			current_next_run = num2;
			if (num2 != long.MaxValue)
			{
				long num3 = (num2 - GetTimeMonotonic()) / 10000;
				if (num3 > int.MaxValue)
				{
					num = 2147483646;
				}
				else
				{
					num = (int)num3;
					if (num < 0)
					{
						num = 0;
					}
				}
			}
			return num;
		}
	}

	private TimerCallback callback;

	private object state;

	private long due_time_ms;

	private long period_ms;

	private long next_run;

	private bool disposed;

	private bool is_dead;

	private bool is_added;

	private const long MaxValue = 4294967294L;

	private static Scheduler scheduler => Scheduler.Instance;

	public Timer(TimerCallback callback, object state, int dueTime, int period)
	{
		Init(callback, state, dueTime, period);
	}

	public Timer(TimerCallback callback, object state, TimeSpan dueTime, TimeSpan period)
	{
		Init(callback, state, (long)dueTime.TotalMilliseconds, (long)period.TotalMilliseconds);
	}

	private void Init(TimerCallback callback, object state, long dueTime, long period)
	{
		if (callback == null)
		{
			throw new ArgumentNullException("callback");
		}
		this.callback = callback;
		this.state = state;
		is_dead = false;
		is_added = false;
		Change(dueTime, period, first: true);
	}

	public bool Change(int dueTime, int period)
	{
		return Change(dueTime, period, first: false);
	}

	public bool Change(TimeSpan dueTime, TimeSpan period)
	{
		return Change((long)dueTime.TotalMilliseconds, (long)period.TotalMilliseconds, first: false);
	}

	public void Dispose()
	{
		if (!disposed)
		{
			disposed = true;
			scheduler.Remove(this);
		}
	}

	private bool Change(long dueTime, long period, bool first)
	{
		if (dueTime > 4294967294u)
		{
			throw new ArgumentOutOfRangeException("dueTime", "Due time too large");
		}
		if (period > 4294967294u)
		{
			throw new ArgumentOutOfRangeException("period", "Period too large");
		}
		if (dueTime < -1)
		{
			throw new ArgumentOutOfRangeException("dueTime");
		}
		if (period < -1)
		{
			throw new ArgumentOutOfRangeException("period");
		}
		if (disposed)
		{
			throw new ObjectDisposedException(null, Environment.GetResourceString("Cannot access a disposed object."));
		}
		due_time_ms = dueTime;
		period_ms = period;
		long new_next_run;
		if (dueTime == 0L)
		{
			new_next_run = 0L;
		}
		else if (dueTime < 0)
		{
			new_next_run = long.MaxValue;
			if (first)
			{
				next_run = new_next_run;
				return true;
			}
		}
		else
		{
			new_next_run = dueTime * 10000 + GetTimeMonotonic();
		}
		scheduler.Change(this, new_next_run);
		return true;
	}

	public bool Dispose(WaitHandle notifyObject)
	{
		if (notifyObject == null)
		{
			throw new ArgumentNullException("notifyObject");
		}
		Dispose();
		NativeEventCalls.SetEvent(notifyObject.SafeWaitHandle);
		return true;
	}

	internal void KeepRootedWhileScheduled()
	{
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern long GetTimeMonotonic();
}
