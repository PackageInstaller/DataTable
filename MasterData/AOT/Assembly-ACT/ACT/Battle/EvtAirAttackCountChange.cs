namespace ACT.Battle;

public class EvtAirAttackCountChange : BaseEvt
{
	public int count;

	public override void Reset()
	{
		count = 0;
	}
}
