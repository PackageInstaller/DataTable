#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Ase.ECS;
using Cysharp.Threading.Tasks;
using GameFramework;
using UnityEngine;
using UnityEngine.Pool;

namespace Ase;

public class NormalLockstepWorld : WorldBase
{
	private ServerCommandSystem _serverCommand;

	private int _teamSurvivalNumber;

	private bool _isExecuteServerCommand;

	private Dictionary<int, bool> _recodeTeamDeadState = new Dictionary<int, bool>();

	private uint _sendTick;

	private int _monsterTypeConfigId;

	private int _monsterId;

	private BattleVerificationData _battleVerificationData;

	private DataStorageOss _dataStorage;

	private const string _lockstepBucketMulti = "kiif-multifightbackdata";

	private const string BattlePlayerMaxDamageData = "-MaxDamage.txt";

	private CreateCopyData _createCopyData;

	private ActivityRoundBattleSystem roundBattleSystem;

	private CopyMapData _copyMapData;

	private Dictionary<int, float> maxDamageDic;

	public override bool IsNeedExecuteViewSystem => true;

	public override int ActorId => LocalActorId;

	public override BattleWorldMode BattleWorldMode => BattleWorldMode.SyncBattle;

	public override bool TestingWorld => false;

	public NormalLockstepWorld(string worldName, GameObject worldRoot, WorldData worldData)
		: base(worldName, worldRoot, worldData)
	{
		if (!(worldData is LockstepBattleWorldData lockstepBattleWorldData))
		{
			Log.Error("初始化 NormalLockstepWorld 错误 ： LockstepBattleWorldData == null...");
			return;
		}
		_createCopyData = new CreateCopyData();
		roundBattleSystem = GetSystem<ActivityRoundBattleSystem>();
		_teamSurvivalNumber = worldData.TeamListConfig.Count;
		if (_teamSurvivalNumber > 1)
		{
			_isExecuteServerCommand = true;
		}
		LRandom = LRandom.New(worldData.RandomSeed);
		GetSystem<AchievementSystem>()?.InitAchievementAction(worldData.BattleAchievementMedalList);
		_serverCommand = GetSystem<ServerCommandSystem>();
		GetSystem<KcpSocketSystem>().InitSocketData(lockstepBattleWorldData.Ip, lockstepBattleWorldData.Port, lockstepBattleWorldData.LocalConnectId);
		GetSystem<ServerCommandSystem>().SystemInit(lockstepBattleWorldData.LockStepWorldType, _isExecuteServerCommand, lockstepBattleWorldData.UserId, lockstepBattleWorldData.RoomKey, lockstepBattleWorldData.UpdateProgressAction, lockstepBattleWorldData.GameStartAction, lockstepBattleWorldData.LostConnectAction);
		InitBattleverification(worldData);
	}

	private void InitBattleverification(WorldData worldData)
	{
		if (worldData.IsBattleSend != 2 && worldData is LockstepBattleWorldData lockstepBattleWorldData)
		{
			_battleVerificationData = new BattleVerificationData(GameEntry.BuiltinData.VersionInfo, lockstepBattleWorldData.RoomId);
			_dataStorage = new DataStorageOss();
		}
	}

	public override async UniTask<bool> GamePreparation(WorldData worldData)
	{
		_ = 2;
		try
		{
			if (worldData is ActivityBattleWorldData activityBattleWorldData)
			{
				return await EnterActivityBattleWorld(activityBattleWorldData);
			}
			if (worldData is CampaignBattleWorldData campaignBattleWorldData)
			{
				return await EnterCampaignLockstepWorld(campaignBattleWorldData);
			}
			if (worldData is LockstepBattleWorldData worldData2)
			{
				return await EnterLockstepWorld(worldData2);
			}
			Log.Error("初始化 NormalLockstepWorld 错误 ： GamePreparation fail");
			return false;
		}
		catch (Exception ex)
		{
			Log.Error("GamePreparation失败 " + ex.Message + " / " + ex.StackTrace);
			return false;
		}
	}

