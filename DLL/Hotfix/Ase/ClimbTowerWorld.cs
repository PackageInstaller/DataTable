using System;
using System.Collections.Generic;
using Ase.ECS;
using Cysharp.Threading.Tasks;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.Pool;

namespace Ase;

public class ClimbTowerWorld : WorldBase
{
	private int towerNum;

	private int endlessLayer;

	private int copyType;

	private bool gameSettlementFinish;

	private bool destoryWorld;

	private ISubscription<OpActivityMessage> subscription_OpActivityMessage;

	private bool taskRateResult;

	private ClimbTowerSystem climbTowerSystem;

	private MonsterStrengthConfig hpConfig;

	private MonsterStrengthConfig recudeTenacityConfig;

	private MonsterStrengthConfig tenacitykConfig;

	private MonsterStrengthConfig attackConfig;

	private List<int> selectBuffs = new List<int>(10);

	private int refreshCount;

	private int maxScore;

	public override bool IsNeedExecuteViewSystem => true;

	public override int ActorId => LocalActorId;

	public override BattleWorldMode BattleWorldMode => BattleWorldMode.SingleBattle;

	public override bool TestingWorld => false;

	public ClimbTowerWorld(string worldName, GameObject worldRoot, WorldData worldData)
		: base(worldName, worldRoot, worldData)
	{
		LRandom = LRandom.New(worldData.RandomSeed);
	}

	public override void GameStart()
	{
		base.GameStart();
		subscription_OpActivityMessage = Context.GetApplicationContext().GetService<IMessenger>().Subscribe<OpActivityMessage>(OnTaskRateChanged);
	}

	public override async UniTask<bool> GamePreparation(WorldData worldData)
	{
		ClimbTowerWorldData climbTowerWorldData = worldData as ClimbTowerWorldData;
		towerNum = climbTowerWorldData.TowerNum;
		copyType = climbTowerWorldData.CopyType;
		selectBuffs.AddRange(climbTowerWorldData.SelectBuff);
		refreshCount = climbTowerWorldData.RefreshCount;
		endlessLayer = climbTowerWorldData.EndlessLayer;
		TowerConfig towerConfig = climbTowerWorldData.TowerConfig;
		hpConfig = towerConfig.HpStrengthConfig;
		attackConfig = towerConfig.AttackStrengthConfig;
		tenacitykConfig = towerConfig.TenacityStrengthConfig;
		recudeTenacityConfig = towerConfig.RecudeTenacityStrengthConfig;
		climbTowerSystem = GetSystem<ClimbTowerSystem>();
		if (!(await OnEnter(climbTowerWorldData)))
		{
			return false;
		}
		if (!(await climbTowerSystem.LoadBattleSceneMapData(climbTowerWorldData, worldRoot, selectBuffs)))
		{
			return false;
		}
		if (!(await OnGamePreparationEnd(climbTowerWorldData)))
		{
			return false;
		}
		return true;
	}

	public override void OnHeroCantRevived(int entityId)
	{
		GameSettlement(GameSettlementType.HeroDead);
	}

