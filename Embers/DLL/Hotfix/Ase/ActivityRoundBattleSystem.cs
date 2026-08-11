#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Ase.ECS;
using Cysharp.Threading.Tasks;
using GameFramework;
using UnityEngine;

namespace Ase;

public class ActivityRoundBattleSystem : BaseSystem
{
	private ActivityMapData mapData;

	private List<ActivityMapDataGroup> activityMapDataRound;

	private float remainStageTime;

	private Dictionary<int, int> roundGroupMonsterCountDic;

	private Dictionary<int, int> monsterBelongGoundGroupDic;

	private Dictionary<int, ActivityRoundCondition> condition = new Dictionary<int, ActivityRoundCondition>();

	private List<int> finishConditions;

	private List<int> finishGroupIds;

	private Dictionary<int, int> cacheNextRound = new Dictionary<int, int>();

	private Dictionary<int, int> trapEntityList;

	public Dictionary<int, BaseEntity> heroEntityList = new Dictionary<int, BaseEntity>();

	private int _curStage;

	public bool IsStart { get; set; }

	private int CurStage
	{
		get
		{
			return _curStage;
		}
		set
		{
			_curStage = value;
			ResetData();
			if (_curStage < mapData.stages.Count)
			{
				activityMapDataRound = mapData.stages[_curStage].allGroupData;
				remainStageTime = mapData.stages[_curStage].stageTime;
				GetSystem<BattleSystem>().SetBattleTimeConfig((int)remainStageTime);
				IsStart = false;
			}
			else
			{
				activityMapDataRound = null;
			}
		}
	}

	protected override bool IsLogicSystem => true;

	public override async UniTask<bool> OnEnter(object data = null)
	{
		if (data is ActivityBattleWorldData activityBattleWorldData)
		{
			roundGroupMonsterCountDic = new Dictionary<int, int>();
			monsterBelongGoundGroupDic = new Dictionary<int, int>();
			mapData = activityBattleWorldData.mapData;
			CurStage = activityBattleWorldData.CurStage;
			ResetData();
		}
		RoomSystem system = world.GetSystem<RoomSystem>();
		system.ActionTrapTrigger = (Action<IEntityRoom, int, IEntityRoom>)Delegate.Combine(system.ActionTrapTrigger, new Action<IEntityRoom, int, IEntityRoom>(HelpOtherGroup));
		return true;
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		if (IsStart && !(mapData == null))
		{
			if (remainStageTime <= 0f)
			{
				world.GameSettlement(GameSettlementType.TimeOver);
				return;
			}
			remainStageTime -= deltaTime;
			TryNext(deltaTime);
		}
	}

	private void TryNext(float deltaTime)
	{
		if (cacheNextRound.Values.Count > 0)
		{
			Dictionary<int, int> dictionary = new Dictionary<int, int>();
			foreach (KeyValuePair<int, int> item in cacheNextRound)
			{
				Next(item.Key, item.Value);
				dictionary.Add(item.Key, item.Value);
			}
			foreach (KeyValuePair<int, int> item2 in dictionary)
			{
				cacheNextRound.Remove(item2.Key);
			}
			dictionary.Clear();
		}
		if (condition.Count <= 0)
		{
			return;
		}
		foreach (ActivityRoundCondition value in condition.Values)
		{
			if (value.value <= 0f)
			{
				value.roundID++;
				cacheNextRound[value.groupID] = value.roundID;
			}
			if (value.changeType == ActivityMapDataRoundChangeType.Time)
			{
				value.value -= deltaTime;
			}
		}
	}

	private void HelpOtherGroup(IEntityRoom heroEntity, int heroCurRoomID, IEntityRoom battleEntity)
	{
		for (int i = 0; i < finishGroupIds.Count; i++)
		{
			if (finishGroupIds[i] == heroCurRoomID)
			{
				SetHeroPos(trapEntityList[battleEntity.ID], heroEntity as BaseEntity);
				break;
			}
		}
	}

	public void SetHeroPos(int roomID, BaseEntity hero)
	{
		if (hero != null && mapData.stages[_curStage].bornPos.Count > roomID && roomID >= 0)
		{
			hero.transform.position = mapData.stages[_curStage].bornPos[roomID];
			ObserverChangeRoomParams observerChangeRoomParams = ReferencePool.Acquire<ObserverChangeRoomParams>();
			observerChangeRoomParams.Init(roomID, hero);
			GetSystem<BattleObserverSystem>().Notify(BattleObserverEventEnum.ChangeRoom, observerChangeRoomParams);
		}
	}

