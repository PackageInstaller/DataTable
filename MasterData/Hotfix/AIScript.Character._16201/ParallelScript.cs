using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._16201;

public class ParallelScript : ParallelBase
{
	protected PlayerSkillCd _playerSkillCd;

	protected List<int> _damageTag_TriggerLightMark;

	private CoroutineNode _perkLogicCor_P43;

	public override void OnEnable()
	{
		base.OnEnable();
		_playerSkillCd = _actor.GetLogicComponent<PlayerSkillCd>();
		if (_damageTag_TriggerLightMark == null)
		{
			_damageTag_TriggerLightMark = new List<int>(5);
		}
		else
		{
			_damageTag_TriggerLightMark.Clear();
		}
		_damageTag_TriggerLightMark.Add(Config.damageTag_TriggerLightMark);
		_actor.buffComponent.AddBuff(16290001, _actor);
		if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 2))
		{
			_actor.buffComponent.AddBuff(16296211, _actor);
		}
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_FINISH", OnBulletFinish);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastSkillEnd);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
	}

	private void OnReceiveCustomEvent(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent adventureActorCustomEvent)
		{
			if (adventureActorCustomEvent.eventHashCode == Config.eventHashCode_TriggerSowrdAura)
			{
				TriggerSowrdAura(adventureActorCustomEvent.intParam);
			}
			OnReceiveCustomEvent(adventureActorCustomEvent);
		}
	}

	protected virtual void OnReceiveCustomEvent(AdventureActorCustomEvent customEvent)
	{
	}

	private void OnBulletFinish(IEvent evt)
	{
		if (evt is AdventureBulletFinishEvent adventureBulletFinishEvent && adventureBulletFinishEvent.owner == _actor && adventureBulletFinishEvent.finishReason != BulletFinishReason.Kill && adventureBulletFinishEvent.bulletHashCode == Config.bulletTag_SwordAura && adventureBulletFinishEvent.sender is AdventureBulletBase bullet)
		{
			OnSwordAuraFinish(bullet);
		}
	}

	private void TriggerSowrdAura(int hitDamageId)
	{
		string bulletAlias = ((!UseHugeSwordAura()) ? Config.bulletKeyList_SwordAura.get_Item(TSRandom.Range(0, Config.bulletKeyList_SwordAura.Count)) : "Bullet_162_JianQi_Big");
		TSVector2 position = _actor.tsTransform.Position + _actor.tsTransform.Left * Config.shootPositionOffset_SwordAura.x + _actor.tsTransform.Forward * Config.shootPositionOffset_SwordAura.y;
		TSVector2 normalized = TSVector2.Rotate(_actor.tsTransform.Forward, TSRandom.Range(Config.shootAngleOffset_SwordAura.x, Config.shootAngleOffset_SwordAura.y)).normalized;
		ILRuntimeAPI.ShootByDirection(bulletAlias, _actor, default, normalized, position, Config.shootPositionY_SwordAura)?.ResetHitID(hitDamageId);
		OnTriggerSwordAura();
	}

	protected virtual bool UseHugeSwordAura()
	{
		return false;
	}

	protected virtual void OnTriggerSwordAura()
	{
	}

	protected virtual void OnSwordAuraFinish(AdventureBulletBase bullet)
	{
	}

	private void OnGetBuff(IEvent evt)
	{
		if (!(evt is AdventureActorGetBuff { sender: PlayerAdventureActor sender } adventureActorGetBuff) || !(sender == _actor))
		{
			return;
		}
		if (adventureActorGetBuff.eventInfo.buffId == 16290001)
		{
			_actor.buffComponent.RemoveBuffByBuffId(16290002);
			MonoSingleton<LuaManager>.Instance?.FireEvent("ChangeSkillIcon", _playerSkillCd.GetCurrentBindSkillId(ActionKey.D), -1);
		}
		else if (adventureActorGetBuff.eventInfo.buffId == 16290002)
		{
			_actor.buffComponent.RemoveBuffByBuffId(16290001);
			MonoSingleton<LuaManager>.Instance?.FireEvent("ChangeSkillIcon", _playerSkillCd.GetCurrentBindSkillId(ActionKey.D), 1);
		}
		if (adventureActorGetBuff.eventInfo.buffTags.Contains(Config.buffTag_Burst_UltraSkill) && CommonUtils.HavePersonalPerk(_actor.dataID, 516243, out var _))
		{
			if (_perkLogicCor_P43 != null)
			{
				_actor.StopLogicCoroutine(_perkLogicCor_P43);
			}
			_perkLogicCor_P43 = _actor.StartLogicCoroutine(PerkLogic_P43(), runImmediately: true);
		}
		OnSelfGetBuff(adventureActorGetBuff);
	}

	private IEnumerator PerkLogic_P43()
	{
		FP addEnergyInterval = CommonUtils.GetScriptValue(_actor, 16243011);
		FP addEnergyValue = CommonUtils.GetScriptValue(_actor, 16243002);
		while (true)
		{
			yield return _actor.WaitTime(addEnergyInterval);
			_playerSkillCd.AddEnergy(addEnergyValue);
		}
	}

	protected virtual void OnSelfGetBuff(AdventureActorGetBuff getBuffEvent)
	{
	}

	private void OnRemoveBuff(IEvent evt)
	{
		if (!(evt is AdventureActorRemoveBuff { sender: PlayerAdventureActor sender } adventureActorRemoveBuff) || !(sender == _actor))
		{
			return;
		}
		if (adventureActorRemoveBuff.eventInfo.buffTags.Contains(Config.buffTag_Burst_UltraSkill) && CommonUtils.HavePersonalPerk(_actor.dataID, 516243, out var _))
		{
			if (_perkLogicCor_P43 != null)
			{
				_actor.StopLogicCoroutine(_perkLogicCor_P43);
			}
			_perkLogicCor_P43 = null;
		}
		OnSelfRemoveBuff(adventureActorRemoveBuff);
	}

	protected virtual void OnSelfRemoveBuff(AdventureActorRemoveBuff removeBuffEvent)
	{
	}

	private void OnCastSkill(IEvent evt)
	{
		if (evt is AdventureActorCastSkillEvent { sender: PlayerAdventureActor sender } adventureActorCastSkillEvent)
		{
			if (sender == _actor)
			{
				OnSelfCastSkill(adventureActorCastSkillEvent);
			}
			OnPlayerCastSkill(adventureActorCastSkillEvent);
		}
	}

	protected virtual void OnSelfCastSkill(AdventureActorCastSkillEvent castSkillEvent)
	{
	}

	protected virtual void OnPlayerCastSkill(AdventureActorCastSkillEvent castSkillEvent)
	{
	}

	private void OnCastSkillEnd(IEvent evt)
	{
		if (evt is AdventureActorCastSkillEndEvent { sender: PlayerAdventureActor sender } adventureActorCastSkillEndEvent && sender == _actor)
		{
			OnSelfCastEndSkill(adventureActorCastSkillEndEvent);
		}
	}

	protected virtual void OnSelfCastEndSkill(AdventureActorCastSkillEndEvent castSkillEndEvent)
	{
	}

	private void OnBeforeHit(IEvent evt)
	{
		if (!(evt is AdventureActorReceiveDamageBeforeHitEvent { to: MonsterAdventureActor to, from: PlayerAdventureActor playerAdventureActor } adventureActorReceiveDamageBeforeHitEvent) || !(playerAdventureActor == _actor))
		{
			return;
		}
		if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, Config.damageTag_Trigger_NormalAttack))
		{
			int buffNum = to.buffComponent.GetBuffNum(0, 0, Config.buffTag_Glimmer_LightMark);
			if (buffNum > 0)
			{
				AdventureActor.AddFromAttr(16290001, _actor, buffNum);
			}
		}
		if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 1) && _actor.buffComponent.CheckBuffByBuffTag(Config.buffTag_Burst_UltraSkill))
		{
			AdventureActor.AddFromAttr(16296111, _actor);
		}
		if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 2) && to.buffComponent.CheckBuffByBuffID(AdventureModuleController.Config.BuffId_Glimmer))
		{
			if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, Config.damageTag_Trigger_1_D2))
			{
				AdventureActor.AddFromAttr(16296211, _actor);
			}
			if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, Config.damageTag_Trigger_2_D2))
			{
				AdventureActor.AddFromAttr(16296221, _actor);
			}
		}
		if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 3) && to.IsEliteOrBossMonster())
		{
			AdventureActor.AddFromAttr(16296311, _actor);
		}
		if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 5) && _actor.actorHealthInfo.hpPercentage >= Config.triggerHpPercent_D5)
		{
			if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, Config.damageTag_Trigger_Rapier_D5))
			{
				AdventureActor.AddFromAttr(16296511, _actor);
			}
			if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, Config.damageTag_Trigger_Claymore_D5))
			{
				AdventureActor.AddFromAttr(16296521, _actor);
			}
		}
		OnBeforeSelfHit(adventureActorReceiveDamageBeforeHitEvent);
	}

	protected virtual void OnBeforeSelfHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
	}

	private void OnReceiveDamage(IEvent evt)
	{
		if (!(evt is AdventureActorReceiveDamageEvent { to: MonsterAdventureActor to, from: PlayerAdventureActor playerAdventureActor } adventureActorReceiveDamageEvent) || !(playerAdventureActor == _actor))
		{
			return;
		}
		if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, Config.damageTag_AddGlimmer_LightMark))
		{
			to.buffComponent.AddBuff(ModuleController<AdventureModuleController>.Instance.BuffId_Glimmer, _actor);
		}
		if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 1) && !_actor.buffComponent.CheckBuffByBuffID(16296111))
		{
			_actor.buffComponent.AddBuff(16296111, _actor);
			int buffID = 16290003;
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 516243, out var _))
			{
				buffID = 16243011;
			}
			_actor.buffComponent.AddBuff(buffID, _actor);
		}
		OnSelfDamaged(adventureActorReceiveDamageEvent);
		if (CheckCanTriggerLightMark(to, adventureActorReceiveDamageEvent.hitDamageTag))
		{
			TriggerLightMark(to, adventureActorReceiveDamageEvent.hitDamageTag);
		}
	}

	protected virtual void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
	}

	protected virtual bool CheckCanTriggerLightMark(MonsterAdventureActor monster, IList<int> hitDamageTag)
	{
		if (monster == null)
		{
			return false;
		}
		if (hitDamageTag != null && hitDamageTag.Count > 0)
		{
			List<int> damageTag_TriggerLightMark = _damageTag_TriggerLightMark;
			if (damageTag_TriggerLightMark != null && damageTag_TriggerLightMark.Count > 0 && CommonUtils.CheckElementMark(CommonDefine.Light, monster) && CommonUtils.CheckTriggerElementMarkCD(_actor, monster))
			{
				for (int i = 0; i < _damageTag_TriggerLightMark.Count; i++)
				{
					int hitTag = _damageTag_TriggerLightMark.get_Item(i);
					if (CommonUtils.CheckHitByTag(hitDamageTag, hitTag))
					{
						return true;
					}
				}
			}
		}
		return false;
	}

	private void TriggerLightMark(MonsterAdventureActor monster, IList<int> hitDamageTag)
	{
		monster.buffComponent?.RemoveBuffByTag(CommonDefine.Light);
		ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_162_LightTrigger_Boom", monster.tsTransform.Position);
		CommonUtils.TriggerElementMarkEvent(CommonDefine.Light, HotfixEnum.AdventureActorElementTriggerType.LightElementTriggerType2, _actor, monster, "LightMark_Trigger_Effect_01");
		if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 4))
		{
			_actor.buffComponent.AddBuff(16296411, _actor);
		}
		OnTriggerLightMark(monster, hitDamageTag);
	}

	protected virtual void OnTriggerLightMark(MonsterAdventureActor monster, IList<int> hitDamageTag)
	{
	}

	public override void OnDisable()
	{
		base.OnDisable();
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REMOVE_BUFF", OnRemoveBuff);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastSkillEnd);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		if (_perkLogicCor_P43 != null)
		{
			_actor.StopLogicCoroutine(_perkLogicCor_P43);
		}
		_perkLogicCor_P43 = null;
	}
}
