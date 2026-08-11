using GameFramework;

namespace Ase.ECS;

public class InstantLogicBullet : LogicBullet
{
	private BulletLifeComponent bulletLifeComponent;

	private BulletTriggerComponent bulletTriggerComponent;

	public override void OnStart()
	{
		base.OnStart();
		bulletLifeComponent = bullet.GetComponent<BulletLifeComponent>();
		bulletTriggerComponent = bullet.GetComponent<BulletTriggerComponent>();
	}

	public override void OnFixedUpdate(float deltaTime)
	{
		if (bullet.IsSurvival)
		{
			bulletTriggerComponent?.DoTriggerUpdate(deltaTime);
			bullet.DoEntityDead();
		}
	}

	public override void OnDead()
	{
		base.OnDead();
		if (bullet != null)
		{
			bulletTriggerComponent?.OnNormalDead();
			bulletLifeComponent?.DoEndLife();
		}
	}

	public override void OnDispose()
	{
		ReferencePool.Release(this);
	}

	protected override void OnClear()
	{
		bulletLifeComponent = null;
		bulletTriggerComponent = null;
	}
}
