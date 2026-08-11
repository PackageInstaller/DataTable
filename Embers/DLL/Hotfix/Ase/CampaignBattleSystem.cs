#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using Ase.ECS;
using Cysharp.Threading.Tasks;
using GameFramework;
using UnityEngine;

namespace Ase;

public class CampaignBattleSystem : BaseSystem
{
	private readonly List<CampaignMonsterGroup> monsterGroups = new List<CampaignMonsterGroup>();

	private readonly List<CampaignTriggerNode> triggerNodes = new List<CampaignTriggerNode>();

	private readonly Dictionary<int, CampaignMonsterGroup> monsterGroupById = new Dictionary<int, CampaignMonsterGroup>();

	private readonly Dictionary<int, CampaignMonsterNode> monsterNodeByEntityId = new Dictionary<int, CampaignMonsterNode>();

	private readonly Dictionary<int, CampaignMonsterNode> monsterNodeByKey = new Dictionary<int, CampaignMonsterNode>();

	private CampaignBattleContext context;

	private bool isRunning;

	private float countdownRemainTime;

	private bool countdownRunning;

	private GameSettlementType countdownSettlementType;

	protected override bool IsLogicSystem => true;

	public CampaignMapData MapData { get; private set; }

	public override UniTask<bool> OnEnter(object data = null)
	{
		if (data is CampaignBattleWorldData campaignBattleWorldData)
		{
			return new UniTask<bool>(Load(campaignBattleWorldData.mapData));
		}
		ClearRuntimeData();
		MapData = null;
		isRunning = false;
		StopCountdown();
		return new UniTask<bool>(result: true);
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		if (!isRunning || MapData == null)
		{
			return;
		}
		context?.Tick(deltaTime);
		TickGroups(deltaTime);
		if (isRunning)
		{
			TickTriggers(deltaTime);
			if (isRunning)
			{
				TryCompleteByAllMonsterDead();
			}
		}
	}

	public override void OnFixedUpdateBefore(WorldUpdateType updateType)
	{
		if (isRunning && MapData != null)
		{
			TickCountdown(world.IntervalTimer);
		}
		context?.FlushPendingAirWallStates();
	}

	public override void OnDispose()
	{
		base.OnDispose();
		ClearRuntimeData();
		MapData = null;
		context = null;
		isRunning = false;
		StopCountdown();
	}

	public async UniTask<bool> LoadBattleSceneMapData(GameObject worldRoot)
	{
		return true;
	}

	public bool RoundHeroPreparation(CampaignBattleWorldData worldData, int teamRebornValue)
	{
		if (worldData == null)
		{
			Log.Error("Campaign 创建英雄失败：WorldData 为空。");
			return false;
		}
		if (worldData.TeamListConfig.IsNullOrEmpty())
		{
			Log.Error("Campaign 创建英雄失败：队伍配置为空。");
			return false;
		}
		if (MapData == null)
		{
			MapData = worldData.mapData;
		}
		if (!HasEnoughHeroBornPoint(worldData.TeamListConfig.Count))
		{
			return false;
		}
		GetSystem<RoomSystem>().CurRoomID = worldData.SelfIndex;
		for (int i = 0; i < worldData.TeamListConfig.Count; i++)
		{
			PeripheryHeroData peripheryHeroData = worldData.TeamListConfig[i];
			if (peripheryHeroData == null)
			{
				Log.Error($"Campaign 创建英雄失败：队伍第 {i} 位英雄配置为空。");
				return false;
			}
			DRHero dataRow = GameEntry.DataTable.GetDataRow<DRHero>(peripheryHeroData.Id);
			if (dataRow == null)
			{
				Log.Error($"Campaign 创建英雄失败：没有找到 Id = {peripheryHeroData.Id} 的英雄配置。");
				return false;
			}
			GetSystem<ParadoxSystem>().CacheParadoxTreeObj(dataRow.AIParadoxId);
			GameObject entityObject = GetSystem<EntityViewCacheSystem>().LoadEntityView(peripheryHeroData.Id, world.GetSkinAssetPath(peripheryHeroData, dataRow));
			HeroEntity heroEntity = GetSystem<EntitySystem>().CreateServerEntity<HeroEntity>(peripheryHeroData.SeatId, peripheryHeroData.Id, new EntityData
			{
				pointData = new EntityPositionData
				{
					position = GetHeroBornPoint(i),
					scale = Vector3.one,
					rotation = GetHeroBornAngle(i)
				},
				entityObject = entityObject,
				updateType = EntityUpdateType.Local,
				logicType = EntityLogicType.None,
				collisionLayer = CollisionSetting.CollisionLayer.Hero,
				collisionMass = 2,
				userData = peripheryHeroData
			});
			heroEntity.BattleHeroData.IsSelf = i == worldData.SelfIndex;
			if (heroEntity.BattleHeroData.IsSelf)
			{
				world.SetActorId(heroEntity);
				LockstepData.Instance?.InitData(world.ActorId, worldData.RoomId, worldData.TeamListConfig.Count, heroEntity.EntityId);
				LockstepData.Instance?.WriteAuthorityEntityId($"随机数 = {worldData.RandomSeed}", heroEntity);
			}
			else if (world.BattleWorldMode == BattleWorldMode.SingleBattle)
			{
				heroEntity.SetAi(memberIsAi: true);
			}
			else if (peripheryHeroData.isRobot)
			{
				heroEntity.SetRobot(robot: true);
			}
			int heroMemberId = GetHeroMemberId(worldData, peripheryHeroData, i);
			GetSystem<BattleSystem>().InitHeroData(heroMemberId, heroEntity, teamRebornValue);
			GetSystem<RoomSystem>().AddToRoomEntity(heroEntity);
		}
		GetSystem<BattleSystem>().InitHeroComplete();
		if (world.ActorId == 0)
		{
			Log.Error("Campaign 初始化世界错误：没有玩家主控角色。");
			return false;
		}
		return true;
	}

