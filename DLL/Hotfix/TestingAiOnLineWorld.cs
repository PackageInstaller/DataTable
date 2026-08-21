#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Ase;
using Ase.ECS;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Resource;
using Sirenix.Utilities;
using UnityEngine;

public class TestingAiOnLineWorld : WorldBase
{
	private CreateCopyData _createCopyData;

	private string _screenName;

	public override bool IsNeedExecuteViewSystem => true;

	public override int ActorId => LocalActorId;

	public override BattleWorldMode BattleWorldMode => BattleWorldMode.SyncBattle;

	public override bool TestingWorld => true;

	public TestingAiOnLineWorld(string worldName, GameObject worldRoot, WorldData worldData)
		: base(worldName, worldRoot, worldData)
	{
		_createCopyData = new CreateCopyData();
		LRandom = LRandom.New(worldData.RandomSeed);
	}

	public override void GameStart()
	{
		GetSystem<SceneSystem>()?.PlayBGM();
		base.GameStart();
	}

	public override async UniTask<bool> GamePreparation(WorldData worldData)
	{
		_ = 2;
		try
		{
			if (!(worldData is BattleWorldData battleWorldData))
			{
				Log.Error("初始化 TestingAiOnLineWorld 失败：缺少 BattleWorldData...");
				return false;
			}
			if (!(await OnEnter(worldData)))
			{
				return false;
			}
			if (!(await _createCopyData.LoadBattleSceneMapData(battleWorldData.MapDataName, GetSystem<GameResourceSystem>(), worldRoot)))
			{
				return false;
			}
			if (!RoundHeroPreparation(worldData, base.BattleConfig.TeamRebornValue))
			{
				return false;
			}
			if (!RoundMonsterPreparation(battleWorldData.BossId))
			{
				return true;
			}
			if (!RoundInteractivePreparation())
			{
				return false;
			}
			if (!(await OnGamePreparationEnd(battleWorldData)))
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
		MsgPlayerInput framePlayerInput = GetFramePlayerInput(deltaTime);
		if (framePlayerInput != null)
		{
			ExecuteOptionHeroCommand(framePlayerInput);
		}
		FixedLoop(WorldUpdateType.All, deltaTime);
		Physics.SyncTransforms();
		if (framePlayerInput != null)
		{
			ReferencePool.Release(framePlayerInput);
		}
	}

	private bool RoundHeroPreparation(WorldData worldData, int teamRebornValue)
	{
		List<PeripheryHeroData> teamListConfig = worldData.TeamListConfig;
		if (teamListConfig.IsNullOrEmpty())
		{
			Log.Error("队伍配置错误!");
			return false;
		}
		for (int i = 0; i < teamListConfig.Count; i++)
		{
			PeripheryHeroData heroModel = teamListConfig[i];
			if (heroModel == null)
			{
				Log.Error("队伍配置错误!");
				return false;
			}
			DRHero dataRow = GameEntry.DataTable.GetDataRow<DRHero>(heroModel.Id);
			if (dataRow == null)
			{
				Log.Error($"没有找到Id = {heroModel.Id} 的英雄配置..");
				return false;
			}
			ScenePoint heroBornPoint = _createCopyData.GetHeroBornPoint("Default", i);
			if (heroBornPoint == null)
			{
				return false;
			}
			GameObject gameObject = GetSystem<EntityViewCacheSystem>().LoadEntityView(dataRow.Id, dataRow.AssetPath);
			if (gameObject == null)
			{
				return false;
			}
			HeroEntity heroEntity = GetSystem<EntitySystem>().CreateEntity<HeroEntity>(heroModel.Id, new EntityData
			{
				pointData = new EntityPositionData
				{
					position = heroBornPoint.transform.position,
					scale = Vector3.one,
					rotation = heroBornPoint.transform.rotation.eulerAngles
				},
				entityObject = gameObject,
				updateType = EntityUpdateType.Local,
				logicType = EntityLogicType.None,
				collisionLayer = CollisionSetting.CollisionLayer.Hero,
				collisionMass = 2,
				userData = heroModel
			});
			if (i == 0)
			{
				SetActorId(heroEntity);
				LockstepData.Instance?.InitData(ActorId, 1001L, teamListConfig.Count, heroEntity.EntityId);
			}
			heroEntity.SetAi(memberIsAi: false);
			heroEntity.GetComponent<AutoFightCompment>()?.SetFreedomBattleMode(isFreedomBattle: true, changeAutoFightIcon: false);
			heroEntity.BattleHeroData.IsSelf = i == 0;
			TeamMember obj = worldData.TeamMemberList?.Find((TeamMember b) => b.HeroModel != null && b.HeroModel.Id == heroModel.Id);
			if (obj == null)
			{
				Log.Error($"未找到TeamMember数据 Id:{heroModel.Id}");
			}
			int index = obj?.MemberId ?? (i + 1);
			GetSystem<BattleSystem>().InitHeroData(index, heroEntity, teamRebornValue);
		}
		GetSystem<BattleSystem>().InitMutilHeroComplete();
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
		GetSystem<BattleSystem>().InitMonsterEntity(monsterEntity);
		return true;
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
			}).SetData(Constant.InteractiveConstant.INTERACTIVE_NAME, interactiveDatum.InteractiveName);
		}
		return true;
	}

	public override void OnHeroCantRevived(int entityId)
	{
		GameSettlement(GameSettlementType.HeroDead);
	}

	private void OnMonsterEntityDead(BaseEntity entity, bool isNormal)
	{
		GameSettlement(GameSettlementType.MonsterDead);
	}

	public override async void GameSettlement(GameSettlementType gameSettlementType)
	{
		base.GameSettlement(gameSettlementType);
		LockstepData.Instance?.SyncSave();
		await UniTask.Delay(3000);
		GamePause();
		Singleton<GameSystem>.Instance.DestroyWorldChannel(this);
		Game.RemoveSingleton<GameSystem>();
		Game.RemoveSingleton<OuterSystem>();
		bool unloadSceneFinish = false;
		UnloadSceneSuccessCallback unloadSceneSuccessCallback = delegate
		{
			unloadSceneFinish = true;
		};
		UnloadSceneFailureCallback unloadSceneFailureCallback = delegate
		{
			unloadSceneFinish = true;
		};
		GameEntry.Scene.UnloadScene("Assets/Art/Scenes/" + base.SceneLoadPath + ".unity", new UnloadSceneCallbacks(unloadSceneSuccessCallback, unloadSceneFailureCallback));
		await UniTask.WaitUntil(() => unloadSceneFinish);
		await GameEntry.UI.OpenWindow<ModeSelectionWindow>("Test/ModeSelectionWindow", new ModeSelectionViewModel());
	}

	protected override void OnAccountDisconnect(int disconnectReason)
	{
		try
		{
			Singleton<GameSystem>.Instance.DestroyWorldChannel(this);
			Game.RemoveSingleton<GameSystem>();
		}
		catch (Exception)
		{
		}
		Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().BacktiTitle(base.SceneLoadPath);
	}

	public override void Shutdown()
	{
		base.Shutdown();
		_createCopyData?.Clear();
		_createCopyData = null;
	}

	public override CreateCopyData GetMapData()
	{
		return _createCopyData;
	}

	protected override Type[] GetSystemTypes()
	{
		return new Type[37]
		{
			typeof(SceneSystem),
			typeof(PathfindingSystem),
			typeof(BattleSystem),
			typeof(InputSystem),
			typeof(TouchSystem),
			typeof(CommandSystem),
			typeof(MonsterAttackSystem),
			typeof(WeaknessSystem),
			typeof(WeaknessBarSystem),
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
			typeof(ParadoxTimelineSystem)
		};
	}
}
