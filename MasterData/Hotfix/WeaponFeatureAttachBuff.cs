using UnityEngine;

[AddComponentMenu("游戏/冒险模块/武器特性/击中目标时附加Buff")]
[DisallowMultipleComponent]
public class WeaponFeatureAttachBuff : WeaponFeature
{
	public string buffID;

	public override bool OnHitActor(LogicEntity actor, ref DeterministicRaycastHit raycastHit)
	{
		return base.OnHitActor(actor, ref raycastHit);
	}
}
