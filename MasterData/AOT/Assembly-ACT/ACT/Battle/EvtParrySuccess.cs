using Bamboo.ECS;

namespace ACT.Battle;

public class EvtParrySuccess : BaseEvt
{
	public Entity attackee;

	public Entity attacker;

	public Entity directAttacker;

	public override void Reset()
	{
	}
}
