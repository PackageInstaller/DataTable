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

public class BattleWorld : WorldBase
{
	private BattleVerificationData _battleVerificationData;

	private DataStorageOss _dataStorage;

	private const string _lockstepBucketSingle = "kiif-battleverification";

	private const string _lockstepBucketMulti = "kiif-multifightbackdata";

	private string LockstepBucketName;

	private string BattlePlayerDataSuffix = "-FightFrameDataInfo.txt";

	private SceneSystem sceneSystem;

	private CreateCopyData _createCopyData;

	private bool _isDevel;

	private int _monsterTypeConfigId;

	private int _monsterId;

	private ActivityRoundBattleSystem roundBattleSystem;

	private Dictionary<int, float> maxDamageDic;

	public bool IsDevelMode => _isDevel;

	public override bool IsNeedExecuteViewSystem => true;

	public override int ActorId => LocalActorId;

	public override BattleWorldMode BattleWorldMode => BattleWorldMode.SingleBattle;

	public override bool TestingWorld => false;

	public BattleWorld(string worldName, GameObject worldRoot, WorldData worldData)
		: base(worldName, worldRoot, worldData)
	{
		_createCopyData = new CreateCopyData();
		sceneSystem = GetSystem<SceneSystem>();
		roundBattleSystem = GetSystem<ActivityRoundBattleSystem>();
		LRandom = LRandom.New(worldData.RandomSeed);
		InitBattleverification(worldData);
	}

	private void InitBattleverification(WorldData worldData)
	{
		_isDevel = worldData.IsDevel;
		if (!_isDevel)
		{
			GetSystem<AchievementSystem>()?.InitAchievementAction(worldData.BattleAchievementMedalList);
		}
		if (worldData.IsBattleSend == 2)
		{
			return;
		}
		LockstepBucketName = "kiif-battleverification";
		if (worldData is BattleWorldData battleWorldData)
		{
			DRCopy dataRow = GameEntry.DataTable.GetDataRow<DRCopy>(battleWorldData.CopyId);
			bool flag = false;
			if (dataRow != null)
			{
				flag = dataRow.CopyType == 99100 || dataRow.CopyType == 99000 || battleWorldData.IsOpenGM;
			}
			if (!_isDevel && !flag)
			{
				_battleVerificationData = new BattleVerificationData(GameEntry.BuiltinData.VersionInfo, battleWorldData.RoomId);
				_dataStorage = new DataStorageOss();
			}
		}
	}

	public override void GameStart()
	{
		_createCopyData.PlayBGM();
		base.GameStart();
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
				return await EnterCampaignBattleWorld(campaignBattleWorldData);
			}
			if (worldData is BattleWorldData battleWorldData)
			{
				return await EnterBattleWorld(battleWorldData);
			}
			Log.Error("初始化 BattleWorld 错误 ： WorldData == null...");
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

