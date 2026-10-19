namespace ACT.Battle;

public class EvtModifyDamage : BaseEvt, IGetAttackData
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
