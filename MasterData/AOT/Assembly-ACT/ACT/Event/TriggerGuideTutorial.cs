namespace ACT.Event;

public class TriggerGuideTutorial : BaseEventContent
{
	public int triggerTutorialId;

	public float duration;

	public override void ReleaseEvt()
	{
		triggerTutorialId = 0;
		duration = 0f;
	}
}