	public override async void GameSettlement(GameSettlementType gameSettlementType)
	{
		bool gameSuccess = gameSettlementType == GameSettlementType.MonsterDead;
		if (gameSuccess)
		{
			await GetRewardBuff();
		}
		base.GameSettlement(gameSettlementType);
		bool showResult = true;
		BattleSystem battleSystem = GetSystem<BattleSystem>();
		if (!gameSettlementFinish)
		{
			Loading loading = await Loading.Show();
			Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().SaveBattleData(battleSystem.BattleMode, battleSystem.GetBSDatasByHeroSeat(), battleSystem.GetAllBattleRecordPointInfo(), (gameSettlementType == GameSettlementType.HeroDead) ? battleSystem.GetKilledMonsterId() : 0, battleSystem.GetBattleFinishAutoFightData());
			int endlessScore = climbTowerSystem.GetEndlessScore();
			if (endlessScore > maxScore)
			{
				maxScore = endlessScore;
			}
			battleSystem.SetGameScore(endlessScore);
			showResult = await battleSystem.GameSettlement(gameSettlementType);
			gameSettlementFinish = true;
			if (showResult & gameSuccess)
			{
				await Singleton<ServiceSystem>.Instance.GetService<ICopyService>().RequestSaveTowerBuffData(selectBuffs, refreshCount, towerNum, endlessLayer);
			}
			loading.Dispose();
		}
		UniTask uniTask = UniTask.WaitUntil(() => taskRateResult);
		UniTask uniTask2 = UniTask.Delay(TimeSpan.FromSeconds(1.5));
		await UniTask.WhenAny(uniTask, uniTask2);
		bool canPlayNext = GetCanPlayNextTower();
		taskRateResult = false;
		if (gameSuccess)
		{
			battleSystem.HeroTeamInvincible();
			await UniTask.Delay(500);
			if (endlessLayer > 0 || (!FinishAreaAllCopy() && canPlayNext))
			{
				GetSystem<ClimbTowerSystem>().ClimbTowerSettlementFinish();
				return;
			}
			await ShowBattleResultWindow(success: true, 0, showScore: false);
		}
		else
		{
			switch (gameSettlementType)
			{
			case GameSettlementType.HeroDead:
			case GameSettlementType.TimeOver:
				battleSystem.MonsterInvincible();
				await UniTask.Delay(1500);
				await ShowBattleResultWindow(success: false, maxScore, endlessLayer > 0);
				break;
			case GameSettlementType.PlayerQuit:
			{
				BattleEndViewModel userData = new BattleEndViewModel(GetbattleResult: false);
				await GameEntry.UI.OpenWindow<BattleEndWindow>("BattleEnd/BattleEndWindow", userData);
				break;
			}
			}
		}
		GamePause();
		if (gameSettlementFinish && !showResult)
		{
			OnAccountDisconnect(0);
			return;
		}
		Singleton<GameSystem>.Instance.DestroyWorldChannel(this);
		Game.RemoveSingleton<GameSystem>();
	}

	private async UniTask GetRewardBuff()
	{
		ClimbTowerSystem system = GetSystem<ClimbTowerSystem>();
		DRCopy copyConfigData = GetCopyConfigData(towerNum);
		List<int> achievementSelectBuffs = CollectionPool<List<int>, int>.Get();
		List<int> achievementSeeBuffs = CollectionPool<List<int>, int>.Get();
		refreshCount = await system.ShowRandomBuffWindow(refreshCount, selectBuffs, copyConfigData.Id, achievementSelectBuffs, achievementSeeBuffs);
		await Singleton<ServiceSystem>.Instance.GetService<IActivityAchievementService>().SendFightChooseBuffIds(achievementSeeBuffs, achievementSelectBuffs);
		CollectionPool<List<int>, int>.Release(achievementSelectBuffs);
		CollectionPool<List<int>, int>.Release(achievementSeeBuffs);
	}

	private void OnTaskRateChanged(OpActivityMessage message)
	{
		taskRateResult = GetCanPlayNextTower();
	}

	private async UniTask ShowBattleResultWindow(bool success, int score, bool showScore)
	{
		DRCopy copyConfigData = GetCopyConfigData(towerNum);
		TowerBattleResultViewModel vm = new TowerBattleResultViewModel(success, copyConfigData.Id, towerNum, score, showScore);
		(await GameEntry.UI.LoadWindow<TowerBattleResultWindow>("OperatingActivity/TownChallenge/TowerBattleResultWindow", vm)).Show();
		await UniTask.WaitUntil(() => vm.CloseWindow);
		if (!success && vm.QuitCopy)
		{
			Singleton<ServiceSystem>.Instance.GetService<ICopyService>().RequestClearTowerBuffData();
		}
	}

	private bool GetCanPlayNextTower()
	{
		if (endlessLayer > 0)
		{
			return true;
		}
		int num = towerNum;
		num++;
		DRCopy copyConfigData = GetCopyConfigData(num);
		if (copyConfigData != null)
		{
			return Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetTowerCopyUnLock(copyConfigData.Id);
		}
		return false;
	}

	private bool FinishAreaAllCopy()
	{
		int floorNum = towerNum;
		DRCopy copyConfigData = GetCopyConfigData(floorNum);
		if (copyConfigData == null)
		{
			return false;
		}
		return Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetTowerAreaFinishByCopyId(copyConfigData.Id);
	}

	public void EnterNextTower()
	{
		if (endlessLayer > 0)
		{
			endlessLayer++;
		}
		else
		{
			towerNum++;
		}
		DRCopy copyConfigData = GetCopyConfigData(towerNum);
		RequestEnterTower(copyConfigData.Id);
	}

