namespace ACT.Event;

public class NpcAssistChangeEvt : BaseEventContent
{
	public int worldId;

	public int npcId;

	public bool npcAssist;

	public override void ReleaseEvt()
	{
		npcId = 0;
		npcAssist = false;
		base.ReleaseEvt();
	}
}
