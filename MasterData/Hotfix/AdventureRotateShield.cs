using System;
using UnityEngine;

[Obsolete]
public class AdventureRotateShield : AdventureRotateWeapon
{
	public override bool isShield => true;

	protected override void OnInit()
	{
		base.OnInit();
		gameObject.layer = 14;
		if (dtCollider != null)
		{
			dtCollider.layer = 14;
		}
		if (weaponColliders == null || weaponColliders.Length == 0)
		{
			owner.LogError("旋转盾牌碰撞体没有配置");
			return;
		}
		for (int i = 0; i < weaponColliders.Length; i++)
		{
			weaponColliders[i].layer = 14;
		}
	}

	protected override void OnActive()
	{
		base.OnActive();
		tsTransform.transformSyncEnabled = true;
	}

	protected override void CheckWeaponCollidersHit()
	{
	}

	protected override void OnVisualUpdate()
	{
		Vector3 position = owner.transform.position;
		position.y = transform.position.y;
		transform.position = position;
	}
}
