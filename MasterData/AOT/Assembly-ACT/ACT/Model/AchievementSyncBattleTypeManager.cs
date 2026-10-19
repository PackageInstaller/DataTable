using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game.Data;
using ACT.Utility;
using Bamboo.Chronos;
using Bamboo.ECS;
using Fundamental;
using Google.Protobuf.Collections;
using UnityEngine;

namespace ACT.Model;

public class AchievementSyncBattleTypeManager : Singleton<AchievementSyncBattleTypeManager>
{
	private const int SyncBattleDataIntervalMs = 5000;

	private bool isUpdraftTiming;

	private Entity updraftEntity;

	private double updraftStartTime;

	private Looper timer;

	private bool hasPendingSyncInfo;

	private readonly Dictionary<int, int> pendingFightTypeCount = new Dictionary<int, int>();

	private readonly Dictionary<int, int> pendingBossKillTime = new Dictionary<int, int>();

	private readonly Dictionary<int, int> pendingUseSkillCount = new Dictionary<int, int>();

	private readonly Dictionary<int, int> pendingCharacterDieOnOneHit = new Dictionary<int, int>();

	private readonly Dictionary<int, int> pendingDamageTypeDieOnOneHit = new Dictionary<int, int>();

	private readonly Dictionary<int, int> pendingCharacterKillMonsterInAirCount = new Dictionary<int, int>();

	private readonly Dictionary<int, int> pendingPlayerDeadByMonsterPointId = new Dictionary<int, int>();

	private readonly Dictionary<int, int> pendingDamageAccumulateByType = new Dictionary<int, int>();

	private readonly Dictionary<int, int> pendingDamageOnceMaximumByType = new Dictionary<int, int>();

	private readonly List<int> pendingInteractedNPCs = new List<int>();

	private static readonly int[] FirstInteractedNpcIdsWithoutSync = new int[1] { 105336108 };

	private readonly HashSet<int> skippedFirstInteractedNpcIds = new HashSet<int>();

	private bool battleConditionCacheInitialized;

	private readonly Dictionary<int, List<ACT.Config.Mission>> battleMissionsByPreconditionId = new Dictionary<int, List<ACT.Config.Mission>>();

	public override ContextType ContextType => ContextType.GAME;

	private bool ShouldSkipFirstInteractedNpc(int npcId)
	{
		for (int i = 0; i < FirstInteractedNpcIdsWithoutSync.Length; i++)
		{
			if (FirstInteractedNpcIdsWithoutSync[i] == npcId)
			{
				return skippedFirstInteractedNpcIds.Add(npcId);
			}
		}
		return false;
	}

	private bool TryGetBattleMissions(PreconditionDataBattleType preconditionType, out List<ACT.Config.Mission> missions)
	{
		EnsureBattleConditionCache();
		return battleMissionsByPreconditionId.TryGetValue((int)preconditionType, out missions);
	}

	private void EnsureBattleConditionCache()
	{
		if (battleConditionCacheInitialized)
		{
			return;
		}
		Dictionary<int, ACT.Config.Mission> dictionary = RuntimeConfigs.data?.missions;
		if (dictionary == null)
		{
			return;
		}
		battleMissionsByPreconditionId.Clear();
		foreach (KeyValuePair<int, ACT.Config.Mission> item in dictionary)
		{
			ACT.Config.Mission value = item.Value;
			if (value != null && IsBattlePreconditionType(value.preconditionId))
			{
				if (!battleMissionsByPreconditionId.TryGetValue(value.preconditionId, out var value2))
				{
					value2 = new List<ACT.Config.Mission>();
					battleMissionsByPreconditionId.Add(value.preconditionId, value2);
				}
				value2.Add(value);
			}
		}
		battleConditionCacheInitialized = true;
	}

