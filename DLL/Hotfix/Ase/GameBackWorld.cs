#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Ase.ECS;
using Cysharp.Threading.Tasks;
using GameFramework;
using UnityEngine;

namespace Ase;

public class GameBackWorld : WorldBase
{
	private int _teamSurvivalNumber;

	private CreateCopyData _createCopyData;

	private CheckBattleResult battleResult;

	private int maxFrame;

	private Dictionary<int, bool> _recodeTeamDeadState = new Dictionary<int, bool>();

	public override bool IsNeedExecuteViewSystem => true;

	public override int ActorId => LocalActorId;

	public override BattleWorldMode BattleWorldMode => BattleWorldMode.SyncBattle;

	public override bool TestingWorld => false;

	protected override void OnAccountDisconnect(int disconnectReason)
	{
	}

	public GameBackWorld(string worldName, GameObject worldRoot, WorldData worldData)
		: base(worldName, worldRoot, worldData)
	{
		_createCopyData = new CreateCopyData();
		_teamSurvivalNumber = worldData.TeamListConfig.Count;
		LRandom = LRandom.New(worldData.RandomSeed);
		GameBackWorldData gameBackWorldData = worldData as GameBackWorldData;
		if (gameBackWorldData.GlobalBattleFrameList != null)
		{
			maxFrame = gameBackWorldData.GlobalBattleFrameList[gameBackWorldData.GlobalBattleFrameList.Count - 1].Tick;
			GetSystem<GameBackCommandSystem>().SetMaxFrame(maxFrame);
			for (int i = 0; i < gameBackWorldData.GlobalBattleFrameList.Count; i++)
			{
				GetSystem<GameBackCommandSystem>().ReceiveBattleFrameResponse(gameBackWorldData.GlobalBattleFrameList[i]);
			}
		}
		battleResult = new CheckBattleResult(this, worldData.RoomId);
	}

	public override async UniTask<bool> GamePreparation(WorldData worldData)
	{
		_ = 2;
		try
		{
			if (!(worldData is GameBackWorldData gameBackWorldData))
			{
				Log.Error("初始化 GameBackWorld 错误 ： lockstepBattleWorldData == null");
				return false;
			}
			if (!(await OnEnter(worldData)))
			{
				return false;
			}
			if (!(await _createCopyData.LoadBattleSceneMapData(gameBackWorldData.MapDataName, GetSystem<GameResourceSystem>(), worldRoot)))
			{
				return false;
			}
			if (!RoundHeroPreparation(gameBackWorldData))
			{
				return false;
			}
			if (!RoundMonsterPreparation(gameBackWorldData.BossId))
			{
				return false;
			}
			if (!RoundInteractivePreparation())
			{
				return false;
			}
			if (!(await OnGamePreparationEnd(gameBackWorldData)))
			{
				return false;
			}
			return true;
		}
		catch (Exception ex)
		{
			Log.Error("GamePreparation失败 " + ex.Message + " / " + ex.StackTrace);
			return false;
		}
	}

	protected override void FixedLoop(float deltaTime)
	{
		tick++;
		VerityServerFrameData serverCommand = GetSystem<GameBackCommandSystem>().GetServerCommand(tick);
		if (tick >= maxFrame)
		{
			GameSettlement(GameSettlementType.BattleOver);
		}
		else
		{
			if (serverCommand == null || IsBattleSettlement)
			{
				return;
			}
			foreach (MsgPlayerInput value in serverCommand.FrameInputData.Values)
			{
				GetSystem<EntitySystem>().ExecuteServer(value.Actor, value);
			}
			GetCurrentGameSpeedInfo();
			FixedLoop(WorldUpdateType.All, base.IntervalTimer);
			Physics.SyncTransforms();
			UpdateGameSpeedInfo();
			ReferencePool.Release(serverCommand);
		}
	}

