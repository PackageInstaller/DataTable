using System.Collections.Generic;
using TrueSync;
using UnityEngine;

[AddComponentMenu("游戏/冒险模块/武器特性/击中目标后向邻近敌人弹射")]
[DisallowMultipleComponent]
public class WeaponFeatureBounceWhenHitActor : WeaponFeature
{
	[Space]
	public FP maxBounceDistance = 0f;

	protected int _bounceCount;

	protected readonly List<DeterministicCollider> _overlapActors = new List<DeterministicCollider>(5);

	protected int _lastFrameCount = -1;

	public override void OnActive()
	{
		base.OnActive();
		_bounceCount = 0;
		_lastFrameCount = -1;
	}

	public override bool OnHitActor(LogicEntity actor, ref DeterministicRaycastHit raycastHit)
	{
		if (_lastFrameCount == LockStepManager.frameCount)
		{
			return true;
		}
		if (_bounceCount < level)
		{
			_bounceCount++;
			_lastFrameCount = LockStepManager.frameCount;
			LogicEntity owner = attachedWeapon.owner;
			LogicEntity logicEntity = null;
			owner.TryGetParentLogicComponent<ActorSearchTarget>(out var comp);
			if (SceneSingleton<DeterministicCollisionManager>.Instance.CheckCircleOverlap((maxBounceDistance > 0f) ? maxBounceDistance : comp.visionRange, actor.tsTransform.Position, _overlapActors, 256))
			{
				FP fP = FP.MaxValue;
				for (int i = 0; i < _overlapActors.Count; i++)
				{
					AdventureActor adventureActor = _overlapActors.get_Item(i).Entity as AdventureActor;
					if (!(adventureActor == null) && !(adventureActor == actor) && owner.IsConfrontWith(adventureActor) && CheckEntitySearchable(adventureActor) && attachedWeapon.QueryActorHitedTimeout(adventureActor.Id, AdventureModuleController.Config.Combat_HitboxDamageImmuneDuration * _bounceCount))
					{
						FP fP2 = actor.DistanceWithRadius(adventureActor);
						if (!(fP2 >= fP))
						{
							fP = fP2;
							logicEntity = adventureActor;
						}
					}
				}
			}
			if (logicEntity != null)
			{
				attachedWeapon.originPosition = attachedWeapon.tsTransform.Position;
				TSVector2 normalized = (logicEntity.tsTransform.Position - attachedWeapon.tsTransform.Position).normalized;
				TrueSyncTransform tsTransform = attachedWeapon.tsTransform;
				AdventureBulletBase adventureBulletBase = attachedWeapon;
				TSVector2 tSVector = (attachedWeapon.velocityDirection = normalized);
				TSVector2 forward = (adventureBulletBase.originDirection = tSVector);
				tsTransform.Forward = forward;
				attachedWeapon.target = logicEntity;
				attachedWeapon.targetPosition = logicEntity.tsTransform.Position;
				return true;
			}
			return base.OnHitActor(actor, ref raycastHit);
		}
		return base.OnHitActor(actor, ref raycastHit);
	}
}
