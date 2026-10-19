namespace ACT.Battle;

public class EvtKillEntity : BaseEvt, IGetAttackData
{
	public AttackData attackData;

	public override void Reset()
	{
		attackData = null;
	}

	public AttackData GetAttackData()
	{
		return attackData;
	}
}
