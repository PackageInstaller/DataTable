namespace ACT.Event;

public class EliteSelectPointRefresh : BaseEventContent
{
	public int elitePointId;

	public bool isTalent;

	public int indexOfThreeProgress;

	public int pointStageIndex;

	public override void ReleaseEvt()
	{
		elitePointId = 0;
		isTalent = false;
		indexOfThreeProgress = 0;
		pointStageIndex = 0;
	}
}
