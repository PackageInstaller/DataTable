using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14401;

public class ParallelScript : ParallelBase
{
	public override void OnEnable()
	{
		base.OnEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_ATTACK", OnReceiveAttack);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_NODAMAGE", OnReceiveNoDamage);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
	}

	private void OnCastSkill(IEvent evt)
	{
		AdventureActorCastSkillEvent adventureActorCastSkillEvent = evt as AdventureActorCastSkillEvent;
		if (adventureActorCastSkillEvent.sender as AdventureActor == _actor && adventureActorCastSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			OnSelfCastSkill(adventureActorCastSkillEvent);
		}
	}

	protected virtual void OnSelfCastSkill(AdventureActorCastSkillEvent castSkillEvent)
	{
	}

	private void OnReceiveAttack(IEvent evt)
	{
		AdventureActorReceiveAttackEvent adventureActorReceiveAttackEvent = evt as AdventureActorReceiveAttackEvent;
		PlayerAdventureActor summoner;
		SummonType summonType;
		if (adventureActorReceiveAttackEvent.from is PlayerAdventureActor playerAdventureActor && playerAdventureActor == _actor && adventureActorReceiveAttackEvent.to is MonsterAdventureActor)
		{
			OnSelfAttacked(adventureActorReceiveAttackEvent);
		}
		else if (adventureActorReceiveAttackEvent.from.IsPlayerSummoned(out summoner, out summonType) && summoner == _actor && adventureActorReceiveAttackEvent.to is MonsterAdventureActor)
		{
			OnSelfSummonedAttacked(adventureActorReceiveAttackEvent);
		}
		else if (adventureActorReceiveAttackEvent.to is PlayerAdventureActor playerAdventureActor2 && playerAdventureActor2 == _actor)
		{
			OnSelfBeAttacked(adventureActorReceiveAttackEvent);
		}
	}

	protected virtual void OnSelfAttacked(AdventureActorReceiveAttackEvent attackEvent)
	{
	}

	protected virtual void OnSelfSummonedAttacked(AdventureActorReceiveAttackEvent attackEvent)
	{
	}

	protected virtual void OnSelfBeAttacked(AdventureActorReceiveAttackEvent attackEvent)
	{
	}

	private void OnReceiveNoDamage(IEvent evt)
	{
		AdventureActorNoDamageEvent adventureActorNoDamageEvent = evt as AdventureActorNoDamageEvent;
		if (adventureActorNoDamageEvent.from.IsPlayerSummoned(out var summoner, out var _) && summoner == _actor && Config.hitDamageIdMapping.TryGetValue(adventureActorNoDamageEvent.hitDamageConfigId, out var value))
		{
			AdventureActor adventureActor = adventureActorNoDamageEvent.to as AdventureActor;
			ILRuntimeAPI.HitActor(_actor, adventureActor, value, null, null, attackFxPlayOnTarget: false, HitBox.FeatureFlag.None, null, uniqueAttackId: adventureActorNoDamageEvent.uniqueAttackId, damageImmuneDuration: -1, hurtAnimType: HitBox.HurtAnimType.None);
		}
	}

	private void OnBeforeHit(IEvent evt)
	{
		AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent = evt as AdventureActorReceiveDamageBeforeHitEvent;
		if (adventureActorReceiveDamageBeforeHitEvent.from is PlayerAdventureActor playerAdventureActor && playerAdventureActor == _actor && adventureActorReceiveDamageBeforeHitEvent.to is MonsterAdventureActor monsterAdventureActor)
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 514441, out var perkLevel) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, Config.damageTag_Trigger_P41))
			{
				AdventureActor.AddFromAttr(14441001, _actor);
			}
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 514443, out perkLevel) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, Config.damageTag_Trigger_P43) && (monsterAdventureActor.isFrozen || monsterAdventureActor.buffComponent.CheckBuffByBuffTag(Config.buffTag_Cold)))
			{
				AdventureActor.AddFromAttr(14443001, _actor);
			}
			if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 5) && (monsterAdventureActor.IsBossMonster() || monsterAdventureActor.monsterInfo.epicType == HotfixEnum.monsterEpicType.ELITE))
			{
				AdventureActor.AddFromAttr(14496511, _actor);
			}
			OnBeforeSelfHit(adventureActorReceiveDamageBeforeHitEvent);
		}
	}

	protected virtual void OnBeforeSelfHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
	}

	private void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (adventureActorReceiveDamageEvent.from is PlayerAdventureActor playerAdventureActor && playerAdventureActor == _actor && adventureActorReceiveDamageEvent.to is MonsterAdventureActor monster)
		{
			if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 3) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, Config.damageTag_Trigger_D3))
			{
				_actor.buffComponent.AddBuff(14496311, _actor);
			}
			OnSelfDamaged(adventureActorReceiveDamageEvent);
			if (CheckCanTriggerWaterMark(monster, adventureActorReceiveDamageEvent.hitDamageTag))
			{
				TriggerWaterMark(monster, adventureActorReceiveDamageEvent.hitDamageTag);
			}
		}
	}

	protected virtual void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
	}

	private bool CheckCanTriggerWaterMark(MonsterAdventureActor monster, IList<int> hitDamageTag)
	{
		if (monster == null || hitDamageTag == null)
		{
			return false;
		}
		if (CommonUtils.CheckElementMark(CommonDefine.Water, monster) && CommonUtils.CheckTriggerElementMarkCD(_actor, monster) && CommonUtils.CheckHitByTag(hitDamageTag, Config.damageTag_TriggerWaterMark))
		{
			return true;
		}
		return false;
	}

	private void TriggerWaterMark(MonsterAdventureActor monster, IList<int> hitDamageTag)
	{
		if (!(monster == null))
		{
			monster.buffComponent?.RemoveBuffByTag(CommonDefine.Water);
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_144_WaterTag1_Boom", monster.tsTransform.Position);
			HandleColdBuff(monster);
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 514441, out var _) && CommonUtils.CheckHitByTag(hitDamageTag, Config.damageTag_Trigger_P41) && TSRandom.Range(FP.Zero, 100) <= CommonUtils.GetScriptValue(_actor, 14441011))
			{
				HandleColdBuff(monster);
			}
			CommonUtils.TriggerElementMarkEvent(CommonDefine.Water, HotfixEnum.AdventureActorElementTriggerType.WaterElementTriggerType1, _actor, monster, "WaterMark_Trigger_Effect_05");
			if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 2))
			{
				_actor.buffComponent.AddBuff(14496211, _actor);
			}
			if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 4))
			{
				_actor.buffComponent.AddBuff(14496411, _actor);
			}
			OnTriggerWarterMark(monster, hitDamageTag);
		}
	}

	private void HandleColdBuff(MonsterAdventureActor monster)
	{
		monster.buffComponent?.AddBuff(4021, _actor);
		if (monster.buffComponent?.GetBuffNum(0, 0, Config.buffTag_Cold) >= 3)
		{
			monster.buffComponent?.RemoveBuffByTag(Config.buffTag_Cold);
			monster.buffComponent?.AddBuff(4100, _actor);
		}
	}

	protected virtual void OnTriggerWarterMark(MonsterAdventureActor target, IList<int> hitDamageTag)
	{
	}

	private void OnActorDied(IEvent evt)
	{
		AdventureActorDiedEvent adventureActorDiedEvent = evt as AdventureActorDiedEvent;
		if (adventureActorDiedEvent.actor is MonsterAdventureActor)
		{
			if (adventureActorDiedEvent.killer is PlayerAdventureActor playerAdventureActor && playerAdventureActor == _actor)
			{
				OnKillTarget(adventureActorDiedEvent);
			}
			OnMonsterDied(adventureActorDiedEvent);
		}
	}

	protected virtual void OnKillTarget(AdventureActorDiedEvent diedEvent)
	{
	}

	protected virtual void OnMonsterDied(AdventureActorDiedEvent diedEvent)
	{
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_ATTACK", OnReceiveAttack);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_NODAMAGE", OnReceiveNoDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_DIED", OnActorDied);
	}
}
