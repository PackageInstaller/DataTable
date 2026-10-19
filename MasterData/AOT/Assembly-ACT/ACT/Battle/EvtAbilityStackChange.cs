namespace ACT.Battle;

public class EvtAbilityStackChange : BaseEvt
{
	public int change;

	public override void Reset()
	{
		change = 0;
	}
}