	private async UniTask QuitWorld(bool success)
	{
		BattleEndViewModel userData = new BattleEndViewModel(GetbattleResult: false);
		await GameEntry.UI.OpenWindow<BattleEndWindow>("BattleEnd/BattleEndWindow", userData);
		Singleton<GameSystem>.Instance.DestroyWorldChannel(this);
		Game.RemoveSingleton<GameSystem>();
	}

	protected override void FixedLoop(float deltaTime)
	{
		tick++;
		MsgPlayerInput framePlayerInput = GetFramePlayerInput(deltaTime);
		ExecuteOptionHeroCommand(framePlayerInput);
		GetCurrentGameSpeedInfo();
		FixedLoop(WorldUpdateType.All, deltaTime);
		Physics.SyncTransforms();
		UpdateGameSpeedInfo();
	}

	private async void RequestEnterTower(int copyId)
	{
		GameResume();
		List<int> addBuffs = new List<int>(4);
		List<AchievementMedal> achievementMedals = null;
		if (!(await Singleton<ServiceSystem>.Instance.GetService<ICopyService>().RequestEnterTower(copyId, addBuffs, achievementMedals)))
		{
			QuitWorld(success: true);
			return;
		}
		gameSettlementFinish = false;
		GetSystem<BattleSystem>().ClearStat();
		GetSystem<BattleSystem>().ResetAllDS();
		GetSystem<AchievementSystem>().ClearData();
		GetSystem<AchievementSystem>().InitAchievementAction(achievementMedals);
		await GetSystem<ClimbTowerSystem>().PlayNewTower(addBuffs, showTitle: true, selectBuffs);
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
			typeof(EntityAudioSystem),
			typeof(TeachGuideSystem),
			typeof(ActivityRoundBattleSystem),
			typeof(ClimbTowerSystem),
			typeof(GameResourceSystem),
			typeof(ParadoxTimelineSystem)
		};
	}

	public override CreateCopyData GetMapData()
	{
		return null;
	}

	public override void MonsterAttrHandle(BaseEntity baseEntity, DRMonsterAttr drMonsterAttr, ref AttrAssignmentData data)
	{
		base.MonsterAttrHandle(baseEntity, drMonsterAttr, ref data);
		float monsterDifficultyFactor = climbTowerSystem.GetMonsterDifficultyFactor(baseEntity.EntityData);
		data.Hp = CalculateAttr(monsterDifficultyFactor, hpConfig, drMonsterAttr.Hp);
		data.Attack = CalculateAttr(monsterDifficultyFactor, attackConfig, drMonsterAttr.Attack);
		data.MaxTenacity = CalculateAttr(monsterDifficultyFactor, tenacitykConfig, drMonsterAttr.MaxTenacity);
		data.BaseTough = CalculateAttr(monsterDifficultyFactor, recudeTenacityConfig, drMonsterAttr.BaseTough);
	}

	private float CalculateAttr(float difficultyFactor, MonsterStrengthConfig config, float drAttr)
	{
		return Mathf.Pow(difficultyFactor, config.Exponent) * config.Factor * drAttr + config.Constant + drAttr;
	}

	protected override void OnAccountDisconnect(int disconnectReason)
	{
		try
		{
			if (destoryWorld)
			{
				return;
			}
			Singleton<GameSystem>.Instance.DestroyWorldChannel(this);
			Game.RemoveSingleton<GameSystem>();
		}
		catch (Exception)
		{
		}
		string sceneLoadPath = Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().GetSceneLoadPath();
		Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().BacktiTitle(sceneLoadPath);
		Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().SetSceneLoadPath(string.Empty);
	}

	public override void Shutdown()
	{
		if (subscription_OpActivityMessage != null)
		{
			subscription_OpActivityMessage.Dispose();
			subscription_OpActivityMessage = null;
		}
		base.Shutdown();
		destoryWorld = true;
	}

	private DRCopy GetCopyConfigData(int floorNum)
	{
		return GameEntry.DataTable.GetDataRow((DRCopy x) => x.CopyRank == floorNum && x.CopyType == copyType);
	}

	public void GetCopyNameDesc(ref string copyName, ref string copyDesc)
	{
		DRCopy copyConfigData = GetCopyConfigData(towerNum);
		copyName = copyConfigData.Name;
		copyDesc = copyConfigData.Desc;
	}
}
