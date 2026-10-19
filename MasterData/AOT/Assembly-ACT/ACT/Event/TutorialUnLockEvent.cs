namespace ACT.Event;

public class TutorialUnLockEvent : BaseEventContent
{
	public int TutorialId;

	public override void ReleaseEvt()
	{
		TutorialId = 0;
	}
}
