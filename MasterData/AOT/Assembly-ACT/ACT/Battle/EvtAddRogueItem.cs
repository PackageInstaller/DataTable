namespace ACT.Battle;

public class EvtAddRogueItem : BaseEvt
{
	public int itemId;

	public override void Reset()
	{
		itemId = 0;
	}
}
