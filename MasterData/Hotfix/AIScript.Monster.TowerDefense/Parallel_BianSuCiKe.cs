using AIScript.DynamicLevel;

namespace AIScript.Monster.TowerDefense;

public class Parallel_BianSuCiKe : TowerMonsterParalletBase
{
	public override void OnStart()
	{
		base.OnStart();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("AREA_EFFECT_ENTER_EXIT", OnAreaEnterOrExit);
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_ENTER_EXIT", OnAreaEnterOrExit);
	}

	private void OnAreaEnterOrExit(IEvent evt)
	{
		if (evt is AdventureAreaEnterExitEvent { iEnter: not false } adventureAreaEnterExitEvent && !(adventureAreaEnterExitEvent.owner == null) && adventureAreaEnterExitEvent.owner.Id == _actor.Id && adventureAreaEnterExitEvent.sender is AreaEffectEntity areaEffectEntity && areaEffectEntity.CheckTag("BianSuCiKe_Dark") && !(adventureAreaEnterExitEvent.triggerCollider?.Entity == null))
		{
			TowerDefenseCharacterActor towerDefenseCharacterActor = adventureAreaEnterExitEvent.triggerCollider.Entity as TowerDefenseCharacterActor;
			if (!(towerDefenseCharacterActor == null))
			{
				towerDefenseCharacterActor.buffComponent.AddBuff(TowerDefenseConfig.buffId_RoleDarken, _actor);
				Dispatch_DarkenRoleGrid(towerDefenseCharacterActor.dataID);
			}
		}
	}
}
