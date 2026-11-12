using TrueSync;
using UnityEngine;

[AddComponentMenu("游戏/冒险模块/武器特性/击中障碍物后反射或停止")]
[DisallowMultipleComponent]
public class WeaponFeatureReflectWhenHitObstacleOrStop : WeaponFeature
{
	protected int _bounceCount;

	protected int _lastFrameCount = -1;

	[HideInInspector]
	public bool isStop;

	public override void OnActive()
	{
		base.OnActive();
		_bounceCount = 0;
		_lastFrameCount = -1;
	}

	public override bool OnHitObstacle(AdventureObstacle obstacle, ref DeterministicRaycastHit raycastHit)
	{
		if (isStop)
		{
			AdventureBulletBlockEvent adventureBulletBlockEvent = AdventureBulletBlockEvent.Generate();
			adventureBulletBlockEvent.sender = attachedWeapon;
			adventureBulletBlockEvent.owner = attachedWeapon.owner as AdventureActor;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureBulletBlockEvent);
			return true;
		}
		if (_lastFrameCount > LockStepManager.frameCount)
		{
			return true;
		}
		if (_bounceCount < level)
		{
			_bounceCount++;
			_lastFrameCount = LockStepManager.frameCount;
			TSVector2 normalized = attachedWeapon.velocityDirection.normalized;
			FP fP = TSMath.Max(attachedWeapon.velocitySpeed * attachedWeapon.LogicDeltaTime - raycastHit.distance, 0);
			TSVector2 normalized2 = TSVector2.Reflect(normalized, raycastHit.normal).normalized;
			TSVector2 point = raycastHit.point;
			if (fP > 0)
			{
				point += normalized2 * fP;
			}
			TrueSyncTransform tsTransform = attachedWeapon.tsTransform;
			TSVector2 position = (attachedWeapon.originPosition = point);
			tsTransform.Position = position;
			TrueSyncTransform tsTransform2 = attachedWeapon.tsTransform;
			AdventureBulletBase adventureBulletBase = attachedWeapon;
			TSVector2 tSVector2 = (attachedWeapon.velocityDirection = normalized2);
			position = (adventureBulletBase.originDirection = tSVector2);
			tsTransform2.Forward = position;
			return true;
		}
		return base.OnHitObstacle(obstacle, ref raycastHit);
	}
}
