using Bamboo.ECS;

namespace ACT.Battle;

public class EvtCreateBullet : BaseEvt, IBulletEvt
{
	public Entity bullet;

	public Entity Bullet => bullet;

	public override void Reset()
	{
		bullet = default;
	}
}
