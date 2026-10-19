namespace ACT.Event;

public class TaskGroupFinshEvt : BaseEventContent
{
	public int taskGroupId;

	public override void ReleaseEvt()
	{
		taskGroupId = 0;
	}
}
