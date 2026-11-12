using UnityEngine;

[AddComponentMenu("游戏/冒险模块/武器特性/触发事件销毁")]
[DisallowMultipleComponent]
public class WeaponFeatureControlFinish : WeaponFeature
{
	public override void OnActive()
	{
		base.OnActive();
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("TRIGGER_BULLUT_FINISH", OnBullutFinish);
	}

	public override void OnDeactive()
	{
		base.OnDeactive();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TRIGGER_BULLUT_FINISH", OnBullutFinish);
	}

	public void OnBullutFinish(IEvent evt)
	{
		if (evt is AdventureBullutFinishTrigger adventureBullutFinishTrigger && adventureBullutFinishTrigger.actor == attachedWeapon.owner)
		{
			attachedWeapon.Finish();
		}
	}

	public override bool OnHitActor(LogicEntity actor, ref DeterministicRaycastHit raycastHit)
	{
		AdventureBullutHitTrigger adventureBullutHitTrigger = AdventureBullutHitTrigger.Generate();
		adventureBullutHitTrigger.fromActor = attachedWeapon.owner as AdventureActor;
		adventureBullutHitTrigger.toActor = actor as AdventureActor;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureBullutHitTrigger);
		return base.OnHitActor(actor, ref raycastHit);
	}
}
