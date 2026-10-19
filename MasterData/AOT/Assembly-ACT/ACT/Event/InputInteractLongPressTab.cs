namespace ACT.Event;

public class InputInteractLongPressTab : BaseEventContent
{
	public float pressTime;

	public bool isOver;

	public override void ReleaseEvt()
	{
		pressTime = 0f;
		isOver = false;
		base.ReleaseEvt();
	}
}
