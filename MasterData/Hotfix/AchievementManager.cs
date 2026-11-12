using System.Collections.Generic;
using UnityEngine;

public class AchievementManager : SceneSingleton<AchievementManager>
{
	public struct AchievementDataDic
	{
		public Dictionary<int, Dictionary<int, int>> DamageDataDic;

		public Dictionary<int, Dictionary<int, int>> killDataDic;

		public Dictionary<int, int> OnceSkillKillCountDic;

		public Dictionary<int, int> CritCountData;

		public Dictionary<int, int> PrefectDodgeData;

		public long MaxDamageValue;

		public Dictionary<int, int> MarkTriggerData;

		public float MainActorHpPrec;

		public Dictionary<int, int> CastSkillData;

		public Dictionary<int, int> EventData;

		public Dictionary<int, int> specialBattleData;
	}

	public Dictionary<int, Dictionary<int, int>> DamageData = new Dictionary<int, Dictionary<int, int>>();

	public Dictionary<int, Dictionary<int, int>> killData = new Dictionary<int, Dictionary<int, int>>();

	private Dictionary<long, Dictionary<int, int>> tmpSkillKillCount = new Dictionary<long, Dictionary<int, int>>();

	private Dictionary<int, int> critCountData = new Dictionary<int, int>();

	private Dictionary<int, int> prefectDodgeData = new Dictionary<int, int>();

	private long maxDamageValue;

	private Dictionary<int, int> markTriggerData = new Dictionary<int, int>();

	private Dictionary<int, int> castSkillData = new Dictionary<int, int>();

	private Dictionary<int, int> eventData;

	private Dictionary<int, int> specialBattleData = new Dictionary<int, int>();