	public Vector3 GetHeroBornPoint(int index)
	{
		if (mapData != null && index + 1 <= mapData.stages[_curStage].bornPos.Count)
		{
			return mapData.stages[_curStage].bornPos[index];
		}
		return Vector3.zero;
	}

	public Vector3 GetHeroBornAngle(int index)
	{
		if (mapData != null && index + 1 <= mapData.stages[_curStage].bornAngle.Count)
		{
			return mapData.stages[_curStage].bornAngle[index];
		}
		return Vector3.zero;
	}

	public int GetHeroBornRoomId(int index)
	{
		if (mapData != null && index + 1 <= mapData.stages[_curStage].roomID.Count)
		{
			return mapData.stages[_curStage].roomID[index];
		}
		return index;
	}

	public bool RoundHeroPreparation(ActivityBattleWorldData worldData)
	{
		if (worldData.TeamListConfig.IsNullOrEmpty())
		{
			Log.Error("队伍配置错误!");
			return false;
		}
		GetSystem<RoomSystem>().CurRoomID = worldData.SelfIndex;
		for (int i = 0; i < worldData.TeamListConfig.Count; i++)
		{
			PeripheryHeroData peripheryHeroData = worldData.TeamListConfig[i];
			DRHero dataRow = GameEntry.DataTable.GetDataRow<DRHero>(worldData.TeamListConfig[i].Id);
			if (dataRow == null)
			{
				Log.Error($"没有找到Id = {worldData.TeamListConfig[i].Id} 的英雄配置..");
				return false;
			}
			GetSystem<ParadoxSystem>().CacheParadoxTreeObj(dataRow.AIParadoxId);
			GameObject entityObject = GetSystem<EntityViewCacheSystem>().LoadEntityView(worldData.TeamListConfig[i].Id, world.GetSkinAssetPath(peripheryHeroData, dataRow));
			Vector3 heroBornPoint = GetHeroBornPoint(i);
			Vector3 heroBornAngle = GetHeroBornAngle(i);
			int heroBornRoomId = GetHeroBornRoomId(i);
			HeroEntity heroEntity = GetSystem<EntitySystem>().CreateServerEntity<HeroEntity>(worldData.TeamListConfig[i].SeatId, worldData.TeamListConfig[i].Id, new EntityData
			{
				pointData = new EntityPositionData
				{
					position = heroBornPoint,
					scale = Vector3.one,
					rotation = heroBornAngle
				},
				entityObject = entityObject,
				updateType = EntityUpdateType.Local,
				logicType = EntityLogicType.None,
				collisionLayer = CollisionSetting.CollisionLayer.Hero,
				collisionMass = 2,
				userData = worldData.TeamListConfig[i]
			});
			heroEntity.BattleHeroData.IsSelf = i == worldData.SelfIndex;
			GetSystem<RoomSystem>().AddToRoomEntity(heroEntity, heroBornRoomId);
			heroEntityList.Add(i, heroEntity);
			if (heroEntity.BattleHeroData.IsSelf)
			{
				world.SetActorId(heroEntity);
				LockstepData.Instance?.InitData(world.ActorId, worldData.RoomId, worldData.TeamListConfig.Count, heroEntity.EntityId);
			}
			else if (world.BattleWorldMode == BattleWorldMode.SingleBattle)
			{
				heroEntity.SetAi(memberIsAi: true);
			}
			else if (peripheryHeroData.isRobot)
			{
				heroEntity.SetRobot(robot: true);
			}
			GetSystem<BattleSystem>().InitHeroData(peripheryHeroData.SeatId, heroEntity, worldData.TeamListConfig.Count);
		}
		GetSystem<BattleSystem>().InitHeroComplete();
		if (heroEntityList.Count > 1 && world.ActorId == 0)
		{
			Log.Error("初始化世界错误：没有玩家主控角色....");
			return false;
		}
		return true;
	}

