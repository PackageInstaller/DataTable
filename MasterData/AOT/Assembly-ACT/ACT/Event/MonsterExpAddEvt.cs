namespace ACT.Event;

public class MonsterExpAddEvt : BaseEventContent
{
	public long addNum;

	public override void ReleaseEvt()
	{
		addNum = 0L;
	}
}
