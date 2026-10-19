namespace ACT.Event;

public class MissionNConditionUpdateEvt : BaseEventContent
{
	public int missionId;

	public int conditionId;

	public int progress;

	public bool finished;
}
