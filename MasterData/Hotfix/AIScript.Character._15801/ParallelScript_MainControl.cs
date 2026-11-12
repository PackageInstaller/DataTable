using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15801;

public class ParallelScript_MainControl : ParallelScript
{
	private CoroutineNode _perkLogicCor_P13;

	public override void OnEnable()
	{
		base.OnEnable();
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515812, out var perkLevel))
		{
			_actor.buffComponent.AddBuff(15812011, _actor);
			_damageTag_TriggerFireMark.Add(Config_MainControl.damageTag_AddTriggerMark_P12);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515813, out perkLevel))
		{
			_actor.buffComponent.AddBuff(15813011, _actor);
			_actor.buffComponent.AddBuff(15813012, _actor);
		}
	}

	protected override void GenerateSummonerController()
	{
		_summonedController = new SummonedController_MainControl(_actor as PlayerAdventureActor);
	}

	protected override void OnSelfBeAttacked(AdventureActorReceiveAttackEvent attackEvent)
	{
		base.OnSelfBeAttacked(attackEvent);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515813, out var _) && _actor.buffComponent.CheckBuffByBuffID(15813011))
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
		_actor.buffComponent.RemoveBuffByBuffId(15813011);
		_actor.EnableDamageImmunity();
		yield return null;
		_actor.DisableDamageImmunity();
		FP scriptValue = CommonUtils.GetScriptValue(_actor, 15813011);
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(scriptValue));
		_actor.buffComponent.AddBuff(15813011, _actor);
	}

	protected override void OnBeforeSelfHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
		base.OnBeforeSelfHit(beforeHitEvent);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515809, out var _) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P9))
		{
			AdventureActor.AddFromAttr(15809001, _actor);
		}
	}

	protected override void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnSelfDamaged(damageEvent);
		MonsterAdventureActor monsterAdventureActor = damageEvent.to as MonsterAdventureActor;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515804, out var perkLevel) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P4))
		{
			string fxAlias = (CommonUtils.HavePersonalPerk(_actor.dataID, 515809, out perkLevel) ? "AreaEffect_15801_Main_Skill_P04P09_Boom" : "AreaEffect_15801_Main_Skill_P04_Boom");
			if (monsterAdventureActor.buffComponent.CheckBuffByBuffID(15804011))
			{
				ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, monsterAdventureActor.tsTransform.Position);
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515808, out perkLevel) && damageEvent.isCrit && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P8))
		{
			_actor.buffComponent.AddBuff(15808011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515810, out perkLevel) && damageEvent.isCrit && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P10))
		{
			_actor.buffComponent.AddBuff(15810011, _actor);
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		if (_perkLogicCor_P13 != null)
		{
			_actor.StopLogicCoroutine(_perkLogicCor_P13);
		}
		_perkLogicCor_P13 = null;
		_actor.InterruptDamageImmunity();
	}
}
