using ACT.Battle.Configs;
using ACT.Event;
using ACT.EventTrack;
using Bamboo.ECS;
using Fundamental;

namespace ACT.Battle;

public static class DamageEventHelper
{
	public static void FireAttackEvents(ActionMemory memory, Entity casterEb, FindTargetResult target, HitTag hitTag)
	{
		SystemAbility abilitySystem = GameManager.abilitySystem;
		EvtAttack evt = abilitySystem.GetEvt<EvtAttack>(memory.owner, memory.ability);
		evt.mainEntity = casterEb;
		evt.target = target.entity;
		evt.targetResult = target;
		evt.hitTag = hitTag;
		abilitySystem.FireEvt(evt);
		abilitySystem.ReleaseEvt(evt);
		EvtAttacked evt2 = abilitySystem.GetEvt<EvtAttacked>(memory.owner, memory.ability);
		evt2.mainEntity = target.entity;
		evt2.attacker = casterEb;
		abilitySystem.FireEvt(evt2);
		abilitySystem.ReleaseEvt(evt2);
		if (target.entity.IsCollection())
		{
			CompAbility compAbility = target.entity.GetCompAbility();
			if (target.entity.GetCompNeutral().defenceTowerType != 4)
			{
				compAbility.damageableHited?.Invoke(casterEb);
			}
			else
			{
				compAbility.comboDamageable?.Invoke(casterEb, target.entity);
			}
		}
	}

	public static void FirePostDamageEvents(ActionMemory memory, AttackData attackData, Ability ability, ActionDamage config)
	{
		SystemAbility abilitySystem = GameManager.abilitySystem;
		Entity owner = memory.owner;
		Entity caster = memory.caster;
		FindTargetResult target = memory.target;
		EvtDealDamage evt = abilitySystem.GetEvt<EvtDealDamage>(owner, ability);
		evt.mainEntity = caster;
		evt.attackData = attackData;
		abilitySystem.FireEvt(evt);
		abilitySystem.ReleaseEvt(evt);
		EvtDamaged evt2 = abilitySystem.GetEvt<EvtDamaged>(owner, ability);
		evt2.mainEntity = target.entity;
		evt2.attackData = attackData;
		abilitySystem.FireEvt(evt2);
		if (!target.entity.IsCollection())
		{
			memory.caster.GetCompAbility().ServerHitRecoveryEnergy(config, config.energyCharge * attackData.energyChargeMul + attackData.energyChargeAdd);
		}
		SystemAbility.DoActions(actions: (attackData.actualDamage != 0) ? config.damaged : config.undamaged, memory: new ActionMemory(memory.caster, memory.owner, memory.target, evt2, memory.ability));
		abilitySystem.ReleaseEvt(evt2);
		FireEvents(memory, attackData, ability);
	}

	private static void FireEvents(ActionMemory memory, AttackData attackData, Ability ability)
	{
		TrackHited evt = EventTrackSolver.Instance.GetEvt<TrackHited>();
		evt.attackee = attackData.attackee;
		evt.attacker = attackData.attacker;
		evt.attackData = attackData;
		evt.postureDamage = attackData.postureDamage;
		evt.actualDamage = attackData.actualDamage;
		evt.skillId = ability?.skillLevelInfo.id ?? 0;
		EventTrackSolver.Instance.Dispatch(evt);
		HitEvt evt2 = Singleton<EventManager>.instance.GetEvt<HitEvt>();
		evt2.attacker = attackData.attacker;
		evt2.target = attackData.attackee;
		evt2.AttackData = attackData;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.BattleOnHit, evt2);
		Singleton<EventManager>.instance.ReleaseEvt(evt2);
		DamageEvt evt3 = Singleton<EventManager>.instance.GetEvt<DamageEvt>();
		evt3.AttackData = attackData;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.OnDamage, evt3);
		Singleton<EventManager>.instance.ReleaseEvt(evt3);
	}
}
