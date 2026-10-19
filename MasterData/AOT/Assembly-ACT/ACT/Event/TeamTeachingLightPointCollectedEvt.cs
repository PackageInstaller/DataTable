namespace ACT.Event;

public class TeamTeachingLightPointCollectedEvt : BaseEventContent
{
	public int stateWorldAssetUid;

	public override void ReleaseEvt()
	{
		base.ReleaseEvt();
		stateWorldAssetUid = 0;
	}
}
