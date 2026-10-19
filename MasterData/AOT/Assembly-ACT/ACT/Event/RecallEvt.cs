namespace ACT.Event;

public class RecallEvt : BaseEventContent
{
	public int checkPointUID;

	public override void ReleaseEvt()
	{
		checkPointUID = 0;
	}
}