	private bool RoundHeroPreparation(GameBackWorldData worldData)
	{
		if (worldData.TeamListConfig.IsNullOrEmpty())
		{
			Log.Error("队伍配置错误!");
			return false;
		}
		for (int i = 0; i < worldData.TeamListConfig.Count; i++)
		{
			PeripheryHeroData heroModel = worldData.TeamListConfig[i];
			DRHero dataRow = GameEntry.DataTable.GetDataRow<DRHero>(heroModel.Id);
			if (dataRow == null)
			{
				Log.Error($"没有找到Id = {worldData.TeamListConfig[i].Id} 的英雄配置..");
				return false;
			}
			ScenePoint heroBornPoint = _createCopyData.GetHeroBornPoint("Default", i);
			if (heroBornPoint == null)
			{
				Log.Error("初始化失败： 缺少地图信息...");
				return false;
			}
			GetSystem<ParadoxSystem>().CacheParadoxTreeObj(dataRow.AIParadoxId);
			GameObject entityObject = null;
			if (IsNeedExecuteViewSystem)
			{
				entityObject = GetSystem<EntityViewCacheSystem>().LoadEntityView(worldData.TeamListConfig[i].Id, dataRow.AssetPath);
			}
			HeroEntity heroEntity = GetSystem<EntitySystem>().CreateServerEntity<HeroEntity>(worldData.TeamListConfig[i].SeatId, worldData.TeamListConfig[i].Id, new EntityData
			{
				pointData = new EntityPositionData
				{
					position = heroBornPoint.transform.position,
					scale = Vector3.one,
					rotation = heroBornPoint.transform.rotation.eulerAngles
				},
				entityObject = entityObject,
				updateType = EntityUpdateType.Local,
				logicType = EntityLogicType.None,
				collisionLayer = CollisionSetting.CollisionLayer.Hero,
				collisionMass = 2,
				userData = worldData.TeamListConfig[i]
			});
			heroEntity.BattleHeroData.IsSelf = i == worldData.SelfIndex;
			if (heroEntity.BattleHeroData.IsSelf)
			{
				SetActorId(heroEntity);
				LockstepData.Instance?.InitData(ActorId, worldData.RoomId, worldData.TeamListConfig.Count, 1104);
				LockstepData.Instance?.WriteAuthorityEntityId($"随机数 = {worldData.RandomSeed}", heroEntity);
			}
			if (heroModel.isRobot)
			{
				heroEntity.SetRobot(robot: true);
			}
			int index = (worldData.TeamMemberList?.Find((TeamMember b) => b.HeroModel != null && b.HeroModel.Id == heroModel.Id))?.MemberId ?? (i + 1);
			GetSystem<BattleSystem>().InitHeroData(index, heroEntity, worldData.TeamListConfig.Count);
		}
		GetSystem<BattleSystem>().InitHeroComplete();
		return true;
	}

