using System.Collections.Generic;
using AIScript.DynamicLevel;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster.TowerDefense._12001;

public class Parallel : TowerCharacterParalletBase
{
	private int hitTag_Garland = CommonHelper.StringToHash("120_B1");

	private string weaponTag_Garland = "120_B1_Garland";

	private const int perkId_1 = 1200101;

	private int onceId_P01 = 811200001;

	private const int perkId_2 = 1200102;

	private FP chargePercent_P02 = 5;

	private FP triggerCD_P02 = 1;

	private FP checkRadius_P02 = 5;

	private const int perkId_3 = 1200103;

	private const int perkId_4 = 1200104;

	private Dictionary<int, int> _dicPerkCd = new Dictionary<int, int> { [1200107] = 25 };

	private int garlandCount;

	private List<LogicEntity> friendEntities = new List<LogicEntity>();

	private Dictionary<long, FP> p02TriggerTimeDic = new Dictionary<long, FP>();

	public override Dictionary<int, int> dicPerkCd => _dicPerkCd;

	public override void OnEnable()
	{
		base.OnEnable();
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("WEAPON_BORN", OnWeaponBorn);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("WEAPON_FINISH", OnWeaponFinish);
		garlandCount = 0;
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("WEAPON_BORN", OnWeaponBorn);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("WEAPON_FINISH", OnWeaponFinish);
		friendEntities.Clear();
		p02TriggerTimeDic.Clear();
	}

	public void OnUpdate()
	{
		if (!GetPerk(1200102) || garlandCount <= 0)
		{
			return;
		}
		FP range = checkRadius_P02;
		CommonUtils.SearchNearTargetsByCircleInTD(actor, _actor.tsTransform.Position, range, friendEntities);
		for (int i = 0; i < friendEntities.Count; i++)
		{
			if (friendEntities.get_Item(i) is TowerDefenseCharacterActor towerDefenseCharacterActor && towerDefenseCharacterActor.Id != _actor.Id && CheckP02Cd(towerDefenseCharacterActor.Id))
			{
				towerDefenseCharacterActor.skillMgr.ModifyEnergyByPercent(towerDefenseCharacterActor.mainSkillId, chargePercent_P02);
			}
		}
	}

	private bool CheckP02Cd(long id)
	{
		if (p02TriggerTimeDic.TryGetValue(id, out var value))
		{
			if (_actor.LogicTime - value > triggerCD_P02)
			{
				p02TriggerTimeDic.set_Item(id, _actor.LogicTime);
				return true;
			}
			return false;
		}
		p02TriggerTimeDic.Add(id, _actor.LogicTime);
		return true;
	}

	public override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster)
	{
		base.OnBeforeHit(evt, monster);
		if (GetPerk(1200101) && CommonUtils.CheckHitByTag(evt.hitDamageTag, hitTag_Garland))
		{
			AdventureActor.AddFromAttr(onceId_P01, _actor);
		}
	}

	private void OnWeaponBorn(IEvent evt)
	{
		if (actor.IsActive && evt is AdventureWeaponBornEvent adventureWeaponBornEvent && !(adventureWeaponBornEvent.owner == null) && adventureWeaponBornEvent.owner.Id == _actor.Id && adventureWeaponBornEvent.weaponTag == weaponTag_Garland)
		{
			garlandCount++;
		}
	}

	private void OnWeaponFinish(IEvent evt)
	{
		if (evt is AdventureWeaponFinishEvent adventureWeaponFinishEvent && !(adventureWeaponFinishEvent.owner == null) && adventureWeaponFinishEvent.owner.Id == _actor.Id && adventureWeaponFinishEvent.weaponTag == weaponTag_Garland && garlandCount > 0)
		{
			garlandCount--;
		}
	}
}
