namespace ACT.Event;

public class GachaTargetStateChangedEvent : BaseEventContent
{
	public int GachaId;

	public int TargetGachaItemId;

	public int TargetPoint;

	public override void OnGet()
	{
		GachaId = 0;
		TargetGachaItemId = 0;
		TargetPoint = 0;
	}
}
