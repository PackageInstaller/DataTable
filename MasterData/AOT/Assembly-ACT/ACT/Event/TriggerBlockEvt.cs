namespace ACT.Event;

public class TriggerBlockEvt : BaseEventContent
{
	public int characterId;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		characterId = 0;
	}
}
