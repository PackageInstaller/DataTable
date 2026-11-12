using TrueSync;
using UnityEngine;

public interface IHitBoxContext
{
	FP QueryHitBoxContextTime();

	TSVector2 QueryHitBoxContextPosition();

	TSVector2 QueryHitBoxContextDirection();

	bool QueryActorHitedTimeout(long actorId, FP timeout);

	void SetActorHitedTime(long actorId, FP time);

	bool CheckHitable(HitBox hitBox, LogicEntity actor);

	bool OnHitActor(HitBox hitBox, int uniqueAttackId, int onceAttackTargetCount, LogicEntity actor, ref DeterministicRaycastHit raycastHit, out bool damaged, GameObject hurtEffectPrefab, bool isHittedEffectScale, bool effectIgnoreTimeScale = true);

	bool OnHitShield(HitBox hitBox, AdventureWeapon shield, ref DeterministicRaycastHit raycastHit);

	bool OnHitObstacle(HitBox hitBox, AdventureObstacle obstacle, ref DeterministicRaycastHit raycastHit);

	bool OnHitDestructibleObstacle(HitBox hitBox, int uniqueAttackId, int onceAttackTargetCount, LogicEntity actor, ref DeterministicRaycastHit raycastHit, out bool damaged, GameObject hurtEffectPrefab, bool isHittedEffectScale, bool effectIgnoreTimeScale = true);
}
