namespace ACT.Event;

public class GotLikeabilityEvent : BaseEventContent
{
	public int gotLikeabilityValue;

	public override void ReleaseEvt()
	{
		gotLikeabilityValue = 0;
	}
}
