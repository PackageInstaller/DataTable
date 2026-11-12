using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;

namespace AIScript.Character._14901;

public class ParallelScript : ParallelBase
{
	public override void OnEnable()
	{
		base.OnEnable();
		Config_MainControl.mainConcTime = 0;
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
	}

	private void OnGetBuff(IEvent evt)
	{
		AdventureActorGetBuff adventureActorGetBuff = evt as AdventureActorGetBuff;
		if ((object)adventureActorGetBuff.from != null && adventureActorGetBuff.eventInfo.buffTags.Contains(CommonDefine.Earth) && CheckTalentLevel(4))
		{
			_actor.buffComponent.AddBuff(14996411, _actor);
		}
	}

	private void OnElementMarkTrigger(IEvent evt)
	{
		AdventureElementMarkTriggerEvent obj = evt as AdventureElementMarkTriggerEvent;
		AdventureActor triggerActor = obj.triggerActor;
		if (obj.elementType == HotfixEnum.elementType.SE)
		{
			bool flag = triggerActor is MonsterAdventureActor { dataID: 14900011 } || triggerActor.Id == _actor.Id;
			if (CheckTalentLevel(2) & flag)
			{
				_actor.buffComponent.AddBuff(14996211, _actor);
			}
		}
	}

	private void OnCastSkill(IEvent evt)
	{
		AdventureActorCastSkillEvent adventureActorCastSkillEvent = evt as AdventureActorCastSkillEvent;
		PlayerAdventureActor playerAdventureActor = adventureActorCastSkillEvent.sender as PlayerAdventureActor;
		if (playerAdventureActor != null)
		{
			OnCastSkill(playerAdventureActor, adventureActorCastSkillEvent);
		}
	}

	private void OnBeforeHit(IEvent evt)
	{
		AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent = evt as AdventureActorReceiveDamageBeforeHitEvent;
		if (_actor == null || adventureActorReceiveDamageBeforeHitEvent.to == null || adventureActorReceiveDamageBeforeHitEvent.hitDamageTag == null || adventureActorReceiveDamageBeforeHitEvent.from == null)
		{
			return;
		}
		OnBeforeHitEvent(adventureActorReceiveDamageBeforeHitEvent);
		if (adventureActorReceiveDamageBeforeHitEvent.from == _actor && adventureActorReceiveDamageBeforeHitEvent.to is MonsterAdventureActor monsterAdventureActor)
		{
			if (GetPerk(514942) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, Config.damageTag_UltraSkill) && monsterAdventureActor.buffComponent.CheckBuffByBuffID(14942011))
			{
				AdventureActor.AddFromAttr(14942001, _actor);
			}
			if (GetPerk(514943) && monsterAdventureActor.buffComponent.CheckBuffByBuffID(14943011) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, Config.damageTag_Gray))
			{
				AdventureActor.AddFromAttr(14943001, _actor);
			}
		}
	}

	private void OnReceiveDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		bool flag = false;
		if (adventureActorReceiveDamageEvent.from is MonsterAdventureActor { dataID: 14900011 })
		{
			flag = true;
		}
		if ((flag || adventureActorReceiveDamageEvent.from is PlayerAdventureActor) && adventureActorReceiveDamageEvent.to is MonsterAdventureActor monster && ((adventureActorReceiveDamageEvent.from == _actor) | flag))
		{
			OnSelfDamaged(adventureActorReceiveDamageEvent);
			if (CheckCanTriggerEarthMark(monster, adventureActorReceiveDamageEvent.hitDamageTag))
			{
				TriggerEarthMark(monster);
			}
		}
	}

	private bool CheckCanTriggerEarthMark(MonsterAdventureActor monster, IList<int> hitDamageTag)
	{
		if (monster == null || hitDamageTag == null)
		{
			return false;
		}
		if (!CommonUtils.CheckElementMark(CommonDefine.Earth, monster))
		{
			return false;
		}
		if (!CommonUtils.CheckTriggerElementMarkCD(_actor, monster))
		{
			return false;
		}
		if (CommonUtils.CheckHitByTag(hitDamageTag, Config.triggerDamageTag_EarthMark))
		{
			return true;
		}
		if (Config_MainControl.mainConcTime > 0 && GetPerk(514902) && CommonUtils.CheckHitByTag(hitDamageTag, Config_MainControl.damageTag_NormalAtk_45))
		{
			return true;
		}
		return false;
	}

	private void TriggerEarthMark(MonsterAdventureActor monster)
	{
		if (GetPerk(514931))
		{
			_actor.buffComponent.AddBuff(14931011, _actor);
		}
		if (GetPerk(514942))
		{
			monster.buffComponent.AddBuff(14942011, _actor);
		}
		monster.buffComponent.RemoveBuffByTag(CommonDefine.Earth);
		ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_149_LandTag1_Stone", monster.tsTransform.Position);
		CommonUtils.TriggerElementMarkEvent(CommonDefine.Earth, HotfixEnum.AdventureActorElementTriggerType.EarthElementTriggerType, _actor, monster, "LandMark_Trigger_Effect_02");
	}

	public void OnUpdate()
	{
		LogicUpdate();
	}

	protected virtual void LogicUpdate()
	{
	}

	protected virtual void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
		if (CheckTalentLevel(1) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config.damageTag_GraySkill) && damageEvent.from is AdventureActor adventureActor && CheckPerkCd(adventureActor.dataID, Config.cd_ScriptParameter_m1))
		{
			adventureActor.buffComponent.AddBuff(14996111, _actor);
		}
		if (CheckTalentLevel(3) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config.damageTag_UltraSkill))
		{
			_actor.buffComponent.AddBuff(14996311, _actor);
		}
	}

	protected virtual void OnBeforeHitEvent(AdventureActorReceiveDamageBeforeHitEvent evt)
	{
		bool flag = false;
		if (evt.from is MonsterAdventureActor { dataID: 14900011 })
		{
			flag = true;
		}
		if ((flag || evt.from is PlayerAdventureActor) && evt.to is MonsterAdventureActor monsterAdventureActor2 && ((evt.from == _actor) | flag) && CheckTalentLevel(5) && (monsterAdventureActor2.monsterInfo.epicType == HotfixEnum.monsterEpicType.ELITE || monsterAdventureActor2.IsBossMonster()))
		{
			AdventureActor.AddFromAttr(14996511, _actor);
		}
	}

	protected virtual void OnCastSkill(PlayerAdventureActor actor, AdventureActorCastSkillEvent skiillEvet)
	{
	}
}
