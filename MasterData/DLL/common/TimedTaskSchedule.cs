using System;
using System.Threading;

public sealed class TimedTaskSchedule : TaskScheduleBase
{
	private DateTime mNextTick;

	private int mThreadPeriodMS;

	public int TimerIntervalMS
	{
		get
		{
			return mThreadPeriodMS;
		}
		set
		{
			if (value < 0)
			{
				throw new ArgumentException($"Timed Task interval cannot be less than zero!!");
			}
			mThreadPeriodMS = value;
		}
	}

	public TimedTaskSchedule(Action<TaskScheduleBase> workerCallback, string name, int updatePeriodMS)
		: base(workerCallback, name)
	{
		mThreadPeriodMS = updatePeriodMS;
	}

	protected override void DoTerminate(int millisecondTimeout)
	{
		Thread.Sleep(mThreadPeriodMS);
	}

	protected override void OnStart()
	{
		mNextTick = DateTime.Now.AddMilliseconds(mThreadPeriodMS);
	}

	public bool ResetNextRunTimeIfTooFarInPast(int maxInPastMilliseconds)
	{
		if (base.IsRunning)
		{
			DateTime now = DateTime.Now;
			if (now > mNextTick && (now - mNextTick).TotalMilliseconds > (double)maxInPastMilliseconds)
			{
				mNextTick = now;
				return true;
			}
		}
		return false;
	}

	protected override void RunThreadBlocker()
	{
		DateTime now = DateTime.Now;
		TimeSpan timeSpan = mNextTick - now;
		if (timeSpan.TotalMilliseconds > 0.0)
		{
			int millisecondsTimeout = (int)timeSpan.TotalMilliseconds;
			Thread.Sleep(millisecondsTimeout);
		}
		mNextTick = mNextTick.AddMilliseconds(mThreadPeriodMS);
	}

	public override string ToString()
	{
		return base.Name + " (@" + TimerIntervalMS + "ms)";
	}
}
