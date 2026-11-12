using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11501;

public class ParallelScript : ParallelBase
{
	protected List<int> _damageTag_AddLightMark;

	protected List<int> _damageTag_TriggerLightMark;

	public override void OnEnable()
	{
		base.OnEnable();
		if (_damageTag_AddLightMark == null)
		{
			_damageTag_AddLightMark = new List<int>();
		}
		else
		{
			_damageTag_AddLightMark.Clear();
		}
		_damageTag_AddLightMark.Add(Config.damageTag_AddLightMark);
		if (_damageTag_TriggerLightMark == null)
		{
			_damageTag_TriggerLightMark = new List<int>();
		}
		else
		{
			_damageTag_TriggerLightMark.Clear();
		}
		_damageTag_TriggerLightMark.Add(Config.damageTag_TriggerLightMark);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
	}

	private void OnCastSkill(IEvent evt)
	{
		if (evt is AdventureActorCastSkillEvent { sender: PlayerAdventureActor sender } adventureActorCastSkillEvent && sender == _actor)
		{
			if (adventureActorCastSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B && CommonUtils.HavePersonalPerk(_actor.dataID, 511541, out var _) && _actor.logicVariable.GetLogicTagToggle("CanTrigger_P41"))
			{
				_actor.logicVariable.ToggleLogicTag("CanTrigger_P41", value: false);
				_actor.buffComponent.AddBuff(11541011, _actor);
			}
			OnSelfCastSkill(adventureActorCastSkillEvent);
		}
	}

	protected virtual void OnSelfCastSkill(AdventureActorCastSkillEvent castSkillEvent)
	{
	}

	private void OnBeforeHit(IEvent evt)
	{
		if (!(evt is AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent) || !(adventureActorReceiveDamageBeforeHitEvent.from == _actor) || !(adventureActorReceiveDamageBeforeHitEvent.to is MonsterAdventureActor monsterAdventureActor))
		{
			return;
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511542, out var perkLevel) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, Config.damageTag_Trigger_P42))
		{
			AdventureActor.AddFromAttr(11542001, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511543, out perkLevel))
		{
			FP scriptValue = CommonUtils.GetScriptValue(_actor, 11543011);
			if (monsterAdventureActor.actorHealthInfo.hpPercentage * 100 <= scriptValue && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, Config.damageTag_Trigger_P43))
			{
				AdventureActor.AddFromAttr(11543001, _actor);
			}
		}
		if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 5) && monsterAdventureActor.IsEliteOrBossMonster())
		{
			AdventureActor.AddFromAttr(11596511, _actor);
		}
		OnBeforeSelfHit(adventureActorReceiveDamageBeforeHitEvent);
	}

	protected virtual void OnBeforeSelfHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
	}

	private void OnReceiveDamage(IEvent evt)
	{
		if (!(evt is AdventureActorReceiveDamageEvent { to: MonsterAdventureActor to, from: PlayerAdventureActor playerAdventureActor } adventureActorReceiveDamageEvent))
		{
			return;
		}
		OnPlayerDamaged(adventureActorReceiveDamageEvent);
		if (playerAdventureActor == _actor)
		{
			if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 3))
			{
				to.buffComponent.AddBuff(11596311, _actor);
			}
			if (CheckCanAddLightMark(to, adventureActorReceiveDamageEvent.hitDamageTag))
			{
				to.buffComponent.AddBuff(3011, _actor);
			}
			OnSelfDamaged(adventureActorReceiveDamageEvent);
			if (CheckCanTriggerLightMark(to, adventureActorReceiveDamageEvent.hitDamageTag))
			{
				TriggerLightMark(to, adventureActorReceiveDamageEvent.hitDamageTag);
			}
		}
	}

	private bool CheckCanAddLightMark(MonsterAdventureActor monster, IList<int> hitDamageTag)
	{
		if (monster == null || hitDamageTag == null)
		{
			return false;
		}
		List<int> damageTag_AddLightMark = _damageTag_AddLightMark;
		if (damageTag_AddLightMark != null && damageTag_AddLightMark.Count > 0)
		{
			for (int i = 0; i < _damageTag_AddLightMark.Count; i++)
			{
				int hitTag = _damageTag_AddLightMark.get_Item(i);
				if (CommonUtils.CheckHitByTag(hitDamageTag, hitTag))
				{
					return true;
				}
			}
		}
		return false;
	}

	private bool CheckCanTriggerLightMark(MonsterAdventureActor monster, IList<int> hitDamageTag)
	{
		if (monster == null || hitDamageTag == null)
		{
			return false;
		}
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
		return false;
	}

	private void TriggerLightMark(MonsterAdventureActor monster, IList<int> hitDamageTag)
	{
		monster.buffComponent?.RemoveBuffByTag(CommonDefine.Light);
		ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_11501_LightTag_Boom_H2", monster.tsTransform.Position);
		CommonUtils.TriggerElementMarkEvent(CommonDefine.Light, HotfixEnum.AdventureActorElementTriggerType.LightElementTriggerType2, _actor, monster, "LightMark_Trigger_Effect_01");
		OnTriggerLightMark(monster, hitDamageTag);
	}

	protected virtual void OnTriggerLightMark(MonsterAdventureActor monster, IList<int> hitDamageTag)
	{
	}

	protected virtual void OnPlayerDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
	}

	protected virtual void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
	}

	private void OnGetBuff(IEvent evt)
	{
		if (evt is AdventureActorGetBuff adventureActorGetBuff && adventureActorGetBuff.from is PlayerAdventureActor && adventureActorGetBuff.eventInfo.buffTags.Contains(CommonDefine.Light) && ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 4))
		{
			_actor.buffComponent.AddBuff(11596411, _actor);
		}
	}

	private void OnElementMarkTrigger(IEvent evt)
	{
		if (evt is AdventureElementMarkTriggerEvent { elementType: HotfixEnum.elementType.LE } adventureElementMarkTriggerEvent && adventureElementMarkTriggerEvent.triggerActor is PlayerAdventureActor && adventureElementMarkTriggerEvent.markActor is MonsterAdventureActor monsterAdventureActor)
		{
			if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 1))
			{
				monsterAdventureActor.buffComponent.AddBuff(11596111, _actor);
			}
			OnLightMarkTrigger(adventureElementMarkTriggerEvent);
		}
	}

	protected virtual void OnLightMarkTrigger(AdventureElementMarkTriggerEvent markTriggerEvent)
	{
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_GET_BUFF", OnGetBuff);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
	}
}
