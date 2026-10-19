namespace ACT.Event;

public class RefreshSystemUnlockRedDot : BaseEventContent
{
	public int systemId;

	public bool isActive;

	public override void ReleaseEvt()
	{
		systemId = 0;
		isActive = false;
	}
}
