using TrueSync;
using UnityEngine;

[AddComponentMenu("游戏/冒险模块/武器特性/完结时重置子弹")]
[DisallowMultipleComponent]
public class WeaponFeatureResetWhenFinish : WeaponFeature
{
	protected int _currentResetCount;

	public override void OnActive()
	{
		base.OnActive();
		_currentResetCount = 0;
	}

	public override bool OnEnd()
	{
		if (_currentResetCount < level)
		{
			_currentResetCount++;
			FP fP = TSVector2.Distance(attachedWeapon.targetPosition, attachedWeapon.originPosition);
			TSVector2 targetPosition = attachedWeapon.tsTransform.Position + attachedWeapon.velocityDirection * fP;
			attachedWeapon.Reset(attachedWeapon.owner, attachedWeapon.tsTransform.Position, attachedWeapon.tsTransform.PositionY, attachedWeapon.velocityDirection, attachedWeapon.target, targetPosition);
			return true;
		}
		return base.OnEnd();
	}
}
