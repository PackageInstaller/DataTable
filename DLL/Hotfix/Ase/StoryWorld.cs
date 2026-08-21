#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Ase.ECS;
using Cysharp.Threading.Tasks;
using GameFramework;
using UnityEngine;

namespace Ase;

public class StoryWorld : WorldBase
{
	private readonly List<HeroEntity> heroEntities = new List<HeroEntity>();

	private List<PeripheryHeroData> originTeamConfig = new List<PeripheryHeroData>();

	private int bossCount;

	private BlackScreen blackScreen;

	protected SceneSystem sceneSystem;

	private int levelId;

	private float frameDeltaTime;

	private bool updateFlag;

	private bool worldDestory;

	public override bool IsStoryWorld => true;

	public override bool IsNeedExecuteViewSystem => true;

	public int LevelId => levelId;

	public override int ActorId => LocalActorId;

	public override BattleWorldMode BattleWorldMode => BattleWorldMode.LevelBattle;

	public override bool TestingWorld => false;

	public StoryWorld(string worldName, GameObject worldRoot, WorldData worldData)
		: base(worldName, worldRoot, worldData)
	{
		if (!(worldData is LevelWorldData levelWorldData))
		{
			Log.Error("StoryWorld 初始化失败 ：LevelWorldData == null...");
			return;
		}
		sceneSystem = GetSystem<SceneSystem>();
		LRandom = LRandom.New(UnityEngine.Random.Range(0, 100));
		levelId = levelWorldData.LevelId;
		CreateWorldEntity();
		GetSystem<AchievementSystem>()?.InitAchievementAction(worldData.BattleAchievementMedalList);
	}

	public override async UniTask<bool> GamePreparation(WorldData worldData)
	{
		blackScreen = await BlackScreen.Show("LEVELlLOADBLACKSCREENGROUP");
		await new WaitForSecondsRealtime(1f);
		if (!(worldData is LevelWorldData levelWorldData))
		{
			Log.Error("StoryWorld 初始化失败 ：LevelWorldData == null...");
			return false;
		}
		GetFirstLevelActiveBonfire(levelWorldData);
		if (!(await OnEnter(worldData)))
		{
			return false;
		}
		if (!(await RoundHeroPreparation(levelWorldData)))
		{
			return false;
		}
		if (!(await OnGamePreparationEnd(levelWorldData)))
		{
			return false;
		}
		return true;
	}

	protected override void FixedLoop(float deltaTime)
	{
		updateFlag = true;
		frameDeltaTime += deltaTime;
	}

	public override void Update(float deltaTime)
	{
		if (updateFlag)
		{
			updateFlag = false;
			tick++;
			ExecuteAISkillCommand();
			MsgPlayerInput framePlayerInput = GetFramePlayerInput(deltaTime);
			if (framePlayerInput != null)
			{
				ExecuteOptionHeroCommand(framePlayerInput);
			}
			GetCurrentGameSpeedInfo();
			FixedLoop(WorldUpdateType.All, frameDeltaTime);
			Singleton<MathTriggerSystem>.Instance?.OnUpdate();
			Physics.SyncTransforms();
			if (framePlayerInput != null)
			{
				ReferencePool.Release(framePlayerInput);
			}
			frameDeltaTime = 0f;
			UpdateGameSpeedInfo();
		}
		base.Update(deltaTime);
	}

	public override async void GameStart()
	{
		await GetSystem<TaskSystem>().ChapterStartUI();
		await UniTask.Yield();
		if (blackScreen != null)
		{
			blackScreen.Dispose();
			await new WaitForSecondsRealtime(1f);
		}
		if (sceneSystem != null)
		{
			await sceneSystem.LevelStart();
			if (!worldDestory)
			{
				base.GameStart();
				Singleton<MathTriggerSystem>.Instance?.OnStart();
			}
		}
	}

	public override void Shutdown()
	{
		if (blackScreen != null)
		{
			blackScreen.Dispose();
		}
		base.Shutdown();
		worldDestory = true;
	}