	private async UniTask<bool> EnterActivityBattleWorld(ActivityBattleWorldData activityBattleWorldData)
	{
		if (!(await OnEnter(activityBattleWorldData)))
		{
			return false;
		}
		if (!(await roundBattleSystem.LoadBattleSceneMapData(GetSystem<GameResourceSystem>(), worldRoot)))
		{
			return false;
		}
		if (!roundBattleSystem.RoundHeroPreparation(activityBattleWorldData))
		{
			return false;
		}
		if (!roundBattleSystem.RoundPreparation())
		{
			return false;
		}
		if (!(await OnGamePreparationEnd(activityBattleWorldData)))
		{
			return false;
		}
		return true;
	}

	private async UniTask<bool> EnterCampaignLockstepWorld(CampaignBattleWorldData campaignBattleWorldData)
	{
		if (!(await OnEnter(campaignBattleWorldData)))
		{
			return false;
		}
		if (!(await GetSystem<CampaignBattleSystem>().LoadBattleSceneMapData(worldRoot)))
		{
			return false;
		}
		if (!GetSystem<CampaignBattleSystem>().RoundHeroPreparation(campaignBattleWorldData, campaignBattleWorldData.TeamListConfig.Count))
		{
			return false;
		}
		if (!RoundInteractivePreparation())
		{
			return false;
		}
		if (!(await OnGamePreparationEnd(campaignBattleWorldData)))
		{
			return false;
		}
		return true;
	}

	private async UniTask<bool> EnterLockstepWorld(WorldData worldData)
	{
		if (!(worldData is LockstepBattleWorldData lockstepBattleWorldData))
		{
			Log.Error("初始化 NormalLockstepWorld 错误 ： LockstepBattleWorldData == null...");
			return false;
		}
		if (!(await OnEnter(worldData)))
		{
			return false;
		}
		if (!(await _createCopyData.LoadBattleSceneMapData(lockstepBattleWorldData.MapDataName, GetSystem<GameResourceSystem>(), worldRoot)))
		{
			return false;
		}
		if (!RoundHeroPreparation(lockstepBattleWorldData))
		{
			return false;
		}
		if (!(await RoundMonsterPreparation(lockstepBattleWorldData.BossId)))
		{
			return false;
		}
		if (!RoundInteractivePreparation())
		{
			return false;
		}
		if (!(await OnGamePreparationEnd(lockstepBattleWorldData)))
		{
			return false;
		}
		return true;
	}

	protected override void FixedLoop(float deltaTime)
	{
		if (_serverCommand.KcpConnectSuccess && _serverCommand.BattleStart)
		{
			_ = KCPLog.Open;
			if (tick == 0)
			{
				tick++;
			}
			MsgPlayerInput msgPlayerInput = SendCommand(deltaTime);
			if (_isExecuteServerCommand)
			{
				ExecuteLockstep(deltaTime);
			}
			else
			{
				SingleExecute(deltaTime, msgPlayerInput);
			}
			if (msgPlayerInput != null)
			{
				ReferencePool.Release(msgPlayerInput);
			}
		}
	}

	private void ExecuteLockstep(float deltaTime)
	{
		for (int i = 0; i < _updateSpeed; i++)
		{
			ExecuteServerCommand(deltaTime);
		}
		NormalSpeedControl();
	}

	private void SingleExecute(float deltaTime, MsgPlayerInput playerInput)
	{
		ExecuteOptionHeroCommand(playerInput);
		GetCurrentGameSpeedInfo();
		FixedLoop(WorldUpdateType.All, deltaTime);
		Physics.Simulate(deltaTime);
		UpdateGameSpeedInfo();
	}

	private MsgPlayerInput SendCommand(float deltaTime)
	{
		_sendTick++;
		MsgPlayerInput framePlayerInput = GetFramePlayerInput(deltaTime);
		if (framePlayerInput != null)
		{
			GetSystem<ServerCommandSystem>()?.SendBattleFrameMessage(framePlayerInput, ActorId, _sendTick);
		}
		return framePlayerInput;
	}

	private void ExecuteServerCommand(float deltaTime)
	{
		VerityServerFrameData serverCommand = GetSystem<ServerCommandSystem>().GetServerCommand(tick);
		if (serverCommand == null)
		{
			return;
		}
		foreach (MsgPlayerInput value in serverCommand.FrameInputData.Values)
		{
			GetSystem<EntitySystem>().ExecuteServer(value.Actor, value);
		}
		GetCurrentGameSpeedInfo();
		FixedLoop(WorldUpdateType.All, base.IntervalTimer);
		Physics.Simulate(deltaTime);
		UpdateGameSpeedInfo();
		GetSystem<ServerCommandSystem>().ClearServerCommand(serverCommand, tick);
		_ = KCPLog.Open;
		tick++;
	}

