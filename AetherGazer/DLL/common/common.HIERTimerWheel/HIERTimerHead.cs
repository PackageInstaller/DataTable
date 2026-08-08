using System.Threading;

namespace common.HIERTimerWheel;

public class HIERTimerHead : ISpinLock, IHIERTimerNodeHead, IHIERTimerNode
{
	public SpinLock mSpinLock { get; set; }

	public IHIERTimerNode mPre { get; set; }

	public IHIERTimerNode mNext { get; set; }

	public bool mIsEmpty
	{
		get
		{
			if (mPre == this)
			{
				return mNext == this;
			}
			return false;
		}
	}

	public void EmptySlot()
	{
		mNext = this;
		mPre = this;
	}
}