	public bool RoundPreparation(int roomID = -1, int roundId = 0)
	{
		List<ActivityMapDataObjData> list = new List<ActivityMapDataObjData>();
		if (roomID == -1)
		{
			for (int i = 0; i < activityMapDataRound.Count; i++)
			{
				RoundPreparation(activityMapDataRound[i].groupID);
			}
		}
		else if (activityMapDataRound.Count > roomID)
		{
			for (int j = 0; j < activityMapDataRound.Count; j++)
			{
				RefershCondition(roomID, roundId, j);
				if (activityMapDataRound[j].groupID == roomID && activityMapDataRound[j].rounds.Count > roundId)
				{
					List<ActivityMapDataObjData> roundObjs = activityMapDataRound[j].rounds[roundId].roundObjs;
					list.AddRange(roundObjs);
					RecordMonster(roomID, roundObjs);
					break;
				}
			}
		}
		if (list.Count > 0)
		{
			for (int k = 0; k < list.Count; k++)
			{
				ActivityMapDataObjData activityMapDataObjData = list[k];
				if (activityMapDataObjData.objType == ActivityMapDataObjType.Monster)
				{
					if (!RoundMonsterPreparation(activityMapDataObjData))
					{
						return false;
					}
				}
				else if (activityMapDataObjData.objType == ActivityMapDataObjType.Interactive)
				{
					if (!RoundInteractivePreparation(activityMapDataObjData))
					{
						return false;
					}
				}
				else if (activityMapDataObjData.objType == ActivityMapDataObjType.Trap && !RoundTrapPreparation(activityMapDataObjData))
				{
					return false;
				}
			}
		}
		return true;
	}

	private bool RoundMonsterPreparation(ActivityMapDataObjData objData)
	{
		DRMonsterAttr dataRow = GameEntry.DataTable.GetDataRow<DRMonsterAttr>(objData.id);
		if (dataRow == null)
		{
			Log.Error($"没有找到怪物编号 = {objData.id}的怪物配置..");
			return false;
		}
		DRMonster dataRow2 = GameEntry.DataTable.GetDataRow<DRMonster>(dataRow.MonsterType);
		if (dataRow2 == null)
		{
			Log.Error($"没有找到怪物种类 = {dataRow.MonsterType}的怪物配置..");
			return false;
		}
		GameObject entityObject = GetSystem<EntityViewCacheSystem>().LoadEntityView(dataRow2.Id, dataRow2.AssetPath);
		MonsterEntity monsterEntity = GetSystem<EntitySystem>().CreateEntity<MonsterEntity>(dataRow2.Id, new EntityData
		{
			pointData = new EntityPositionData
			{
				position = objData.pos,
				scale = Vector3.one,
				rotation = objData.angles
			},
			entityObject = entityObject,
			updateType = EntityUpdateType.Local,
			logicType = EntityLogicType.None,
			collisionLayer = CollisionSetting.CollisionLayer.Boss,
			collisionMass = 2,
			campType = CampType.Monster,
			userData = dataRow2,
			userDataPam = dataRow,
			callbacks = new EntityCallbacks(OnMonsterEntityDead, null)
		});
		GetSystem<BattleSystem>().InitMonsterEntity(monsterEntity);
		GetSystem<RoomSystem>().AddToRoomEntity(monsterEntity, objData.groupID);
		monsterBelongGoundGroupDic.Add(monsterEntity.Id, objData.groupID);
		return true;
	}

	private bool RoundInteractivePreparation(ActivityMapDataObjData objData)
	{
		DRMapItem dataRow = GameEntry.DataTable.GetDataRow<DRMapItem>(objData.id);
		if (dataRow == null)
		{
			Log.Error($"没有找到编号 = {objData.id}的交互物配置..");
			return false;
		}
		GetSystem<ParadoxSystem>().CacheParadoxTreeObj(dataRow.AIParadoxId);
		GameObject entityObject = GetSystem<EntityViewCacheSystem>().LoadEntityView(objData.id, dataRow.AssetPath);
		SyncBattleInteractiveEntity syncBattleInteractiveEntity = GetSystem<EntitySystem>().CreateEntity<SyncBattleInteractiveEntity>(objData.id, new EntityData
		{
			pointData = new EntityPositionData
			{
				position = objData.pos,
				scale = Vector3.one,
				rotation = objData.angles
			},
			entityObject = entityObject,
			userData = dataRow,
			updateType = EntityUpdateType.Authority,
			logicType = EntityLogicType.None
		});
		GetSystem<RoomSystem>().AddToRoomEntity(syncBattleInteractiveEntity, objData.groupID);
		syncBattleInteractiveEntity.SetData(Constant.InteractiveConstant.INTERACTIVE_NAME, objData.name);
		return true;
	}

	private bool RoundTrapPreparation(ActivityMapDataObjData objData)
	{
		DRBattleEntityConfig dataRow = GameEntry.DataTable.GetDataRow<DRBattleEntityConfig>(objData.id);
		GameObject entityObject = GetSystem<EntityViewCacheSystem>().LoadEntityView(objData.id, dataRow.AssetPath);
		ActivityTrapEntity activityTrapEntity = GetSystem<EntitySystem>().CreateEntity<ActivityTrapEntity>(objData.id, new EntityData
		{
			pointData = new EntityPositionData
			{
				position = objData.pos,
				scale = Vector3.one,
				rotation = objData.angles
			},
			entityObject = entityObject,
			updateType = EntityUpdateType.Authority,
			logicType = EntityLogicType.None,
			userData = dataRow
		});
		trapEntityList[activityTrapEntity.Id] = objData.groupHelp;
		GetSystem<RoomSystem>().AddToRoomEntity(activityTrapEntity, objData.groupID);
		return true;
	}

