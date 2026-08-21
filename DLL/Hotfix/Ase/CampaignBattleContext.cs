#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using Ase.ECS;
using GameFramework;
using UnityEngine;
using UnityEngine.Pool;
using UnityEngine.Rendering;

namespace Ase;

public class CampaignBattleContext
{
	private struct CampaignBuffPopupRequest(PopupTipType popupTipType, int popupId)
	{
		public PopupTipType popupTipType = popupTipType;

		public int popupId = popupId;
	}

	private struct CampaignFollowBuffRecord(int entityId, int buffId)
	{
		public int entityId = entityId;

		public int buffId = buffId;
	}

	private class CampaignFutureMonsterBuffRule : IReference
	{
		public CampaignBuffData buffData;

		public List<int> buffIds;

		public CampaignMonsterGroup ownerGroup;

		public int followGroupId;

		public float remainingDuration;

		public bool IsTimeLimited
		{
			get
			{
				if (buffData != null)
				{
					return buffData.durationType == CampaignBuffDurationType.TimeLimit;
				}
				return false;
			}
		}

		public bool IsExpired
		{
			get
			{
				if (IsTimeLimited)
				{
					return remainingDuration <= 0f;
				}
				return false;
			}
		}

		public float ApplyDuration
		{
			get
			{
				if (!IsTimeLimited)
				{
					return 0f;
				}
				return Mathf.Max(remainingDuration, 0f);
			}
		}

		public void Clear()
		{
			buffData = null;
			ownerGroup = null;
			followGroupId = 0;
			remainingDuration = 0f;
			if (buffIds != null)
			{
				CollectionPool<List<int>, int>.Release(buffIds);
				buffIds = null;
			}
		}
	}

	private const float CampaignBuffPopupBaseSafeInterval = 0.2f;

	private const float CampaignBuffPopupPendingSafeInterval = 0.04f;

	private const float CampaignBuffPopupTipSafeInterval = 0.03f;

	private const float CampaignBuffPopupMaxSafeInterval = 0.4f;

	private readonly BaseSystem ownerSystem;

	private readonly WorldBase world;

	private readonly IReadOnlyList<CampaignMonsterGroup> monsterGroups;

	private readonly Dictionary<int, CampaignMonsterGroup> monsterGroupById;

	private readonly Dictionary<int, CampaignMonsterNode> monsterNodeByEntityId;

	private readonly Dictionary<int, CampaignMonsterNode> monsterNodeByKey;

	private readonly Dictionary<int, CampaignBuffNode> buffNodeById = new Dictionary<int, CampaignBuffNode>();

	private readonly Dictionary<int, List<CampaignFollowBuffRecord>> followBuffsByGroupId = new Dictionary<int, List<CampaignFollowBuffRecord>>();

	private readonly List<CampaignFutureMonsterBuffRule> futureMonsterBuffRules = new List<CampaignFutureMonsterBuffRule>();

	private readonly Dictionary<int, CampaignAirWallNode> airWallNodeById = new Dictionary<int, CampaignAirWallNode>();

	private readonly Dictionary<int, bool> pendingAirWallActiveById = new Dictionary<int, bool>();

	private readonly List<int> pendingAirWallIds = new List<int>();

	private readonly List<Material> loadedAirWallMaterials = new List<Material>();

	private readonly HashSet<int> shownCampaignBuffPopupIds = new HashSet<int>();

	private readonly Queue<CampaignBuffPopupRequest> pendingCampaignBuffPopups = new Queue<CampaignBuffPopupRequest>();

	private readonly EntityCallbacks monsterEntityCallbacks;

	private GameObject airWallRoot;

	private float nextCampaignBuffPopupTime;

	private float campaignBuffPopupDurationEndTime;

	private int currentCampaignBuffPopupTipCount;

	public CampaignBattleContext(BaseSystem ownerSystem, WorldBase world, IReadOnlyList<CampaignMonsterGroup> monsterGroups, Dictionary<int, CampaignMonsterGroup> monsterGroupById, Dictionary<int, CampaignMonsterNode> monsterNodeByEntityId, Dictionary<int, CampaignMonsterNode> monsterNodeByKey, IReadOnlyList<CampaignBuffData> buffDatas, IReadOnlyList<CampaignAirWallData> airWallDatas)
	{
		this.ownerSystem = ownerSystem;
		this.world = world;
		this.monsterGroups = monsterGroups;
		this.monsterGroupById = monsterGroupById;
		this.monsterNodeByEntityId = monsterNodeByEntityId;
		this.monsterNodeByKey = monsterNodeByKey;
		monsterEntityCallbacks = new EntityCallbacks(OnMonsterEntityDead, null);
		BuildBuffNodes(buffDatas);
		BuildAirWallNodes(airWallDatas);
	}

	public static int GetMonsterNodeKey(int groupId, int monsterIndex)
	{
		if (groupId <= 0 || monsterIndex <= 0)
		{
			return 0;
		}
		return groupId * 10000 + monsterIndex;
	}

