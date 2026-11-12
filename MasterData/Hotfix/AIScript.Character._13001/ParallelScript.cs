using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._13001;

public class ParallelScript : ParallelBase
{
	protected List<int> _damageTag_TriggerWaterCorrosion;

	private int _addCount_P43;

	public override void OnEnable()
	{
		base.OnEnable();
		if (_damageTag_TriggerWaterCorrosion == null)
		{
			_damageTag_TriggerWaterCorrosion = new List<int>();
		}
		else
		{
			_damageTag_TriggerWaterCorrosion.Clear();
		}
		_damageTag_TriggerWaterCorrosion.Add(Config.damageTag_TriggerWaterCorrosion);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("AREA_EFFECT_ENTER_EXIT", OnAreaEffectEnterExit);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
	}

	private void OnCastSkill(IEvent evt)
	{
		if (!(evt is AdventureActorCastSkillEvent { sender: PlayerAdventureActor sender } adventureActorCastSkillEvent) || !(sender == _actor))
		{
			return;
		}
		if (adventureActorCastSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 2))
			{
				_actor.buffComponent.AddBuff(13096211, _actor);
			}
		}
		else if (adventureActorCastSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.D)
		{
			_addCount_P43 = 0;
		}
		OnSelfCastSkill(adventureActorCastSkillEvent);
	}

	protected virtual void OnSelfCastSkill(AdventureActorCastSkillEvent castSkillEvent)
	{
	}

	private void OnBeforeHit(IEvent evt)
	{
		if (!(evt is AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent) || !(adventureActorReceiveDamageBeforeHitEvent.from is PlayerAdventureActor) || !(adventureActorReceiveDamageBeforeHitEvent.to is MonsterAdventureActor monsterAdventureActor))
		{
			return;
		}
		if (adventureActorReceiveDamageBeforeHitEvent.from == _actor)
		{
			if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, Config.damageTag_UltraSkill))
			{
				if (CommonUtils.HavePersonalPerk(_actor.dataID, 513041, out var perkLevel))
				{
					AdventureActor.AddFromAttr(13041001, _actor);
				}
				if (CommonUtils.HavePersonalPerk(_actor.dataID, 513043, out perkLevel) && _addCount_P43 > 0)
				{
					AdventureActor.AddFromAttr(13043001, _actor, _addCount_P43);
				}
			}
			if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 5) && (monsterAdventureActor.monsterInfo.epicType == HotfixEnum.monsterEpicType.ELITE || monsterAdventureActor.IsBossMonster()))
			{
				AdventureActor.AddFromAttr(13096511, _actor);
			}
			OnSelfBeforeHit(adventureActorReceiveDamageBeforeHitEvent);
		}
		OnPlayerBeforeHit(adventureActorReceiveDamageBeforeHitEvent);
	}

	private void OnReceiveDamage(IEvent evt)
	{
		if (!(evt is AdventureActorReceiveDamageEvent { to: MonsterAdventureActor to } adventureActorReceiveDamageEvent))
		{
			return;
		}
		PlayerAdventureActor summoner;
		if (adventureActorReceiveDamageEvent.from == _actor)
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 513043, out var _) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, Config.damageTag_UltraSkill))
			{
				int num = CommonUtils.GetScriptValue(_actor, 13043013).AsInt();
				if (to.isFrozen && _addCount_P43 < num)
				{
					FP scriptValue = CommonUtils.GetScriptValue(_actor, 13043011);
					List<AreaEffectEntity> areaEffectByTag = ILRuntimeAPI.GetAreaEffectByTag(Config.areaEffectTag_UltraSkill);
					for (int i = 0; i < areaEffectByTag.Count; i++)
					{
						areaEffectByTag.get_Item(i)?.AddLeftTime(scriptValue);
					}
					_addCount_P43++;
				}
			}
			if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 3) && adventureActorReceiveDamageEvent.damageType == HotfixEnum.damageType.SKILL)
			{
				to.buffComponent.AddBuff(13096311, _actor);
			}
			OnSelfDamaged(adventureActorReceiveDamageEvent);
			if (CheckCanTriggerWaterCorrosion(to, adventureActorReceiveDamageEvent.hitDamageTag))
			{
				TriggerWaterCorrosion(to, adventureActorReceiveDamageEvent.hitDamageTag);
			}
		}
		else if (adventureActorReceiveDamageEvent.from.IsPlayerMinion(out summoner) && summoner == _actor && CheckCanTriggerWaterCorrosion(to, adventureActorReceiveDamageEvent.hitDamageTag))
		{
			TriggerWaterCorrosion(to, adventureActorReceiveDamageEvent.hitDamageTag);
		}
	}

	private bool CheckCanTriggerWaterCorrosion(MonsterAdventureActor monster, IList<int> hitDamageTag)
	{
		if (monster == null || hitDamageTag == null)
		{
			return false;
		}
		if (_damageTag_TriggerWaterCorrosion == null || _damageTag_TriggerWaterCorrosion.Count <= 0)
		{
			return false;
		}
		if (CommonUtils.CheckElementMark(CommonDefine.Water, monster) && CommonUtils.CheckTriggerElementMarkCD(_actor, monster))
		{
			for (int i = 0; i < _damageTag_TriggerWaterCorrosion.Count; i++)
			{
				int hitTag = _damageTag_TriggerWaterCorrosion.get_Item(i);
				if (CommonUtils.CheckHitByTag(hitDamageTag, hitTag))
				{
					return true;
				}
			}
		}
		return false;
	}

	private void TriggerWaterCorrosion(MonsterAdventureActor monster, IList<int> hitDamageTag)
	{
		monster.buffComponent.RemoveBuffByTag(CommonDefine.Water);
		monster.buffComponent.AddBuff(4021, _actor);
		ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_130_WaterTag1_Boom", monster.tsTransform.Position);
		if (monster.buffComponent.GetBuffNum(0, 0, Config.tag_Cold) >= 3)
		{
			monster.buffComponent.RemoveBuffByTag(Config.tag_Cold);
			monster.buffComponent.AddBuff(4100, _actor);
		}
		OnTriggerWaterCorrosion(monster, hitDamageTag);
		CommonUtils.TriggerElementMarkEvent(CommonDefine.Water, HotfixEnum.AdventureActorElementTriggerType.WaterElementTriggerType1, _actor, monster, "WaterMark_Trigger_Effect_05");
	}

	protected virtual void OnSelfBeforeHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
	}

	protected virtual void OnPlayerBeforeHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
	}

	protected virtual void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
	}

	protected virtual void OnTriggerWaterCorrosion(MonsterAdventureActor monster, IList<int> hitDamageTag)
	{
	}

	private void OnAreaEffectEnterExit(IEvent evt)
	{
		if (evt is AdventureAreaEnterExitEvent { sender: AreaEffectEntity sender } adventureAreaEnterExitEvent && sender.CheckTag(Config.areaEffectTag_UltraSkill) && CommonUtils.HavePersonalPerk(_actor.dataID, 513042, out var _) && adventureAreaEnterExitEvent.triggerCollider != null && adventureAreaEnterExitEvent.triggerCollider.Entity is PlayerAdventureActor playerAdventureActor && playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.WE)
		{
			if (adventureAreaEnterExitEvent.iEnter)
			{
				playerAdventureActor.buffComponent.AddBuff(13042011, _actor);
			}
			else
			{
				playerAdventureActor.buffComponent.RemoveBuffByBuffId(13042011);
			}
		}
	}

	private void OnElementMarkTrigger(IEvent evt)
	{
		if (evt is AdventureElementMarkTriggerEvent adventureElementMarkTriggerEvent && adventureElementMarkTriggerEvent.triggerActor is PlayerAdventureActor && adventureElementMarkTriggerEvent.elementType == HotfixEnum.elementType.WE)
		{
			if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 1))
			{
				adventureElementMarkTriggerEvent.markActor?.buffComponent.AddBuff(13096111, _actor);
			}
			if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 4))
			{
				_actor.buffComponent.AddBuff(13096411, _actor);
			}
		}
	}

	private void Clear()
	{
		_addCount_P43 = 0;
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_ENTER_EXIT", OnAreaEffectEnterExit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		Clear();
	}
}
