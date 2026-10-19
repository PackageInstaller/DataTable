namespace ACT.Event;

public class AssistBackEvt : BaseEventContent
{
	public bool isTriggerAssistBack;

	public int lastCharacterId;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		isTriggerAssistBack = false;
		lastCharacterId = 0;
	}
}
