namespace ACT.Event;

public class WorldLevelTaskNotifyEvt : BaseEventContent
{
	public int taskId;

	public override void ReleaseEvt()
	{
		taskId = 0;
	}
}
