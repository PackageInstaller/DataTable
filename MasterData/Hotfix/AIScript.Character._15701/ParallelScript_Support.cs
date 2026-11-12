using AIScript.Utils;
using AdventureBehaviour;

namespace AIScript.Character._15701;

public class ParallelScript_Support : ParallelScript
{
	public override void OnEnable()
	{
		base.OnEnable();
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515731, out var perkLevel))
		{
			foreach (AdventureActor allPlayerActor in ILRuntimeAPI.GetAllPlayerActors(_actor))
			{
				if (allPlayerActor.actorElementInfo.elementType == HotfixEnum.elementType.DE)
				{
					allPlayerActor.buffComponent.AddBuff(15731011, _actor);
				}
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515733, out perkLevel))
		{
			int playerActorCountByElement = CommonUtils.GetPlayerActorCountByElement(HotfixEnum.elementType.DE);
			_actor.buffComponent.AddBuffNum(15733011, playerActorCountByElement, _actor);
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
	}

	private void OnCastSkill(IEvent evt)
	{
		if (evt is AdventureActorCastSkillEvent { sender: PlayerAdventureActor sender } adventureActorCastSkillEvent && adventureActorCastSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B && CommonUtils.HavePersonalPerk(_actor.dataID, 515730, out var _) && sender.actorElementInfo.elementType == HotfixEnum.elementType.DE)
		{
			_actor.buffComponent.AddBuff(15730011, _actor);
		}
	}

	protected override void OnBeforeSelfHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
		base.OnBeforeSelfHit(beforeHitEvent);
		MonsterAdventureActor monsterAdventureActor = beforeHitEvent.to as MonsterAdventureActor;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515725, out var perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P25))
		{
			AdventureActor.AddFromAttr(15725001, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515727, out perkLevel) && (monsterAdventureActor.monsterInfo.epicType == HotfixEnum.monsterEpicType.NORMAL || monsterAdventureActor.monsterInfo.epicType == HotfixEnum.monsterEpicType.ELITE) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P27))
		{
			AdventureActor.AddFromAttr(15727001, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515728, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P28))
		{
			int buffNumByID = _actor.buffComponent.GetBuffNumByID(15728011);
			if (buffNumByID > 0)
			{
				AdventureActor.AddFromAttr(15728001, _actor, buffNumByID);
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515729, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P29) && monsterAdventureActor.IsEliteOrBossMonster())
		{
			AdventureActor.AddFromAttr(15729001, _actor);
		}
	}

	protected override void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnSelfDamaged(damageEvent);
		MonsterAdventureActor monsterAdventureActor = damageEvent.to as MonsterAdventureActor;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515722, out var perkLevel) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_Support.damageTag_Trigger_P22))
		{
			if (monsterAdventureActor.buffComponent.CheckBuffByBuffID(15721011))
			{
				monsterAdventureActor.buffComponent.RemoveBuffByBuffId(15721011);
				ILRuntimeAPI.HitActor(_actor, monsterAdventureActor, 157300014, "fx_15701_hit_ToothBoom", null, attackFxPlayOnTarget: false, HitBox.FeatureFlag.None, null, -1);
			}
			else
			{
				monsterAdventureActor.buffComponent.AddBuff(15721011, _actor);
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515726, out perkLevel) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_Support.damageTag_Trigger_P26))
		{
			_actor.buffComponent.AddBuff(15726011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515728, out perkLevel) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_Support.damageTag_Trigger_P28))
		{
			_actor.buffComponent.AddBuff(15728011, _actor);
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
	}
}