	public CampaignMonsterGroup GetMonsterGroup(int groupId)
	{
		monsterGroupById.TryGetValue(groupId, out var value);
		return value;
	}

	public bool ActivateMonsterGroup(int groupId, float delayTime = 0f)
	{
		return GetMonsterGroup(groupId)?.RequestExternalActivation(delayTime) ?? false;
	}

	public void GameSettlement(GameSettlementType settlementType)
	{
		if (settlementType == GameSettlementType.MonsterDead && ownerSystem is CampaignBattleSystem campaignBattleSystem)
		{
			campaignBattleSystem.StopForCampaignSettlement();
		}
		world?.GameSettlement(settlementType);
	}

	public void PlayPopupTip(PopupTipType popupTipType, int popupId)
	{
		if (popupId > 0)
		{
			Singleton<Story>.Instance.PlayQueueTip(popupTipType, popupId);
		}
	}

	public void SetAirWallsActive(List<int> airWallIds, bool active)
	{
		if (airWallIds == null || airWallIds.Count == 0)
		{
			return;
		}
		for (int i = 0; i < airWallIds.Count; i++)
		{
			int num = airWallIds[i];
			if (num > 0 && airWallNodeById.TryGetValue(num, out var value))
			{
				if (!active)
				{
					value.SetActive(active: false);
				}
				else if (!(value.GameObject == null))
				{
					value.SetActive(active: true);
				}
			}
		}
	}

	public void HideAirWalls(List<int> airWallIds)
	{
		SetAirWallsActive(airWallIds, active: false);
	}

	public void QueueAirWallsActive(List<int> airWallIds, bool active)
	{
		if (airWallIds == null || airWallIds.Count == 0)
		{
			return;
		}
		for (int i = 0; i < airWallIds.Count; i++)
		{
			int num = airWallIds[i];
			if (num > 0 && airWallNodeById.ContainsKey(num))
			{
				if (!pendingAirWallActiveById.ContainsKey(num))
				{
					pendingAirWallIds.Add(num);
				}
				pendingAirWallActiveById[num] = active;
			}
		}
	}

	public void FlushPendingAirWallStates()
	{
		if (pendingAirWallIds.Count == 0)
		{
			return;
		}
		for (int i = 0; i < pendingAirWallIds.Count; i++)
		{
			int key = pendingAirWallIds[i];
			if (pendingAirWallActiveById.TryGetValue(key, out var value) && airWallNodeById.TryGetValue(key, out var value2))
			{
				if (!value)
				{
					value2.SetActive(active: false);
				}
				else if (!(value2.GameObject == null))
				{
					value2.SetActive(active: true);
				}
			}
		}
		pendingAirWallIds.Clear();
		pendingAirWallActiveById.Clear();
	}

	public bool IsMonsterGroupCompleted(int groupId)
	{
		return GetMonsterGroup(groupId)?.IsCompleted ?? false;
	}

	public bool IsPreviousGroupCompleted(CampaignMonsterGroup group)
	{
		int num = IndexOfGroup(group);
		if (num <= 0)
		{
			return false;
		}
		return monsterGroups[num - 1].IsCompleted;
	}

	public bool IsMonsterNodeCompleted(int monsterNodeKey)
	{
		if (monsterNodeKey <= 0)
		{
			return false;
		}
		if (monsterNodeByKey.TryGetValue(monsterNodeKey, out var value))
		{
			return value.IsCompleted;
		}
		return false;
	}

	public bool IsHeroEnterTriggerArea(CampaignTriggerData data)
	{
		if (data == null)
		{
			return false;
		}
		List<HeroEntity> list = GetSystem<EntitySystem>()?.GetTeamHero();
		if (list == null)
		{
			return false;
		}
		for (int i = 0; i < list.Count; i++)
		{
			HeroEntity heroEntity = list[i];
			if (heroEntity != null && heroEntity.IsSurvival && IsPointInTrigger(data, heroEntity.transform.position))
			{
				return true;
			}
		}
		return false;
	}

	public bool IsHeroInRange(Vector3 center, float range)
	{
		if (range <= 0f)
		{
			return false;
		}
		List<HeroEntity> list = GetSystem<EntitySystem>()?.GetTeamHero();
		if (list == null)
		{
			return false;
		}
		float num = range * range;
		for (int i = 0; i < list.Count; i++)
		{
			HeroEntity heroEntity = list[i];
			if (heroEntity != null && heroEntity.IsSurvival && SqrDistanceXZ(heroEntity.transform.position, center) <= num)
			{
				return true;
			}
		}
		return false;
	}