	private void RefershCondition(int roomID, int roundId, int index)
	{
		ActivityRoundCondition activityRoundCondition = new ActivityRoundCondition();
		activityRoundCondition.groupID = index;
		activityRoundCondition.roundID = roundId;
		activityRoundCondition.changeType = activityMapDataRound[index].rounds[roundId].roundType;
		switch (activityRoundCondition.changeType)
		{
		case ActivityMapDataRoundChangeType.Kill:
			activityRoundCondition.value = activityMapDataRound[index].rounds[roundId].killNum;
			break;
		case ActivityMapDataRoundChangeType.Time:
			activityRoundCondition.value = activityMapDataRound[index].rounds[roundId].time;
			break;
		}
		condition[roomID] = activityRoundCondition;
	}

	private void RecordMonster(int roomID, List<ActivityMapDataObjData> objs)
	{
		int num = 0;
		for (int i = 0; i < objs.Count; i++)
		{
			if (objs[i].objType == ActivityMapDataObjType.Monster)
			{
				num++;
			}
		}
		if (roundGroupMonsterCountDic.TryGetValue(roomID, out var _))
		{
			roundGroupMonsterCountDic[roomID] += num;
		}
		else
		{
			roundGroupMonsterCountDic.Add(roomID, num);
		}
	}

	private void ResetData()
	{
		finishGroupIds = new List<int>();
		finishConditions = new List<int>();
		trapEntityList = new Dictionary<int, int>();
	}

	private void Next(int roomID, int roundId)
	{
		if (NextIsValid(roomID, roundId))
		{
			RoundPreparation(roomID, roundId);
			return;
		}
		condition.Remove(roomID);
		finishConditions.Add(roomID);
		if (condition.Count == 0)
		{
			CurStage++;
			if (activityMapDataRound != null)
			{
				world.GetSystem<RoomSystem>().ReleseAllRoomEntityExHero();
				ResetAllHeroPosition();
				RoundPreparation();
			}
			else
			{
				world.GameSettlement(GameSettlementType.MonsterDead);
			}
		}
		else if (roundGroupMonsterCountDic[roomID] == 0)
		{
			finishGroupIds.Add(roomID);
		}
	}

	private bool NextIsValid(int roomID, int roundId)
	{
		if (activityMapDataRound.Count <= roomID)
		{
			return false;
		}
		if (activityMapDataRound[roomID].rounds.Count <= roundId)
		{
			return false;
		}
		return true;
	}

	private void ResetAllHeroPosition()
	{
		foreach (KeyValuePair<int, BaseEntity> heroEntity in heroEntityList)
		{
			SetHeroPos(heroEntity.Key, heroEntity.Value);
		}
	}

	private void OnMonsterEntityDead(BaseEntity entity, bool isNormal)
	{
		GetSystem<RoomSystem>().OnMonsterEntityDead(entity);
		if (!monsterBelongGoundGroupDic.TryGetValue(entity.Id, out var value))
		{
			return;
		}
		if (condition.TryGetValue(value, out var value2) && value2.changeType == ActivityMapDataRoundChangeType.Kill)
		{
			value2.value--;
		}
		if (!roundGroupMonsterCountDic.TryGetValue(value, out var _))
		{
			return;
		}
		roundGroupMonsterCountDic[value]--;
		if (roundGroupMonsterCountDic[value] != 0 || condition.TryGetValue(value, out var _))
		{
			return;
		}
		for (int i = 0; i < finishConditions.Count; i++)
		{
			if (finishConditions[i] == value)
			{
				finishGroupIds.Add(value);
			}
		}
	}

	public async UniTask<bool> LoadBattleSceneMapData(GameResourceSystem resourceSystem, GameObject worldRoot)
	{
		return true;
	}

	public override void OnDispose()
	{
		base.OnDispose();
		roundGroupMonsterCountDic?.Clear();
		monsterBelongGoundGroupDic?.Clear();
		condition?.Clear();
		finishConditions?.Clear();
		finishGroupIds?.Clear();
		cacheNextRound?.Clear();
		trapEntityList?.Clear();
		roundGroupMonsterCountDic = null;
		monsterBelongGoundGroupDic = null;
		condition = null;
		finishConditions = null;
		finishGroupIds = null;
		cacheNextRound = null;
		trapEntityList = null;
	}
}
