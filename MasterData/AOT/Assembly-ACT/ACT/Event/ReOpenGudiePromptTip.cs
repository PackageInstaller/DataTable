namespace ACT.Event;

public class ReOpenGudiePromptTip : BaseEventContent
{
	public bool curGuideIsOpeningAndNeedTip;

	public int tipId;

	public override void ReleaseEvt()
	{
		curGuideIsOpeningAndNeedTip = false;
		tipId = 0;
	}
}
