using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14001;

public class ParallelScript : ParallelBase
{
	private FP _lastTriggerTime_P41;

	private readonly List<int> _damageTag_P42 = new List<int> { Config.damageTag_Trigger_P42 };

	public override void OnEnable()
	{
		base.OnEnable();
		_lastTriggerTime_P41 = 0;
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_GET_BUFF", OnGetBuff);
	}

	private void OnCastSkill(IEvent evt)
	{
		if (evt is AdventureActorCastSkillEvent { sender: PlayerAdventureActor sender } adventureActorCastSkillEvent && sender == _actor && adventureActorCastSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B && ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 3))
		{
			_actor.buffComponent.AddBuff(14096311, _actor);
		}
	}

	private void OnBeforeHit(IEvent evt)
	{
		if (evt is AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent && adventureActorReceiveDamageBeforeHitEvent.from is PlayerAdventureActor && adventureActorReceiveDamageBeforeHitEvent.to is MonsterAdventureActor entity && adventureActorReceiveDamageBeforeHitEvent.from == _actor)
		{
			if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 5) && entity.IsEliteOrBossMonster())
			{
				AdventureActor.AddFromAttr(14096511, _actor);
			}
			OnBeforeSelfHit(adventureActorReceiveDamageBeforeHitEvent);
		}
	}

	protected virtual void OnBeforeSelfHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
	}

	private void OnReceiveDamage(IEvent evt)
	{
		if (!(evt is AdventureActorReceiveDamageEvent { from: PlayerAdventureActor playerAdventureActor, to: MonsterAdventureActor to } adventureActorReceiveDamageEvent))
		{
			return;
		}
		int perkLevel;
		if (playerAdventureActor == _actor)
		{
			OnSelfDamaged(adventureActorReceiveDamageEvent);
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 514042, out perkLevel) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, Config.damageTag_Trigger_P42))
			{
				if (to.monsterInfo.epicType == HotfixEnum.monsterEpicType.NORMAL)
				{
					to.Kill(_actor, null, HitBox.FeatureFlag.None, null, isHurtEffectScale: true, _damageTag_P42);
				}
				else
				{
					to.buffComponent.AddBuff(14042011, _actor);
				}
			}
			if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 2))
			{
				_actor.buffComponent.AddBuff(14096211, _actor);
			}
			if (CheckCanTriggerLandMark(to, adventureActorReceiveDamageEvent.hitDamageTag, adventureActorReceiveDamageEvent.weapon))
			{
				TriggerLandMark(to, adventureActorReceiveDamageEvent.hitDamageTag);
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514041, out perkLevel) && (_lastTriggerTime_P41 <= 0 || _actor.LogicTime - _lastTriggerTime_P41 > CommonUtils.GetScriptValue(_actor, 14041011)) && !playerAdventureActor.isAssist && playerAdventureActor.actorElementInfo.elementType == HotfixEnum.elementType.SE && adventureActorReceiveDamageEvent.damageType == HotfixEnum.damageType.NORMAL && playerAdventureActor.buffComponent.GetBuffNumByID(14041011) >= 3)
		{
			ILRuntimeAPI.HitActor(_actor, to, 140541001, "fx_14001_Hit_Attack", null, attackFxPlayOnTarget: false, HitBox.FeatureFlag.None, null, -1);
			_lastTriggerTime_P41 = _actor.LogicTime;
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
		if (CommonUtils.CheckElementMark(CommonDefine.Earth, monster) && CommonUtils.CheckTriggerElementMarkCD(_actor, monster) && CommonUtils.CheckHitByTag(hitDamageTag, Config.damageTag_TriggerLandMark))
		{
			return true;
		}
		return false;
	}

	private void TriggerLandMark(MonsterAdventureActor monster, IList<int> hitDamageTag)
	{
		monster.buffComponent.RemoveBuffByTag(CommonDefine.Earth);
		ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_14001_LandTag1_Boom", monster.tsTransform.Position);
		CommonUtils.TriggerElementMarkEvent(CommonDefine.Earth, HotfixEnum.AdventureActorElementTriggerType.EarthElementTriggerType, _actor, monster, "LandMark_Trigger_Effect_02");
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514043, out var _) && CommonUtils.CheckHitByTag(hitDamageTag, Config.damageTag_Trigger_P43))
		{
			_actor.buffComponent.AddBuff(14043011, _actor);
		}
		if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 1))
		{
			_actor.buffComponent.AddBuff(14096111, _actor);
		}
		OnTriggerLandMark(monster, hitDamageTag);
	}

	protected virtual void OnTriggerLandMark(MonsterAdventureActor monster, IList<int> hitDamageTag)
	{
	}

	private void OnGetBuff(IEvent evt)
	{
		if (evt is AdventureActorGetBuff adventureActorGetBuff && adventureActorGetBuff.from is PlayerAdventureActor && adventureActorGetBuff.eventInfo.buffTags.Contains(CommonDefine.Earth) && ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 4))
		{
			_actor.buffComponent.AddBuff(14096411, _actor);
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnReceiveDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_GET_BUFF", OnGetBuff);
		_lastTriggerTime_P41 = 0;
	}
}
