namespace common.HIERTimerWheel;

public class HIERTimerSlot
{
	public HIERTimerHead mEntry = new HIERTimerHead();

	public HIERTimerSlot()
	{
		mEntry.mNext = mEntry;
		mEntry.mPre = mEntry;
	}

	public bool TakeSlotContent(ref HIERTimerHead newRoot)
	{
		if ((mEntry.mPre == mEntry && mEntry.mNext == mEntry) || newRoot == null)
		{
			return false;
		}
		newRoot.mNext = mEntry.mNext;
		newRoot.mPre = mEntry.mPre;
		newRoot.mNext.mPre = newRoot;
		newRoot.mPre.mNext = newRoot;
		EmptySlot();
		return true;
	}

	private void EmptySlot()
	{
		mEntry.mNext = mEntry;
		mEntry.mPre = mEntry;
	}

	public void InsertHead(HIERTimer timer)
	{
		IHIERTimerNode mNext = mEntry.mNext;
		timer.mPre = mEntry;
		timer.mNext = mNext;
		mNext.mPre = timer;
		mEntry.mNext = timer;
	}

	public void InsertTail(HIERTimer timer)
	{
		IHIERTimerNode mPre = mEntry.mPre;
		mPre.mNext = timer;
		timer.mPre = mPre;
		timer.mNext = mEntry;
		mEntry.mPre = timer;
	}
}
