using System.Collections.Generic;
using AIScript.Monster._13700011Drone;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._13701;

public class ParallelScript : ParallelBase
{
	public override void OnEnable()
	{
		base.OnEnable();
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("BULLET_FINISH", OnBulletFinish);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_PROACTIVE_REDUCESKILLSECTION", OnProactiveReduceSkillSection);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_REMOVE_BUFF", OnBuffRemove);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTriggerForConstellation);
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_PROACTIVE_REDUCESKILLSECTION", OnProactiveReduceSkillSection);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REMOVE_BUFF", OnBuffRemove);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTriggerForConstellation);
	}

	private void OnBulletFinish(IEvent evt)
	{
		if (evt is AdventureBulletFinishEvent adventureBulletFinishEvent && !(adventureBulletFinishEvent.owner == null) && !(_actor == null) && adventureBulletFinishEvent.owner.Id == _actor.Id && adventureBulletFinishEvent.finishReason != BulletFinishReason.Kill)
		{
			OnSelfBulletFinish(adventureBulletFinishEvent);
		}
	}

	protected virtual void OnSelfBulletFinish(AdventureBulletFinishEvent bulletEvt)
	{
	}

	private void OnBeforeHit(IEvent evt)
	{
		if (evt is AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent && !(_actor == null) && !(adventureActorReceiveDamageBeforeHitEvent.from == null))
		{
			OnDroneBeforeHit(adventureActorReceiveDamageBeforeHitEvent);
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance?.activedPlayerActor as PlayerAdventureActor;
			if (playerAdventureActor != null && adventureActorReceiveDamageBeforeHitEvent.from == playerAdventureActor && adventureActorReceiveDamageBeforeHitEvent.from.Id != _actor.Id)
			{
				OnMainBeforeHit(adventureActorReceiveDamageBeforeHitEvent, playerAdventureActor);
			}
			if (adventureActorReceiveDamageBeforeHitEvent.from.Id == _actor.Id)
			{
				OnSelfBeforeHit(adventureActorReceiveDamageBeforeHitEvent);
			}
		}
	}

	protected virtual void OnSelfBeforeHit(AdventureActorReceiveDamageBeforeHitEvent beforeHit)
	{
		if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 5) && beforeHit.to.IsEliteOrBossMonster())
		{
			AdventureActor.AddFromAttr(13796511, _actor);
		}
		if (beforeHit.to is AdventureActor adventureActor && CommonUtils.CheckHitByTag(beforeHit.hitDamageTag, Config.UltraHitTag_137) && CommonUtils.HavePersonalPerk(_actor.dataID, 513742, out var _))
		{
			int buffNumByID = adventureActor.buffComponent.GetBuffNumByID(13742011);
			if (buffNumByID > 0)
			{
				AdventureActor.AddFromAttr(13742001, _actor, buffNumByID);
			}
		}
	}

	protected virtual void OnMainBeforeHit(AdventureActorReceiveDamageBeforeHitEvent beforeHit, PlayerAdventureActor main)
	{
	}

	private void OnDroneBeforeHit(AdventureActorReceiveDamageBeforeHitEvent beforeHit)
	{
		if (!CommonUtils.CheckHitByTag(beforeHit.hitDamageTag, Config_Drone.damageTag_Drone))
		{
			return;
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513723, out var perkLevel))
		{
			int buffNumByID = _actor.buffComponent.GetBuffNumByID(13723011);
			if (buffNumByID > 0)
			{
				AdventureActor.AddFromAttr(13723011, _actor, buffNumByID);
			}
			AdventureActor.AddFromAttr(13723021, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513728, out perkLevel) && beforeHit.to.IsEliteOrBossMonster())
		{
			AdventureActor.AddFromAttr(13728001, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513729, out perkLevel))
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance?.activedPlayerActor as PlayerAdventureActor;
			if (playerAdventureActor != null && playerAdventureActor.attackTarget == beforeHit.to)
			{
				AdventureActor.AddFromAttr(13729001, _actor);
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513730, out perkLevel))
		{
			AdventureActor.AddFromAttr(13730001, _actor);
		}
	}

	private void OnReceiveDamage(IEvent evt)
	{
		if (!(evt is AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent))
		{
			return;
		}
		if (adventureActorReceiveDamageEvent.from is PlayerAdventureActor playerAdventureActor && playerAdventureActor == _actor)
		{
			if (adventureActorReceiveDamageEvent.to is MonsterAdventureActor)
			{
				OnSelfDamaged(adventureActorReceiveDamageEvent);
			}
		}
		else
		{
			OnOtherSourceDamaged(adventureActorReceiveDamageEvent);
		}
	}

	protected virtual void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
		if (CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config.CommonTag_WindMark))
		{
			CommonHelper_137.TryTriggerWindMark(_actor, damageEvent.to);
		}
		if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 1) && (CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config.damageTag_NormalAttack_137) || CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_Drone.damageTag_Drone)))
		{
			AdventureActor adventureActor = damageEvent.to as AdventureActor;
			if (adventureActor != null)
			{
				adventureActor.buffComponent.AddBuff(13796111, _actor);
			}
		}
		if (CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config.UltraHitTag_137) && CommonUtils.HavePersonalPerk(_actor.dataID, 513742, out var _))
		{
			(damageEvent.to as AdventureActor).buffComponent.AddBuff(13742011, _actor);
		}
	}

	protected virtual void OnOtherSourceDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
	}

	protected bool TryRollArmedEnergy()
	{
		FP logicTagValue = _actor.logicVariable.GetLogicTagValue("LastArmedEnergyTime");
		FP armedEnergyCD = Config.ArmedEnergyCD;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513701, out var _) && _actor.buffComponent.CheckBuffByBuffID(13700011))
		{
			armedEnergyCD -= CommonUtils.GetScriptValue(_actor, 13701011);
		}
		if (!(logicTagValue <= 0) && !(_actor.LogicTime > logicTagValue + armedEnergyCD))
		{
			return false;
		}
		return CheckProbability(Config.ArmedEnergyProbability);
	}

	private void OnCastSkill(IEvent evt)
	{
		if (evt is AdventureActorCastSkillEvent adventureActorCastSkillEvent && !(_actor == null) && adventureActorCastSkillEvent.sender is PlayerAdventureActor)
		{
			OnCastSkill(adventureActorCastSkillEvent);
		}
	}

	protected virtual void OnCastSkill(AdventureActorCastSkillEvent evt)
	{
		TryAddTeamWindSkillBuff(evt.sender as PlayerAdventureActor, evt.skillEventInfo.skillSlotType);
		if (evt.sender as AdventureActor == _actor && evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.D && CommonUtils.HavePersonalPerk(_actor.dataID, 513741, out var _))
		{
			_actor.buffComponent.AddBuff(13741011, _actor);
		}
		if (evt.sender as AdventureActor == _actor && evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B && ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 4))
		{
			_actor.buffComponent.AddBuff(13796411, _actor);
		}
	}

	private void OnProactiveReduceSkillSection(IEvent evt)
	{
		if (evt is AdventureActorProactiveReduceSkillSectionEvent adventureActorProactiveReduceSkillSectionEvent && !(_actor == null) && adventureActorProactiveReduceSkillSectionEvent.skillEventInfo != null)
		{
			TryAddTeamWindSkillBuff(adventureActorProactiveReduceSkillSectionEvent.sender as PlayerAdventureActor, adventureActorProactiveReduceSkillSectionEvent.skillEventInfo.skillSlotType);
		}
	}

	private void OnGetBuff(IEvent evt)
	{
		if (!(evt is AdventureActorGetBuff adventureActorGetBuff) || _actor == null)
		{
			return;
		}
		if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 3) && adventureActorGetBuff.eventInfo.buffTags.Contains(CommonDefine.Wind) && adventureActorGetBuff.from is PlayerAdventureActor)
		{
			List<AdventureActor> allPlayerActors = ILRuntimeAPI.GetAllPlayerActors(_actor);
			for (int i = 0; i < allPlayerActors.Count; i++)
			{
				AdventureActor adventureActor = allPlayerActors.get_Item(i);
				if (adventureActor.actorElementInfo.elementType == HotfixEnum.elementType.AE)
				{
					adventureActor.buffComponent.AddBuff(13796311, _actor);
				}
			}
		}
		if (adventureActorGetBuff.sender is PlayerAdventureActor playerAdventureActor && !(playerAdventureActor != _actor))
		{
			OnSelfGetBuff(adventureActorGetBuff);
		}
	}

	protected virtual void OnSelfGetBuff(AdventureActorGetBuff getBuffEvt)
	{
	}

	private void OnBuffRemove(IEvent evt)
	{
		if (evt is AdventureActorRemoveBuff adventureActorRemoveBuff && !(_actor == null) && adventureActorRemoveBuff.sender is PlayerAdventureActor playerAdventureActor && !(playerAdventureActor != _actor))
		{
			OnSelfBuffRemove(adventureActorRemoveBuff);
		}
	}

	protected virtual void OnSelfBuffRemove(AdventureActorRemoveBuff removeBuffEvt)
	{
	}

	private void TryAddTeamWindSkillBuff(PlayerAdventureActor caster, HotfixEnum.skillSlotType slot)
	{
		if (!(caster == null) && CommonUtils.HavePersonalPerk(_actor.dataID, 513743, out var _) && caster.actorElementInfo.elementType == HotfixEnum.elementType.AE && slot == HotfixEnum.skillSlotType.B)
		{
			_actor.buffComponent.AddBuff(13743011, _actor);
		}
	}

	private void OnElementMarkTriggerForConstellation(IEvent evt)
	{
		if (evt is AdventureElementMarkTriggerEvent adventureElementMarkTriggerEvent && !(_actor == null) && ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 2) && adventureElementMarkTriggerEvent.elementType == HotfixEnum.elementType.AE && adventureElementMarkTriggerEvent.triggerActor is PlayerAdventureActor)
		{
			_actor.buffComponent.AddBuff(13796211, _actor);
		}
	}
}
