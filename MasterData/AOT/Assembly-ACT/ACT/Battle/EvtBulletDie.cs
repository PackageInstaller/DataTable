using Bamboo.ECS;

namespace ACT.Battle;

public class EvtBulletDie : BaseEvt, IBulletEvt
{
	public Entity bullet;

	public Entity Bullet => bullet;

	public override void Reset()
	{
		bullet = default;
	}
}
