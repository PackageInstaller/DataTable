namespace ACT.Event;

public class ReadGuideTutorial : BaseEventContent
{
	public int ReadTutorialId;

	public override void ReleaseEvt()
	{
		ReadTutorialId = 0;
	}
}
