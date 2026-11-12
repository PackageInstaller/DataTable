using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11601;

public class ParallelScript : ParallelBase
{
	protected List<int> _damageTag_TriggerLandMark;

	private int _triggerTimes_D3;

	public override void OnEnable()
	{
		base.OnEnable();
		if (_damageTag_TriggerLandMark == null)
		{
			_damageTag_TriggerLandMark = new List<int>();
		}
		else
		{
			_damageTag_TriggerLandMark.Clear();
		}
		_damageTag_TriggerLandMark.Add(Config.damageTag_TriggerLandMark);
		_triggerTimes_D3 = 0;
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
	}

	private void OnBeforeHit(IEvent evt)
	{
		if (!(evt is AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent) || !(adventureActorReceiveDamageBeforeHitEvent.from is PlayerAdventureActor) || !(adventureActorReceiveDamageBeforeHitEvent.to is MonsterAdventureActor target) || !(adventureActorReceiveDamageBeforeHitEvent.from == _actor))
		{
			return;
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511641, out var perkLevel) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, Config.damageTag_Trigger_P41))
		{
			AdventureActor.AddFromAttr(11641001, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511642, out perkLevel) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, Config.damageTag_Trigger_P42))
		{
			FP logicTagValue = _actor.logicVariable.GetLogicTagValue("UltraSkillHitTimes");
			if (logicTagValue > 0)
			{
				FP scriptValue = CommonUtils.GetScriptValue(_actor, 11642011);
				AdventureActor.AddFromAttr(11642001, _actor, TSMath.Clamp(logicTagValue, 1, scriptValue).AsInt());
			}
		}
		if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 4) && CommonUtils.CheckElementMark(CommonDefine.EarthMark1, target))
		{
			AdventureActor.AddFromAttr(11696411, _actor);
		}
		OnBeforeSelfHit(adventureActorReceiveDamageBeforeHitEvent);
	}

	protected virtual void OnBeforeSelfHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
	}

	private void OnReceiveDamage(IEvent evt)
	{
		if (!(evt is AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent) || !(adventureActorReceiveDamageEvent.from is PlayerAdventureActor) || !(adventureActorReceiveDamageEvent.to is MonsterAdventureActor monster))
		{
			return;
		}
		if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 3) && adventureActorReceiveDamageEvent.skillSlotType == HotfixEnum.skillSlotType.D)
		{
			_triggerTimes_D3++;
			if (_triggerTimes_D3 >= 20)
			{
				foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
				{
					actorL.buffComponent.AddBuff(11696311, _actor);
				}
				_triggerTimes_D3 = 0;
			}
		}
		if (!(adventureActorReceiveDamageEvent.from == _actor))
		{
			return;
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511642, out var _) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, Config.damageTag_Trigger_P42))
		{
			FP logicTagValue = _actor.logicVariable.GetLogicTagValue("UltraSkillHitTimes");
			_actor.logicVariable.SetLogicTagValue("UltraSkillHitTimes", logicTagValue + 1);
		}
		if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 1) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, Config.damageTag_Trigger_D1))
		{
			foreach (PlayerAdventureActor actorL2 in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
			{
				actorL2.buffComponent.AddBuff(11696111, _actor);
			}
		}
		if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 5) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, Config.damageTag_Trigger_D5))
		{
			_actor.buffComponent.AddBuff(11696511, _actor);
		}
		OnSelfDamaged(adventureActorReceiveDamageEvent);
		if (CheckCanTriggerLandMark(monster, adventureActorReceiveDamageEvent.hitDamageTag, adventureActorReceiveDamageEvent.weapon))
		{
			TriggerLandMark(monster, adventureActorReceiveDamageEvent.hitDamageTag);
		}
	}

	protected virtual void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
	}

	private bool CheckCanTriggerLandMark(MonsterAdventureActor monster, IList<int> hitDamageTag, AdventureWeapon hitWeapon)
	{
		if (monster == null || hitDamageTag == null)
		{
			return false;
		}
		if (_damageTag_TriggerLandMark == null || _damageTag_TriggerLandMark.Count <= 0)
		{
			return false;
		}
		if (CommonUtils.CheckElementMark(CommonDefine.EarthMark1, monster) && CommonUtils.CheckTriggerElementMarkCD(_actor, monster))
		{
			for (int i = 0; i < _damageTag_TriggerLandMark.Count; i++)
			{
				int hitTag = _damageTag_TriggerLandMark.get_Item(i);
				if (CommonUtils.CheckHitByTag(hitDamageTag, hitTag))
				{
					return true;
				}
			}
			return CheckWeaponCanTriggerLandMark(hitWeapon);
		}
		return false;
	}

	protected virtual bool CheckWeaponCanTriggerLandMark(AdventureWeapon hitWeapon)
	{
		return false;
	}

	private void TriggerLandMark(MonsterAdventureActor monster, IList<int> hitDamageTag)
	{
		ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_11601_LandTag1_Stone", monster.tsTransform.Position);
		monster.buffComponent.RemoveBuffByTag(CommonDefine.EarthMark1);
		CommonUtils.TriggerElementMarkEvent(CommonDefine.EarthMark1, HotfixEnum.AdventureActorElementTriggerType.EarthElementTriggerType, _actor, monster, "LandMark_Trigger_Effect_02");
		OnTriggerLandMark(monster, hitDamageTag);
	}

	protected virtual void OnTriggerLandMark(MonsterAdventureActor monster, IList<int> hitDamageTag)
	{
	}

	private void OnElementMarkTrigger(IEvent evt)
	{
		if (evt is AdventureElementMarkTriggerEvent { elementType: HotfixEnum.elementType.SE } adventureElementMarkTriggerEvent)
		{
			if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 2))
			{
				_actor.buffComponent.AddBuff(11696211, _actor);
			}
			OnLandMarkTrigger(adventureElementMarkTriggerEvent.triggerActor, adventureElementMarkTriggerEvent.markActor);
		}
	}

	protected virtual void OnLandMarkTrigger(AdventureActor triggerActor, AdventureActor markActor)
	{
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
	}
}