	private async UniTask<bool> EnterCampaignBattleWorld(CampaignBattleWorldData campaignBattleWorldData)
	{
		if (!(await OnEnter(campaignBattleWorldData)))
		{
			return false;
		}
		if (!(await GetSystem<CampaignBattleSystem>().LoadBattleSceneMapData(worldRoot)))
		{
			return false;
		}
		if (!GetSystem<CampaignBattleSystem>().RoundHeroPreparation(campaignBattleWorldData, base.BattleConfig.TeamRebornValue))
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

	private async UniTask<bool> EnterBattleWorld(BattleWorldData battleWorldData)
	{
		if (!(await OnEnter(battleWorldData)))
		{
			return false;
		}
		if (!(await _createCopyData.LoadBattleSceneMapData(battleWorldData.MapDataName, GetSystem<GameResourceSystem>(), worldRoot, battleWorldData.CopyId)))
		{
			return false;
		}
		if (!RoundHeroPreparation(battleWorldData, base.BattleConfig.TeamRebornValue))
		{
			return false;
		}
		if (!RoundMonsterPreparation(battleWorldData.BossId))
		{
			return false;
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

	protected override void FixedLoop(float deltaTime)
	{
		tick++;
		MsgPlayerInput framePlayerInput = GetFramePlayerInput(deltaTime);
		ExecuteAISkillCommand();
		RecodeCommand(framePlayerInput);
		ExecuteOptionHeroCommand(framePlayerInput);
		GetCurrentGameSpeedInfo();
		FixedLoop(WorldUpdateType.All, deltaTime);
		Physics.SyncTransforms();
		UpdateGameSpeedInfo();
	}

	private void RecodeCommand(MsgPlayerInput playerInput)
	{
		if (!IsBattleSettlement)
		{
			if (playerInput != null)
			{
				playerInput.Tick = (int)tick;
			}
			_battleVerificationData?.RecodeCommand(playerInput);
		}
	}

	public override void RecodeCommand(int entityID, string paradoxParamKey, int paradoxParamValue)
	{
		if (!IsBattleSettlement)
		{
			_battleVerificationData?.RecodeAICommand(entityID, paradoxParamKey, paradoxParamValue, (int)tick);
		}
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

	private bool RoundHeroPreparation(WorldData worldData, int teamRebornValue)
	{
		List<PeripheryHeroData> teamListConfig = worldData.TeamListConfig;
		List<TeamMember> teamMemberList = worldData.TeamMemberList;
		if (teamListConfig.IsNullOrEmpty())
		{
			return false;
		}
		for (int i = 0; i < teamListConfig.Count; i++)
		{
			PeripheryHeroData heroModel = teamListConfig[i];
			TeamMember teamMember = teamMemberList?.Find((TeamMember b) => b.HeroModel != null && b.HeroModel.Id == heroModel.Id);
			if (teamMember == null)
			{
				Log.Error($"未找到TeamMember数据 Id:{heroModel.Id}");
			}
			if (heroModel == null)
			{
				return false;
			}
			ScenePoint heroBornPoint = _createCopyData.GetHeroBornPoint("Default", i);
			if (heroBornPoint == null)
			{
				return false;
			}
			DRHero dataRow = GameEntry.DataTable.GetDataRow<DRHero>(heroModel.Id);
			GameObject entityObject = GetSystem<EntityViewCacheSystem>().LoadEntityView(heroModel.Id, GetSkinAssetPath(heroModel, dataRow));
			HeroEntity heroEntity = GetSystem<EntitySystem>().CreateEntity<HeroEntity>(heroModel.Id, new EntityData
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
				userData = heroModel
			});
			if (i == 0)
			{
				SetActorId(heroEntity);
				LockstepData.Instance?.InitData(ActorId, worldData.RoomId, worldData.TeamListConfig.Count, heroEntity.Id);
				LockstepData.Instance?.WriteAuthorityEntityId($"随机数 = {worldData.RandomSeed}", heroEntity);
			}
			heroEntity.SetAi(i != 0);
			heroEntity.BattleHeroData.IsSelf = i == 0;
			int index = teamMember?.MemberId ?? (i + 1);
			GetSystem<BattleSystem>().InitHeroData(index, heroEntity, teamRebornValue);
			GetSystem<RoomSystem>().AddToRoomEntity(heroEntity);
		}
		GetSystem<BattleSystem>().InitHeroComplete();
		return true;
	}

	private bool RoundMonsterPreparation(int monsterId)
	{
		DRMonsterAttr dataRow = GameEntry.DataTable.GetDataRow<DRMonsterAttr>(monsterId);
		if (dataRow == null)
		{
			return false;
		}
		DRMonster dataRow2 = GameEntry.DataTable.GetDataRow<DRMonster>(dataRow.MonsterType);
		if (dataRow2 == null)
		{
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
		GetSystem<RoomSystem>().AddToRoomEntity(monsterEntity);
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
				return false;
			}
			GetSystem<ParadoxSystem>().CacheParadoxTreeObj(dataRow.AIParadoxId);
			GameObject entityObject = GetSystem<EntityViewCacheSystem>().LoadEntityView(item.InteractiveId, dataRow.AssetPath);
			SyncBattleInteractiveEntity syncBattleInteractiveEntity = GetSystem<EntitySystem>().CreateEntity<SyncBattleInteractiveEntity>(item.InteractiveId, new EntityData
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
			});
			syncBattleInteractiveEntity.SetData(Constant.InteractiveConstant.INTERACTIVE_NAME, item.InteractiveName);
			GetSystem<RoomSystem>().AddToRoomEntity(syncBattleInteractiveEntity);
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

	private void SaveBattleVerificationCommand()
	{
		if (_battleVerificationData != null && _dataStorage != null)
		{
			_battleVerificationData?.RecodeCommand(null, (int)tick);
			_battleVerificationData?.RecodeMaxDamage(maxDamageDic);
			byte[] data = _battleVerificationData?.GetVerificationData();
			_dataStorage.AsyncPutObject(LockstepBucketName, $"{_battleVerificationData?.RoomId}/{_battleVerificationData?.RoomId}{BattlePlayerDataSuffix}", data);
			_battleVerificationData?.Clear();
			_battleVerificationData = null;
		}
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
		if (_isDevel)
		{
			return;
		}
		if (gameSettlementType == GameSettlementType.MonsterDead)
		{
			Task.Run(delegate
			{
				SaveBattleVerificationCommand();
			});
		}
		LockstepData.Instance?.SyncSave();
		Loading loading = await Loading.Show();
		BattleSystem battleSystem = GetSystem<BattleSystem>();
		Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>()?.SaveBattleData(battleSystem.BattleMode, battleSystem.GetBSDatasByHeroSeat(), battleSystem.GetAllBattleRecordPointInfo(), (gameSettlementType == GameSettlementType.HeroDead) ? battleSystem.GetKilledMonsterId() : 0, battleSystem.GetBattleFinishAutoFightData());
		bool showResult = await battleSystem.GameSettlement(gameSettlementType);
		loading.Dispose();
		switch (gameSettlementType)
		{
		case GameSettlementType.MonsterDead:
			battleSystem?.HeroTeamInvincible();
			await UniTask.Delay(5500);
			break;
		case GameSettlementType.HeroDead:
			battleSystem.MonsterInvincible();
			await UniTask.Delay(3000);
			break;
		case GameSettlementType.GoldLevelOver:
			await UniTask.Delay(1000);
			break;
		}
		GamePause();
		if (!showResult)
		{
			OnAccountDisconnect(0);
			return;
		}
		BattleEndViewModel userData = new BattleEndViewModel(GetbattleResult: true);
		await GameEntry.UI.OpenWindow<BattleEndWindow>("BattleEnd/BattleEndWindow", userData);
		Singleton<GameSystem>.Instance.DestroyWorldChannel(this);
		Game.RemoveSingleton<GameSystem>();
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
		return new Type[41]
		{
			typeof(RoomSystem),
			typeof(BattleWorldTimeLineSystem),
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
			typeof(ActivityRoundBattleSystem),
			typeof(CampaignBattleSystem),
			typeof(ParadoxTimelineSystem)
		};
	}
}
