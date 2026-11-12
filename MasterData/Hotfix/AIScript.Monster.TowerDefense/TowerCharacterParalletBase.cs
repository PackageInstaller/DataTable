using System.Collections.Generic;
using AIScript.DynamicLevel;
using AIScript.Utils;
using Nova.Hotfix;
using TrueSync;
using XLua;

namespace AIScript.Monster.TowerDefense;

public class TowerCharacterParalletBase : ParallelBase
{
	private const string TOWERDEFENSE_GM_FAST_CD = "TowerdefenseGM_FastCD";

	private const string TowerdefenseGM_ChangeFireHeatValue = "TowerdefenseGM_ChangeFireHeatValue";

	public virtual Dictionary<int, int> dicPerkCd { get; }

	public TowerDefenseCharacterActor actor => _actor as TowerDefenseCharacterActor;

	public override void OnEnable()
	{
		base.OnEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastEndSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_ATTACK", OnReceiveAttack);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("AREA_EFFECT_BEGIN", OnAreaEffectBegin);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("AREA_EFFECT_FINISH", OnAreaEffectFinish);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnReceiveBeforeHit);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_CRIT_DAMAGE", OnReceiveCrit);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_PERSONAL_PERK_UPDATE", OnPersonalPerkUpdate);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_FINISH", OnBulletFinish);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("TOWERDEFENSE_ENERGY_CAPSUILE_EVT", OnEnergyUpdate);
		if (actor.IsHotLevel)
		{
			ModuleController<AdventureModuleController>.Instance.AddEventListener("TOWERDEFENSE_UPDATE_GRID_FIRE_COUNT", OnUpdateGridFireCount);
			ModuleController<AdventureModuleController>.Instance.AddEventListener("TOWERDEFENSE_SPRAY_UPDATE_ROLE_FIRE_COUNT", OnSprayUpdateFireCount);
		}
		Singleton<EventDispatchManager>.Instance.AddEventListener("TowerdefenseGM_FastCD", OnGMFastCD);
		Singleton<EventDispatchManager>.Instance.AddEventListener("TowerdefenseGM_ChangeFireHeatValue", OnGMChangeFireHeatValue);
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastEndSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_ATTACK", OnReceiveAttack);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_BEGIN", OnAreaEffectBegin);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_FINISH", OnAreaEffectFinish);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnReceiveBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_CRIT_DAMAGE", OnReceiveCrit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_PERSONAL_PERK_UPDATE", OnPersonalPerkUpdate);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TOWERDEFENSE_ENERGY_CAPSUILE_EVT", OnEnergyUpdate);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TOWERDEFENSE_UPDATE_GRID_FIRE_COUNT", OnUpdateGridFireCount);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TOWERDEFENSE_SPRAY_UPDATE_ROLE_FIRE_COUNT", OnSprayUpdateFireCount);
		Singleton<EventDispatchManager>.Instance?.RemoveEventListener("TowerdefenseGM_FastCD", OnGMFastCD);
		Singleton<EventDispatchManager>.Instance?.RemoveEventListener("TowerdefenseGM_ChangeFireHeatValue", OnGMChangeFireHeatValue);
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
	}

	private void OnReceiveAttack(IEvent evt)
	{
		if (!actor.IsActive)
		{
			return;
		}
		AdventureActorReceiveAttackEvent adventureActorReceiveAttackEvent = evt as AdventureActorReceiveAttackEvent;
		if (adventureActorReceiveAttackEvent != null)
		{
			OnReceiveAttack(adventureActorReceiveAttackEvent);
		}
		if (_actor != null && _actor.Id == adventureActorReceiveAttackEvent.from.Id)
		{
			MonsterAdventureActor monsterAdventureActor = adventureActorReceiveAttackEvent.to as MonsterAdventureActor;
			if (monsterAdventureActor != null)
			{
				OnHitPre(adventureActorReceiveAttackEvent, monsterAdventureActor);
			}
		}
	}

	private void OnReceiveDamage(IEvent evt)
	{
		if (actor.IsActive)
		{
			AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
			if (adventureActorReceiveDamageEvent != null)
			{
				OnReceiveDamage(adventureActorReceiveDamageEvent);
			}
			MonsterAdventureActor monsterAdventureActor = adventureActorReceiveDamageEvent.to as MonsterAdventureActor;
			if (_actor != null && monsterAdventureActor != null)
			{
				OnHitPost(adventureActorReceiveDamageEvent, monsterAdventureActor, _actor.Id == adventureActorReceiveDamageEvent.from.Id);
			}
		}
	}

	private void OnAreaEffectBegin(IEvent evt)
	{
		if (actor.IsActive)
		{
			AdventureAreaEffectBeginEvent adventureAreaEffectBeginEvent = evt as AdventureAreaEffectBeginEvent;
			if (_actor != null && adventureAreaEffectBeginEvent.owner.Id == _actor.Id)
			{
				OnAreaEffectBegin(adventureAreaEffectBeginEvent);
			}
		}
	}

	private void OnAreaEffectFinish(IEvent evt)
	{
		if (actor.IsActive)
		{
			AdventureAreaEffectFinishEvent adventureAreaEffectFinishEvent = evt as AdventureAreaEffectFinishEvent;
			if (_actor != null && adventureAreaEffectFinishEvent.owner.Id == _actor.Id)
			{
				OnAreaEffectFinish(adventureAreaEffectFinishEvent);
			}
		}
	}

	private void OnAreaEffectEnd(IEvent evt)
	{
		if (actor.IsActive)
		{
			AdventureAreaEffectFinishEvent adventureAreaEffectFinishEvent = evt as AdventureAreaEffectFinishEvent;
			if (_actor != null && adventureAreaEffectFinishEvent.owner.Id == _actor.Id)
			{
				OnAreaEffectEnd(adventureAreaEffectFinishEvent);
			}
		}
	}

	private void OnReceiveBeforeHit(IEvent evt)
	{
		if (!actor.IsActive)
		{
			return;
		}
		AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent = evt as AdventureActorReceiveDamageBeforeHitEvent;
		if (_actor != null && adventureActorReceiveDamageBeforeHitEvent.from.Id == _actor.Id)
		{
			MonsterAdventureActor monsterAdventureActor = adventureActorReceiveDamageBeforeHitEvent.to as MonsterAdventureActor;
			if (monsterAdventureActor != null)
			{
				OnBeforeHit(adventureActorReceiveDamageBeforeHitEvent, monsterAdventureActor);
			}
		}
	}

	private void OnReceiveCrit(IEvent evt)
	{
		if (actor.IsActive)
		{
			AdventureActorReceiveCritDamageEvent adventureActorReceiveCritDamageEvent = evt as AdventureActorReceiveCritDamageEvent;
			if (_actor != null && _actor.Id == adventureActorReceiveCritDamageEvent.from.Id && adventureActorReceiveCritDamageEvent.to as MonsterAdventureActor != null)
			{
				OnCrit(adventureActorReceiveCritDamageEvent);
			}
		}
	}

	private void OnCustomEvent(IEvent evt)
	{
		if (actor.IsActive && evt is AdventureActorCustomEvent evt2)
		{
			OnCustomEvent(evt2);
		}
	}

	private void OnElementMarkTrigger(IEvent evt)
	{
		if (actor.IsActive)
		{
			AdventureElementMarkTriggerEvent evt2 = evt as AdventureElementMarkTriggerEvent;
			OnElementMarkTrigger(evt2);
		}
	}

	private void OnPersonalPerkUpdate(IEvent evt)
	{
		if (actor.IsActive && evt is AdventureActorPersonalPerkUpdateEvent adventureActorPersonalPerkUpdateEvent && adventureActorPersonalPerkUpdateEvent.actorDataId == _actor.dataID)
		{
			OnPersonalPerkUpdate(adventureActorPersonalPerkUpdateEvent);
		}
	}

	private void OnEnergyUpdate(IEvent evt)
	{
		if (evt is TowerDefenseEnergyCapsuleEvent evt2)
		{
			OnEnergyUpdate(evt2);
		}
	}

	private void OnGMFastCD(IEvent evt)
	{
		if ((GeneralEvent)evt != null)
		{
			actor.skillMgr.ModifyEnergyByPercent(actor.mainSkillId, 100);
		}
	}

	private void OnGMChangeFireHeatValue(IEvent evt)
	{
		GeneralEvent generalEvent = (GeneralEvent)evt;
		if (generalEvent != null)
		{
			LuaTable luaTable = generalEvent.data as LuaTable;
			if (CommonHelper.TryParseStringParamToInt(luaTable.get_Item((object)1).ToString(), out var intValue) && CommonHelper.TryParseStringParamToInt(luaTable.get_Item((object)2).ToString(), out var intValue2) && intValue == _actor.dataID)
			{
				FP delta = intValue2 - actor.fireHeatValue;
				actor.UpdateFire(delta);
			}
		}
	}

	private void OnCastSkill(IEvent evt)
	{
		AdventureActorCastSkillEvent adventureActorCastSkillEvent = evt as AdventureActorCastSkillEvent;
		if (_actor != null && adventureActorCastSkillEvent.sender as AdventureActor == _actor)
		{
			OnCastSkill(adventureActorCastSkillEvent);
		}
	}

	private void OnCastEndSkill(IEvent evt)
	{
		AdventureActorCastSkillEndEvent adventureActorCastSkillEndEvent = evt as AdventureActorCastSkillEndEvent;
		if (_actor != null && adventureActorCastSkillEndEvent.sender as AdventureActor == _actor)
		{
			OnCastEndSkill(adventureActorCastSkillEndEvent);
		}
	}

	private void OnBulletFinish(IEvent evt)
	{
		if (evt is AdventureBulletFinishEvent adventureBulletFinishEvent && _actor != null && adventureBulletFinishEvent.owner == _actor)
		{
			OnBulletFinish(adventureBulletFinishEvent);
		}
	}

	public virtual void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster)
	{
	}

	public virtual void OnReceiveAttack(AdventureActorReceiveAttackEvent evt)
	{
	}

	public virtual void OnHitPre(AdventureActorReceiveAttackEvent evt, MonsterAdventureActor monster)
	{
	}

	public virtual void OnReceiveDamage(AdventureActorReceiveDamageEvent evt)
	{
	}

	public virtual void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
	}

	public virtual void OnCrit(AdventureActorReceiveCritDamageEvent evt)
	{
	}

	public virtual void OnCastSkill(AdventureActorCastSkillEvent evt)
	{
	}

	public virtual void OnCastEndSkill(AdventureActorCastSkillEndEvent evt)
	{
	}

	public virtual void OnCustomEvent(AdventureActorCustomEvent evt)
	{
	}

	public virtual void OnAreaEffectBegin(AdventureAreaEffectBeginEvent evt)
	{
	}

	public virtual void OnAreaEffectFinish(AdventureAreaEffectFinishEvent evt)
	{
	}

	public virtual void OnElementMarkTrigger(AdventureElementMarkTriggerEvent evt)
	{
	}

	public virtual void OnPersonalPerkUpdate(AdventureActorPersonalPerkUpdateEvent evt)
	{
		if (dicPerkCd != null && dicPerkCd.TryGetValue(evt.perkId, out var value))
		{
			actor.skillMgr.AddRecoveryEnergyRatio(actor.mainSkillId, value);
		}
		TowerDefensePotential towerDefensePotential = Singleton<HotfixDataController>.Instance.GetTowerDefensePotential(evt.perkId);
		if (towerDefensePotential != null && towerDefensePotential.Effect1 != 0)
		{
			if (evt.isNew || evt.newLevel > 0)
			{
				actor.buffComponent.AddBuff(towerDefensePotential.Effect1, actor);
			}
			else
			{
				actor.buffComponent.RemoveBuffByBuffId(towerDefensePotential.Effect1);
			}
		}
	}

	public virtual void OnBulletFinish(AdventureBulletFinishEvent evt)
	{
	}

	public virtual void OnEnergyUpdate(TowerDefenseEnergyCapsuleEvent evt)
	{
		if (actor.Id == evt.entityID)
		{
			actor.skillMgr.ModifyEnergyByPercent(actor.mainSkillId, evt.chargePercent);
		}
	}

	private void OnUpdateGridFireCount(IEvent evt)
	{
		if (actor.IsActive && evt is GeneralEventWithReturnData { sender: var sender } generalEventWithReturnData && CommonUtils.TryParseStringParamToInt(sender?.ToString(), out var intValue) && intValue == actor.dataID)
		{
			if (CommonUtils.TryParseStringParamToFP(generalEventWithReturnData.data?.ToString(), out var fpValue))
			{
				actor.UpdateFireBaseValue(fpValue);
			}
			if (generalEventWithReturnData.returnInt == 1)
			{
				actor.buffComponent.AddBuff(TowerDefenseConfig.buffId_Fire_Strong, actor);
			}
			else
			{
				actor.buffComponent.RemoveBuffByBuffId(TowerDefenseConfig.buffId_Fire_Strong);
			}
		}
	}

	private void OnSprayUpdateFireCount(IEvent evt)
	{
		if (actor.IsActive && evt is GeneralEvent { sender: var sender } generalEvent && CommonUtils.TryParseStringParamToInt(sender?.ToString(), out var intValue) && intValue == actor.dataID && CommonUtils.TryParseStringParamToFP(generalEvent.data?.ToString(), out var fpValue))
		{
			actor.UpdateSparayBaseValue(fpValue);
			actor.buffComponent.RemoveBuffByBuffId(TowerDefenseConfig.buffId_Fire_Strong);
		}
	}

	public bool IsTowerCharacterOrSummoned(LogicEntity entity)
	{
		if (entity is TowerDefenseCharacterActor)
		{
			return true;
		}
		if (_actor.IsSummoned(out var summoner, out var _) && summoner is TowerDefenseCharacterActor)
		{
			return true;
		}
		return false;
	}
}
