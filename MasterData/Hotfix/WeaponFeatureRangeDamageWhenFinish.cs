using TrueSync;
using UnityEngine;

[AddComponentMenu("游戏/冒险模块/武器特性/完结时造成范围伤害")]
[DisallowMultipleComponent]
public class WeaponFeatureRangeDamageWhenFinish : WeaponFeature
{
	public int hitDamageId;

	[Space]
	public FP damageArea = 0f;

	public override bool OnEnd()
	{
		if (damageArea > 0)
		{
			attachedWeapon.hitBox.hitDamageId = hitDamageId;
			attachedWeapon.hitBox.CircleAreaHit(damageArea, 0f, attachedWeapon.tsTransform.Position, out var _, out var _, attachedWeapon.uniqueAttackId);
		}
		return base.OnEnd();
	}
}
