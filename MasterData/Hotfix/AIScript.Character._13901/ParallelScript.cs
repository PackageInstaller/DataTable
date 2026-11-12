using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._13901;

public class ParallelScript : ParallelBase
{
	private CoroutineNode _rebindUltraSkillCor;

	public override void OnEnable()
	{
		base.OnEnable();
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastSkillEnd);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_NODAMAGE", OnReceiveNoDamage);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
	}

	private void OnCastSkill(IEvent evt)
	{
		if (!(evt is AdventureActorCastSkillEvent { sender: PlayerAdventureActor sender } adventureActorCastSkillEvent) || !(sender == _actor))
		{
			return;
		}
		if (adventureActorCastSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.D && ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 4))
		{
			_actor.buffComponent.AddBuff(13996411, _actor);
		}
		if (adventureActorCastSkillEvent.skillEventInfo.skillId == 13940001)
		{
			if (_rebindUltraSkillCor != null)
			{
				_actor.StopLogicCoroutine(_rebindUltraSkillCor);
			}
			_rebindUltraSkillCor = null;
		}
		OnSelfCastSkill(adventureActorCastSkillEvent);
	}

	protected virtual void OnSelfCastSkill(AdventureActorCastSkillEvent castSkillEvent)
	{
	}

	private void OnCastSkillEnd(IEvent evt)
	{
		if (evt is AdventureActorCastSkillEndEvent { sender: PlayerAdventureActor sender } adventureActorCastSkillEndEvent && sender == _actor)
		{
			OnSelfCastSkillEnd(adventureActorCastSkillEndEvent);
		}
	}

	protected virtual void OnSelfCastSkillEnd(AdventureActorCastSkillEndEvent castSkillEndEvent)
	{
	}

	private void OnGetBuff(IEvent evt)
	{
		if (!(evt is AdventureActorGetBuff adventureActorGetBuff))
		{
			return;
		}
		if (adventureActorGetBuff.sender is PlayerAdventureActor playerAdventureActor)
		{
			if (playerAdventureActor == _actor)
			{
				OnSelfGetBuff(adventureActorGetBuff);
			}
		}
		else if (adventureActorGetBuff.sender is MonsterAdventureActor && adventureActorGetBuff.eventInfo.buffTags.Contains(CommonDefine.Water) && ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 3) && adventureActorGetBuff.from is PlayerAdventureActor)
		{
			_actor.buffComponent.AddBuff(13996311, _actor);
		}
	}

	protected virtual void OnSelfGetBuff(AdventureActorGetBuff getBuffEvent)
	{
	}

	private void OnRemoveBuff(IEvent evt)
	{
		if (evt is AdventureActorRemoveBuff { sender: PlayerAdventureActor sender } adventureActorRemoveBuff && sender == _actor)
		{
			OnSelfRemoveBuff(adventureActorRemoveBuff);
		}
	}

	protected virtual void OnSelfRemoveBuff(AdventureActorRemoveBuff removeBuffEvent)
	{
	}

	private void OnReceiveCustomEvent(IEvent evt)
	{
		if (!(evt is AdventureActorCustomEvent adventureActorCustomEvent))
		{
			return;
		}
		if (adventureActorCustomEvent.eventHashCode == Config.eventHashCode_ChangeUltraSkillStage)
		{
			if (_rebindUltraSkillCor != null)
			{
				_actor.StopLogicCoroutine(_rebindUltraSkillCor);
			}
			_rebindUltraSkillCor = null;
			if (((PlayerAdventureActor)_actor).playerSkillCd.GetCurrentBindSkillId(ActionKey.D) == 13940001)
			{
				_rebindUltraSkillCor = _actor.StartLogicCoroutine(RebindUltraSkillLogic(), runImmediately: true);
			}
		}
		OnReceiveCustomEvent(adventureActorCustomEvent);
	}

	private IEnumerator RebindUltraSkillLogic()
	{
		yield return _actor.WaitTime(Config.canUseTime_SecondStage_UltraSkill);
		((PlayerAdventureActor)_actor).playerSkillCd.BindSkillIdToButton(ActionKey.D, 13940000);
		_rebindUltraSkillCor = null;
	}

	protected virtual void OnReceiveCustomEvent(AdventureActorCustomEvent customEvent)
	{
	}

	private void OnReceiveNoDamage(IEvent evt)
	{
		if (evt is AdventureActorNoDamageEvent adventureActorNoDamageEvent && adventureActorNoDamageEvent.from == _actor)
		{
			Config.hitDamageIdMapping.TryGetValue(adventureActorNoDamageEvent.hitDamageConfigId, out var value);
			if (OverrideHitDamageId(adventureActorNoDamageEvent.hitDamageTag, adventureActorNoDamageEvent.hitDamageConfigId, out var overrideHitDamageId))
			{
				value = overrideHitDamageId;
			}
			if (value > 0 && adventureActorNoDamageEvent.to is AdventureActor adventureActor)
			{
				ILRuntimeAPI.HitActor(_actor, adventureActor, value, null, null, attackFxPlayOnTarget: false, HitBox.FeatureFlag.None, null, uniqueAttackId: adventureActorNoDamageEvent.uniqueAttackId, damageImmuneDuration: -1, hurtAnimType: HitBox.HurtAnimType.None);
			}
		}
	}

	protected virtual bool OverrideHitDamageId(IList<int> hitDamageTag, int hitDamageId, out int overrideHitDamageId)
	{
		overrideHitDamageId = 0;
		return false;
	}

	private void OnBeforeHit(IEvent evt)
	{
		if (!(evt is AdventureActorReceiveDamageBeforeHitEvent { to: MonsterAdventureActor to, from: PlayerAdventureActor playerAdventureActor } adventureActorReceiveDamageBeforeHitEvent) || !(playerAdventureActor == _actor))
		{
			return;
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513942, out var perkLevel) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, Config.damageTag_Trigger_P42))
		{
			AdventureActor.AddFromAttr(13942001, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513943, out perkLevel) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, Config.damageTag_Trigger_P43))
		{
			AdventureActor.AddFromAttr(13943001, _actor);
		}
		if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 1))
		{
			if (adventureActorReceiveDamageBeforeHitEvent.damageType == HotfixEnum.damageType.SKILL)
			{
				AdventureActor.AddFromAttr(13996111, _actor);
			}
			if (_actor.buffComponent.CheckBuffByBuffTag(Config.buffTag_FirstStage_UltraSkill))
			{
				AdventureActor.AddFromAttr(13996121, _actor);
			}
		}
		if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 5) && to.IsEliteOrBossMonster())
		{
			AdventureActor.AddFromAttr(13996511, _actor);
		}
		OnBeforeSelfHit(adventureActorReceiveDamageBeforeHitEvent);
	}

	protected virtual void OnBeforeSelfHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
	}

	private void OnReceiveDamage(IEvent evt)
	{
		if (evt is AdventureActorReceiveDamageEvent { to: MonsterAdventureActor to, from: PlayerAdventureActor playerAdventureActor } adventureActorReceiveDamageEvent && playerAdventureActor == _actor)
		{
			OnSelfDamaged(adventureActorReceiveDamageEvent);
			if (CheckCanTriggerWaterMark(to, adventureActorReceiveDamageEvent.hitDamageTag))
			{
				TriggerWaterMark(to, adventureActorReceiveDamageEvent.hitDamageTag);
			}
		}
	}

	protected virtual void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
	}

	private bool CheckCanTriggerWaterMark(MonsterAdventureActor monster, IList<int> hitDamageTag)
	{
		if (monster == null)
		{
			return false;
		}
		if (hitDamageTag != null && hitDamageTag.Count > 0 && CommonUtils.CheckElementMark(CommonDefine.Water, monster) && CommonUtils.CheckTriggerElementMarkCD(_actor, monster) && (CommonUtils.CheckHitByTag(hitDamageTag, Config.damageTag_TriggerWaterMark) || ExtraCheckTriggerWaterMarkHitTag(hitDamageTag)))
		{
			return true;
		}
		return false;
	}

	protected virtual bool ExtraCheckTriggerWaterMarkHitTag(IList<int> hitDamageTag)
	{
		return false;
	}

	private void TriggerWaterMark(MonsterAdventureActor monster, IList<int> hitDamageTag)
	{
		if (!(monster == null))
		{
			if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 4))
			{
				_actor.buffComponent.AddBuff(13996411, _actor);
			}
			monster.buffComponent.RemoveBuffByTag(CommonDefine.Water);
			ILRuntimeAPI.HitActor(_actor, monster, 139000001, "fx_common_base_WaterMark1_Trigger2_A");
			monster.buffComponent.AddBuff(4031, _actor);
			TriggerTide(monster);
			CommonUtils.TriggerElementMarkEvent(CommonDefine.Water, HotfixEnum.AdventureActorElementTriggerType.WaterElementTriggerType2, _actor, monster, "WaterMark_Trigger_Effect_06");
			OnTriggerWarterMark(monster, hitDamageTag);
		}
	}

	protected virtual void TriggerTide(MonsterAdventureActor monster)
	{
		if (monster.buffComponent.HaveBuffNumMax(4031))
		{
			monster.buffComponent.RemoveBuffByBuffId(4031);
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_13901_WaterTrigger", monster.tsTransform.Position);
			OnTriggerTide();
		}
	}

	protected virtual void OnTriggerWarterMark(MonsterAdventureActor monster, IList<int> hitDamageTag)
	{
	}

	protected virtual void OnTriggerTide()
	{
	}

	public override void OnDisable()
	{
		base.OnDisable();
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastSkillEnd);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_NODAMAGE", OnReceiveNoDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		if (_rebindUltraSkillCor != null)
		{
			_actor.StopLogicCoroutine(_rebindUltraSkillCor);
		}
		_rebindUltraSkillCor = null;
	}
}
