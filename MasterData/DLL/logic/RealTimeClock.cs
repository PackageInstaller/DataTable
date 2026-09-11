using System;

public class RealTimeClock
{
	private static readonly DateTime mJanFirst1970 = new DateTime(1970, 1, 1);

	private long mStartTime;

	public long GetElaspedTimeSinceStart()
	{
		return GetMSSinceJan1970() - mStartTime;
	}

	private static long GetMSSinceJan1970()
	{
		return (long)((DateTime.Now.ToUniversalTime() - mJanFirst1970).TotalMilliseconds + 0.5);
	}

	public void StartClock()
	{
		mStartTime = GetMSSinceJan1970();
	}
}
