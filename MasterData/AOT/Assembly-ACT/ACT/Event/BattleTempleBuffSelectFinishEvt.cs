namespace ACT.Event;

public class BattleTempleBuffSelectFinishEvt : BaseEventContent
{
	public int swid;

	public override void ReleaseEvt()
	{
		swid = 0;
		base.ReleaseEvt();
	}
}
