using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14101;

public class ParallelScript_MainControl : ParallelScript
{
	private CoroutineNode _perkLogicCor_P13;

	private FP _buffTime_P13;

	private int _triggerTimes_P13;

	public override void OnEnable()
	{
		base.OnEnable();
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514103, out var perkLevel))
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 514108, out perkLevel))
			{
				_buffId_Ink = 14108012;
			}
			else
			{
				_buffId_Ink = 14103011;
			}
		}
		else if (CommonUtils.HavePersonalPerk(_actor.dataID, 514108, out perkLevel))
		{
			_buffId_Ink = 14108011;
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514105, out perkLevel))
		{
			_buffIdDic_Burn = Config_MainControl.buffIdDic_Burn_P5;
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514111, out perkLevel))
		{
			_damageTag_TriggerFireMark?.Add(Config_MainControl.damageTag_TriggerFireMark_P11);
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_DIED", OnDied);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REMOVE_SHIELD", OnRemoveShield);
	}

	private void OnCastSkill(IEvent evt)
	{
		if (evt is AdventureActorCastSkillEvent { sender: PlayerAdventureActor sender } adventureActorCastSkillEvent && sender == _actor && adventureActorCastSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B && CommonUtils.HavePersonalPerk(_actor.dataID, 514113, out var _))
		{
			if (_perkLogicCor_P13 != null)
			{
				_actor.StopLogicCoroutine(_perkLogicCor_P13);
			}
			_perkLogicCor_P13 = _actor.StartLogicCoroutine(PerkLogic_P13(), runImmediately: true);
		}
	}

	private IEnumerator PerkLogic_P13()
	{
		_actor.buffComponent.AddBuff(14113011, _actor);
		_buffTime_P13 = Config_MainControl.buffTime_P13;
		_triggerTimes_P13 = 0;
		while (_buffTime_P13 > 0)
		{
			_buffTime_P13 -= _actor.LogicDeltaTime;
			yield return null;
		}
		_actor.buffComponent.RemoveBuffByBuffId(14113011);
	}

	protected override void OnBeforeSelfHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
		base.OnBeforeSelfHit(beforeHitEvent);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514101, out var perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P1))
		{
			AdventureActor.AddFromAttr(14101011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514104, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P4))
		{
			int buffNumByID = _actor.buffComponent.GetBuffNumByID(14104011);
			if (buffNumByID > 0)
			{
				AdventureActor.AddFromAttr(14104011, _actor, buffNumByID);
			}
		}
	}

	protected override void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnSelfDamaged(damageEvent);
		MonsterAdventureActor monsterAdventureActor = damageEvent.to as MonsterAdventureActor;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514109, out var perkLevel) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P9))
		{
			monsterAdventureActor.buffComponent.AddBuff(14109011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514113, out perkLevel) && damageEvent.isCrit && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_MainControl.damageTag_TriggerAddBuffTime_P13) && _triggerTimes_P13 < 3)
		{
			_buffTime_P13 += Config_MainControl.addBuffTime_P13;
			_triggerTimes_P13++;
		}
	}

	protected override void TriggerBurn(MonsterAdventureActor monster)
	{
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514103, out var _) && monster.buffComponent.GetBuffNum(0, 0, Config.buffTag_Ink) >= 4)
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_14101_Main_Skill_P03_Boom", monster.tsTransform.Position);
			monster.buffComponent.RemoveBuffByTag(Config.buffTag_Ink);
			_actor.buffComponent.AddBuff(14103012, _actor);
		}
		else
		{
			base.TriggerBurn(monster);
		}
	}

	protected override void OnTriggerBurn(MonsterAdventureActor monster)
	{
		base.OnTriggerBurn(monster);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514109, out var _) && monster.buffComponent.CheckBuffByBuffID(14109011))
		{
			monster.buffComponent.AddBuff(14109012, _actor);
		}
	}

	protected override void OnTriggerFireMark(MonsterAdventureActor monster, IList<int> hitDamageTag)
	{
		base.OnTriggerFireMark(monster, hitDamageTag);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514111, out var perkLevel))
		{
			_actor.buffComponent.AddBuff(14111011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514112, out perkLevel))
		{
			monster.buffComponent.AddBuff(14112011, _actor);
		}
	}

	private void OnDied(IEvent evt)
	{
		if (evt is AdventureActorDiedEvent { actor: MonsterAdventureActor actor } && CommonUtils.HavePersonalPerk(_actor.dataID, 514106, out var _) && actor.buffComponent.CheckBuffByBuffTag(Config.buffTag_Burn))
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_14101_Main_Skill_P06_FirePit", actor.tsTransform.Position);
		}
	}

	private void OnRemoveShield(IEvent evt)
	{
		if (evt is AdventureActorRemoveShield adventureActorRemoveShield && adventureActorRemoveShield.sender as AdventureActor == _actor && CommonUtils.HavePersonalPerk(_actor.dataID, 514110, out var _) && adventureActorRemoveShield.shieldId == 14110001)
		{
			_actor.buffComponent?.RemoveBuffByBuffId(14110011);
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_DIED", OnDied);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REMOVE_SHIELD", OnRemoveShield);
		if (_perkLogicCor_P13 != null)
		{
			_actor.StopLogicCoroutine(_perkLogicCor_P13);
		}
		_perkLogicCor_P13 = null;
		_buffTime_P13 = 0;
		_triggerTimes_P13 = 0;
	}
}
