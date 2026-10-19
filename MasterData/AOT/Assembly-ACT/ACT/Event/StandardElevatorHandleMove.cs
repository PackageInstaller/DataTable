namespace ACT.Event;

public class StandardElevatorHandleMove : BaseEventContent
{
	public bool inMoveing;

	public override void ReleaseEvt()
	{
		inMoveing = false;
		base.ReleaseEvt();
	}
}
