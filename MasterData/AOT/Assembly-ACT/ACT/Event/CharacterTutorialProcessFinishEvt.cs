namespace ACT.Event;

public class CharacterTutorialProcessFinishEvt : BaseEventContent
{
	public int finishProcessId;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		finishProcessId = 0;
	}
}