	public bool SpawnMonsterNode(CampaignMonsterNode node)
	{
		CampaignMonsterNodeData campaignMonsterNodeData = node?.Data;
		if (campaignMonsterNodeData == null)
		{
			return false;
		}
		DRMonsterAttr dataRow = GameEntry.DataTable.GetDataRow<DRMonsterAttr>(campaignMonsterNodeData.monsterId);
		if (dataRow == null)
		{
			Log.Error($"没有找到怪物编号 = {campaignMonsterNodeData.monsterId} 的怪物配置。");
			node.Complete();
			return false;
		}
		DRMonster dataRow2 = GameEntry.DataTable.GetDataRow<DRMonster>(dataRow.MonsterType);
		if (dataRow2 == null)
		{
			Log.Error($"没有找到怪物种类 = {dataRow.MonsterType} 的怪物配置。");
			node.Complete();
			return false;
		}
		GetSystem<ParadoxSystem>()?.CacheParadoxTreeObj(dataRow2.AIParadoxId);
		GameObject obj = GetSystem<EntityViewCacheSystem>()?.LoadEntityView(dataRow2.Id, dataRow2.AssetPath);
		EntitySystem system = GetSystem<EntitySystem>();
		if (system == null)
		{
			node.Complete();
			return false;
		}
		EntityData entityData = EntityData.Create(campaignMonsterNodeData.monsterPos, campaignMonsterNodeData.monsterRot, Vector3.one, obj, CollisionSetting.CollisionLayer.Boss, dataRow2);
		entityData.campType = CampType.Monster;
		entityData.userDataPam = dataRow;
		entityData.callbacks = monsterEntityCallbacks;
		MonsterEntity monsterEntity = system.CreateEntity<MonsterEntity>(dataRow2.Id, entityData);
		if (monsterEntity == null)
		{
			node.Complete();
			return false;
		}
		node.BindEntity(monsterEntity);
		monsterNodeByEntityId[monsterEntity.Id] = node;
		bool refreshBattleTimeConfig = true;
		if (ownerSystem is CampaignBattleSystem campaignBattleSystem && campaignBattleSystem.MapData != null && ((campaignBattleSystem.MapData.countdownWin && campaignBattleSystem.MapData.countdownWinTime > 0f) || (campaignBattleSystem.MapData.countdownLose && campaignBattleSystem.MapData.countdownLoseTime > 0f)))
		{
			refreshBattleTimeConfig = false;
		}
		GetSystem<BattleSystem>()?.InitMonsterEntity(monsterEntity, refreshBattleTimeConfig);
		GetSystem<RoomSystem>()?.AddToRoomEntity(monsterEntity);
		return true;
	}

	public void Tick(float deltaTime)
	{
		TickFutureMonsterBuffRules(deltaTime);
		TryPlayNextCampaignBuffPopup();
	}

	public void ApplyFutureMonsterBuffs(CampaignMonsterNode node)
	{
		BaseEntity baseEntity = node?.Entity;
		if (baseEntity == null || !baseEntity.IsSurvival || futureMonsterBuffRules.Count == 0)
		{
			return;
		}
		BuffSystem system = GetSystem<BuffSystem>();
		if (system == null)
		{
			return;
		}
		for (int i = 0; i < futureMonsterBuffRules.Count; i++)
		{
			CampaignFutureMonsterBuffRule campaignFutureMonsterBuffRule = futureMonsterBuffRules[i];
			if (campaignFutureMonsterBuffRule == null || campaignFutureMonsterBuffRule.buffData == null || campaignFutureMonsterBuffRule.buffIds == null || campaignFutureMonsterBuffRule.buffIds.Count == 0)
			{
				ReleaseFutureMonsterBuffRuleAt(i);
				i--;
			}
			else if (campaignFutureMonsterBuffRule.IsExpired)
			{
				ReleaseFutureMonsterBuffRuleAt(i);
				i--;
			}
			else
			{
				ApplyBuffsToTarget(system, campaignFutureMonsterBuffRule.buffData, campaignFutureMonsterBuffRule.buffIds, baseEntity, campaignFutureMonsterBuffRule.ApplyDuration, campaignFutureMonsterBuffRule.ownerGroup);
			}
		}
	}

	public void ApplyCampaignBuffs(List<int> buffNodeIds, CampaignMonsterGroup ownerGroup = null, CampaignMonsterNode ownerNode = null, CampaignTriggerData triggerData = null)
	{
		if (buffNodeIds == null || buffNodeIds.Count == 0)
		{
			return;
		}
		for (int i = 0; i < buffNodeIds.Count; i++)
		{
			int num = buffNodeIds[i];
			if (num > 0 && buffNodeById.TryGetValue(num, out var value))
			{
				value.Apply(ownerGroup, ownerNode, triggerData);
			}
		}
	}

	public bool DoesAnyBuffNeedSpawnedMonster(List<int> buffNodeIds)
	{
		if (buffNodeIds == null || buffNodeIds.Count == 0)
		{
			return false;
		}
		for (int i = 0; i < buffNodeIds.Count; i++)
		{
			int num = buffNodeIds[i];
			if (num > 0 && buffNodeById.TryGetValue(num, out var value) && value.Data != null && NeedsCurrentSpawnedMonsterTarget(value.Data.targetType))
			{
				return true;
			}
		}
		return false;
	}

