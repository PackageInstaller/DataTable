namespace ACT.Event;

public class CharacterTutorialEnterOrLeaveRaidEvt : BaseEventContent
{
	public bool isEnterRaid;

	public override void ReleaseEvt()
	{
		isEnterRaid = false;
	}
}
