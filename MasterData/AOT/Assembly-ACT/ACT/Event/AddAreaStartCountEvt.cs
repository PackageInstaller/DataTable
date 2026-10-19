namespace ACT.Event;

public class AddAreaStartCountEvt : BaseEventContent
{
	public int AreaId;

	public int AddStarCount;

	public override void ReleaseEvt()
	{
		AreaId = 0;
		AddStarCount = 0;
	}
}
