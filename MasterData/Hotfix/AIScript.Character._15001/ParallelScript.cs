using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15001;

public class ParallelScript : ParallelBase
{
	private FP _lastTriggerTime_P42;

	public override void OnEnable()
	{
		base.OnEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_ATTACK", OnReceiveAttack);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
	}

	private void OnGetBuff(IEvent evt)
	{
		if (evt is AdventureActorGetBuff adventureActorGetBuff && adventureActorGetBuff.from is PlayerAdventureActor && adventureActorGetBuff.eventInfo.buffTags.Contains(CommonDefine.Light) && ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 4))
		{
			_actor.buffComponent.AddBuff(15096411, _actor);
		}
	}

	private void OnReceiveAttack(IEvent evt)
	{
		AdventureActorReceiveAttackEvent adventureActorReceiveAttackEvent = evt as AdventureActorReceiveAttackEvent;
		if (adventureActorReceiveAttackEvent.from is PlayerAdventureActor && adventureActorReceiveAttackEvent.to is MonsterAdventureActor && adventureActorReceiveAttackEvent.from == _actor)
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 515043, out var _) && CommonUtils.CheckHitByTag(adventureActorReceiveAttackEvent.hitDamageTag, Config.damageTag_Trigger_P43))
			{
				_actor.buffComponent.AddBuff(15043011, _actor);
			}
			OnSelfAttacked(adventureActorReceiveAttackEvent);
		}
	}

	protected virtual void OnSelfAttacked(AdventureActorReceiveAttackEvent attackEvent)
	{
	}

	private void OnBeforeHit(IEvent evt)
	{
		AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent = evt as AdventureActorReceiveDamageBeforeHitEvent;
		if (adventureActorReceiveDamageBeforeHitEvent.from is PlayerAdventureActor && adventureActorReceiveDamageBeforeHitEvent.to is MonsterAdventureActor monsterAdventureActor && adventureActorReceiveDamageBeforeHitEvent.from == _actor)
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 515042, out var _) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, Config.damageTag_Trigger_P42) && (monsterAdventureActor.monsterInfo.epicType == HotfixEnum.monsterEpicType.ELITE || monsterAdventureActor.IsBossMonster()))
			{
				AdventureActor.AddFromAttr(15042001, _actor);
			}
			if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 5) && (monsterAdventureActor.IsBossMonster() || monsterAdventureActor.monsterInfo.epicType == HotfixEnum.monsterEpicType.ELITE))
			{
				AdventureActor.AddFromAttr(15096511, _actor);
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
		if (!(adventureActorReceiveDamageEvent.from is PlayerAdventureActor) || !(adventureActorReceiveDamageEvent.to is MonsterAdventureActor monsterAdventureActor) || !(adventureActorReceiveDamageEvent.from == _actor))
		{
			return;
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515042, out var _) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, Config.damageTag_Trigger_P42) && (monsterAdventureActor.monsterInfo.epicType == HotfixEnum.monsterEpicType.ELITE || monsterAdventureActor.IsBossMonster()))
		{
			FP scriptValue = CommonUtils.GetScriptValue(_actor, 15042012);
			if (_lastTriggerTime_P42 <= 0 || _actor.LogicTime - _lastTriggerTime_P42 > scriptValue)
			{
				FP scriptValue2 = CommonUtils.GetScriptValue(_actor, 15042011);
				((PlayerAdventureActor)_actor)?.playerSkillCd?.AddEnergy(scriptValue2);
				_lastTriggerTime_P42 = _actor.LogicTime;
			}
		}
		if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 1))
		{
			_actor.buffComponent.AddBuff(15096111, _actor);
		}
		OnSelfDamaged(adventureActorReceiveDamageEvent);
		if (CheckCanTriggerLightMark(monsterAdventureActor, adventureActorReceiveDamageEvent.hitDamageTag))
		{
			TriggerLightMark(monsterAdventureActor, adventureActorReceiveDamageEvent.hitDamageTag);
		}
	}

	protected virtual void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
	}

	private bool CheckCanTriggerLightMark(MonsterAdventureActor monster, IList<int> hitDamageTag)
	{
		if (monster == null || hitDamageTag == null || hitDamageTag.Count <= 0)
		{
			return false;
		}
		if (CommonUtils.CheckElementMark(CommonDefine.LightMark1, monster) && CommonUtils.CheckTriggerElementMarkCD(_actor, monster))
		{
			if (CommonUtils.CheckHitByTag(hitDamageTag, Config.damageTag_TriggerLightMark))
			{
				return true;
			}
			if (CommonUtils.CheckHitByTag(hitDamageTag, Config.damageTag_RateTriggerLightMark))
			{
				return TSRandom.Range(FP.Zero, 100) <= CommonUtils.GetScriptValue(_actor, 0);
			}
		}
		return false;
	}

	private void TriggerLightMark(MonsterAdventureActor monster, IList<int> hitDamageTag)
	{
		monster.buffComponent.RemoveBuffByTag(CommonDefine.LightMark1);
		ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_150_LightTag_Boom", monster.tsTransform.Position);
		CommonUtils.TriggerElementMarkEvent(CommonDefine.LightMark1, HotfixEnum.AdventureActorElementTriggerType.LightElementTriggerType1, _actor, monster, "LightMark_Trigger_Effect_02");
		if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 2))
		{
			_actor.buffComponent.AddBuff(15096211, _actor);
		}
		OnTriggerLightMark(hitDamageTag, monster);
	}

	protected virtual void OnTriggerLightMark(IList<int> hitDamageTag, MonsterAdventureActor target)
	{
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_ATTACK", OnReceiveAttack);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		_lastTriggerTime_P42 = 0;
	}
}
