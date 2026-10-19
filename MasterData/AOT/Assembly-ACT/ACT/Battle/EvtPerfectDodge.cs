using Bamboo.ECS;

namespace ACT.Battle;

public class EvtPerfectDodge : BaseEvt
{
	public Entity attacker;

	public override void Reset()
	{
		attacker = default;
	}
}
