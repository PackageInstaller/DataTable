namespace ACT.Event;

public class RogueCloseInteractTips : BaseEventContent
{
	public int swuid;

	public override void ReleaseEvt()
	{
		swuid = 0;
	}
}
