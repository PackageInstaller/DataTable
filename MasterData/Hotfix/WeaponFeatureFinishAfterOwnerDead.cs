using UnityEngine;

[AddComponentMenu("游戏/冒险模块/武器特性/持有者死亡时完结")]
[DisallowMultipleComponent]
public class WeaponFeatureFinishAfterOwnerDead : WeaponFeature
{
	public override void OnUpdate()
	{
		base.OnUpdate();
		if (attachedWeapon != null && attachedWeapon.owner is AdventureActor adventureActor && !adventureActor.actorHealthInfo.isAlive)
		{
			finishAttachedWeapon = true;
		}
	}
}
