using System.Collections.Generic;
using AIScript.Utils;

namespace AIScript.Character._15001;

public class ParallelScript_Support : ParallelScript
{
	private HashSet<long> _hittedSet_P30;

	public override void OnEnable()
	{
		base.OnEnable();
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515032, out var perkLevel))
		{
			_actor.buffComponent.AddBuff(15032011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515033, out perkLevel))
		{
			foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
			{
				if (actorL.actorElementInfo.elementType == HotfixEnum.elementType.LE)
				{
					actorL.buffComponent.AddBuff(15033011, _actor);
				}
			}
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
	}

	private void OnCastSkill(IEvent evt)
	{
		AdventureActorCastSkillEvent adventureActorCastSkillEvent = evt as AdventureActorCastSkillEvent;
		AdventureActor adventureActor = adventureActorCastSkillEvent.sender as AdventureActor;
		if (adventureActor is PlayerAdventureActor && adventureActorCastSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 515029, out var perkLevel) && adventureActor == SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor)
			{
				_actor.buffComponent.AddBuff(15029011, _actor);
			}
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 515030, out perkLevel) && adventureActor == _actor)
			{
				_hittedSet_P30?.Clear();
			}
		}
	}

	protected override void OnSelfAttacked(AdventureActorReceiveAttackEvent attackEvent)
	{
		base.OnSelfAttacked(attackEvent);
		MonsterAdventureActor monsterAdventureActor = attackEvent.to as MonsterAdventureActor;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515030, out var _) && CommonUtils.CheckHitByTag(attackEvent.hitDamageTag, Config_Support.damageTag_Trigger_P30))
		{
			if (_hittedSet_P30 == null)
			{
				_hittedSet_P30 = new HashSet<long>();
			}
			if (_hittedSet_P30.Add(monsterAdventureActor.Id))
			{
				_actor.buffComponent.AddBuff(15030011, _actor);
			}
		}
	}

	protected override void OnBeforeSelfHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
		base.OnBeforeSelfHit(beforeHitEvent);
		MonsterAdventureActor monsterAdventureActor = beforeHitEvent.to as MonsterAdventureActor;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515022, out var perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P22))
		{
			AdventureActor.AddFromAttr(15022011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515024, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P24))
		{
			AdventureActor.AddFromAttr(15024011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515026, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P26))
		{
			int buffNumByID = monsterAdventureActor.buffComponent.GetBuffNumByID(15026011);
			if (buffNumByID > 0)
			{
				AdventureActor.AddFromAttr(15026001, _actor, buffNumByID);
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515027, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P27) && monsterAdventureActor.isLostControl)
		{
			AdventureActor.AddFromAttr(15027001, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515029, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P29))
		{
			int num = _actor.logicVariable.GetLogicTagValue("AdditionalAttrCount_P29").AsInt();
			if (num > 0)
			{
				AdventureActor.AddFromAttr(15029001, _actor, num);
			}
		}
	}

	protected override void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnSelfDamaged(damageEvent);
		MonsterAdventureActor monsterAdventureActor = damageEvent.to as MonsterAdventureActor;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515026, out var _) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_Support.damageTag_Trigger_P26))
		{
			monsterAdventureActor.buffComponent.AddBuff(15026011, _actor);
		}
	}

	protected override void OnTriggerLightMark(IList<int> hitDamageTag, MonsterAdventureActor target)
	{
		base.OnTriggerLightMark(hitDamageTag, target);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515031, out var _) && CommonUtils.CheckHitByTag(hitDamageTag, Config_Support.damageTag_Trigger_P31))
		{
			_actor.buffComponent.AddBuff(15031011, _actor);
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		_hittedSet_P30?.Clear();
	}
}