	public void ApplyConfiguredBuff(CampaignBuffData buffData, List<int> buffIds, float duration = 0f, CampaignMonsterGroup ownerGroup = null, CampaignMonsterNode ownerNode = null, CampaignTriggerData triggerData = null)
	{
		if (buffData == null || buffIds == null || buffIds.Count == 0)
		{
			return;
		}
		CampaignBuffTargetType targetType = buffData.targetType;
		List<int> list = CollectionPool<List<int>, int>.Get();
		for (int i = 0; i < buffIds.Count; i++)
		{
			if (buffIds[i] > 0)
			{
				list.Add(buffIds[i]);
			}
		}
		if (list.Count == 0)
		{
			CollectionPool<List<int>, int>.Release(list);
			return;
		}
		if (IsFutureMonsterTargetType(targetType))
		{
			RegisterFutureMonsterBuffRule(buffData, list, duration, ownerGroup);
		}
		if (!IsCurrentTargetType(targetType))
		{
			CollectionPool<List<int>, int>.Release(list);
			return;
		}
		List<BaseEntity> buffTargets = GetBuffTargets(buffData, ownerGroup, triggerData);
		if (buffTargets == null || buffTargets.Count == 0)
		{
			if (buffTargets != null)
			{
				CollectionPool<List<BaseEntity>, BaseEntity>.Release(buffTargets);
			}
			CollectionPool<List<int>, int>.Release(list);
			return;
		}
		BuffSystem system = GetSystem<BuffSystem>();
		if (system == null)
		{
			CollectionPool<List<BaseEntity>, BaseEntity>.Release(buffTargets);
			CollectionPool<List<int>, int>.Release(list);
		}
		else
		{
			ApplyBuffsToTargets(system, buffData, list, buffTargets, duration, ownerGroup);
			CollectionPool<List<BaseEntity>, BaseEntity>.Release(buffTargets);
			CollectionPool<List<int>, int>.Release(list);
		}
	}

	private void ApplyBuffsToTargets(BuffSystem buffSystem, CampaignBuffData buffData, List<int> buffIds, List<BaseEntity> targets, float duration, CampaignMonsterGroup ownerGroup)
	{
		if (buffSystem != null && targets != null && buffIds != null && buffIds.Count != 0)
		{
			for (int i = 0; i < targets.Count; i++)
			{
				ApplyBuffsToTarget(buffSystem, buffData, buffIds, targets[i], duration, ownerGroup);
			}
		}
	}

	private void ApplyBuffsToTarget(BuffSystem buffSystem, CampaignBuffData buffData, List<int> buffIds, BaseEntity target, float duration, CampaignMonsterGroup ownerGroup)
	{
		if (buffSystem == null || target == null || !target.IsSurvival || buffIds == null || buffIds.Count == 0)
		{
			return;
		}
		for (int i = 0; i < buffIds.Count; i++)
		{
			int buffId = buffIds[i];
			Buff buff = buffSystem.CheckAndAcquireBuff(target, target, buffId);
			if (buff != null)
			{
				Buff buff2 = buffSystem.FindEntityBuff(target.Id, buffId) ?? buff;
				if (duration > 0f)
				{
					buff2.SetDuration(duration);
				}
				RegisterFollowBuff(buffData, ownerGroup, buff2);
				TryPlayCampaignBuffPopup(buffId);
			}
		}
	}

	public int RandomInt(int minValue, int maxValue)
	{
		if (world == null || minValue >= maxValue)
		{
			return minValue;
		}
		return world.RandomInt(minValue, maxValue);
	}

	public void Dispose()
	{
		RemoveAllFollowBuffs();
		ClearFutureMonsterBuffRules();
		buffNodeById.Clear();
		shownCampaignBuffPopupIds.Clear();
		pendingCampaignBuffPopups.Clear();
		nextCampaignBuffPopupTime = 0f;
		campaignBuffPopupDurationEndTime = 0f;
		currentCampaignBuffPopupTipCount = 0;
		ClearAirWallRuntime();
	}

	private void TryPlayCampaignBuffPopup(int buffId)
	{
		if (buffId > 0 && !shownCampaignBuffPopupIds.Contains(buffId))
		{
			DRCampaignBuff dataRow = GameEntry.DataTable.GetDataRow<DRCampaignBuff>(buffId);
			if (dataRow != null && dataRow.PopupId > 0)
			{
				shownCampaignBuffPopupIds.Add(buffId);
				EnqueueCampaignBuffPopup(GetCampaignBuffPopupTipType(dataRow.PopupTipType), dataRow.PopupId);
			}
		}
	}

	private void EnqueueCampaignBuffPopup(PopupTipType popupTipType, int popupId)
	{
		if (popupId > 0)
		{
			pendingCampaignBuffPopups.Enqueue(new CampaignBuffPopupRequest(popupTipType, popupId));
			RefreshCampaignBuffPopupTime();
			TryPlayNextCampaignBuffPopup();
		}
	}