	private async UniTask<bool> RoundHeroPreparation(LevelWorldData worldData)
	{
		for (int i = 0; i < worldData.TeamListConfig.Count; i++)
		{
			PeripheryHeroData peripheryHeroData = worldData.TeamListConfig[i];
			DRHero dataRow = GameEntry.DataTable.GetDataRow<DRHero>(peripheryHeroData.Id);
			if (dataRow == null)
			{
				Log.Error($"没有找到Id = {worldData.TeamListConfig[i].Id} 的英雄配置..");
				return false;
			}
			GameObject entityObject = await GetSystem<EntityViewCacheSystem>().AsyncLoadEntityView(worldData.TeamListConfig[i].Id, GetSkinAssetPath(peripheryHeroData, dataRow));
			ScenePoint scenePoint = sceneSystem.GetHeroBornPoint(worldData.BonfireKey, i);
			if (scenePoint == null)
			{
				scenePoint = new GameObject("临时出生点").AddComponent<ScenePoint>();
				scenePoint.transform.SetParent(((Component)(object)sceneSystem.GetLevelMapData())?.transform);
			}
			HeroEntity heroEntity = GetSystem<EntitySystem>().CreateEntity<HeroEntity>(worldData.TeamListConfig[i].Id, new EntityData
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
				collisionLayer = CollisionSetting.CollisionLayer.Hero,
				collisionMass = 2,
				userData = worldData.TeamListConfig[i]
			});
			if (i == 0)
			{
				LocalActorId = heroEntity.Id;
				GetSystem<CameraSystem>().BindTargetEntity(heroEntity);
			}
			heroEntity.SetAi(i != 0);
			heroEntity.BattleHeroData.IsSelf = i == 0;
			GetSystem<BattleSystem>().InitHeroData(i + 1, heroEntity, 0);
			heroEntities.Add(heroEntity);
			originTeamConfig.Add(heroEntity.BattleHeroData.HeroModel);
		}
		GetSystem<BattleSystem>().InitHeroComplete();
		return true;
	}

	private void GetFirstLevelActiveBonfire(LevelWorldData worldData)
	{
		if (worldData.LevelId != 100 || Singleton<ServiceSystem>.Instance.GetService<ISOService>().CheckGuideComplete())
		{
			return;
		}
		List<int> bonfireActiveList = Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().GetBonfireActiveList(100);
		int num = int.Parse(worldData.BonfireKey);
		if (bonfireActiveList != null && bonfireActiveList.Count > 0)
		{
			foreach (int item in bonfireActiveList)
			{
				if (item > num)
				{
					num = item;
				}
			}
		}
		worldData.BonfireKey = num.ToString();
		sceneSystem.UpdateBonfireBornPoint(worldData.BonfireKey);
	}

	public override void OnHeroCantRevived(int entityId)
	{
		GetSystem<BattleSystem>().OnLevelFailed(entityDead: true);
	}

	public void OnBossCreate()
	{
		bossCount++;
	}

	public void OnBossRelease(bool closeBossBloodBar = false)
	{
		bossCount--;
		if (closeBossBloodBar)
		{
			GetSystem<BattleSystem>().SetBossMode(bossModel: false);
		}
	}

	private async UniTask StoryQuitTask(bool reprotData)
	{
		if (sceneSystem != null)
		{
			if (reprotData)
			{
				sceneSystem.ExitLevelDataReport();
			}
			sceneSystem.QuitLevel();
			await StoryQuitTask();
		}
	}

	public async UniTask StoryQuitTask()
	{
		await sceneSystem.CloseStreamer();
		if (this != null)
		{
			if (Singleton<Story>.Instance != null)
			{
				Singleton<Story>.Instance.StoryQuit();
			}
			Singleton<GameSystem>.Instance.DestroyWorldChannel(this);
			Game.RemoveSingleton<GameSystem>();
			Game.RemoveSingleton<MathTriggerSystem>();
		}
	}

	public override async void GameSettlement(GameSettlementType gameSettlementType)
	{
		switch (gameSettlementType)
		{
		case GameSettlementType.PlayerQuit:
		{
			GamePause();
			LoadingBackToMainViewModel loadingBackToMainViewModel = new LoadingBackToMainViewModel(base.SceneLoadPath, autoUnload: true, StoryQuitTask);
			DRLoadingTips randomLoadingTap = await Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().PrepareLoading(GameProcessType.Outer);
			loadingBackToMainViewModel.SetRandomLoadingTap(randomLoadingTap);
			await (await GameEntry.UI.LoadWindow<LoadingWindow>(AssetUtility.GetUIFormAsset("Loading/LoadingWindow"), "LOADING", loadingBackToMainViewModel)).DoShow();
			await UniTask.WaitUntil(() => loadingBackToMainViewModel.IsLoadingFinish);
			bool loadingSuccess = loadingBackToMainViewModel.LoadingSuccess;
			if (loadingBackToMainViewModel.LoadingSuccess)
			{
				loadingBackToMainViewModel.CloseLoading();
			}
			Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().LoadingEnd(loadingSuccess);
			break;
		}
		case GameSettlementType.TimeOver:
			GetSystem<BattleSystem>().OnLevelFailed(entityDead: false);
			break;
		}
	}

	protected override void OnAccountDisconnect(int disconnectReason)
	{
		GamePause();
		Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().BacktiTitle(base.SceneLoadPath, StoryQuitTask);
	}

	public async Task RestTeam()
	{
		if (sceneSystem.GetIsInTeachGuideLevel())
		{
			return;
		}
		List<PeripheryHeroData> originTeam = GetOriginTeam();
		bool flag = true;
		for (int i = 0; i < heroEntities.Count; i++)
		{
			flag = originTeam.Contains(heroEntities[i].BattleHeroData.HeroModel);
			if (!flag)
			{
				break;
			}
		}
		if (!flag)
		{
			await GetSystem<BattleSystem>().SwitchTeam(originTeam, useBornFire: false, changeOriginTeam: false);
		}
	}

	public List<PeripheryHeroData> GetOriginTeam()
	{
		return originTeamConfig;
	}

	public List<int> GetOriginTeamIds()
	{
		List<int> list = new List<int>();
		foreach (PeripheryHeroData item in originTeamConfig)
		{
			list.Add(item.Id);
		}
		return list;
	}

	public void SwitchTeamClearData(bool changeOriginTeam)
	{
		heroEntities.Clear();
		if (changeOriginTeam)
		{
			originTeamConfig.Clear();
		}
	}

	public void SwitchTeamAddData(HeroEntity heroEntity, bool changeOriginTeam)
	{
		if (changeOriginTeam)
		{
			originTeamConfig.Add(heroEntity.BattleHeroData.HeroModel);
		}
		heroEntities.Add(heroEntity);
	}

	protected override Type[] GetSystemTypes()
	{
		return new Type[40]
		{
			typeof(SceneSystem),
			typeof(PathfindingSystem),
			typeof(InputSystem),
			typeof(TouchSystem),
			typeof(WeaknessSystem),
			typeof(WeaknessBarSystem),
			typeof(CommandSystem),
			typeof(EntityViewCacheSystem),
			typeof(ParadoxSystem),
			typeof(EntitySystem),
			typeof(KinematicCharacterSystem),
			typeof(CameraSystem),
			typeof(VirtualCameraSystem),
			typeof(EffectSystem),
			typeof(PostProcessEffectSystem),
			typeof(HitSystem),
			typeof(BattleSystem),
			typeof(MonsterAttackSystem),
			typeof(BuffSystem),
			typeof(UIDamageTextSystem),
			typeof(HealthBarsSystem),
			typeof(VolumeSystem),
			typeof(BulletSystem),
			typeof(SkillIndicatorSystem),
			typeof(TaskSystem),
			typeof(DropSystem),
			typeof(WarningIndicatorSystem),
			typeof(FrameFrozenSystem),
			typeof(AlertHitInfoSystem),
			typeof(MultiPlayerSystem),
			typeof(LevelCullingSystem),
			typeof(MechanismCacheSystem),
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

	public override void CreateWorldEntity()
	{
		base.CreateWorldEntity();
		WorldEntity = sceneSystem.GetSystem<EntitySystem>().CreateEntity<WorldEntity>(0, new EntityData
		{
			pointData = new EntityPositionData
			{
				position = Vector3.zero,
				scale = Vector3.zero,
				rotation = Vector3.zero
			},
			entityObject = null,
			userData = null,
			updateType = EntityUpdateType.Ignore,
			logicType = EntityLogicType.None,
			callbacks = null
		});
	}

	public override async void LoadOtherWorld(LoadingToOtherLevelViewModel loadingToOtherLevelViewModel)
	{
		if (!loadingToOtherLevelViewModel.CheckNeedLoading(levelId))
		{
			GetSystem<BattleSystem>().OnTeleport(loadingToOtherLevelViewModel.GetBornfireKey(), delegate
			{
				loadingToOtherLevelViewModel.CloseViews();
			});
			return;
		}
		string sceneLoadPath = sceneSystem.GetWorld().SceneLoadPath;
		BlackScreen blackScreen = await BlackScreen.Show("TIMELINE");
		await UniTask.WaitForSeconds(1);
		await StoryQuitTask(reprotData: true);
		await UniTask.WaitForSeconds(1);
		DRLoadingTips randomLoadingTap = await Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().PrepareLoading(GameProcessType.Story);
		loadingToOtherLevelViewModel.SetTeamList(originTeamConfig);
		loadingToOtherLevelViewModel.SetPreviousScene(sceneLoadPath);
		loadingToOtherLevelViewModel.SetRandomLoadingTap(randomLoadingTap);
		LoadingWindow obj = await GameEntry.UI.LoadWindow<LoadingWindow>(AssetUtility.GetUIFormAsset("Loading/LoadingWindow"), "LOADING", loadingToOtherLevelViewModel);
		blackScreen.Dispose();
		obj.DoShow(ignoreAnimation: true);
		await UniTask.WaitUntil(() => loadingToOtherLevelViewModel.IsLoadingFinish);
		bool loadingSuccess = loadingToOtherLevelViewModel.LoadingSuccess;
		if (loadingToOtherLevelViewModel.LoadingSuccess)
		{
			UIWindowHelper.WindowRelease();
			await loadingToOtherLevelViewModel.CloseLoading();
		}
		Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().LoadingEnd(loadingSuccess);
	}

	public override void MonsterAttrHandle(BaseEntity baseEntity, DRMonsterAttr drMonsterAttr, ref AttrAssignmentData data)
	{
		base.MonsterAttrHandle(baseEntity, drMonsterAttr, ref data);
		int worldLevel = GetSystem<SceneSystem>().GetPlayerRank();
		if (worldLevel != -1)
		{
			DRWorldLevel dataRow = GameEntry.DataTable.GetDataRow((DRWorldLevel dRWorldLevel) => dRWorldLevel.Monsterlevel == drMonsterAttr.MonsterLevel && dRWorldLevel.Worldlevel == worldLevel);
			if (dataRow != null)
			{
				data.Hp *= dataRow.HpRatio;
				data.Attack *= dataRow.AttackRatio;
				data.MaxTenacity *= dataRow.MaxTenacityRatio;
				data.BaseTough *= dataRow.BaseToughRatio;
				data.AtkLightLevel *= dataRow.AtkLightLevelRatio;
				data.HpLightLevel *= dataRow.HpLightLevelRatio;
			}
		}
	}

	public override CreateCopyData GetMapData()
	{
		return null;
	}
}