	private void Start()
	{
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_LEVEL_START", OnLevelStart);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_DIED", ActorDied);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_CRIT_DAMAGE", OnReceiveCrit);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("TRIGGER_PERFECTDODGE", OnPrefectDodge);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("TRIGGER_ACHIEVEMENTEVT", TriggerEvent);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BATTLE_ACHIEVEMENT_FINISH", SpecialBattleData);
	}

	private void OnDisable()
	{
		ClearData();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_LEVEL_START", OnLevelStart);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_DIED", ActorDied);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_RECEIVE_CRIT_DAMAGE", OnReceiveCrit);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TRIGGER_PERFECTDODGE", OnPrefectDodge);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ELEMENT_MARK_TRIGGER", OnElementMarkTrigger);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TRIGGER_ACHIEVEMENTEVT", TriggerEvent);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BATTLE_ACHIEVEMENT_FINISH", SpecialBattleData);
	}

	private bool isPlayerEntity(LogicEntity logicEntity)
	{
		if (logicEntity is PlayerAdventureActor)
		{
			return true;
		}
		if (logicEntity.IsPlayerSummoned(out var _, out var _))
		{
			return true;
		}
		return false;
	}

	private void ClearData()
	{
		DamageData.Clear();
		killData.Clear();
		tmpSkillKillCount.Clear();
		critCountData.Clear();
		prefectDodgeData.Clear();
		maxDamageValue = 0L;
		markTriggerData.Clear();
		castSkillData.Clear();
	}

	private void OnLevelStart(IEvent evt)
	{
		ClearData();
	}

	private void OnDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (isPlayerEntity(adventureActorReceiveDamageEvent.from))
		{
			if (adventureActorReceiveDamageEvent.damage > maxDamageValue)
			{
				maxDamageValue = adventureActorReceiveDamageEvent.damage;
			}
			int dataID = (adventureActorReceiveDamageEvent.from as AdventureActor).dataID;
			if (adventureActorReceiveDamageEvent.isKill)
			{
				int uniqueAttackId = adventureActorReceiveDamageEvent.uniqueAttackId;
				if (uniqueAttackId > 0)
				{
					if (tmpSkillKillCount.ContainsKey(uniqueAttackId))
					{
						if (tmpSkillKillCount.get_Item((long)uniqueAttackId).ContainsKey(dataID))
						{
							tmpSkillKillCount.get_Item((long)uniqueAttackId).set_Item(dataID, tmpSkillKillCount.get_Item((long)uniqueAttackId).get_Item(dataID) + 1);
						}
						else
						{
							tmpSkillKillCount.get_Item((long)uniqueAttackId).Add(dataID, 1);
						}
					}
					else
					{
						tmpSkillKillCount.Add(uniqueAttackId, new Dictionary<int, int>());
						tmpSkillKillCount.get_Item((long)uniqueAttackId).Add(dataID, 1);
					}
				}
			}
		}
		if (!isPlayerEntity(adventureActorReceiveDamageEvent.to))
		{
			return;
		}
		int dataID2 = (adventureActorReceiveDamageEvent.to as AdventureActor).dataID;
		int hitDamageId = adventureActorReceiveDamageEvent.hitDamageId;
		if (DamageData.ContainsKey(dataID2))
		{
			if (DamageData.get_Item(dataID2).ContainsKey(hitDamageId))
			{
				DamageData.get_Item(dataID2).set_Item(hitDamageId, DamageData.get_Item(dataID2).get_Item(hitDamageId) + 1);
			}
			else
			{
				DamageData.get_Item(dataID2).Add(hitDamageId, 1);
			}
		}
		else
		{
			DamageData.Add(dataID2, new Dictionary<int, int>());
			DamageData.get_Item(dataID2).Add(hitDamageId, 1);
		}
	}

	private void ActorDied(IEvent evt)
	{
		AdventureActorDiedEvent adventureActorDiedEvent = evt as AdventureActorDiedEvent;
		if (adventureActorDiedEvent.killer == null || adventureActorDiedEvent.deadType == DeadType.ClearSelf || adventureActorDiedEvent.deadType == DeadType.DestorySelf || !isPlayerEntity(adventureActorDiedEvent.killer))
		{
			return;
		}
		int dataID = (adventureActorDiedEvent.killer as AdventureActor).dataID;
		int dataID2 = adventureActorDiedEvent.actor.dataID;
		if (killData.ContainsKey(dataID))
		{
			if (killData.get_Item(dataID).ContainsKey(dataID2))
			{
				killData.get_Item(dataID).set_Item(dataID2, killData.get_Item(dataID).get_Item(dataID2) + 1);
			}
			else
			{
				killData.get_Item(dataID).Add(dataID2, 1);
			}
		}
		else
		{
			killData.Add(dataID, new Dictionary<int, int>());
			killData.get_Item(dataID).Add(dataID2, 1);
		}
	}

	private void OnReceiveCrit(IEvent evt)
	{
		AdventureActorReceiveCritDamageEvent adventureActorReceiveCritDamageEvent = evt as AdventureActorReceiveCritDamageEvent;
		if (!(adventureActorReceiveCritDamageEvent.from == null) && isPlayerEntity(adventureActorReceiveCritDamageEvent.from))
		{
			int dataID = (adventureActorReceiveCritDamageEvent.from as AdventureActor).dataID;
			if (critCountData.ContainsKey(dataID))
			{
				critCountData.get_Item(dataID)++;
			}
			else
			{
				critCountData.set_Item(dataID, 1);
			}
		}
	}

	private void OnPrefectDodge(IEvent evt)
	{
		AdventurePerfectDodgeTrigger adventurePerfectDodgeTrigger = evt as AdventurePerfectDodgeTrigger;
		if (!(adventurePerfectDodgeTrigger.actor == null) && isPlayerEntity(adventurePerfectDodgeTrigger.actor))
		{
			if (prefectDodgeData.ContainsKey(adventurePerfectDodgeTrigger.actor.dataID))
			{
				prefectDodgeData.get_Item(adventurePerfectDodgeTrigger.actor.dataID)++;
			}
			else
			{
				prefectDodgeData.set_Item(adventurePerfectDodgeTrigger.actor.dataID, 1);
			}
		}
	}

	private void OnElementMarkTrigger(IEvent evt)
	{
		AdventureElementMarkTriggerEvent adventureElementMarkTriggerEvent = evt as AdventureElementMarkTriggerEvent;
		if (!(adventureElementMarkTriggerEvent.triggerActor == null) && isPlayerEntity(adventureElementMarkTriggerEvent.triggerActor))
		{
			int elementType = (int)adventureElementMarkTriggerEvent.elementType;
			if (markTriggerData.ContainsKey(elementType))
			{
				markTriggerData.get_Item(elementType)++;
			}
			else
			{
				markTriggerData.set_Item(elementType, 1);
			}
		}
	}

	private void OnCastSkill(IEvent evt)
	{
		AdventureActorCastSkillEvent adventureActorCastSkillEvent = evt as AdventureActorCastSkillEvent;
		if (adventureActorCastSkillEvent.sender is PlayerAdventureActor)
		{
			int skillId = adventureActorCastSkillEvent.skillEventInfo.skillId;
			if (castSkillData.ContainsKey(skillId))
			{
				castSkillData.get_Item(skillId)++;
			}
			else
			{
				castSkillData.set_Item(skillId, 1);
			}
		}
	}

	private void TriggerEvent(IEvent evt)
	{
		if (evt is AchievementEvent achievementEvent)
		{
			if (eventData.ContainsKey(achievementEvent.evtId))
			{
				eventData.get_Item(achievementEvent.evtId) += achievementEvent.count;
			}
			else
			{
				eventData.set_Item(achievementEvent.evtId, achievementEvent.count);
			}
		}
	}

	private void SpecialBattleData(IEvent evt)
	{
		if (evt is AdventureBattleAchievementFinishEvent adventureBattleAchievementFinishEvent && !specialBattleData.TryAdd((int)adventureBattleAchievementFinishEvent.achievementType, 1))
		{
			specialBattleData.get_Item((int)adventureBattleAchievementFinishEvent.achievementType)++;
		}
	}

	public AchievementDataDic GetAchievementData()
	{
		AchievementDataDic result = new AchievementDataDic
		{
			DamageDataDic = DamageData,
			killDataDic = killData
		};
		Dictionary<int, int> dictionary = new Dictionary<int, int>();
		int num = 0;
		foreach (KeyValuePair<long, Dictionary<int, int>> item in tmpSkillKillCount)
		{
			foreach (KeyValuePair<int, int> item2 in item.Value)
			{
				if (num < item2.Value)
				{
					num = item2.Value;
					dictionary.Clear();
					dictionary.Add(item2.Key, item2.Value);
				}
			}
		}
		result.OnceSkillKillCountDic = dictionary;
		result.CritCountData = critCountData;
		result.PrefectDodgeData = prefectDodgeData;
		result.MaxDamageValue = maxDamageValue;
		result.MarkTriggerData = markTriggerData;
		result.MainActorHpPrec = (float)SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor.GetLogicComponent<ActorHealthInfo>().hpPercentage;
		result.CastSkillData = castSkillData;
		result.specialBattleData = specialBattleData;
		string text = "specialBattleData:\n";
		foreach (KeyValuePair<int, int> specialBattleDatum in result.specialBattleData)
		{
			text += $"ID:{specialBattleDatum.Key} Count:{specialBattleDatum.Value}\n";
		}
		Debug.Log(text);
		return result;
	}
}
