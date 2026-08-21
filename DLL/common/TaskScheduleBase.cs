using System;
using System.Threading;

public abstract class TaskScheduleBase
{
	private const int kAbortedThreadJoinTimeoutMS = 500;

	public const int kInvalidTaskID = -1;

	private Action<TaskScheduleBase> mDoWorkCallback;

	private DateTime mLastRun;

	private TimeSpan mLastRuntime;

	protected object mLockObject = new object();

	private string mName = string.Empty;

	private TimeSpan mRuntimeHighwater = TimeSpan.Zero;

	private DateTime mStartedAt;

	private int mTaskID = sTaskCount++;

	private volatile bool mTerminating;

	protected Thread mThread;

	private volatile bool mWaiting;

	private static int sTaskCount;

	public bool IsRunning
	{
		get
		{
			if (mThread != null && mThread.IsAlive)
			{
				return (mThread.ThreadState & ThreadState.AbortRequested) == 0;
			}
			return false;
		}
	}

	public bool IsWaiting => mWaiting;

	public DateTime LastRun => mLastRun;

	public TimeSpan LastRuntime => mLastRuntime;

	public string Name => mName;

	public TimeSpan RuntimeHighwater => mRuntimeHighwater;

	public DateTime StartedAt => mStartedAt;

	public int TaskID => mTaskID;

	public event Action<Exception> UnhandledException;

	protected TaskScheduleBase(Action<TaskScheduleBase> workerCallback, string threadName)
	{
		mDoWorkCallback = workerCallback;
		if (mDoWorkCallback == null)
		{
			throw new ArgumentNullException("Argument workerCallback is NULL!");
		}
		mName = threadName;
	}

	protected virtual void DoTerminate(int millisecondTimeout)
	{
	}

	private void DoWork()
	{
		if (mDoWorkCallback != null)
		{
			mDoWorkCallback(this);
		}
	}

	protected virtual void OnStart()
	{
	}

	public void ResetHighWatermark()
	{
		lock (mLockObject)
		{
			mRuntimeHighwater = TimeSpan.Zero;
		}
	}

	private void RunThread()
	{
		try
		{
			while (!mTerminating)
			{
				mWaiting = true;
				RunThreadBlocker();
				mWaiting = false;
				if (!mTerminating)
				{
					DateTime now = DateTime.Now;
					DoWork();
					mLastRun = now;
					mLastRuntime = DateTime.Now - now;
					if (mLastRuntime > mRuntimeHighwater)
					{
						mRuntimeHighwater = mLastRuntime;
					}
				}
			}
		}
		catch (ThreadAbortException ex)
		{
			XLogger.Error($"Thread '{mName}' has been aborted: {ex.ToString()}");
		}
		catch (ThreadInterruptedException ex2)
		{
			XLogger.Error($"Thread '{mName}' has been interrupted: {ex2.ToString()}");
		}
		catch (Exception ex3)
		{
			XLogger.Error($"Caught exception '{mName}' in thread. Terminating with exception: {ex3.ToString()}");
			mTerminating = true;
			if (UnhandledException != null)
			{
				UnhandledException(ex3);
			}
		}
		finally
		{
			mTerminating = false;
		}
	}

	protected abstract void RunThreadBlocker();

	internal void StartThread()
	{
		lock (mLockObject)
		{
			if (mTerminating)
			{
				throw new InvalidOperationException($"Cannot restart a terminated task. For now.");
			}
			if (IsRunning)
			{
				throw new InvalidCastException($"Task {this} is already running. We can't start an already running task!");
			}
			mThread = new Thread(RunThread);
			mThread.Name = Name;
			mThread.IsBackground = true;
			mStartedAt = DateTime.Now;
			OnStart();
			mThread.Start();
		}
	}

	internal void TerminateThread(int millisecondTimeout)
	{
		lock (mLockObject)
		{
			if (IsRunning)
			{
				mTerminating = true;
				DoTerminate(millisecondTimeout);
				XLogger.Debug($"TerminateThread sleep : {mName},{Thread.CurrentThread.ManagedThreadId},{mThread.ManagedThreadId},{millisecondTimeout}");
				if (!Thread.CurrentThread.Equals(mThread))
				{
					XLogger.Debug("join ....");
					if (!mThread.Join(millisecondTimeout))
					{
						XLogger.Error("Attempted to join task '{0}' but it didn't shutdown in time ({1} ms). Injecting abort exception to terminate", mName, millisecondTimeout);
						mThread.Abort();
						if (!mThread.Join(500))
						{
							XLogger.Error("Failed to join thread {0} after aborting. Infinite loop? (will prevent editor shutdown and re-play)", mName);
						}
					}
				}
				else
				{
					XLogger.Warn("Thread {0} is trying to stop itself, not calling join!", mName);
				}
				XLogger.Debug("TerminateThread join : name {0} cost: {1} ", mName, millisecondTimeout);
			}
			mThread = null;
			mTerminating = false;
		}
	}

	public override string ToString()
	{
		return mName;
	}
}
