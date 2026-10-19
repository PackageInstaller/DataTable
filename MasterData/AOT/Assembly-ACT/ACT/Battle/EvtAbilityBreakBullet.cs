using Bamboo.ECS;

namespace ACT.Battle;

public class EvtAbilityBreakBullet : BaseEvt
{
	public Entity bullet;

	public override void Reset()
	{
		bullet = default;
	}
}