	private static bool IsBattlePreconditionType(int preconditionId)
	{
		if (preconditionId != 88 && preconditionId != 90 && preconditionId != 91 && preconditionId != 106 && preconditionId != 109 && preconditionId != 111)
		{
			return preconditionId == 118;
		}
		return true;
	}

	private void ResetBattleConditionCache()
	{
		battleMissionsByPreconditionId.Clear();
		battleConditionCacheInitialized = false;
	}

	public override void Init()
	{
		base.Init();
		StartTimer();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.MonsterDieCount, OnMonsterDie);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.MonsterHpHitDownToZero, OnMonsterHpDownToZero);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.OnDamage, OnDamage);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.KillEntity, OnKillEntity);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.EntityPostureChange, OnEntityPostureChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Motion_MotionStateChange, OnMotionStateChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BeforeBattleCharacterChange, OnBeforeBattleCharacterChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.TrapKillMonster, OnTrapKillMonster);
	}

	public override void UnInit()
	{
		base.UnInit();
		StopUpdraftTimer();
		FlushPendingSyncInfo();
		StopTimer();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.MonsterDieCount, OnMonsterDie);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.MonsterHpHitDownToZero, OnMonsterHpDownToZero);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.OnDamage, OnDamage);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.KillEntity, OnKillEntity);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.EntityPostureChange, OnEntityPostureChange);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Motion_MotionStateChange, OnMotionStateChange);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BeforeBattleCharacterChange, OnBeforeBattleCharacterChange);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.TrapKillMonster, OnTrapKillMonster);
		skippedFirstInteractedNpcIds.Clear();
		ResetBattleConditionCache();
	}

	public override void OnDestroy()
	{
		base.OnDestroy();
		ResetUpdraftTimer();
		StopTimer();
	}

	private void StartTimer()
	{
		if (!timer.IsValid())
		{
			timer = FixedUpdateTimer.Default.LoopMs(5000, FlushPendingSyncInfo);
		}
	}

	private void StopTimer()
	{
		if (timer.IsValid())
		{
			timer.Cancel();
		}
		timer = default;
	}

	private void OnMonsterDie(BaseEventContent obj)
	{
		if (obj is EntityDieEvt entityDieEvt && entityDieEvt.entity.IsValid && entityDieEvt.entity.TryGetCompMonster(out CompMonster component))
		{
			int id = component.id;
			if (Model<AccomplishmentModel>.Interface.CheckBattleParam(id))
			{
				DispatchSyncFightType(5, 1);
			}
		}
	}

	private void OnFailureToughnessStrip(BaseEventContent obj)
	{
		DispatchSyncFightType(21, 1);
	}

	private void OnBeKilledByOneHit(BaseEventContent obj)
	{
		if (!TryGetOneHitCharacterInfo(obj, out var _, out var characterId, out var hpPercent) || !TryGetBattleMissions(PreconditionDataBattleType.CharacterDieOnOneHit, out var missions))
		{
			return;
		}
		foreach (ACT.Config.Mission item in missions)
		{
			if (item.cParam != null && item.cParam.Length != 0)
			{
				int num = item.cParam[0];
				if (num > 0 && hpPercent > num)
				{
					DispatchSyncFightType(characterId, hpPercent, SyncBattleDataType.CharacterDieOnOneHit);
				}
			}
		}
	}

	private void OnBeKilledByOneHitByDamageType(BaseEventContent obj)
	{
		if (!TryGetOneHitCharacterInfo(obj, out var evt, out var _, out var hpPercent) || !TryGetAchievementDamageType(evt.attackData, out var damageType) || !TryGetBattleMissions(PreconditionDataBattleType.CharacterDieOnOneHitByDamageType, out var missions))
		{
			return;
		}
		foreach (ACT.Config.Mission item in missions)
		{
			if (item.cParam != null && item.cParam.Length != 0)
			{
				int num = item.cParam[0];
				int num2 = ((item.cParam.Length > 1) ? item.cParam[1] : 0);
				if (num > 0 && (num2 <= 0 || num2 == damageType) && hpPercent > num)
				{
					DispatchSyncFightType(damageType, hpPercent, SyncBattleDataType.DamageTypeDieOnOneHit);
				}
			}
		}
	}

	private void OnBecauseTheTrapDiesTimes(BaseEventContent obj)
	{
		if (obj is OnKillEntity { attackData: not null } onKillEntity && (onKillEntity.attackData.adjust1AttackType.HasFlag(Adjust1AttackTypeTag.Trap) || onKillEntity.attackData.attacker.GetEntityType() == EntityType.StateObject || onKillEntity.attackData.attacker.IsCollection()) && onKillEntity.attackData.attackee.TryGetCompCharacter(out CompCharacter component) && component.characterSource != null)
		{
			DispatchSyncFightType(23, 1);
		}
	}

	private void OnCharacterDieByMonsterPoint(BaseEventContent obj)
	{
		if (!(obj is OnKillEntity { attackData: not null } onKillEntity))
		{
			return;
		}
		Entity attacker = onKillEntity.attackData.attacker;
		if (onKillEntity.attackData.attackee.TryGetCompCharacter(out CompCharacter component) && component.characterSource != null && attacker.TryGetCompMonster(out CompMonster component2))
		{
			int monsterPointId = component2.monsterPointId;
			if (monsterPointId > 0 && ShouldSyncCharacterDieByMonsterPoint(monsterPointId))
			{
				DispatchSyncFightType(monsterPointId, 1, SyncBattleDataType.PlayerDeadByMonsterPointID);
			}
		}
	}

	private void OnTrapKillMonster(BaseEventContent obj)
	{
		DispatchSyncFightType(28, 1);
	}

	private void OnInSkyKillMonster(BaseEventContent obj)
	{
		if (!(obj is OnKillEntity { attackData: not null } onKillEntity))
		{
			return;
		}
		Entity attacker = onKillEntity.attackData.attacker;
		Entity attackee = onKillEntity.attackData.attackee;
		if (attacker.TryGetCompCharacter(out CompCharacter component) && component.characterSource != null && attackee.TryGetCompMonster(out CompMonster _) && attacker.TryGetCompPhysics(out CompPhysics component3) && !component3.isGrounded)
		{
			int num = component.characterSource.Id();
			if (ShouldSyncInSkyKillMonster(num))
			{
				DispatchSyncFightType(num, 1, SyncBattleDataType.CharacterKillMonsterInAirCount);
			}
		}
	}

	private void OnMotionStateChange(BaseEventContent eventContent)
	{
		if (eventContent is MotionStateChangeEvt motionStateChangeEvt && motionStateChangeEvt.entity.IsValid && motionStateChangeEvt.entity.IsCharacter())
		{
			if (motionStateChangeEvt.beforeState != MotionState.GrabHook && motionStateChangeEvt.curState == MotionState.GrabHook)
			{
				DispatchSyncFightType(26, 1);
			}
			if (motionStateChangeEvt.beforeState == MotionState.Updraft && motionStateChangeEvt.curState != MotionState.Updraft)
			{
				StopUpdraftTimer(motionStateChangeEvt.entity);
			}
			else if (!(motionStateChangeEvt.entity != MonoECS.instance.mainEntity) && motionStateChangeEvt.beforeState != MotionState.Updraft && motionStateChangeEvt.curState == MotionState.Updraft)
			{
				StartUpdraftTimer(motionStateChangeEvt.entity);
			}
		}
	}

	private void StartUpdraftTimer(Entity entity)
	{
		if (isUpdraftTiming)
		{
			if (entity == updraftEntity)
			{
				return;
			}
			StopUpdraftTimer();
		}
		isUpdraftTiming = true;
		updraftEntity = entity;
		updraftStartTime = Time.timeAsDouble;
	}

	private void StopUpdraftTimer(Entity entity = default(Entity))
	{
		if (isUpdraftTiming && (!entity.IsValid || !(entity != updraftEntity)))
		{
			double num = Math.Max(0.0, Time.timeAsDouble - updraftStartTime);
			ResetUpdraftTimer();
			if (ShouldSyncUpdraftTime(num))
			{
				int count = Mathf.RoundToInt((float)num);
				DispatchSyncFightType(29, count, SyncBattleDataType.UpdraftTimeMaximum);
			}
		}
	}

	private void ResetUpdraftTimer()
	{
		isUpdraftTiming = false;
		updraftEntity = default;
		updraftStartTime = 0.0;
	}

	private bool ShouldSyncUpdraftTime(double flightDurationSeconds)
	{
		if (!TryGetBattleMissions(PreconditionDataBattleType.UpdraftTimeCount, out var missions))
		{
			return false;
		}
		foreach (ACT.Config.Mission item in missions)
		{
			if (flightDurationSeconds >= (double)item.number)
			{
				return true;
			}
		}
		return false;
	}

	private void OnBeforeBattleCharacterChange(BaseEventContent obj)
	{
		if (obj is BattleCharacterChangeEvt { switchSkill: not false })
		{
			DispatchSyncFightType(18, 1);
		}
	}

	public void OnEvtMotionChange(EvtMotionChange evt)
	{
		if (evt != null && evt.isFirstMotion && evt.skillId > 0 && Model<AccomplishmentModel>.Interface.CheckBattleParam(evt.skillId))
		{
			DispatchSyncFightType(evt.skillId, 1, SyncBattleDataType.UseSkill);
		}
	}

	private void OnMonsterHpDownToZero(BaseEventContent obj)
	{
		if (obj is OnMonsterHpDownToZero onMonsterHpDownToZero && onMonsterHpDownToZero.attacker.IsValid && onMonsterHpDownToZero.attackee.IsValid && onMonsterHpDownToZero.attacker.TryGetCompCharacter(out CompCharacter component) && component.characterSource != null && onMonsterHpDownToZero.attackee.TryGetCompMonster(out CompMonster component2))
		{
			int num = component.characterSource.Id();
			int id = component2.id;
			bool num2 = Model<AccomplishmentModel>.Interface.CheckBattleParam(num, id) || Model<AccomplishmentModel>.Interface.CheckBattleParam(num) || Model<AccomplishmentModel>.Interface.CheckBattleParam(id);
			bool flag = false;
			if (onMonsterHpDownToZero.attacker.TryGetCompAbility(out CompAbility component3))
			{
				int hp = component3.hp;
				flag = Model<AccomplishmentModel>.Interface.CheckBattleParam(id, hp) || Model<AccomplishmentModel>.Interface.CheckBattleParam(num, id, hp);
			}
			if (num2 | flag)
			{
				DispatchSyncFightType(5, 1);
			}
		}
	}

	private void OnDamage(BaseEventContent obj)
	{
		if (!(obj is DamageEvt { AttackData: not null, AttackData: var attackData } damageEvt))
		{
			return;
		}
		Entity mainEntity = MonoECS.instance.mainEntity;
		if (!mainEntity.IsValid || !attackData.attacker.IsValid || attackData.attacker != mainEntity)
		{
			return;
		}
		int actualDamage = damageEvt.AttackData.actualDamage;
		if (actualDamage > 0)
		{
			if (TryGetAchievementElementDamageType(attackData, out var damageType))
			{
				DispatchDamageByType(damageType, actualDamage);
			}
			if (attackData.critical)
			{
				DispatchDamageByType(4, actualDamage);
			}
		}
	}

	private void DispatchDamageByType(int damageType, int actualDamage)
	{
		if (ShouldSyncDamageAccumulateByType(damageType))
		{
			DispatchSyncFightType(damageType, actualDamage, SyncBattleDataType.DamageAccumulateByType);
		}
		if (ShouldSyncDamageOnceMaximumByType(damageType, actualDamage))
		{
			DispatchSyncFightType(damageType, actualDamage, SyncBattleDataType.DamageOnceMaximumByType);
		}
	}

	private void OnKillEntity(BaseEventContent obj)
	{
		OnBeKilledByOneHit(obj);
		OnBeKilledByOneHitByDamageType(obj);
		OnBecauseTheTrapDiesTimes(obj);
		OnCharacterDieByMonsterPoint(obj);
		OnInSkyKillMonster(obj);
	}

	private bool TryGetOneHitCharacterInfo(BaseEventContent obj, out OnKillEntity evt, out int characterId, out int hpPercent)
	{
		evt = null;
		characterId = 0;
		hpPercent = 0;
		if (!(obj is OnKillEntity { attackData: { } attackData } onKillEntity) || !attackData.attackee.IsValid)
		{
			return false;
		}
		evt = onKillEntity;
		if (!evt.attackData.attackee.TryGetCompCharacter(out CompCharacter component) || component.characterSource == null)
		{
			return false;
		}
		int beforeKillHp = evt.beforeKillHp;
		if (beforeKillHp <= 0 || evt.maxHp <= 0)
		{
			return false;
		}
		characterId = component.characterSource.Id();
		hpPercent = Mathf.RoundToInt((float)beforeKillHp * 100f / (float)evt.maxHp);
		return true;
	}

	private bool TryGetAchievementDamageType(AttackData attackData, out int damageType)
	{
		damageType = 0;
		if (attackData == null)
		{
			return false;
		}
		damageType = (int)(attackData.critical ? Element.Born : (attackData.element + 19));
		if (!attackData.critical)
		{
			if (damageType >= 20)
			{
				return damageType <= 24;
			}
			return false;
		}
		return true;
	}

	private bool TryGetAchievementElementDamageType(AttackData attackData, out int damageType)
	{
		damageType = 0;
		if (attackData == null)
		{
			return false;
		}
		damageType = (int)(attackData.element + 19);
		if (damageType >= 20)
		{
			return damageType <= 24;
		}
		return false;
	}

	private bool ShouldSyncDamageAccumulateByType(int damageType)
	{
		if (!TryGetBattleMissions(PreconditionDataBattleType.DamageTotalByType, out var missions))
		{
			return false;
		}
		foreach (ACT.Config.Mission item in missions)
		{
			if (item.cParam == null || item.cParam.Length == 0)
			{
				return true;
			}
			int num = item.cParam[0];
			if (num <= 0 || num == damageType)
			{
				return true;
			}
		}
		return false;
	}

	private bool ShouldSyncDamageOnceMaximumByType(int damageType, int actualDamage)
	{
		if (!TryGetBattleMissions(PreconditionDataBattleType.DamageOnceByType, out var missions))
		{
			return false;
		}
		foreach (ACT.Config.Mission item in missions)
		{
			if (actualDamage >= item.number)
			{
				if (item.cParam == null || item.cParam.Length == 0)
				{
					return true;
				}
				int num = item.cParam[0];
				if (num <= 0 || num == damageType)
				{
					return true;
				}
			}
		}
		return false;
	}

	private bool ShouldSyncInSkyKillMonster(int characterId)
	{
		if (!TryGetBattleMissions(PreconditionDataBattleType.InSkyKillMonster, out var missions))
		{
			return false;
		}
		foreach (ACT.Config.Mission item in missions)
		{
			if (item.cParam == null || item.cParam.Length == 0)
			{
				return true;
			}
			int num = item.cParam[0];
			if (num <= 0 || num == characterId)
			{
				return true;
			}
		}
		return false;
	}

	private bool ShouldSyncCharacterDieByMonsterPoint(int monsterPointId)
	{
		if (!TryGetBattleMissions(PreconditionDataBattleType.CharacterDieByMonsterPoint, out var missions))
		{
			return false;
		}
		foreach (ACT.Config.Mission item in missions)
		{
			if (item.cParam == null || item.cParam.Length == 0)
			{
				continue;
			}
			for (int i = 0; i < item.cParam.Length; i++)
			{
				if (item.cParam[i] == monsterPointId)
				{
					return true;
				}
			}
		}
		return false;
	}

	private void OnEntityPostureChange(BaseEventContent obj)
	{
		if (obj is EntityPostureChangeEvt entityPostureChangeEvt && (entityPostureChangeEvt.oldPosture <= 0 || entityPostureChangeEvt.curPosture <= 0) && entityPostureChangeEvt.oldPosture > entityPostureChangeEvt.curPosture)
		{
			Entity entity = MonoECS.instance.GetEntity(entityPostureChangeEvt.entityId);
			if (entity.IsValid && entity.TryGetCompMonster(out CompMonster _))
			{
				OnFailureToughnessStrip(obj);
			}
		}
	}

	public void DispatchDestroyMapItemsCount(int subMapAreaId, int count = 1)
	{
		DispatchSyncFightType(24, count);
	}

	public void DispatchAnchorTransfer()
	{
		DispatchSyncFightType(27, 1);
	}

	public void DispatchResurrectionCount()
	{
		DispatchSyncFightType(25, 1);
	}

	public void DispatchInteractedNPC(int npcId)
	{
		if (npcId > 0 && !ShouldSkipFirstInteractedNpc(npcId))
		{
			DispatchSyncFightType(npcId, 1, SyncBattleDataType.InteractedNPCS);
		}
	}

	public void DispatchInteractedNPC(List<int> list)
	{
		if (list != null && list.Count != 0)
		{
			for (int i = 0; i < list.Count; i++)
			{
				DispatchInteractedNPC(list[i]);
			}
		}
	}

	public void DispatchSyncFightType(int key, int count, SyncBattleDataType syncType = SyncBattleDataType.FightTypeCount)
	{
		if (GameUtility.gameLoader.IsNetMode)
		{
			CacheSyncFightType(key, count, syncType);
		}
	}

	private void CacheSyncFightType(int key, int count, SyncBattleDataType syncType)
	{
		hasPendingSyncInfo = true;
		switch (syncType)
		{
		case SyncBattleDataType.FightTypeCount:
			AddMapValue(pendingFightTypeCount, key, count);
			break;
		case SyncBattleDataType.BossKillTime:
			SetMinMapValue(pendingBossKillTime, key, count);
			break;
		case SyncBattleDataType.UseSkill:
			AddMapValue(pendingUseSkillCount, key, count);
			break;
		case SyncBattleDataType.CharacterDieOnOneHit:
			SetMaxMapValue(pendingCharacterDieOnOneHit, key, count);
			break;
		case SyncBattleDataType.DamageTypeDieOnOneHit:
			SetMaxMapValue(pendingDamageTypeDieOnOneHit, key, count);
			break;
		case SyncBattleDataType.CharacterKillMonsterInAirCount:
			AddMapValue(pendingCharacterKillMonsterInAirCount, key, count);
			break;
		case SyncBattleDataType.PlayerDeadByMonsterPointID:
			AddMapValue(pendingPlayerDeadByMonsterPointId, key, count);
			break;
		case SyncBattleDataType.DamageAccumulateByType:
			AddMapValue(pendingDamageAccumulateByType, key, count);
			break;
		case SyncBattleDataType.DamageOnceMaximumByType:
			SetMaxMapValue(pendingDamageOnceMaximumByType, key, count);
			break;
		case SyncBattleDataType.UpdraftTimeMaximum:
			SetMaxMapValue(pendingFightTypeCount, key, count);
			break;
		case SyncBattleDataType.InteractedNPCS:
			pendingInteractedNPCs.Add(key);
			break;
		default:
			AddMapValue(pendingFightTypeCount, key, count);
			break;
		}
	}

	private void AddMapValue(Dictionary<int, int> map, int key, int value)
	{
		if (map.TryGetValue(key, out var value2))
		{
			map[key] = value2 + value;
		}
		else
		{
			map[key] = value;
		}
	}

	private void SetMaxMapValue(Dictionary<int, int> map, int key, int value)
	{
		if (!map.TryGetValue(key, out var value2) || value > value2)
		{
			map[key] = value;
		}
	}

	private void SetMinMapValue(Dictionary<int, int> map, int key, int value)
	{
		if (!map.TryGetValue(key, out var value2) || value < value2)
		{
			map[key] = value;
		}
	}

	private void FlushPendingSyncInfo()
	{
		if (!hasPendingSyncInfo)
		{
			return;
		}
		bool num = pendingFightTypeCount.Count > 0 || pendingBossKillTime.Count > 0 || pendingUseSkillCount.Count > 0 || pendingCharacterDieOnOneHit.Count > 0 || pendingDamageTypeDieOnOneHit.Count > 0 || pendingCharacterKillMonsterInAirCount.Count > 0 || pendingPlayerDeadByMonsterPointId.Count > 0 || pendingDamageAccumulateByType.Count > 0 || pendingDamageOnceMaximumByType.Count > 0 || pendingInteractedNPCs.Count > 0;
		AchievementSyncInfo achievementSyncInfo = null;
		if (num)
		{
			achievementSyncInfo = new AchievementSyncInfo();
			CopyToMap(achievementSyncInfo.FightTypeCntInfo, pendingFightTypeCount);
			CopyToMap(achievementSyncInfo.BossKillTime, pendingBossKillTime);
			CopyToMap(achievementSyncInfo.UseSkillCount, pendingUseSkillCount);
			CopyToMap(achievementSyncInfo.CharacterDieOnOneHit, pendingCharacterDieOnOneHit);
			CopyToMap(achievementSyncInfo.DamageTypeDieOnOneHit, pendingDamageTypeDieOnOneHit);
			CopyToMap(achievementSyncInfo.CharacterKillMonsterInAirCount, pendingCharacterKillMonsterInAirCount);
			CopyToMap(achievementSyncInfo.PlayerDeadByMonsterPointID, pendingPlayerDeadByMonsterPointId);
			CopyToMap(achievementSyncInfo.DamageAccumulateByType, pendingDamageAccumulateByType);
			CopyToMap(achievementSyncInfo.DamageOnceMaximumByType, pendingDamageOnceMaximumByType);
			for (int i = 0; i < pendingInteractedNPCs.Count; i++)
			{
				achievementSyncInfo.InteractedNPCs.Add(pendingInteractedNPCs[i]);
			}
		}
		ClearPendingSyncInfo();
		hasPendingSyncInfo = false;
		if (achievementSyncInfo != null)
		{
			SyncBattleMassage evt = Singleton<EventManager>.instance.GetEvt<SyncBattleMassage>();
			evt.syncInfo = achievementSyncInfo;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.AddBehaveCount, evt);
			evt.syncInfo = null;
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}

	private void CopyToMap(MapField<int, int> target, Dictionary<int, int> source)
	{
		foreach (KeyValuePair<int, int> item in source)
		{
			target[item.Key] = item.Value;
		}
	}

	private void ClearPendingSyncInfo()
	{
		pendingFightTypeCount.Clear();
		pendingBossKillTime.Clear();
		pendingUseSkillCount.Clear();
		pendingCharacterDieOnOneHit.Clear();
		pendingDamageTypeDieOnOneHit.Clear();
		pendingCharacterKillMonsterInAirCount.Clear();
		pendingPlayerDeadByMonsterPointId.Clear();
		pendingDamageAccumulateByType.Clear();
		pendingDamageOnceMaximumByType.Clear();
		pendingInteractedNPCs.Clear();
	}
}