	public bool Load(CampaignMapData mapData)
	{
		if (mapData == null)
		{
			Log.Error("读取战役地图数据失败：CampaignMapData 为空。");
			ClearRuntimeData();
			MapData = null;
			isRunning = false;
			return false;
		}
		MapData = mapData;
		if (!BuildRuntimeData(mapData))
		{
			Log.Error("[Campaign] 战役地图加载失败。地图=" + mapData.name + "。");
			ClearRuntimeData();
			MapData = null;
			isRunning = false;
			return false;
		}
		isRunning = true;
		StartCountdown(mapData);
		return true;
	}

	public CampaignMonsterGroupData GetMonsterGroupData(int groupId)
	{
		return GetMonsterGroup(groupId)?.Data;
	}

	public CampaignMonsterGroup GetMonsterGroup(int groupId)
	{
		monsterGroupById.TryGetValue(groupId, out var value);
		return value;
	}

	private bool BuildRuntimeData(CampaignMapData mapData)
	{
		ClearRuntimeData();
		context = new CampaignBattleContext(this, world, monsterGroups, monsterGroupById, monsterNodeByEntityId, monsterNodeByKey, mapData.buffDatas, mapData.ariWallDatas);
		if (mapData.monsterGroupDatas != null)
		{
			for (int i = 0; i < mapData.monsterGroupDatas.Count; i++)
			{
				CampaignMonsterGroupData campaignMonsterGroupData = mapData.monsterGroupDatas[i];
				if (campaignMonsterGroupData != null)
				{
					CampaignMonsterGroup campaignMonsterGroup = new CampaignMonsterGroup(campaignMonsterGroupData, context);
					monsterGroups.Add(campaignMonsterGroup);
					if (monsterGroupById.ContainsKey(campaignMonsterGroup.GroupId))
					{
						Log.Error($"读取战役地图数据失败：重复的怪物组编号 {campaignMonsterGroup.GroupId}。");
						return false;
					}
					monsterGroupById.Add(campaignMonsterGroup.GroupId, campaignMonsterGroup);
					if (!RegisterMonsterNodes(campaignMonsterGroup))
					{
						return false;
					}
				}
			}
		}
		if (mapData.triggerDatas != null)
		{
			for (int j = 0; j < mapData.triggerDatas.Count; j++)
			{
				CampaignTriggerData campaignTriggerData = mapData.triggerDatas[j];
				if (campaignTriggerData != null && campaignTriggerData.isTrigger)
				{
					triggerNodes.Add(new CampaignTriggerNode(campaignTriggerData, context));
				}
			}
		}
		HideConfiguredAirWalls();
		return true;
	}

	private bool HasEnoughHeroBornPoint(int heroCount)
	{
		if (MapData == null)
		{
			Log.Error("Campaign 创建英雄失败：CampaignMapData 为空。");
			return false;
		}
		if (MapData.bornPos == null || MapData.bornPos.Count < heroCount)
		{
			Log.Error($"Campaign 创建英雄失败：英雄出生位置数量不足，需要 {heroCount} 个，当前 {MapData.bornPos?.Count ?? 0} 个。");
			return false;
		}
		if (MapData.bornAngle == null || MapData.bornAngle.Count < heroCount)
		{
			Log.Error($"Campaign 创建英雄失败：英雄出生旋转数量不足，需要 {heroCount} 个，当前 {MapData.bornAngle?.Count ?? 0} 个。");
			return false;
		}
		return true;
	}

	private Vector3 GetHeroBornPoint(int index)
	{
		return MapData.bornPos[index];
	}

	private Vector3 GetHeroBornAngle(int index)
	{
		return MapData.bornAngle[index];
	}

	private static int GetHeroMemberId(CampaignBattleWorldData worldData, PeripheryHeroData heroModel, int index)
	{
		TeamMember obj = worldData.TeamMemberList?.Find((TeamMember member) => member.HeroModel != null && member.HeroModel.Id == heroModel.Id);
		if (obj == null)
		{
			Log.Error($"Campaign 未找到 TeamMember 数据，HeroId: {heroModel.Id}");
		}
		return obj?.MemberId ?? (index + 1);
	}

