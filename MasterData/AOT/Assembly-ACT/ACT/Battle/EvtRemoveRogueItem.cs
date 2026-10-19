namespace ACT.Battle;

public class EvtRemoveRogueItem : BaseEvt
{
	public int itemId;

	public override void Reset()
	{
		itemId = 0;
	}
}
