namespace ACT.Event;

public class PlayerLevelChangeEvt : BaseEventContent
{
	public int beforeLevel;

	public int curretLevel;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		beforeLevel = 0;
		curretLevel = 0;
	}
}
