namespace ACT.Battle;

public class EvtBeforeShieldConsume : BaseEvt, IGetAttackData
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