	private void TryPlayNextCampaignBuffPopup()
	{
		if (!(Time.time < nextCampaignBuffPopupTime) && pendingCampaignBuffPopups.Count != 0)
		{
			CampaignBuffPopupRequest campaignBuffPopupRequest = pendingCampaignBuffPopups.Dequeue();
			PlayPopupTip(campaignBuffPopupRequest.popupTipType, campaignBuffPopupRequest.popupId);
			float popupQueueDuration = GetPopupQueueDuration(campaignBuffPopupRequest.popupId, out currentCampaignBuffPopupTipCount);
			campaignBuffPopupDurationEndTime = Time.time + popupQueueDuration;
			RefreshCampaignBuffPopupTime();
		}
	}

	private void RefreshCampaignBuffPopupTime()
	{
		if (!(campaignBuffPopupDurationEndTime <= Time.time))
		{
			float campaignBuffPopupSafeInterval = GetCampaignBuffPopupSafeInterval(currentCampaignBuffPopupTipCount, pendingCampaignBuffPopups.Count);
			nextCampaignBuffPopupTime = campaignBuffPopupDurationEndTime + campaignBuffPopupSafeInterval;
		}
	}

	private static float GetCampaignBuffPopupSafeInterval(int popupTipCount, int pendingPopupCount)
	{
		if (pendingPopupCount <= 0)
		{
			return 0f;
		}
		return Mathf.Min(0.2f + (float)Mathf.Max(0, popupTipCount - 1) * 0.03f + (float)Mathf.Max(0, pendingPopupCount - 1) * 0.04f, 0.4f);
	}

	private static float GetPopupQueueDuration(int popupId, out int popupTipCount)
	{
		popupTipCount = 0;
		DRPopupTipQueue dataRow = GameEntry.DataTable.GetDataRow<DRPopupTipQueue>(popupId);
		if (dataRow?.GroupList == null || dataRow.GroupList.Count == 0)
		{
			return 0f;
		}
		float num = 0f;
		for (int i = 0; i < dataRow.GroupList.Count; i++)
		{
			DRPopupTip dataRow2 = GameEntry.DataTable.GetDataRow<DRPopupTip>(dataRow.GroupList[i]);
			if (dataRow2 != null)
			{
				popupTipCount++;
				float num2 = ((dataRow2.Frames == 0f) ? 1f : dataRow2.Frames);
				num += num2 + dataRow2.WaitTime + dataRow2.Fadeout;
			}
		}
		return num;
	}

	private static PopupTipType GetCampaignBuffPopupTipType(int popupTipType)
	{
		if (popupTipType != 2)
		{
			return PopupTipType.Story;
		}
		return PopupTipType.Task;
	}

	private void OnMonsterEntityDead(BaseEntity entity, bool isNormal)
	{
		if (entity != null && monsterNodeByEntityId.TryGetValue(entity.Id, out var value))
		{
			monsterNodeByEntityId.Remove(entity.Id);
			value.OnEntityDead();
		}
	}

	private int IndexOfGroup(CampaignMonsterGroup group)
	{
		for (int i = 0; i < monsterGroups.Count; i++)
		{
			if (monsterGroups[i] == group)
			{
				return i;
			}
		}
		return -1;
	}

	private void RegisterFutureMonsterBuffRule(CampaignBuffData buffData, List<int> buffIds, float duration, CampaignMonsterGroup ownerGroup)
	{
		if (buffData != null && buffIds != null && buffIds.Count != 0 && IsFutureMonsterTargetType(buffData.targetType) && (buffData.durationType != CampaignBuffDurationType.TimeLimit || !(duration <= 0f)))
		{
			List<int> list = CollectionPool<List<int>, int>.Get();
			for (int i = 0; i < buffIds.Count; i++)
			{
				list.Add(buffIds[i]);
			}
			CampaignFutureMonsterBuffRule campaignFutureMonsterBuffRule = ReferencePool.Acquire<CampaignFutureMonsterBuffRule>();
			campaignFutureMonsterBuffRule.buffData = buffData;
			campaignFutureMonsterBuffRule.buffIds = list;
			campaignFutureMonsterBuffRule.ownerGroup = ownerGroup;
			campaignFutureMonsterBuffRule.followGroupId = ResolveFollowGroupId(buffData, ownerGroup);
			campaignFutureMonsterBuffRule.remainingDuration = ((buffData.durationType == CampaignBuffDurationType.TimeLimit) ? duration : 0f);
			futureMonsterBuffRules.Add(campaignFutureMonsterBuffRule);
		}
	}

