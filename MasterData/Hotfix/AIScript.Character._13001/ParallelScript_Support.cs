using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._13001;

public class ParallelScript_Support : ParallelScript
{
	private Dictionary<long, int> _addBuffTimsDic_P22;

	private Dictionary<long, int> _damageTimesDic_P26;

	private List<int> _damageTag_P27;

	private HashSet<long> _triggerSet_P29;

	public override void OnEnable()
	{
		base.OnEnable();
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513033, out var _))
		{
			foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
			{
				if (actorL.actorElementInfo.elementType == HotfixEnum.elementType.WE)
				{
					actorL.buffComponent.AddBuff(13033011, _actor);
				}
			}
		}
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_PLAYER_LEAVE", OnActorLeave);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ELEMENT_MARK_TRIGGER", OnElementTrigger);
	}

	private void OnActorLeave(IEvent evt)
	{
		if (!(evt is AdventurePlayerLeaveEvent adventurePlayerLeaveEvent) || !(adventurePlayerLeaveEvent.player == _actor) || !CommonUtils.HavePersonalPerk(_actor.dataID, 513022, out var _))
		{
			return;
		}
		Dictionary<long, int> addBuffTimsDic_P = _addBuffTimsDic_P22;
		if (addBuffTimsDic_P == null || addBuffTimsDic_P.Count <= 0)
		{
			return;
		}
		foreach (long key in _addBuffTimsDic_P22.Keys)
		{
			MonsterAdventureActor monsterAdventureActor = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntityByID(key) as MonsterAdventureActor;
			if (monsterAdventureActor != null && monsterAdventureActor.actorHealthInfo.isAlive)
			{
				ILRuntimeAPI.HitActor(_actor, monsterAdventureActor, 130522001, "fx_13001_loop_B2_Skill_Perk29_Hurt", null, attackFxPlayOnTarget: false, HitBox.FeatureFlag.None, null, -1);
				monsterAdventureActor.buffComponent?.RemoveBuffByBuffId(13022011);
				monsterAdventureActor.buffComponent?.RemoveBuffByBuffId(13022012);
			}
		}
		_addBuffTimsDic_P22.Clear();
	}

	private void OnReceiveCustomEvent(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent adventureActorCustomEvent && string.Equals(adventureActorCustomEvent.eventName, "StartIceRain"))
		{
			TSVector2 startPosition = _actor.tsTransform.Position + _actor.tsTransform.Left * Config_Support.startAreaEffectOffset_Skill.x + _actor.tsTransform.Forward * Config_Support.startAreaEffectOffset_Skill.y;
			_actor.StartLogicCoroutine(PerkLogic_Skill(startPosition, _actor.tsTransform.Forward));
		}
	}

	protected override void OnSelfCastSkill(AdventureActorCastSkillEvent castSkillEvent)
	{
		base.OnSelfCastSkill(castSkillEvent);
		if (castSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			_triggerSet_P29?.Clear();
		}
	}

	protected override void OnSelfBeforeHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
		base.OnSelfBeforeHit(beforeHitEvent);
		MonsterAdventureActor monsterAdventureActor = beforeHitEvent.to as MonsterAdventureActor;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513022, out var perkLevel))
		{
			if (CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Attach_P22))
			{
				int buffNumByID = monsterAdventureActor.buffComponent.GetBuffNumByID(13022011);
				if (buffNumByID > 0)
				{
					AdventureActor.AddFromAttr(13022011, _actor, buffNumByID);
				}
			}
			else if (CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Remove_P22))
			{
				int buffNumByID2 = monsterAdventureActor.buffComponent.GetBuffNumByID(13022011);
				if (buffNumByID2 > 0)
				{
					AdventureActor.AddFromAttr(13022011, _actor, buffNumByID2);
				}
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513023, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P23))
		{
			AdventureActor.AddFromAttr(13023011, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513025, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P25))
		{
			AdventureActor.AddFromAttr(13025001, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513027, out perkLevel) && (monsterAdventureActor.IsBossMonster() || monsterAdventureActor.monsterInfo.epicType == HotfixEnum.monsterEpicType.ELITE) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P27))
		{
			FDP fDP = (FDP)CommonUtils.GetScriptValue(_actor, 13027011) / (FDP)100L;
			if (monsterAdventureActor.actorHealthInfo.hpPercentage < fDP)
			{
				AdventureActor.AddFromAttr(13027001, _actor);
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513028, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P28))
		{
			AdventureActor.AddFromAttr(13028001, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513030, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, Config_Support.damageTag_Trigger_P30))
		{
			AdventureActor.AddFromAttr(13030001, _actor);
		}
	}

	protected override void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnSelfDamaged(damageEvent);
		MonsterAdventureActor monsterAdventureActor = damageEvent.to as MonsterAdventureActor;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513022, out var perkLevel) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_Support.damageTag_AddArrow_P22) && _actor.state == ActorState.Action && monsterAdventureActor.actorHealthInfo.isAlive)
		{
			if (monsterAdventureActor.buffComponent.CheckBuffByBuffID(13022011))
			{
				ILRuntimeAPI.HitActor(_actor, monsterAdventureActor, 130522002);
			}
			if (monsterAdventureActor == _actor.attackTarget)
			{
				if (_addBuffTimsDic_P22 == null)
				{
					_addBuffTimsDic_P22 = new Dictionary<long, int>();
				}
				if (_addBuffTimsDic_P22.ContainsKey(monsterAdventureActor.Id))
				{
					perkLevel = _addBuffTimsDic_P22.get_Item(monsterAdventureActor.Id)++;
				}
				else
				{
					_addBuffTimsDic_P22.Add(monsterAdventureActor.Id, 1);
				}
				BuffEntity buffEntity = monsterAdventureActor.buffComponent?.AddBuff(13022011, _actor);
				if (buffEntity != null)
				{
					int buffNum = buffEntity.GetBuffNum();
					int num = -1;
					for (int i = 0; i < Config_Support.arrowFxBuffLimitList_P22.Count; i++)
					{
						if (buffNum <= Config_Support.arrowFxBuffLimitList_P22.get_Item(i))
						{
							num = i + 1;
							break;
						}
					}
					if (num > 0 && _addBuffTimsDic_P22.get_Item(monsterAdventureActor.Id) == num)
					{
						monsterAdventureActor.buffComponent?.AddBuff(13022012, _actor);
						_addBuffTimsDic_P22.set_Item(monsterAdventureActor.Id, 0);
					}
				}
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513025, out perkLevel) && monsterAdventureActor == _actor.attackTarget && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_Support.damageTag_Trigger_P25) && monsterAdventureActor.actorHealthInfo.isAlive)
		{
			if (monsterAdventureActor.buffComponent.CheckBuffByBuffID(13025012))
			{
				monsterAdventureActor.buffComponent.RemoveBuffByBuffId(13025012);
				monsterAdventureActor.buffComponent.AddBuff(13025013, _actor);
				_actor.StartLogicCoroutine(DelayHit_25(monsterAdventureActor), runImmediately: true);
			}
			else if (monsterAdventureActor.buffComponent.CheckBuffByBuffID(13025011))
			{
				monsterAdventureActor.buffComponent.RemoveBuffByBuffId(13025011);
				monsterAdventureActor.buffComponent.AddBuff(13025012, _actor);
			}
			else
			{
				monsterAdventureActor.buffComponent.AddBuff(13025011, _actor);
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513026, out perkLevel) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_Support.damageTag_Trigger_P26))
		{
			if (_damageTimesDic_P26 == null)
			{
				_damageTimesDic_P26 = new Dictionary<long, int>();
			}
			if (_damageTimesDic_P26.TryGetValue(monsterAdventureActor.Id, out var value))
			{
				value++;
				if (value >= 3)
				{
					monsterAdventureActor.buffComponent.AddBuff(13026011, _actor);
					_damageTimesDic_P26.set_Item(monsterAdventureActor.Id, 0);
				}
				else
				{
					_damageTimesDic_P26.set_Item(monsterAdventureActor.Id, value);
				}
			}
			else
			{
				_damageTimesDic_P26.Add(monsterAdventureActor.Id, 1);
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513027, out perkLevel) && monsterAdventureActor.monsterInfo.epicType == HotfixEnum.monsterEpicType.NORMAL && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_Support.damageTag_Trigger_P27))
		{
			FDP fDP = (FDP)CommonUtils.GetScriptValue(_actor, 13027011) / (FDP)100L;
			if (monsterAdventureActor.actorHealthInfo.hpPercentage < fDP)
			{
				if (_damageTag_P27 == null)
				{
					_damageTag_P27 = new List<int> { Config_Support.damageTag_Trigger_P27 };
				}
				monsterAdventureActor.Kill(_actor, null, HitBox.FeatureFlag.None, null, isHurtEffectScale: true, _damageTag_P27);
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513028, out perkLevel) && damageEvent.isCrit && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_Support.damageTag_Trigger_P28))
		{
			foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
			{
				if (actorL.actorElementInfo.elementType == HotfixEnum.elementType.WE)
				{
					actorL.buffComponent.AddBuff(13028011, _actor);
				}
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513029, out perkLevel) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_Support.damageTag_Trigger_P29))
		{
			if (_triggerSet_P29 == null)
			{
				_triggerSet_P29 = new HashSet<long>();
			}
			if (_triggerSet_P29.Add(monsterAdventureActor.Id))
			{
				_actor.buffComponent.AddBuff(13029012, _actor);
			}
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513032, out perkLevel) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, Config_Support.damageTag_Trigger_P32))
		{
			monsterAdventureActor.buffComponent.AddBuff(4011, _actor);
		}
	}

	private void OnElementTrigger(IEvent evt)
	{
		if (evt is AdventureElementMarkTriggerEvent { elementType: HotfixEnum.elementType.WE } && CommonUtils.HavePersonalPerk(_actor.dataID, 513032, out var _) && ILRuntimeAPI.GetAreaEffectByTag(Config_Support.checkAreaEffectTag_P32).Count > 0)
		{
			_actor.buffComponent.AddBuff(13032011, _actor);
		}
	}

	private IEnumerator PerkLogic_Skill(TSVector2 startPosition, TSVector2 direction)
	{
		int areaEffectCount = 0;
		TSVector2 position = startPosition;
		while (areaEffectCount < 20)
		{
			position += Config_Support.areaEffectDistance_Skill * direction;
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_130_Support_Skill_P22_IceRain", position);
			areaEffectCount++;
			yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(Config_Support.generateInterval_Skill));
		}
	}

	private IEnumerator DelayHit_25(MonsterAdventureActor monster)
	{
		new PlayFX().Play(_actor, null, "fx_13001_base_B2_Skill_Perk_25_atk", 0, monster.tsTransform.Position, TSVector2.zero);
		long monsterId = monster.Id;
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(Config_Support.hitDelay_P25));
		if (monster != null && monster.Id == monsterId && monster.actorHealthInfo.isAlive)
		{
			monster.buffComponent.RemoveBuffByBuffId(13025013);
			ILRuntimeAPI.HitActor(_actor, monster, 130525001, "fx_13001_hit_Water", null, attackFxPlayOnTarget: false, HitBox.FeatureFlag.None, null, -1);
		}
	}

	private void Clear()
	{
		_addBuffTimsDic_P22?.Clear();
		_damageTimesDic_P26?.Clear();
		_triggerSet_P29?.Clear();
	}

	public override void OnDisable()
	{
		base.OnDisable();
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_PLAYER_LEAVE", OnActorLeave);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ELEMENT_MARK_TRIGGER", OnElementTrigger);
		Clear();
	}
}
