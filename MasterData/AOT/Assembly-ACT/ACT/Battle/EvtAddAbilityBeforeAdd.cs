namespace ACT.Battle;

public class EvtAddAbilityBeforeAdd : BaseAddAbilityEvt
{
	public int stack;

	public override void Reset()
	{
		stack = 0;
		name = null;
		mainEntity = default;
		targetEntity = default;
		ability = null;
	}
}