	private void TickFutureMonsterBuffRules(float deltaTime)
	{
		if (deltaTime <= 0f || futureMonsterBuffRules.Count == 0)
		{
			return;
		}
		for (int num = futureMonsterBuffRules.Count - 1; num >= 0; num--)
		{
			CampaignFutureMonsterBuffRule campaignFutureMonsterBuffRule = futureMonsterBuffRules[num];
			if (campaignFutureMonsterBuffRule == null || campaignFutureMonsterBuffRule.buffData == null || campaignFutureMonsterBuffRule.buffIds == null || campaignFutureMonsterBuffRule.buffIds.Count == 0)
			{
				ReleaseFutureMonsterBuffRuleAt(num);
			}
			else if (campaignFutureMonsterBuffRule.IsTimeLimited)
			{
				campaignFutureMonsterBuffRule.remainingDuration -= deltaTime;
				if (campaignFutureMonsterBuffRule.remainingDuration <= 0f)
				{
					ReleaseFutureMonsterBuffRuleAt(num);
				}
			}
		}
	}

	private void RemoveFutureMonsterBuffRulesForGroup(int groupId)
	{
		if (groupId <= 0 || futureMonsterBuffRules.Count == 0)
		{
			return;
		}
		for (int num = futureMonsterBuffRules.Count - 1; num >= 0; num--)
		{
			CampaignFutureMonsterBuffRule campaignFutureMonsterBuffRule = futureMonsterBuffRules[num];
			if (campaignFutureMonsterBuffRule != null && campaignFutureMonsterBuffRule.followGroupId == groupId)
			{
				ReleaseFutureMonsterBuffRuleAt(num);
			}
		}
	}

	private void ReleaseFutureMonsterBuffRuleAt(int index)
	{
		CampaignFutureMonsterBuffRule campaignFutureMonsterBuffRule = futureMonsterBuffRules[index];
		futureMonsterBuffRules.RemoveAt(index);
		if (campaignFutureMonsterBuffRule != null)
		{
			ReferencePool.Release(campaignFutureMonsterBuffRule);
		}
	}

	private void ClearFutureMonsterBuffRules()
	{
		for (int num = futureMonsterBuffRules.Count - 1; num >= 0; num--)
		{
			ReleaseFutureMonsterBuffRuleAt(num);
		}
	}

	private void BuildBuffNodes(IReadOnlyList<CampaignBuffData> buffDatas)
	{
		if (buffDatas == null)
		{
			return;
		}
		for (int i = 0; i < buffDatas.Count; i++)
		{
			CampaignBuffData campaignBuffData = buffDatas[i];
			if (campaignBuffData != null && campaignBuffData.buffNodeId > 0 && !buffNodeById.ContainsKey(campaignBuffData.buffNodeId))
			{
				buffNodeById.Add(campaignBuffData.buffNodeId, new CampaignBuffNode(campaignBuffData, this));
			}
		}
	}

	public void RemoveFollowBuffsForGroup(int groupId)
	{
		if (groupId <= 0)
		{
			return;
		}
		RemoveFutureMonsterBuffRulesForGroup(groupId);
		if (!followBuffsByGroupId.TryGetValue(groupId, out var value))
		{
			return;
		}
		BuffSystem system = GetSystem<BuffSystem>();
		if (system != null)
		{
			for (int i = 0; i < value.Count; i++)
			{
				CampaignFollowBuffRecord campaignFollowBuffRecord = value[i];
				system.FinishEntityBuff(campaignFollowBuffRecord.entityId, campaignFollowBuffRecord.buffId);
			}
		}
		followBuffsByGroupId.Remove(groupId);
		CollectionPool<List<CampaignFollowBuffRecord>, CampaignFollowBuffRecord>.Release(value);
	}

	private void RemoveAllFollowBuffs()
	{
		if (followBuffsByGroupId.Count == 0)
		{
			return;
		}
		List<int> list = CollectionPool<List<int>, int>.Get();
		foreach (int key in followBuffsByGroupId.Keys)
		{
			list.Add(key);
		}
		for (int i = 0; i < list.Count; i++)
		{
			RemoveFollowBuffsForGroup(list[i]);
		}
		CollectionPool<List<int>, int>.Release(list);
	}

	private void RegisterFollowBuff(CampaignBuffData buffData, CampaignMonsterGroup ownerGroup, Buff buff)
	{
		if (buffData == null || buffData.durationType != CampaignBuffDurationType.FollowMonsterGroup || buff?.BuffOwner == null)
		{
			return;
		}
		int num = ResolveFollowGroupId(buffData, ownerGroup);
		if (num > 0)
		{
			if (!followBuffsByGroupId.TryGetValue(num, out var value))
			{
				value = CollectionPool<List<CampaignFollowBuffRecord>, CampaignFollowBuffRecord>.Get();
				followBuffsByGroupId.Add(num, value);
			}
			value.Add(new CampaignFollowBuffRecord(buff.BuffOwner.Id, buff.BuffId));
		}
	}

	private static int ResolveFollowGroupId(CampaignBuffData buffData, CampaignMonsterGroup ownerGroup)
	{
		if (buffData == null || buffData.durationType != CampaignBuffDurationType.FollowMonsterGroup)
		{
			return 0;
		}
		if (buffData.followMonsterGroupId <= 0)
		{
			return ownerGroup?.GroupId ?? 0;
		}
		return buffData.followMonsterGroupId;
	}

