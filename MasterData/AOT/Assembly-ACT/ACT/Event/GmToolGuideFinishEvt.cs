namespace ACT.Event;

public class GmToolGuideFinishEvt : BaseEventContent
{
	public bool isAllFinsh;

	public int guideId;

	public bool finshCurrent;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		guideId = 0;
		isAllFinsh = false;
	}
}
