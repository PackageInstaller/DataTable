namespace ACT.Battle;

public class EvtDamaged : BaseEvt, IGetAttackData
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
