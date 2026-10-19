namespace ACT.Battle;

public class EvtPostureDamage : BaseEvt, IGetAttackData
{
	public float beforePosture;

	public float afterPosture;

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
