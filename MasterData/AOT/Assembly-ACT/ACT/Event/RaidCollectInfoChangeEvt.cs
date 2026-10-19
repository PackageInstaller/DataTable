namespace ACT.Event;

public class RaidCollectInfoChangeEvt : BaseEventContent
{
	public int collectCount;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		collectCount = 0;
	}
}
