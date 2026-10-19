using Bamboo.ECS;

namespace ACT.Battle;

public class EvtAccumulateDamage : BaseEvt
{
	public Entity attackee;

	public float AccumulatedDamage;

	public override void Reset()
	{
	}
}
