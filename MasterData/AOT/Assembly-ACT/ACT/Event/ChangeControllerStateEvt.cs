namespace ACT.Event;

public class ChangeControllerStateEvt : BaseEventContent
{
	public int swid;

	public int state;

	public override void ReleaseEvt()
	{
		swid = 0;
		state = 0;
		base.ReleaseEvt();
	}
}
