namespace ACT.Event;

public class UpdateLittleItemEvt : BaseEventContent
{
	public int bottleUid;

	public int itemId;

	public override void ReleaseEvt()
	{
		itemId = 0;
	}
}
