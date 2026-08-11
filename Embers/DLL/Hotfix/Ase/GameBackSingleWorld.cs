#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Ase.ECS;
using Cysharp.Threading.Tasks;
using GameFramework;
using UnityEngine;

namespace Ase;

public class GameBackSingleWorld : WorldBase
{
	protected CreateCopyData _createCopyData;

	private CheckBattleResult battleResult;

	private int maxFrame;

	private Dictionary<int, bool> _recodeTeamDeadState = new Dictionary<int, bool>();

	public override bool IsNeedExecuteViewSystem => true;

	public override int ActorId => LocalActorId;

	public override BattleWorldMode BattleWorldMode => BattleWorldMode.SingleBattle;

	public override bool TestingWorld => false;

	protected override void OnAccountDisconnect(int disconnectReason)
	{
	}

	public GameBackSingleWorld(string worldName, GameObject worldRoot, WorldData worldData)
		: base(worldName, worldRoot, worldData)
	{
		_createCopyData = new CreateCopyData();
		LRandom = LRandom.New(worldData.RandomSeed);
		GameBackWorldData gameBackWorldData = worldData as GameBackWorldData;
		if (gameBackWorldData.OneBattleFrameMessage != null)
		{
			maxFrame = gameBackWorldData.OneBattleFrameMessage[gameBackWorldData.OneBattleFrameMessage.Count - 1].Tick;
			GetSystem<GameBackCommandSystem>().SetMaxFrame(maxFrame);
			for (int i = 0; i < gameBackWorldData.OneBattleFrameMessage.Count; i++)
			{
				GetSystem<GameBackCommandSystem>().ReceiveBattleFrameResponse(gameBackWorldData.OneBattleFrameMessage[i]);
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
			if (string.IsNullOrEmpty(gameBackWorldData.MapDataName))
			{
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
		if (tick > maxFrame)
		{
			GameSettlement(GameSettlementType.BattleOver);
			return;
		}
		if (serverCommand != null)
		{
			foreach (MsgPlayerInput value in serverCommand.FrameInputData.Values)
			{
				if (value.Actor == LocalActorId)
				{
					GetSystem<EntitySystem>().ExecuteServer(value.Actor, value);
				}
			}
			foreach (SingleBattleFrameMessage item in serverCommand.FrameAIData?.Values)
			{
				if (item.Actor != LocalActorId)
				{
					GetSystem<EntitySystem>().GetEntity(item.Actor).GetComponent<AIParadoxComponent>().SetVariableValues(item.ParadoxParamKey, item.ParadoxParamValue == 1);
				}
			}
		}
		GetCurrentGameSpeedInfo();
		FixedLoop(WorldUpdateType.All, deltaTime);
		Physics.SyncTransforms();
		UpdateGameSpeedInfo();
		if (serverCommand != null)
		{
			ReferencePool.Release(serverCommand);
		}
	}

	protected bool RoundHeroPreparation(GameBackWorldData worldData)
	{
		if (worldData.TeamListConfig.IsNullOrEmpty())
		{
			Log.Error("队伍配置错误!");
			return false;
		}
		for (int i = 0; i < worldData.TeamListConfig.Count; i++)
		{
			DRHero dataRow = GameEntry.DataTable.GetDataRow<DRHero>(worldData.TeamListConfig[i].Id);
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
			GameObject entityObject = null;
			if (IsNeedExecuteViewSystem)
			{
				entityObject = GetSystem<EntityViewCacheSystem>().LoadEntityView(worldData.TeamListConfig[i].Id, dataRow.AssetPath);
			}
			HeroEntity heroEntity = GetSystem<EntitySystem>().CreateEntity<HeroEntity>(worldData.TeamListConfig[i].Id, new EntityData
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
			heroEntity.BattleHeroData.IsSelf = i == 0;
			if (heroEntity.BattleHeroData.IsSelf)
			{
				SetActorId(heroEntity);
				LockstepData.Instance?.InitData(ActorId, worldData.RoomId, worldData.TeamListConfig.Count, heroEntity.Id);
				LockstepData.Instance?.WriteAuthorityEntityId($"随机数 = {worldData.RandomSeed}", heroEntity);
			}
			heroEntity.SetAi(i != 0);
			GetSystem<BattleSystem>().InitHeroData(i + 1, heroEntity, worldData.TeamListConfig.Count);
			GetSystem<RoomSystem>().AddToRoomEntity(heroEntity);
		}
		GetSystem<BattleSystem>().InitHeroComplete();
		return true;
	}

	protected virtual bool RoundMonsterPreparation(int monsterId)
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
		GameObject entityObject = null;
		if (IsNeedExecuteViewSystem)
		{
			entityObject = GetSystem<EntityViewCacheSystem>().LoadEntityView(dataRow2.Id, dataRow2.AssetPath);
		}
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

	protected void OnMonsterEntityDead(BaseEntity entity, bool isNormal)
	{
		GameSettlement(GameSettlementType.MonsterDead);
	}

	protected virtual bool RoundInteractivePreparation()
	{
		foreach (InteractiveData interactiveDatum in _createCopyData.GetInteractiveData())
		{
			DRMapItem dataRow = GameEntry.DataTable.GetDataRow<DRMapItem>(interactiveDatum.InteractiveId);
			if (dataRow == null)
			{
				Log.Error($"没有找到编号 = {interactiveDatum.InteractiveId}的交互物配置..");
				return false;
			}
			GameObject entityObject = null;
			if (IsNeedExecuteViewSystem)
			{
				entityObject = GetSystem<EntityViewCacheSystem>().LoadEntityView(interactiveDatum.InteractiveId, dataRow.AssetPath);
			}
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
		}
		GameSettlement(GameSettlementType.HeroDead);
	}

	public override async void GameSettlement(GameSettlementType gameSettlementType)
	{
		if (!IsBattleSettlement)
		{
			GameBackResult = battleResult.Check(_recodeTeamDeadState.Count);
			IsBattleSettlement = true;
			LockstepData.Instance?.SyncSave();
			await UniTask.Delay(100);
			Singleton<GameSystem>.Instance.DestroyWorldChannel(this);
			Game.RemoveSingleton<GameSystem>();
			Game.RemoveSingleton<OuterSystem>();
		}
	}

	public override CreateCopyData GetMapData()
	{
		return _createCopyData;
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

	protected override Type[] GetSystemTypes()
	{
		return new Type[41]
		{
			typeof(RoomSystem),
			typeof(SceneSystem),
			typeof(PathfindingSystem),
			typeof(BattleSystem),
			typeof(InputSystem),
			typeof(TouchSystem),
			typeof(CommandSystem),
			typeof(MonsterAttackSystem),
			typeof(WeaknessSystem),
			typeof(EntityViewCacheSystem),
			typeof(ParadoxSystem),
			typeof(EntitySystem),
			typeof(KinematicCharacterSystem),
			typeof(SkillTimeLineSystem),
			typeof(CameraSystem),
			typeof(VirtualCameraSystem),
			typeof(EffectSystem),
			typeof(PostProcessEffectSystem),
			typeof(HitSystem),
			typeof(UIDamageTextSystem),
			typeof(HealthBarsSystem),
			typeof(WeaknessBarSystem),
			typeof(VolumeSystem),
			typeof(BulletSystem),
			typeof(BuffSystem),
			typeof(SkillIndicatorSystem),
			typeof(WarningIndicatorSystem),
			typeof(FrameFrozenSystem),
			typeof(AlertHitInfoSystem),
			typeof(MultiPlayerSystem),
			typeof(AchievementSystem),
			typeof(BattleObserverSystem),
			typeof(BattleDamageProgressSystem),
			typeof(BattleStateSystem),
			typeof(GameResourceSystem),
			typeof(EntityAudioSystem),
			typeof(TeachGuideSystem),
			typeof(GameBackCommandSystem),
			typeof(BattleInfoSystem),
			typeof(ActivityRoundBattleSystem),
			typeof(ParadoxTimelineSystem)
		};
	}
}
