namespace ACT.Event;

public class GuideTutorialAward : BaseEventContent
{
	public int RewardTutorialId;

	public override void ReleaseEvt()
	{
		RewardTutorialId = 0;
	}
}
