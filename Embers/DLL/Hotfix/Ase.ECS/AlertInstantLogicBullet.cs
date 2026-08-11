using GameFramework;

namespace Ase.ECS;

public class AlertInstantLogicBullet : LogicBullet
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
			bulletLifeComponent.DoShadowEndLife();
			bulletTriggerComponent?.DoAlertTriggerUpdate(deltaTime);
		}
	}

	public override void OnDead()
	{
		base.OnDead();
		bulletTriggerComponent?.OnNormalDead();
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
