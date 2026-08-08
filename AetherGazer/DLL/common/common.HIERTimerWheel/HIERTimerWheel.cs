using System;

namespace common.HIERTimerWheel;

public class HIERTimerWheel
{
	private HIERTimerSlot[] mLayer0 = new HIERTimerSlot[256];

	private HIERTimerSlot[] mLayer1 = new HIERTimerSlot[64];

	private HIERTimerSlot[] mLayer2 = new HIERTimerSlot[64];

	private HIERTimerSlot[] mLayer3 = new HIERTimerSlot[64];

	private HIERTimerSlot[] mLayer4 = new HIERTimerSlot[64];

	private HIERTimerHead root = new HIERTimerHead();

	private HIERTimerHead freeTimer = new HIERTimerHead();

	public Action<HIERTimer> onTrigger;

	private long mJiffies;

	private long mStartRealTime;

	public HIERTimer CreateTimer(uint expires, uint period, object userData, Action<object, bool> action)
	{
		long num = expires + mJiffies;
		HIERTimer hIERTimer = null;
		hIERTimer = ((!freeTimer.mIsEmpty) ? ((HIERTimer)PopFreeNode(freeTimer)) : new HIERTimer(num, period, userData, action));
		hIERTimer.mAction = action;
		hIERTimer.mUserData = userData;
		hIERTimer.mIsFree = false;
		hIERTimer.mExpires = num;
		hIERTimer.mPeriod = period;
		AddTimer(hIERTimer);
		return hIERTimer;
	}

	protected IHIERTimerNode PopFreeNode(HIERTimerHead freeHead)
	{
		IHIERTimerNode mNext = freeHead.mNext;
		IHIERTimerNode mNext2 = freeHead.mNext.mNext;
		mNext2.mPre = freeHead;
		freeHead.mNext = mNext2;
		mNext.mNext = null;
		mNext.mPre = null;
		return mNext;
	}

	protected void PushFreeNode(HIERTimerHead freeHead, HIERTimer timer)
	{
		timer.Reset();
		IHIERTimerNode mPre = freeHead.mPre;
		mPre.mNext = timer;
		timer.mPre = mPre;
		timer.mNext = freeHead;
		freeHead.mPre = timer;
	}

	public HIERTimerWheel()
	{
		mStartRealTime = DateTime.UtcNow.Ticks / 10000;
	}

	protected virtual long GetJiffies()
	{
		return DateTime.UtcNow.Ticks / 10000 - mStartRealTime;
	}

	public void Init()
	{
		mJiffies = GetJiffies();
		for (int i = 0; i < mLayer0.Length; i++)
		{
			mLayer0[i] = new HIERTimerSlot();
		}
		for (int j = 0; j < mLayer1.Length; j++)
		{
			mLayer1[j] = new HIERTimerSlot();
		}
		for (int k = 0; k < mLayer2.Length; k++)
		{
			mLayer2[k] = new HIERTimerSlot();
		}
		for (int l = 0; l < mLayer3.Length; l++)
		{
			mLayer3[l] = new HIERTimerSlot();
		}
		for (int m = 0; m < mLayer4.Length; m++)
		{
			mLayer4[m] = new HIERTimerSlot();
		}
		freeTimer.EmptySlot();
	}

	public void AddTimer(HIERTimer timer)
	{
		long num = timer.mExpires - mJiffies;
		HIERTimerSlot hIERTimerSlot = null;
		long num2 = 0L;
		if (num < 256)
		{
			num2 = timer.mExpires & 0xFF;
			hIERTimerSlot = mLayer0[num2];
		}
		else if (num < 16384)
		{
			num2 = (timer.mExpires >> 8) & 0x3F;
			hIERTimerSlot = mLayer1[num2];
		}
		else if (num < 1048576)
		{
			num2 = (timer.mExpires >> 14) & 0x3F;
			hIERTimerSlot = mLayer2[num2];
		}
		else if (num < 67108864)
		{
			num2 = (timer.mExpires >> 20) & 0x3F;
			hIERTimerSlot = mLayer3[num2];
		}
		else if (num < 0)
		{
			num2 = mJiffies & 0xFF;
			hIERTimerSlot = mLayer0[num2];
		}
		else
		{
			num2 = (timer.mExpires >> 26) & 0x3F;
			hIERTimerSlot = mLayer4[num2];
		}
		if (hIERTimerSlot != null)
		{
			hIERTimerSlot.InsertTail(timer);
			return;
		}
		throw new ArgumentOutOfRangeException();
	}

	public uint CascadeTimer(ref HIERTimerSlot[] slots, uint slotIndex)
	{
		HIERTimerSlot hIERTimerSlot = slots[slotIndex];
		if (hIERTimerSlot != null)
		{
			if (hIERTimerSlot.TakeSlotContent(ref root))
			{
				IHIERTimerNode iHIERTimerNode = root.mNext;
				while (iHIERTimerNode != root)
				{
					IHIERTimerNode mNext = iHIERTimerNode.mNext;
					AddTimer((HIERTimer)iHIERTimerNode);
					iHIERTimerNode = mNext;
				}
			}
			return slotIndex;
		}
		throw new ArgumentNullException();
	}

	private uint GetIndex(int layer)
	{
		long num = mJiffies;
		return (uint)((num >> 8 + layer * 6) & 0x3F);
	}

	public void DestroyTimer(HIERTimer t)
	{
		if (t.mIsFree)
		{
			XLogger.Debug("重复删除");
			return;
		}
		IHIERTimerNode mPre = t.mPre;
		IHIERTimerNode iHIERTimerNode = (mPre.mNext = t.mNext);
		iHIERTimerNode.mPre = mPre;
		if (t.mAction != null)
		{
			t.mAction(t.mUserData, arg2: true);
		}
		PushFreeNode(freeTimer, t);
	}

	public void RunTimer()
	{
		long jiffies = GetJiffies();
		if (jiffies - mJiffies > 1073741823)
		{
			XLogger.Debug("HIERTimerWheel heavy calc timer count: {0}", jiffies - mJiffies);
		}
		while (jiffies - mJiffies >= 0)
		{
			long num = mJiffies & 0xFF;
			if (num == 0L && CascadeTimer(ref mLayer1, GetIndex(0)) == 0 && CascadeTimer(ref mLayer2, GetIndex(1)) == 0 && CascadeTimer(ref mLayer3, GetIndex(2)) == 0)
			{
				CascadeTimer(ref mLayer4, GetIndex(3));
			}
			if (mLayer0[num].TakeSlotContent(ref root))
			{
				IHIERTimerNode iHIERTimerNode = root.mNext;
				while (iHIERTimerNode != root)
				{
					IHIERTimerNode mNext = iHIERTimerNode.mNext;
					HIERTimer hIERTimer = (HIERTimer)iHIERTimerNode;
					if (hIERTimer != null && hIERTimer.mAction != null)
					{
						hIERTimer.mAction(hIERTimer.mUserData, arg2: false);
					}
					if (onTrigger != null)
					{
						onTrigger(hIERTimer);
					}
					if (hIERTimer.mPeriod > 0)
					{
						hIERTimer.mExpires = mJiffies + hIERTimer.mPeriod;
						AddTimer(hIERTimer);
					}
					else
					{
						PushFreeNode(freeTimer, hIERTimer);
					}
					iHIERTimerNode = mNext;
				}
			}
			mJiffies++;
		}
	}

	public void Shutdown()
	{
		onTrigger = null;
	}
}
