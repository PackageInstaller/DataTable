namespace ACT.Event;

public class GuideFinishEvt : BaseEventContent
{
	public int guideId;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
	}
}