	private void BuildAirWallNodes(IReadOnlyList<CampaignAirWallData> airWallDatas)
	{
		if (airWallDatas == null)
		{
			return;
		}
		for (int i = 0; i < airWallDatas.Count; i++)
		{
			CampaignAirWallData campaignAirWallData = airWallDatas[i];
			if (campaignAirWallData != null && campaignAirWallData.airWallId > 0 && !airWallNodeById.ContainsKey(campaignAirWallData.airWallId))
			{
				CampaignAirWallNode campaignAirWallNode = new CampaignAirWallNode(campaignAirWallData);
				GameObject gameObject = CreateAirWallObject(campaignAirWallData);
				if (gameObject != null)
				{
					campaignAirWallNode.Bind(gameObject);
				}
				airWallNodeById.Add(campaignAirWallData.airWallId, campaignAirWallNode);
			}
		}
	}

	private GameObject CreateAirWallObject(CampaignAirWallData data)
	{
		Transform transform = GetAirWallRoot();
		if (transform == null)
		{
			return null;
		}
		GameObject gameObject = new GameObject(string.Format("{0}_{1}", "Quad", data.airWallId));
		gameObject.tag = "AirWall";
		gameObject.transform.SetParent(transform, worldPositionStays: true);
		gameObject.transform.position = data.airWallPos;
		gameObject.transform.rotation = Quaternion.Euler(data.airWallRot);
		gameObject.transform.localScale = data.airWallScale;
		Mesh builtinResource = Resources.GetBuiltinResource<Mesh>("Quad.fbx");
		if (builtinResource == null)
		{
			Object.Destroy(gameObject);
			return null;
		}
		gameObject.AddComponent<MeshFilter>().sharedMesh = builtinResource;
		MeshCollider obj = gameObject.AddComponent<MeshCollider>();
		obj.sharedMesh = builtinResource;
		obj.convex = false;
		((Collider)obj).isTrigger = false;
		MeshRenderer meshRenderer = gameObject.AddComponent<MeshRenderer>();
		meshRenderer.shadowCastingMode = ShadowCastingMode.On;
		meshRenderer.receiveShadows = true;
		Material orLoadAirWallMaterial = GetOrLoadAirWallMaterial();
		if (orLoadAirWallMaterial != null)
		{
			meshRenderer.sharedMaterial = orLoadAirWallMaterial;
		}
		gameObject.SetActive(value: false);
		return gameObject;
	}

	private Transform GetAirWallRoot()
	{
		if (world == null)
		{
			return null;
		}
		if (airWallRoot == null)
		{
			airWallRoot = new GameObject("CampaignAirWallRoot");
			airWallRoot.transform.SetParent(world.MechanismRoot, worldPositionStays: false);
		}
		return airWallRoot.transform;
	}

	private Material GetOrLoadAirWallMaterial()
	{
		if (world == null)
		{
			return null;
		}
		GameResourceSystem system = GetSystem<GameResourceSystem>();
		if (system == null)
		{
			return null;
		}
		Material material = system.LoadAsset<Material>("Assets/Art/MapData/Campaign/Unlit_Lattice.mat");
		if (material != null && !loadedAirWallMaterials.Contains(material))
		{
			loadedAirWallMaterials.Add(material);
			system.AddMaterialResPath("Assets/Art/MapData/Campaign/Unlit_Lattice.mat");
		}
		return material;
	}

	private void ClearAirWallRuntime()
	{
		foreach (CampaignAirWallNode value in airWallNodeById.Values)
		{
			value?.Destroy();
		}
		pendingAirWallIds.Clear();
		pendingAirWallActiveById.Clear();
		airWallNodeById.Clear();
		if (airWallRoot != null)
		{
			Object.Destroy(airWallRoot);
			airWallRoot = null;
		}
		loadedAirWallMaterials.Clear();
	}

	private bool IsPointInTrigger(CampaignTriggerData data, Vector3 point)
	{
		Vector3 vector = Quaternion.Inverse(Quaternion.Euler(data.triggerRot)) * (point - data.triggerPos);
		Vector3 vector2 = data.triggerScale * 0.5f;
		if (Mathf.Abs(vector.x) <= vector2.x && Mathf.Abs(vector.y) <= vector2.y)
		{
			return Mathf.Abs(vector.z) <= vector2.z;
		}
		return false;
	}

	private static float SqrDistanceXZ(Vector3 a, Vector3 b)
	{
		float num = a.x - b.x;
		float num2 = a.z - b.z;
		return num * num + num2 * num2;
	}