	private bool RegisterMonsterNodes(CampaignMonsterGroup group)
	{
		for (int i = 0; i < group.MonsterNodes.Count; i++)
		{
			CampaignMonsterNode campaignMonsterNode = group.MonsterNodes[i];
			int monsterNodeKey = campaignMonsterNode.MonsterNodeKey;
			if (monsterNodeKey > 0 && !monsterNodeByKey.ContainsKey(monsterNodeKey))
			{
				monsterNodeByKey.Add(monsterNodeKey, campaignMonsterNode);
			}
			else if (monsterNodeKey > 0)
			{
				Log.Error($"读取战役地图数据失败：重复的怪物节点Key。组Id={group.GroupId}，怪物序号={campaignMonsterNode.MonsterIndex}，怪物节点Key={monsterNodeKey}。");
				return false;
			}
		}
		return true;
	}

	private void ClearRuntimeData()
	{
		if (monsterGroups.Count > 0 || triggerNodes.Count > 0 || monsterNodeByEntityId.Count > 0 || monsterNodeByKey.Count > 0 || context != null)
		{
			LogRuntimeDataDestroy();
		}
		monsterGroups.Clear();
		triggerNodes.Clear();
		monsterGroupById.Clear();
		monsterNodeByEntityId.Clear();
		monsterNodeByKey.Clear();
		context?.Dispose();
		context = null;
		StopCountdown();
	}

	private void StartCountdown(CampaignMapData mapData)
	{
		StopCountdown();
		if (mapData == null)
		{
			return;
		}
		float f;
		if (mapData.countdownWin && mapData.countdownWinTime > 0f)
		{
			f = mapData.countdownWinTime;
			countdownSettlementType = GameSettlementType.MonsterDead;
		}
		else
		{
			if (!mapData.countdownLose || !(mapData.countdownLoseTime > 0f))
			{
				return;
			}
			f = mapData.countdownLoseTime;
			countdownSettlementType = GameSettlementType.TimeOver;
		}
		countdownRemainTime = f;
		countdownRunning = true;
		BattleSystem system = GetSystem<BattleSystem>();
		int battleTimeConfig = Mathf.CeilToInt(f);
		system?.SetBattleTimeConfig(battleTimeConfig);
		system?.SetBattleTimeDelayWithoutTimeOver(0f);
	}

	public void StopForCampaignSettlement()
	{
		isRunning = false;
		if (countdownRunning)
		{
			GetSystem<BattleSystem>()?.StopBattleTime();
		}
		StopCountdown();
	}

	private void StopCountdown()
	{
		countdownRemainTime = 0f;
		countdownRunning = false;
		countdownSettlementType = GameSettlementType.MonsterDead;
	}

	private bool TickCountdown(float deltaTime)
	{
		if (!countdownRunning)
		{
			return false;
		}
		if (countdownRemainTime <= deltaTime)
		{
			GameSettlementType gameSettlementType = countdownSettlementType;
			countdownRemainTime = 0f;
			StopForCampaignSettlement();
			world.GameSettlement(gameSettlementType);
			return true;
		}
		countdownRemainTime -= deltaTime;
		return false;
	}

	private void TickGroups(float deltaTime)
	{
		for (int i = 0; i < monsterGroups.Count; i++)
		{
			monsterGroups[i].Tick(deltaTime);
		}
	}

	private void HideConfiguredAirWalls()
	{
		for (int i = 0; i < monsterGroups.Count; i++)
		{
			monsterGroups[i].HideConfiguredAirWalls();
		}
	}

	private void TickTriggers(float deltaTime)
	{
		for (int i = 0; i < triggerNodes.Count; i++)
		{
			CampaignTriggerNode campaignTriggerNode = triggerNodes[i];
			if (campaignTriggerNode.Tick(deltaTime))
			{
				isRunning = !campaignTriggerNode.IsWinTrigger;
				if (!isRunning)
				{
					break;
				}
			}
		}
	}

	private void TryCompleteByAllMonsterDead()
	{
		if (monsterGroups.Count == 0)
		{
			return;
		}
		for (int i = 0; i < monsterGroups.Count; i++)
		{
			if (!monsterGroups[i].IsCompleted)
			{
				return;
			}
		}
		StopForCampaignSettlement();
		world.GameSettlement(GameSettlementType.MonsterDead);
	}

	private void LogRuntimeDataDestroy()
	{
		for (int i = 0; i < monsterGroups.Count; i++)
		{
			CampaignMonsterGroup campaignMonsterGroup = monsterGroups[i];
			if (campaignMonsterGroup != null)
			{
				for (int j = 0; j < campaignMonsterGroup.MonsterNodes.Count; j++)
				{
					_ = campaignMonsterGroup.MonsterNodes[j];
				}
			}
		}
		for (int k = 0; k < triggerNodes.Count; k++)
		{
			_ = triggerNodes[k];
		}
	}
}