	private bool RoundMonsterPreparation(int monsterId)
	{
		DRMonsterAttr dataRow = GameEntry.DataTable.GetDataRow<DRMonsterAttr>(monsterId);
		if (dataRow == null)
		{
			Log.Error($"没有找到怪物编号 = {monsterId}的怪物配置..");
			return false;
		}
		DRMonster dataRow2 = GameEntry.DataTable.GetDataRow<DRMonster>(dataRow.MonsterType);
		if (dataRow2 == null)
		{
			Log.Error($"没有找到怪物种类 = {dataRow.MonsterType}的怪物配置..");
			return false;
		}
		ScenePoint scenePoint = _createCopyData.GetScenePoint();
		if (scenePoint == null)
		{
			Log.Error("初始化失败： 缺少地图信息...");
			return false;
		}
		GameObject entityObject = GetSystem<EntityViewCacheSystem>().LoadEntityView(dataRow2.Id, dataRow2.AssetPath);
		MonsterEntity monsterEntity = GetSystem<EntitySystem>().CreateEntity<MonsterEntity>(dataRow2.Id, new EntityData
		{
			pointData = new EntityPositionData
			{
				position = scenePoint.transform.position,
				scale = Vector3.one,
				rotation = scenePoint.transform.rotation.eulerAngles
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
		GetSystem<BattleInfoSystem>()?.SetBattleTimeConfig(monsterEntity?.MonsterAttrConfig.BattleDuration ?? 360);
		return true;
	}

	private void OnMonsterEntityDead(BaseEntity entity, bool isNormal)
	{
		GameSettlement(GameSettlementType.MonsterDead);
	}

	private bool RoundInteractivePreparation()
	{
		foreach (InteractiveData interactiveDatum in _createCopyData.GetInteractiveData())
		{
			DRMapItem dataRow = GameEntry.DataTable.GetDataRow<DRMapItem>(interactiveDatum.InteractiveId);
			if (dataRow == null)
			{
				Log.Error($"没有找到编号 = {interactiveDatum.InteractiveId}的交互物配置..");
				return false;
			}
			GetSystem<ParadoxSystem>().CacheParadoxTreeObj(dataRow.AIParadoxId);
			GameObject entityObject = GetSystem<EntityViewCacheSystem>().LoadEntityView(interactiveDatum.InteractiveId, dataRow.AssetPath);
			GetSystem<EntitySystem>().CreateEntity<SyncBattleInteractiveEntity>(interactiveDatum.InteractiveId, new EntityData
			{
				pointData = new EntityPositionData
				{
					position = interactiveDatum.point,
					scale = Vector3.one,
					rotation = interactiveDatum.rotation
				},
				entityObject = entityObject,
				userData = dataRow,
				updateType = EntityUpdateType.Authority,
				logicType = EntityLogicType.None
			});
		}
		return true;
	}

	public override void OnHeroCantRevived(int entityId)
	{
		if (!_recodeTeamDeadState.ContainsKey(entityId))
		{
			_recodeTeamDeadState.Add(entityId, value: false);
			_teamSurvivalNumber--;
			if (_teamSurvivalNumber == 0)
			{
				GameSettlement(GameSettlementType.HeroDead);
			}
		}
	}

	public override async void GameSettlement(GameSettlementType gameSettlementType)
	{
		if (!IsBattleSettlement)
		{
			GameBackResult = battleResult.Check(_recodeTeamDeadState.Count);
			IsBattleSettlement = true;
			LockstepData.Instance?.SyncSave();
			await UniTask.Delay(1000);
			Singleton<GameSystem>.Instance.DestroyWorldChannel(this);
			Game.RemoveSingleton<GameSystem>();
			Game.RemoveSingleton<OuterSystem>();
		}
	}

	public override void Shutdown()
	{
		base.Shutdown();
		_createCopyData?.Clear();
		_createCopyData = null;
		if (_recodeTeamDeadState != null)
		{
			_recodeTeamDeadState.Clear();
			_recodeTeamDeadState = null;
		}
	}

	public override CreateCopyData GetMapData()
	{
		return _createCopyData;
	}

	protected override Type[] GetSystemTypes()
	{
		return new Type[38]
		{
			typeof(RoomSystem),
			typeof(SceneSystem),
			typeof(PathfindingSystem),
			typeof(InputSystem),
			typeof(MonsterAttackSystem),
			typeof(CommandSystem),
			typeof(EntityViewCacheSystem),
			typeof(WeaknessSystem),
			typeof(ParadoxSystem),
			typeof(EntitySystem),
			typeof(KinematicCharacterSystem),
			typeof(CameraSystem),
			typeof(VirtualCameraSystem),
			typeof(EffectSystem),
			typeof(PostProcessEffectSystem),
			typeof(HitSystem),
			typeof(BattleSystem),
			typeof(BattleInfoSystem),
			typeof(BuffSystem),
			typeof(UIDamageTextSystem),
			typeof(HealthBarsSystem),
			typeof(WeaknessBarSystem),
			typeof(VolumeSystem),
			typeof(BulletSystem),
			typeof(TouchSystem),
			typeof(SkillIndicatorSystem),
			typeof(WarningIndicatorSystem),
			typeof(FrameFrozenSystem),
			typeof(GameBackCommandSystem),
			typeof(AlertHitInfoSystem),
			typeof(MultiPlayerSystem),
			typeof(MechanismCacheSystem),
			typeof(BattleObserverSystem),
			typeof(BattleDamageProgressSystem),
			typeof(BattleStateSystem),
			typeof(GameResourceSystem),
			typeof(EntityAudioSystem),
			typeof(TeachGuideSystem)
		};
	}
}
