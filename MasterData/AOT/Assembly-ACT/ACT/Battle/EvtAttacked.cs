using Bamboo.ECS;

namespace ACT.Battle;

public class EvtAttacked : BaseEvt
{
	public Entity attacker;

	public override void Reset()
	{
		attacker = default;
	}
}
