namespace ACT.Event;

public class RefreshBattleMainRefreshCanvasGroup : BaseEventContent
{
	public bool isActive;

	public override void ReleaseEvt()
	{
		isActive = false;
	}
}
