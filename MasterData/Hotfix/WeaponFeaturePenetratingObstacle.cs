using UnityEngine;

[AddComponentMenu("游戏/冒险模块/武器特性/穿透障碍物")]
[DisallowMultipleComponent]
public class WeaponFeaturePenetratingObstacle : WeaponFeature
{
	protected int _lastFrameCount = -1;

	public override void OnActive()
	{
		base.OnActive();
		_lastFrameCount = -1;
	}

	public override bool OnHitObstacle(AdventureObstacle obstacle, ref DeterministicRaycastHit raycastHit)
	{
		if (_lastFrameCount == LockStepManager.frameCount)
		{
			return true;
		}
		_lastFrameCount = LockStepManager.frameCount;
		return true;
	}
}
