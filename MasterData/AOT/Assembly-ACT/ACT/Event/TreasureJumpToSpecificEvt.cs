namespace ACT.Event;

public class TreasureJumpToSpecificEvt : BaseEventContent
{
	public int OpenType;

	public int JumpTargetTreasureId;

	public override void ReleaseEvt()
	{
		OpenType = 0;
		JumpTargetTreasureId = -1;
	}
}
