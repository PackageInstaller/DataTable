namespace ACT.Event;

public class UpdateFirstAreaCompleteEvt : BaseEventContent
{
	public int index;

	public int AreaId;

	public bool isComplete;

	public override void ReleaseEvt()
	{
		index = 0;
		AreaId = 0;
		isComplete = false;
	}
}
