namespace ACT.Event;

public class RefreshSystemEntriesInBossChaseBattle : BaseEventContent
{
	public bool isActive;

	public override void ReleaseEvt()
	{
		isActive = false;
	}
}
