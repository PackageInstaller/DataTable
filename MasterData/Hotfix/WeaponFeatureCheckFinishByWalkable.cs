using UnityEngine;

[AddComponentMenu("游戏/冒险模块/武器特性/处于非行走层时完结")]
[DisallowMultipleComponent]
public class WeaponFeatureCheckFinishByWalkable : WeaponFeature
{
	public override void OnUpdate()
	{
		base.OnUpdate();
		if (!(attachedWeapon == null) && !(attachedWeapon.owner == null) && !((AdventureActor)attachedWeapon.owner).QueryPositionWalkable(attachedWeapon.tsTransform.Position, attachedWeapon.tsTransform.PositionY))
		{
			finishAttachedWeapon = true;
		}
	}
}