	private List<BaseEntity> GetBuffTargets(CampaignBuffData buffData, CampaignMonsterGroup ownerGroup, CampaignTriggerData triggerData)
	{
		List<BaseEntity> list = CollectionPool<List<BaseEntity>, BaseEntity>.Get();
		if (buffData == null)
		{
			return list;
		}
		switch (buffData.targetType)
		{
		case CampaignBuffTargetType.All:
			CollectPlayerTargets(list);
			CollectAllMonsterTargets(list);
			break;
		case CampaignBuffTargetType.AllPlay:
			CollectPlayerTargets(list);
			break;
		case CampaignBuffTargetType.TriggerPlay:
			CollectTriggerPlayerTarget(list, triggerData);
			break;
		case CampaignBuffTargetType.MonsterGroup:
			CollectMonsterGroupTargets(list, buffData, ownerGroup);
			break;
		case CampaignBuffTargetType.AllMonster:
		case CampaignBuffTargetType.AliveMonster:
			CollectAllMonsterTargets(list);
			break;
		}
		return list;
	}

	private void CollectPlayerTargets(List<BaseEntity> targets)
	{
		List<HeroEntity> list = GetSystem<EntitySystem>()?.GetTeamHero();
		if (list == null)
		{
			return;
		}
		for (int i = 0; i < list.Count; i++)
		{
			if (list[i] != null)
			{
				targets.Add(list[i]);
			}
		}
	}

	private void CollectTriggerPlayerTarget(List<BaseEntity> targets, CampaignTriggerData triggerData)
	{
		if (triggerData == null)
		{
			return;
		}
		List<HeroEntity> list = GetSystem<EntitySystem>()?.GetTeamHero();
		if (list == null)
		{
			return;
		}
		for (int i = 0; i < list.Count; i++)
		{
			HeroEntity heroEntity = list[i];
			if (heroEntity != null && heroEntity.IsSurvival && IsPointInTrigger(triggerData, heroEntity.transform.position))
			{
				targets.Add(heroEntity);
				break;
			}
		}
	}

	private void CollectMonsterGroupTargets(List<BaseEntity> targets, CampaignBuffData buffData, CampaignMonsterGroup ownerGroup)
	{
		bool flag = false;
		if (buffData?.targetMonsterGroupIds != null)
		{
			for (int i = 0; i < buffData.targetMonsterGroupIds.Count; i++)
			{
				int num = buffData.targetMonsterGroupIds[i];
				if (num > 0 && monsterGroupById.TryGetValue(num, out var value))
				{
					flag = true;
					CollectOwnerGroupTargets(targets, value);
				}
			}
		}
		if (!flag)
		{
			CollectOwnerGroupTargets(targets, ownerGroup);
		}
	}

	private void CollectAllMonsterTargets(List<BaseEntity> targets)
	{
		List<BaseEntity> list = GetSystem<EntitySystem>()?.FindAllMonsterEntities();
		if (list == null)
		{
			return;
		}
		for (int i = 0; i < list.Count; i++)
		{
			BaseEntity baseEntity = list[i];
			if (baseEntity != null)
			{
				targets.Add(baseEntity);
			}
		}
		CollectionPool<List<BaseEntity>, BaseEntity>.Release(list);
	}

	private bool CollectOwnerGroupTargets(List<BaseEntity> targets, CampaignMonsterGroup ownerGroup)
	{
		if (ownerGroup == null)
		{
			return false;
		}
		IReadOnlyList<CampaignMonsterNode> monsterNodes = ownerGroup.MonsterNodes;
		for (int i = 0; i < monsterNodes.Count; i++)
		{
			AddMonsterNodeTarget(targets, monsterNodes[i]);
		}
		return true;
	}

	private static void AddMonsterNodeTarget(List<BaseEntity> targets, CampaignMonsterNode node)
	{
		if (node?.Entity != null && node.Entity.IsSurvival && !targets.Contains(node.Entity))
		{
			targets.Add(node.Entity);
		}
	}

	private static bool IsCurrentTargetType(CampaignBuffTargetType targetType)
	{
		if (targetType != CampaignBuffTargetType.All && targetType != CampaignBuffTargetType.AllPlay && targetType != CampaignBuffTargetType.TriggerPlay && targetType != CampaignBuffTargetType.MonsterGroup && targetType != CampaignBuffTargetType.AllMonster)
		{
			return targetType == CampaignBuffTargetType.AliveMonster;
		}
		return true;
	}

	private static bool IsFutureMonsterTargetType(CampaignBuffTargetType targetType)
	{
		if (targetType != CampaignBuffTargetType.All && targetType != CampaignBuffTargetType.AllMonster)
		{
			return targetType == CampaignBuffTargetType.NewBornMonster;
		}
		return true;
	}

	private static bool NeedsCurrentSpawnedMonsterTarget(CampaignBuffTargetType targetType)
	{
		if (targetType != CampaignBuffTargetType.MonsterGroup)
		{
			return targetType == CampaignBuffTargetType.AliveMonster;
		}
		return true;
	}

	private T GetSystem<T>() where T : BaseSystem
	{
		BaseSystem baseSystem = ownerSystem;
		if (baseSystem == null)
		{
			return null;
		}
		return baseSystem.GetSystem<T>();
	}
}
