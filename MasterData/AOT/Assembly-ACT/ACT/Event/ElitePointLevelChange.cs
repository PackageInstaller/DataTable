namespace ACT.Event;

public class ElitePointLevelChange : BaseEventContent
{
	public bool isLevelUp;

	public int elitePointId;

	public int indexOfThreeProgress;

	public override void ReleaseEvt()
	{
		isLevelUp = false;
		elitePointId = 0;
		indexOfThreeProgress = 0;
	}
}
