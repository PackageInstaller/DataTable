namespace ACT.Battle;

public class EvtTenacitiedDamaged : BaseEvt, IGetAttackData
{
	public AttackData attackData;

	public AttackData GetAttackData()
	{
		return attackData;
	}

	public override void Reset()
	{
		attackData = null;
	}
}
