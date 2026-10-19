namespace ACT.Event;

public class UpdateAreaRewardEvt : BaseEventContent
{
	public int AreaId;

	public override void ReleaseEvt()
	{
		AreaId = 0;
	}
}
