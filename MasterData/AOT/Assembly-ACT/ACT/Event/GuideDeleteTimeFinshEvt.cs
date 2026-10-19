namespace ACT.Event;

public class GuideDeleteTimeFinshEvt : BaseEventContent
{
	public int stepId;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		stepId = 0;
	}
}
