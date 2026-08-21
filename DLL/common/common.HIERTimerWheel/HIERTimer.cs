using System;
using System.Threading;

namespace common.HIERTimerWheel;

public class HIERTimer : IHIERTimerNode
{
	private static volatile int sFeed;

	private int mID;

	public Action<object, bool> mAction;

	public long mExpires;

	public long mPeriod;

	public object mUserData;

	public bool mIsFree;

	public IHIERTimerNode mPre { get; set; }

	public IHIERTimerNode mNext { get; set; }

	public HIERTimer(long expires, uint period, Action<object, bool> action)
	{
		mID = Interlocked.Increment(ref sFeed);
		mAction = action;
		mExpires = expires;
		mPeriod = period;
		mUserData = null;
	}

	public HIERTimer(long expires, uint period, object userData, Action<object, bool> action)
	{
		mID = Interlocked.Increment(ref sFeed);
		mAction = action;
		mExpires = expires;
		mPeriod = period;
		mUserData = userData;
	}

	public void Reset()
	{
		mIsFree = true;
		mID = 0;
		mAction = null;
		mExpires = 0L;
		mPeriod = 0L;
		mUserData = null;
	}
}
