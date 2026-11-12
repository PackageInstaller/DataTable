using UnityEngine;

[AddComponentMenu("游戏/冒险模块/武器特性/只有攻击目标受到伤害")]
[DisallowMultipleComponent]
public class WeaponFeatureCertainActorHitted : WeaponFeature
{
	protected int _lastFrameCount = -1;

	public override void OnActive()
	{
		base.OnActive();
		_lastFrameCount = -1;
	}

	public override bool OnHitActor(LogicEntity actor, ref DeterministicRaycastHit raycastHit)
	{
		if (_lastFrameCount == LockStepManager.frameCount)
		{
			return false;
		}
		_lastFrameCount = LockStepManager.frameCount;
		return attachedWeapon.target == actor;
	}
}
