namespace common.HIERTimerWheel;

public interface IHIERTimerNode
{
	IHIERTimerNode mPre { get; set; }

	IHIERTimerNode mNext { get; set; }
}
