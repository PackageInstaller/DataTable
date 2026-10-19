using ACT.World.Asset;

namespace ACT.Event;

public class BigWorldChallengeResultEvt : BaseEventContent
{
	public ChallengeType challengeType;

	public int configId;

	public bool success;

	public override void ReleaseEvt()
	{
		challengeType = ChallengeType.Break;
		configId = 0;
		success = false;
	}
}
