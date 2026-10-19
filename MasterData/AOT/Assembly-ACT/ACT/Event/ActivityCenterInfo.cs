namespace ACT.Event;

public class ActivityCenterInfo : BaseEventContent
{
	public int activityId;

	public override void ReleaseEvt()
	{
		activityId = 0;
		base.ReleaseEvt();
	}
}
