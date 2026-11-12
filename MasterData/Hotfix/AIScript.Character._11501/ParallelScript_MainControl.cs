using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11501;

public class ParallelScript_MainControl : ParallelScript
{
	private long _lastTargetId_P2;

	private HashSet<long> _triggerSet_P10;

	private FP _lastTriggerTime_P13;

	public override void OnEnable()
	{
		base.OnEnable();
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511511, out var perkLevel))
		{
			_actor.buffComponent.AddBuff(11511011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511512, out perkLevel))
		{
			_damageTag_TriggerLightMark?.Add(Config_MainControl.damageTag_TriggerLightMark_P12);
		}
	}

	protected override void OnBeforeSelfHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
		base.OnBeforeSelfHit(beforeHitEvent);
		MonsterAdventureActor monsterAdventureActor = beforeHitEvent.to as MonsterAdventureActor;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511502, out var perkLevel) && _actor.buffComponent.GetBuffNumByID(11502011) >= 12 && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_MainControl.damageTag_P2))
		{
			AdventureActor.AddFromAttr(11502011, _actor);
		}
		if (monsterAdventureActor != null && CommonUtils.HavePersonalPerk(_actor.dataID, 511507, out perkLevel))
		{
			ILRuntimeAPI.SearchByRangeAndPosition(_actor, monsterAdventureActor.tsTransform.Position, Config_MainControl.triggerRadius_P7 + monsterAdventureActor.GetRadius(), (List<LogicEntity> enemyList) =>
			{
				if (enemyList != null && enemyList.Count <= 1)
				{
					AdventureActor.AddFromAttr(11507001, _actor);
				}
			}, isConfront: true);
		}
		if (!CommonUtils.HavePersonalPerk(_actor.dataID, 511509, out perkLevel) || !CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_MainControl.damageTag_P9))
		{
			return;
		}
		foreach (KeyValuePair<AnimationSlotConfigComponent.SlotType, int> item in Config_MainControl.damageTagDic_Funnel)
		{
			AnimationSlotConfigComponent.SlotType key = item.Key;
			int value = item.Value;
			if (CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, value))
			{
				string tag = $"{key}_{511509}";
				if (_actor.logicVariable.GetLogicTagToggle(tag))
				{
					AdventureActor.AddFromAttr(11509001, _actor);
				}
			}
		}
	}

	protected override void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnSelfDamaged(damageEvent);
		MonsterAdventureActor monster = damageEvent.to as MonsterAdventureActor;
		if (monster == null)
		{
			return;
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511502, out var perkLevel) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_MainControl.damageTag_P2))
		{
			if (_lastTargetId_P2 <= 0)
			{
				_lastTargetId_P2 = monster.Id;
			}
			else if (!_actor.logicVariable.GetLogicTagToggle("TriggerPerk_P2"))
			{
				if (_lastTargetId_P2 == monster.Id)
				{
					_actor.buffComponent.AddBuff(11502011, _actor);
					if (_actor.buffComponent.GetBuffNumByID(11502011) >= 12)
					{
						_actor.logicVariable.ToggleLogicTag("TriggerPerk_P2", value: true);
						_actor.buffComponent.AddBuff(11502012, _actor);
						AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
						adventureActorCustomEvent.sender = _actor;
						adventureActorCustomEvent.actor = _actor;
						adventureActorCustomEvent.eventHashCode = Config_MainControl.eventHashCode_Trigger_LaserStrengthen;
						_actor.DispatchEvent(adventureActorCustomEvent);
					}
				}
				else
				{
					_lastTargetId_P2 = monster.Id;
					_actor.buffComponent.RemoveBuffByBuffId(11502011, 1);
				}
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511503, out perkLevel) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_MainControl.damageTag_P3) && !monster.buffComponent.CheckBuffByBuffID(11503011))
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_11501_Main_Skill_P06_Beam", monster.tsTransform.Position, default, (AreaEffectEntity areaEffect) =>
			{
				AreaEffect_FollowComponent areaEffectComponent = areaEffect.GetAreaEffectComponent<AreaEffect_FollowComponent>();
				if (areaEffectComponent != null)
				{
					areaEffectComponent.targetType = AreaEffect_FollowComponent.FollowTargetType.SpecifiedTarget;
					areaEffectComponent.FollowTarget = monster;
				}
			});
			monster.buffComponent.AddBuff(11503011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511505, out perkLevel) && monster.IsEliteOrBossMonster() && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_MainControl.damageTag_Trigger_P5))
		{
			foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
			{
				actorL.buffComponent.AddBuff(11505011, _actor);
			}
		}
		if (!CommonUtils.HavePersonalPerk(_actor.dataID, 511510, out perkLevel) || !CommonUtils.CheckElementMark(CommonDefine.Light, monster) || !CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_MainControl.damageTag_P10))
		{
			return;
		}
		if (_triggerSet_P10 == null)
		{
			_triggerSet_P10 = new HashSet<long>();
		}
		if (!_triggerSet_P10.Add(monster.Id))
		{
			return;
		}
		foreach (PlayerAdventureActor actorL2 in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
		{
			actorL2.buffComponent.AddBuff(11510011, _actor);
		}
	}

	protected override void OnTriggerLightMark(MonsterAdventureActor monster, IList<int> hitDamageTag)
	{
		base.OnTriggerLightMark(monster, hitDamageTag);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511511, out var perkLevel))
		{
			_actor.buffComponent.AddBuff(11511012, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 511512, out perkLevel) && hitDamageTag.Contains(Config_MainControl.damageTag_TriggerLightMark_P12))
		{
			_actor.buffComponent.AddBuff(11512011, _actor);
		}
	}

	protected override void OnSelfCastSkill(AdventureActorCastSkillEvent castSkillEvent)
	{
		base.OnSelfCastSkill(castSkillEvent);
		int perkLevel;
		if (castSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.A)
		{
			if (!CommonUtils.HavePersonalPerk(_actor.dataID, 511513, out perkLevel))
			{
				return;
			}
			FP scriptValue = CommonUtils.GetScriptValue(_actor, 11513011);
			if (_lastTriggerTime_P13 <= 0 || _actor.LogicTime - _lastTriggerTime_P13 > scriptValue)
			{
				if (!string.IsNullOrEmpty("AreaEffect_11501_LimitDodge_Stun"))
				{
					ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_11501_LimitDodge_Stun", _actor.tsTransform.Position);
				}
				_lastTriggerTime_P13 = _actor.LogicTime;
			}
		}
		else if (castSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B && CommonUtils.HavePersonalPerk(_actor.dataID, 511510, out perkLevel))
		{
			_triggerSet_P10?.Clear();
		}
	}

	private void Clear()
	{
		_lastTargetId_P2 = 0L;
		_triggerSet_P10?.Clear();
		_lastTriggerTime_P13 = 0;
	}

	public override void OnDisable()
	{
		base.OnDisable();
		Clear();
	}
}
