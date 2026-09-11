using System;
using System.Collections.Concurrent;
using System.Threading;

public class CalcTaskSchedule<T> : TaskScheduleBase
{
	public ConcurrentQueue<T> mPendingTasks;

	private Action<TaskScheduleBase> mBlockerCallback;

	private ManualResetEventSlim mEvent = new ManualResetEventSlim();

	private bool mIsReady;

	public CalcTaskSchedule(Action<TaskScheduleBase> workerCallback, Action<TaskScheduleBase> blockerCallback, string threadName)
		: base(workerCallback, threadName)
	{
		mBlockerCallback = blockerCallback;
		mPendingTasks = new ConcurrentQueue<T>();
	}

	public void PushTask(T task)
	{
		if (task != null)
		{
			mPendingTasks.Enqueue(task);
			Wakeup();
		}
	}

	public void PushTaskManual(T task)
	{
		if (task != null)
		{
			mPendingTasks.Enqueue(task);
		}
	}

	public void Wakeup()
	{
		if (mEvent != null)
		{
			mEvent.Set();
		}
	}

	public bool PopTask(out T task)
	{
		return mPendingTasks.TryDequeue(out task);
	}

	protected override void RunThreadBlocker()
	{
		if (mPendingTasks.IsEmpty)
		{
			if (!mIsReady)
			{
				mIsReady = true;
				XLogger.Debug("任务线程@" + Thread.CurrentThread.ManagedThreadId + " 启动完毕!");
			}
			try
			{
				if (mBlockerCallback != null)
				{
					mBlockerCallback(this);
				}
			}
			finally
			{
				mEvent.Reset();
			}
		}
		mEvent.Wait();
	}

	protected override void DoTerminate(int millisecondTimeout)
	{
		base.DoTerminate(millisecondTimeout);
		if (!mPendingTasks.IsEmpty || !base.IsWaiting)
		{
			mThread.Join();
		}
		if (mEvent != null)
		{
			mEvent.Set();
			mEvent.Dispose();
		}
	}
}