	private bool RoundHeroPreparation(LockstepBattleWorldData worldData)
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
				return false;
			}
			GetSystem<ParadoxSystem>().CacheParadoxTreeObj(dataRow.AIParadoxId);
			GameObject entityObject = GetSystem<EntityViewCacheSystem>().LoadEntityView(worldData.TeamListConfig[i].Id, GetSkinAssetPath(heroModel, dataRow));
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
				LockstepData.Instance?.InitData(ActorId, worldData.RoomId, worldData.TeamListConfig.Count, heroEntity.EntityId);
			}
			else if (heroModel.isRobot)
			{
				heroEntity.SetRobot(robot: true);
			}
			TeamMember obj = worldData.TeamMemberList?.Find((TeamMember b) => b.HeroModel != null && b.HeroModel.Id == heroModel.Id);
			if (obj == null)
			{
				Log.Error($"未找到TeamMember数据 Id:{heroModel.Id}");
			}
			int index = obj?.MemberId ?? (i + 1);
			GetSystem<BattleSystem>().InitHeroData(index, heroEntity, worldData.TeamListConfig.Count);
		}
		GetSystem<BattleSystem>().InitHeroComplete();
		if (LocalActorId == 0)
		{
			Log.Error("初始化世界错误：没有玩家主控角色....");
			return false;
		}
		return true;
	}

	protected override void CheckCameraChange()
	{
	}

	private async UniTask<bool> RoundMonsterPreparation(int monsterId)
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
		GetSystem<ParadoxSystem>().CacheParadoxTreeObj(dataRow2.AIParadoxId);
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
		_monsterTypeConfigId = monsterEntity.MonsterAttrConfig?.MonsterType ?? 0;
		_monsterId = monsterEntity.MonsterAttrConfig?.Id ?? 0;
		return true;
	}

	private bool RoundInteractivePreparation()
	{
		List<InteractiveData> interactiveData = _createCopyData.GetInteractiveData();
		if (interactiveData == null)
		{
			return true;
		}
		foreach (InteractiveData item in interactiveData)
		{
			DRMapItem dataRow = GameEntry.DataTable.GetDataRow<DRMapItem>(item.InteractiveId);
			if (dataRow == null)
			{
				Log.Error($"没有找到编号 = {item.InteractiveId}的交互物配置..");
				return false;
			}
			GetSystem<ParadoxSystem>().CacheParadoxTreeObj(dataRow.AIParadoxId);
			GameObject entityObject = GetSystem<EntityViewCacheSystem>().LoadEntityView(item.InteractiveId, dataRow.AssetPath);
			GetSystem<EntitySystem>().CreateEntity<SyncBattleInteractiveEntity>(item.InteractiveId, new EntityData
			{
				pointData = new EntityPositionData
				{
					position = item.point,
					scale = Vector3.one,
					rotation = item.rotation
				},
				entityObject = entityObject,
				userData = dataRow,
				updateType = EntityUpdateType.Authority,
				logicType = EntityLogicType.None
			}).SetData(Constant.InteractiveConstant.INTERACTIVE_NAME, item.InteractiveName);
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

	private void OnMonsterEntityDead(BaseEntity entity, bool isNormal)
	{
		GameSettlement(GameSettlementType.MonsterDead);
	}

	protected override void GameAchievementSettlement(bool isSuccess)
	{
		base.GameAchievementSettlement(isSuccess);
		Dictionary<int, int> dictionary = CollectionPool<Dictionary<int, int>, KeyValuePair<int, int>>.Get();
		dictionary.Add(6012, isSuccess ? 1 : 0);
		dictionary.Add(6013, _monsterTypeConfigId);
		dictionary.Add(6014, _monsterId);
		GetSystem<AchievementSystem>().DoubleVerityAchievement(dictionary);
	}

	public override async void GameSettlement(GameSettlementType gameSettlementType)
	{
		base.GameSettlement(gameSettlementType);
		if (IsBattleSettlement)
		{
			return;
		}
		IsBattleSettlement = true;
		GetSystem<ServerCommandSystem>()?.SendBattleEnd();
		LockstepData.Instance?.SyncSave();
		if ((gameSettlementType == GameSettlementType.HeroDead || gameSettlementType == GameSettlementType.MonsterDead || gameSettlementType == GameSettlementType.TimeOver || gameSettlementType == GameSettlementType.PlayerQuit) && !(await C2SGameSettlement(gameSettlementType)))
		{
			OnAccountDisconnect(0);
			return;
		}
		switch (gameSettlementType)
		{
		case GameSettlementType.MonsterDead:
			GetSystem<BattleSystem>()?.HeroTeamInvincible();
			Task.Run(delegate
			{
				try
				{
					SaveBattleVerificationCommand();
				}
				catch (Exception ex)
				{
					Log.Error("[KCP] 保存战斗校验数据失败: " + ex.Message + "\n" + ex.StackTrace);
				}
			});
			await UniTask.Delay(5500);
			break;
		case GameSettlementType.HeroDead:
			GetSystem<BattleSystem>()?.MonsterInvincible();
			await UniTask.Delay(3000);
			break;
		}
		GetSystem<ServerCommandSystem>()?.HideSystem();
		switch (gameSettlementType)
		{
		case GameSettlementType.LostConnect:
		{
			Singleton<NetworkSystem>.Instance.DisposeMainChannel();
			LoadingStartupViewModel loadViewModel = new LoadingStartupViewModel(base.SceneLoadPath, autoUnload: true, battleExit: true);
			DRLoadingTips randomLoadingTap2 = await Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().PrepareLoading(GameProcessType.Login);
			loadViewModel.SetRandomLoadingTap(randomLoadingTap2);
			await GameEntry.UI.OpenWindow<LoadingWindow>("Loading/LoadingWindow", "LOADING", loadViewModel);
			await UniTask.WaitUntil(() => loadViewModel.IsLoadingFinish);
			if (loadViewModel.LoadingSuccess)
			{
				Singleton<GameSystem>.Instance.DestroyWorldChannel(this);
				Game.RemoveSingleton<GameSystem>();
				StartupWindow startWindow = await GameEntry.UI.LoadWindow<StartupWindow>("Start/StartupWindow", new StartupViewModel());
				await loadViewModel.CloseLoading();
				startWindow.Show();
			}
			break;
		}
		case GameSettlementType.MonsterDead:
		case GameSettlementType.HeroDead:
		case GameSettlementType.PlayerQuit:
		case GameSettlementType.TimeOver:
		{
			BattleEndViewModel userData = new BattleEndViewModel(GetbattleResult: true);
			await GameEntry.UI.OpenWindow<BattleEndWindow>("BattleEnd/BattleEndWindow", userData);
			Singleton<GameSystem>.Instance.DestroyWorldChannel(this);
			Game.RemoveSingleton<GameSystem>();
			break;
		}
		case GameSettlementType.BattleOver:
		{
			LoadingBackToMainViewModel loadingBackToMainViewModel = new LoadingBackToMainViewModel(base.SceneLoadPath, autoUnload: true, "Copy");
			DRLoadingTips randomLoadingTap = await Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().PrepareLoading(GameProcessType.Outer);
			loadingBackToMainViewModel.SetRandomLoadingTap(randomLoadingTap);
			LoadingWindow obj = await GameEntry.UI.LoadWindow<LoadingWindow>(AssetUtility.GetUIFormAsset("Loading/LoadingWindow"), "LOADING", loadingBackToMainViewModel);
			Singleton<GameSystem>.Instance.DestroyWorldChannel(this);
			Game.RemoveSingleton<GameSystem>();
			obj.DoShow();
			await UniTask.WaitUntil(() => loadingBackToMainViewModel.IsLoadingFinish);
			bool loadingSuccess = loadingBackToMainViewModel.LoadingSuccess;
			if (loadingBackToMainViewModel.LoadingSuccess)
			{
				await loadingBackToMainViewModel.CloseLoading();
			}
			Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().LoadingEnd(loadingSuccess);
			break;
		}
		}
	}

	private async Task<bool> C2SGameSettlement(GameSettlementType settlementType)
	{
		BattleSystem system = GetSystem<BattleSystem>();
		if (system == null)
		{
			return false;
		}
		Loading loading = await Loading.Show();
		system = GetSystem<BattleSystem>();
		if (system == null)
		{
			loading.Dispose();
			return false;
		}
		Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>()?.SaveBattleData(system.BattleMode, system.GetBSDatasByHeroSeat(), system.GetAllBattleRecordPointInfo(), (settlementType == GameSettlementType.HeroDead) ? system.GetKilledMonsterId() : 0, system.GetBattleFinishAutoFightData());
		bool result = await system.GameSettlement(settlementType);
		loading.Dispose();
		return result;
	}

	public override void RecodeMaxDamage(int entityID, float damage)
	{
		if (maxDamageDic == null)
		{
			maxDamageDic = CollectionPool<Dictionary<int, float>, KeyValuePair<int, float>>.Get();
		}
		if (maxDamageDic.TryGetValue(entityID, out var value))
		{
			if (damage > value)
			{
				maxDamageDic[entityID] = damage;
			}
		}
		else
		{
			maxDamageDic[entityID] = damage;
		}
	}

	private void SaveBattleVerificationCommand()
	{
		if (_battleVerificationData != null && _dataStorage != null)
		{
			_battleVerificationData?.RecodeMaxDamage(maxDamageDic);
			byte[] data = _battleVerificationData?.GetVerificationData();
			_dataStorage.AsyncPutObject("kiif-multifightbackdata", string.Format("{0}/{1}{2}", _battleVerificationData?.RoomId, _battleVerificationData?.RoomId, "-MaxDamage.txt"), data);
			_battleVerificationData?.Clear();
			_battleVerificationData = null;
			if (maxDamageDic != null)
			{
				CollectionPool<Dictionary<int, float>, KeyValuePair<int, float>>.Release(maxDamageDic);
				maxDamageDic = null;
			}
		}
	}

	protected override void OnAccountDisconnect(int disconnectReason)
	{
		Singleton<GameSystem>.Instance.DestroyWorldChannel(this);
		Game.RemoveSingleton<GameSystem>();
		Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().BacktiTitle(base.SceneLoadPath);
	}

	public override void Shutdown()
	{
		base.Shutdown();
		_serverCommand = null;
		_createCopyData?.Clear();
		_createCopyData = null;
		if (_recodeTeamDeadState != null)
		{
			_recodeTeamDeadState.Clear();
			_recodeTeamDeadState = null;
		}
		_sendTick = 0u;
	}

	public override CreateCopyData GetMapData()
	{
		return _createCopyData;
	}

	protected override Type[] GetSystemTypes()
	{
		return new Type[43]
		{
			typeof(BattleWorldTimeLineSystem),
			typeof(KcpSocketSystem),
			typeof(ServerCommandSystem),
			typeof(SceneSystem),
			typeof(PathfindingSystem),
			typeof(InputSystem),
			typeof(TouchSystem),
			typeof(CommandSystem),
			typeof(MonsterAttackSystem),
			typeof(EntityViewCacheSystem),
			typeof(WeaknessSystem),
			typeof(WeaknessBarSystem),
			typeof(ParadoxSystem),
			typeof(EntitySystem),
			typeof(KinematicCharacterSystem),
			typeof(CameraSystem),
			typeof(VirtualCameraSystem),
			typeof(EffectSystem),
			typeof(PostProcessEffectSystem),
			typeof(HitSystem),
			typeof(BattleSystem),
			typeof(BuffSystem),
			typeof(UIDamageTextSystem),
			typeof(HealthBarsSystem),
			typeof(VolumeSystem),
			typeof(BulletSystem),
			typeof(SkillIndicatorSystem),
			typeof(WarningIndicatorSystem),
			typeof(FrameFrozenSystem),
			typeof(AlertHitInfoSystem),
			typeof(MultiPlayerSystem),
			typeof(MechanismCacheSystem),
			typeof(AchievementSystem),
			typeof(BattleObserverSystem),
			typeof(BattleDamageProgressSystem),
			typeof(BattleStateSystem),
			typeof(GameResourceSystem),
			typeof(EntityAudioSystem),
			typeof(TeachGuideSystem),
			typeof(ActivityRoundBattleSystem),
			typeof(CampaignBattleSystem),
			typeof(RoomSystem),
			typeof(ParadoxTimelineSystem)
		};
	}
}
