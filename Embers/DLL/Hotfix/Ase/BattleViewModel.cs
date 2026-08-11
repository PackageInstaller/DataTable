#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Ase.ECS;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class BattleViewModel : OptionBase
{
	private int showUIStatis;

	private bool gameOver;

	private BattleUserInfoViewModel userInfoViewModel;

	private BossBloodBarViewModel bossBloodBarViewModel;

	private SystemInfoViewModel systemInfoViewModel;

	private BattleTaskInfoViewModel taskInfoViewModel;

	private BattleInteractiveViewModel interactiveViewModel;

	private MiniMapViewModel miniMapViewModel;

	private BattleTweenInfoViewModel tweenInfoViewModel;

	private NPCPopDialogViewModel npcPopDialogViewModel;

	private BattleStatWindowModel battleStatWindowViewModel;

	private BattleTaskTargetViewModel taskTargetViewModel;

	private DirPosViewModel dirPosViewModel;

	private BattleEmoteViewModel _battleEmoteViewModel;

	private MonsterCopyViewModel _monsterCopyViewModel;

	private SimpleCommand<string> optCommand;

	protected readonly InteractionRequest<bool> hidePanelRequest = new InteractionRequest<bool>();

	private InteractionRequest updateMiniMapRst = new InteractionRequest();

	private Action quitGame;

	private Action resetAutoFightTimerAction;

	private Action<float, string> showBattleTipsAction;

	private Action<LoadingToOtherLevelViewModel> loadOtherWorld;

	public Transform ChildViewParent;

	private Action openBattleResultAction;

	private BattleWorldMode _battleMode;

	private bool showMiniMap;

	private int enterCaverId;

	private bool isGuideLevel;

	private bool hideSetWindowQuitBtn;

	private HeroEntity _selfEntity;

	private Action<BattleHeroData, bool> onChangeHero;

	private Action<float, float, EntityViewModel> onShowDamageText;

	private Action<int> onReleaseSkill4;

	private Action onTeachObserverEnergy;

	private Action<Transform> onTeachObserverAIXp;

	private InteractionRequest<TouchLayout> refreshUserLayoutRequest = new InteractionRequest<TouchLayout>();

	private Func<ProcessOperationEnum, bool> onProcessOperation;

	private Action<string, Action> onTeleport;

	private Action onRevert;

	private Action<BattleGMEnum> gmAction;

	private bool isStartBattleTime;

	private Transform cachePlayer;

	private TaotieEatViewModel taotieEatViewModel;

	private ISubscription<LevelSaveMessage> _levelSaveSubscription;

	public List<OpenViewArg> initOpenViews = new List<OpenViewArg>();

	private Dictionary<string, OptionBase> childVMs = new Dictionary<string, OptionBase>();

	public bool ShowWindow => showUIStatis >= 0;

	public IInteractionRequest HidePanelRequest => hidePanelRequest;

	public BattleWorldMode BattleWorldMode => _battleMode;

	public HeroEntity SelfEntity => _selfEntity;

	public NPCPopDialogViewModel NpcPopDialogVM => npcPopDialogViewModel;

	public bool IsGuideLevel
	{
		get
		{
			return isGuideLevel;
		}
		set
		{
			Set(ref isGuideLevel, value, "IsGuideLevel");
		}
	}

	public bool ShowMiniMap => showMiniMap;

	public InteractionRequest UpdateMiniMapRst => updateMiniMapRst;

	public IInteractionRequest RefreshUserLayoutRequest => refreshUserLayoutRequest;

	public BossBloodBarViewModel BossInfoViewModel => bossBloodBarViewModel;

	public BattleUserInfoViewModel UserInfoViewModel => userInfoViewModel;

	public SystemInfoViewModel SystemInfoViewModel => systemInfoViewModel;

	public BattleTaskInfoViewModel TaskInfoViewModel => taskInfoViewModel;

	public MiniMapViewModel MiniMapViewModel => miniMapViewModel;

	public BattleTweenInfoViewModel TweenInfoViewModel => tweenInfoViewModel;

	public BattleInteractiveViewModel InteractiveViewModel => interactiveViewModel;

	public BattleEmoteViewModel BattleEmoteViewModel => _battleEmoteViewModel;

	public DirPosViewModel DirPosViewModel => dirPosViewModel;

	public MonsterCopyViewModel MonsterCopyViewModel => _monsterCopyViewModel;

	private BattleViewModel()
	{
		userInfoViewModel = new BattleUserInfoViewModel(this);
		bossBloodBarViewModel = new BossBloodBarViewModel(this);
		miniMapViewModel = new MiniMapViewModel(this);
		tweenInfoViewModel = new BattleTweenInfoViewModel(this);
		npcPopDialogViewModel = new NPCPopDialogViewModel();
		dirPosViewModel = new DirPosViewModel();
		_levelSaveSubscription = Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>()?.GetMessager().Subscribe<LevelSaveMessage>(OnLevelSaveChanged);
	}

	public BattleViewModel(int battleTime, int inCavesId, BattleWorldMode worldMode)
		: this()
	{
		enterCaverId = inCavesId;
		_battleMode = worldMode;
		optCommand = new SimpleCommand<string>(OnOpt);
		taskInfoViewModel = new BattleTaskInfoViewModel();
		systemInfoViewModel = new SystemInfoViewModel(this, battleTime);
		_battleEmoteViewModel = new BattleEmoteViewModel(this);
	}

	public void AddWorldModeParam(BattleSpecialModeEnum specialModeEnum, bool isOpenBattleDS)
	{
		userInfoViewModel.IsSingleGame = _battleMode == BattleWorldMode.LevelBattle || _battleMode == BattleWorldMode.SingleBattle;
		userInfoViewModel.ShowRebornTime = _battleMode == BattleWorldMode.SyncBattle || _battleMode == BattleWorldMode.GameBack || _battleMode == BattleWorldMode.SingleBattle;
		if (_battleMode != BattleWorldMode.LevelBattle && specialModeEnum == BattleSpecialModeEnum.None && isOpenBattleDS)
		{
			OpenBattleDS();
		}
	}

	public void AddMonsterCopyView()
	{
		if (!childVMs.ContainsKey(typeof(MonsterCopyViewModel).FullName))
		{
			if (_monsterCopyViewModel == null)
			{
				_monsterCopyViewModel = new MonsterCopyViewModel(this, ChildViewParent);
			}
			AddChildVM(_monsterCopyViewModel);
			AddInitOpenViews(new OpenViewArg(typeof(MonsterCopyView), _monsterCopyViewModel, "Battle", isOpenWindow: false));
		}
	}

	public void RefreshMonsterCopyData(string content, string killCount)
	{
		if (_monsterCopyViewModel == null)
		{
			_monsterCopyViewModel = new MonsterCopyViewModel(this, ChildViewParent);
		}
		_monsterCopyViewModel.TaskContent = content;
		_monsterCopyViewModel.KillCount = killCount;
	}

	public void AddQuitGame(Action action, Action breakAutoFightAction, Action<float, string> showBattleTips)
	{
		quitGame = action;
		resetAutoFightTimerAction = breakAutoFightAction;
		showBattleTipsAction = showBattleTips;
	}

	public void ResetAutoFightTimerExcute()
	{
		resetAutoFightTimerAction?.Invoke();
	}

	public void AddLoadOtherWorld(Action<LoadingToOtherLevelViewModel> action)
	{
		loadOtherWorld = action;
	}

	public void InitMapData(MapConfigData mapConfigData, bool isTeachGuideLevel)
	{
		try
		{
			if (isTeachGuideLevel)
			{
				showMiniMap = false;
			}
			else if (mapConfigData == null)
			{
				showMiniMap = false;
			}
			else
			{
				showMiniMap = true;
				miniMapViewModel.RefreshMiniMapData(mapConfigData);
			}
		}
		catch (Exception message)
		{
			showMiniMap = false;
			Log.Error(message);
		}
		updateMiniMapRst.Raise();
	}

	public void SetIsGuideLevel(bool isGuideWorld)
	{
		IsGuideLevel = isGuideWorld;
	}

	public void SetCavernId(int cavernId)
	{
		enterCaverId = cavernId;
		taskTargetViewModel?.SetCavernID(cavernId);
	}

	public override async void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is ProcessOperationEnum processOperationEnum)
		{
			if (onProcessOperation != null)
			{
				bool success = onProcessOperation(processOperationEnum);
				OnProcessOperationFinished(processOperationEnum, success);
			}
		}
		else if (obj is OptionArg optionArg)
		{
			if (optionArg.OptionName.Equals("Quit"))
			{
				QuitGame();
				return;
			}
			if ("OpenBag".Equals(optionArg.OptionName))
			{
				if (systemInfoViewModel != null)
				{
					openWindowRequest.Raise(new OpenViewArg(typeof(WarehouseWindow), new WarehouseViewModel(this, inBattle: true)), delegate
					{
						systemInfoViewModel.EnableOpt();
					});
				}
				return;
			}
			if ("OnReleaseSkill4".Equals(optionArg.OptionName))
			{
				OnReleaseSkill4((BattleUserViewModel)optionArg.Obj);
				return;
			}
			if ("OpenSetting".Equals(optionArg.OptionName))
			{
				if (systemInfoViewModel != null)
				{
					bossBloodBarViewModel.StopDownEffect(isStop: true);
					bool isCampaignWorldBoss = false;
					CopyEnterInfoData copyEnterInfoData = Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().GetCopyEnterInfoData();
					if (copyEnterInfoData != null)
					{
						isCampaignWorldBoss = copyEnterInfoData.IsCampaignBattle;
					}
					GameSettingViewModel settingVm = new GameSettingViewModel(this, "战斗界面", inBattle: true, _battleMode, enterCaverId != 0, hideSetWindowQuitBtn, isCampaignWorldBoss);
					AddSettingHero(settingVm);
					await Singleton<ServiceSystem>.Instance.GetService<IRoleService>().InitManualServerInfo();
					openWindowRequest.Raise(new OpenViewArg(typeof(GameSettingWindow), settingVm), delegate
					{
						systemInfoViewModel.EnableOpt();
						bossBloodBarViewModel.StopDownEffect(isStop: false);
					});
					ResetAutoFightTimerExcute();
				}
				return;
			}
			if ("AutoFightBanOpen".Equals(optionArg.OptionName))
			{
				if (systemInfoViewModel.AutoFightToogleEnum == AutoFightToogleEnum.LevelLock)
				{
					showBattleTipsAction?.Invoke(1f, "传火等级20级解锁自动战斗");
				}
				else
				{
					showBattleTipsAction?.Invoke(1f, "强烈辉烬干扰，无法开启自动战斗");
				}
				return;
			}
			if ("AutoFightBanClose".Equals(optionArg.OptionName))
			{
				showBattleTipsAction?.Invoke(1f, "强烈辉烬干扰，无法关闭自动战斗");
				return;
			}
			if (optionArg.OptionName.Equals("Teleport"))
			{
				object obj2 = optionArg.Obj;
				MapViewModel mapViewModel = obj2 as MapViewModel;
				if (mapViewModel != null)
				{
					onTeleport?.Invoke(mapViewModel.TeleportId.ToString(), delegate
					{
						mapViewModel.Close();
					});
					return;
				}
			}
			if (optionArg.OptionName.Equals("Revert"))
			{
				onRevert?.Invoke();
			}
			else if (optionArg.OptionName.Equals("AddSettingHero"))
			{
				AddSettingHero((GameSettingViewModel)optionArg.Obj);
			}
			else if (optionArg.OptionName.Equals("OpenTaskWindow"))
			{
				List<TaskDataViewModel> allTask = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().GetAllTask();
				TaskRedPointData redPoint = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().GetRedPoint();
				TaskMainViewModel taskMainViewModel = new TaskMainViewModel(this, redPoint, allTask, 0, -1);
				openWindowRequest.Raise(new OpenViewArg(typeof(TaskMainWindow), taskMainViewModel), null);
				List<TaskDataViewModel> allTrackingTasks = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>().FilterTrackingTask(allTask);
				taskMainViewModel.SelectTrackingTask(allTrackingTasks);
			}
			else if ("OnObserverTeachEnergyGuide".Equals(optionArg.OptionName))
			{
				onTeachObserverEnergy?.Invoke();
			}
			else if ("OnObserverTeachAIXpGuide".Equals(optionArg.OptionName))
			{
				Transform obj3 = (Transform)optionArg.Obj;
				onTeachObserverAIXp?.Invoke(obj3);
			}
		}
		else if (obj is BattleGMEnum obj4)
		{
			gmAction?.Invoke(obj4);
		}
		else if (obj is LoadingToOtherLevelViewModel loadingToOtherLevelViewModel)
		{
			LoadOtherWorld(loadingToOtherLevelViewModel);
		}
	}

	private void OnOpt(string obj)
	{
	}

	private bool ValidOpt()
	{
		if (!optCommand.Enabled)
		{
			Toast.ShowInfo("您操作太频繁了！");
			return false;
		}
		return true;
	}

	public void OnInteractiveButtonClick()
	{
		if (interactiveViewModel == null)
		{
			Toast.ShowInfo("当前无法交互！");
		}
		else
		{
			interactiveViewModel.OnInteractiveButtonClick();
		}
	}

	private void AddSettingHero(GameSettingViewModel gameSettingViewModel)
	{
		gameSettingViewModel.AddHero(userInfoViewModel?.GetHeroList());
		AddStatusHeroes(gameSettingViewModel);
	}

	private void AddStatusHeroes(GameSettingViewModel gameSettingViewModel)
	{
		if (gameSettingViewModel == null || userInfoViewModel == null)
		{
			return;
		}
		List<StatusSettingViewModel.StatusHeroSnapshot> list = new List<StatusSettingViewModel.StatusHeroSnapshot>();
		Dictionary<int, StatusSettingViewModel.StatusBattleSnapshot> dictionary = new Dictionary<int, StatusSettingViewModel.StatusBattleSnapshot>();
		foreach (KeyValuePair<int, BattleUserViewModel> battleUser in userInfoViewModel.BattleUsers)
		{
			BattleUserViewModel value = battleUser.Value;
			BattleHeroData heroData = value?.HeroData;
			PeripheryHeroData peripheryHeroData = heroData?.HeroModel;
			StatusSettingViewModel.StatusBattleSnapshot snap;
			if (peripheryHeroData != null && !value.IsEmpty)
			{
				StatusSettingViewModel.StatusHeroSnapshot item = new StatusSettingViewModel.StatusHeroSnapshot
				{
					HeroId = peripheryHeroData.Id,
					HeroSkinSuffix = peripheryHeroData.SkinSuffix,
					Weapon = peripheryHeroData.Weapon,
					Attribute = peripheryHeroData.HeroAttributeEnum,
					DestinyLevel = peripheryHeroData.DestinyLevel,
					HeroModel = peripheryHeroData.GetHeroModel()
				};
				list.Add(item);
				snap = new StatusSettingViewModel.StatusBattleSnapshot();
				SetProp("Hp", PropertyType.Max);
				SetProp("Defence", PropertyType.Cur);
				SetProp("Attack", PropertyType.Cur);
				SetProp("Crit", PropertyType.Cur);
				SetProp("CritRadio", PropertyType.Cur);
				SetProp("Energy", PropertyType.Max);
				SetProp("LightDamageRadio", PropertyType.Cur);
				SetProp("DarkDamageRadio", PropertyType.Cur);
				SetProp("WaterDamageRadio", PropertyType.Cur);
				SetProp("FireDamageRadio", PropertyType.Cur);
				SetProp("WindDamageRadio", PropertyType.Cur);
				SetProp("IceDamageRadio", PropertyType.Cur);
				SetProp("ThunderDamageRadio", PropertyType.Cur);
				if (heroData.BuffList != null)
				{
					snap.LiveBuffList = heroData.BuffList;
					snap.BuffList.AddRange(heroData.BuffList);
				}
				dictionary[peripheryHeroData.Id] = snap;
			}
			void SetProp(string key, PropertyType propertyType)
			{
				float property = BattleFormulaUtility.GetProperty(heroData.Entity, key, propertyType);
				snap.PropertyValues[key] = property;
			}
		}
		bool enableRealtimeBuff = !userInfoViewModel.IsSingleGame;
		gameSettingViewModel.AddStatusHeroes(list, dictionary, enableRealtimeBuff);
	}

	public void UpdateHeroEntities(HeroEntity heroEntity)
	{
		_selfEntity = heroEntity;
		_battleEmoteViewModel.InitHeroData(heroEntity);
	}

	public void InitHeroData(int index, BattleHeroData heroData)
	{
		if (userInfoViewModel != null)
		{
			userInfoViewModel.InitHeroData(index, heroData);
		}
	}

	public void AddHeroRebornNumber(int rebornNumber)
	{
		if (userInfoViewModel != null)
		{
			userInfoViewModel.RefreshRebornCount(rebornNumber);
		}
	}

	public void RefreshUserRebornCount(int rebornNumber)
	{
		userInfoViewModel.RefreshRebornCount(rebornNumber);
	}

	public void SetHeroData(int index, BattleHeroData heroData)
	{
		userInfoViewModel.SetHeroData(index, heroData);
	}

	public void SetHeroDataEmpty(int index)
	{
		userInfoViewModel.SetHeroEmpty(index);
	}

	public void SetHaveRealPeople()
	{
		systemInfoViewModel.SetRealPeopel();
	}

	public void AddHeroChange(Action<BattleHeroData, bool> setAiToActor)
	{
		onChangeHero = (Action<BattleHeroData, bool>)Delegate.Combine(onChangeHero, setAiToActor);
	}

	private void OnChangeHero(BattleUserViewModel userViewModel)
	{
		if (ValidOpt())
		{
			onChangeHero?.Invoke(userViewModel.HeroData, arg2: false);
		}
	}

	public void AddReleaseSkill4(Action<int> releaseHeroSkill4)
	{
		onReleaseSkill4 = releaseHeroSkill4;
	}

	private void OnReleaseSkill4(BattleUserViewModel battleUser)
	{
		if (battleUser != null && battleUser.HeroData != null && battleUser.HeroData.Entity != null)
		{
			onReleaseSkill4?.Invoke(battleUser.HeroData.Entity.Id);
		}
	}

	public void AddTeachEnergyGuide(Action teachGuide)
	{
		onTeachObserverEnergy = teachGuide;
	}

	public void AddTeachAIXpEnergyGuide(Action<Transform> teachGuide)
	{
		onTeachObserverAIXp = teachGuide;
	}

	public void ChangeHeroBind(int memberId1, int memberId2)
	{
	}

	public void RefreshUserLayout(TouchLayout layout)
	{
		refreshUserLayoutRequest.Raise(layout);
	}

	public float GetBossHpLeft(GameSettlementType gameSettlementType)
	{
		if (BossInfoViewModel == null || BossInfoViewModel.MonsterData == null)
		{
			return 100f;
		}
		float num = ((BossInfoViewModel.MonsterData.GetPropertyData("Hp") == null) ? 1f : BossInfoViewModel.MonsterData.GetPropertyData("Hp").CurValue);
		float num2 = ((BossInfoViewModel.MonsterData.GetPropertyData("Hp") == null) ? 1f : BossInfoViewModel.MonsterData.GetPropertyData("Hp").MaxValue);
		float num3 = num / num2;
		if (num3 == 0f || gameSettlementType == GameSettlementType.GoldLevelOver)
		{
			return -1f;
		}
		return num3 * 100f;
	}

	private void QuitGame()
	{
		quitGame?.Invoke();
	}

	private void LoadOtherWorld(LoadingToOtherLevelViewModel loadingToOtherLevelViewModel)
	{
		loadOtherWorld?.Invoke(loadingToOtherLevelViewModel);
	}

	public async Task<bool> GameOver(int teamKilled, float bossHpLeft, int mode, int monsterKill, float actorDamage, int actorKillCount, long score)
	{
		return await Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().SendGameOver(teamKilled, GetBattleTime(), bossHpLeft, mode, monsterKill, actorDamage, actorKillCount, score);
	}

	public void AddProcessOperation(Func<ProcessOperationEnum, bool> action)
	{
		onProcessOperation = (Func<ProcessOperationEnum, bool>)Delegate.Combine(onProcessOperation, action);
	}

	private async void OnProcessOperationFinished(ProcessOperationEnum operationEnum, bool success)
	{
		if (success)
		{
			switch (operationEnum)
			{
			case ProcessOperationEnum.GameOver:
				QuitGame();
				break;
			case ProcessOperationEnum.GamePause:
			case ProcessOperationEnum.GameResume:
				break;
			}
		}
	}

	public void AddTeleportAction(Action<string, Action> action)
	{
		onTeleport = (Action<string, Action>)Delegate.Combine(onTeleport, action);
	}

	public void AddRevertAction(Action action)
	{
		onRevert = (Action)Delegate.Combine(onRevert, action);
	}

	public void AddBattleStatGMAction(Action<BattleGMEnum> action)
	{
		gmAction = (Action<BattleGMEnum>)Delegate.Combine(gmAction, action);
	}

	public void SetBattleTimeConfig(int time)
	{
		systemInfoViewModel.SetBattleTimeConfig(time);
	}

	public void SetReverseTime(bool reverse)
	{
		systemInfoViewModel.SetReverseTime(reverse);
	}

	public void SetTriggerTimeOverOnCountDownEnd(bool triggerTimeOver)
	{
		systemInfoViewModel?.SetTriggerTimeOverOnCountDownEnd(triggerTimeOver);
	}

	private void CheckStartBattleTime()
	{
		if (systemInfoViewModel != null)
		{
			if (isStartBattleTime && !systemInfoViewModel.StartCountDown)
			{
				systemInfoViewModel.ShowTime(isShow: true);
				systemInfoViewModel.StartGameCountDown(isStart: true);
			}
			else if (systemInfoViewModel.StartCountDown && !isStartBattleTime)
			{
				systemInfoViewModel.StartGameCountDown(isStart: false);
			}
		}
	}

	public void StartBattleTime(bool isStart)
	{
		isStartBattleTime = isStart;
		CheckStartBattleTime();
	}

	public void StopBattleTime(bool isRefreshTime = true)
	{
		isStartBattleTime = false;
		systemInfoViewModel.ShowTime(isShow: false);
		systemInfoViewModel.StartGameCountDown(isStart: false, isRefreshTime);
	}

	public void BattleTimeElapse(float deltaTime)
	{
		systemInfoViewModel.AddGameTime(deltaTime);
	}

	public void UpdateBossBloodBarData(BattleMonsterData data, HeroAttributeEnum heroAttributeEnum)
	{
		bossBloodBarViewModel.UpdateData(data, heroAttributeEnum);
	}

	public void UpdateBossDownStateTimer(float deltaTime)
	{
		if (bossBloodBarViewModel != null && !(bossBloodBarViewModel.DownFillMax <= 0f))
		{
			bossBloodBarViewModel.DownFill -= deltaTime;
			if (bossBloodBarViewModel.DownFill <= 0f)
			{
				bossBloodBarViewModel.DownFillMax = 0f;
			}
		}
	}

	public void ShowBossBar(bool isShow)
	{
		if (bossBloodBarViewModel != null)
		{
			bossBloodBarViewModel.ShowBar(isShow);
		}
	}

	public void ShowBossName(bool isShow)
	{
		if (bossBloodBarViewModel != null)
		{
			bossBloodBarViewModel.ShowName(isShow);
		}
	}

	public void OpenBattleDS()
	{
		if (!childVMs.ContainsKey(typeof(BattleDSViewModel).FullName))
		{
			BattleDSViewModel battleDSViewModel = new BattleDSViewModel(this, ChildViewParent);
			battleDSViewModel.IsVisible = true;
			AddChildVM(battleDSViewModel);
			AddInitOpenViews(new OpenViewArg(typeof(BattleDSView), battleDSViewModel, "Battle", isOpenWindow: false));
		}
	}

	public void BattleDSComplete(Dictionary<int, EntityStatInfo> battleAccount)
	{
		if (childVMs.ContainsKey(typeof(BattleDSViewModel).FullName))
		{
			GetChildVM<BattleDSViewModel>().OnDataComplete(userInfoViewModel, battleAccount);
		}
	}

	public void RefreshDS(int entityId, EntityStatInfo data, Dictionary<int, EntityStatInfo> total)
	{
		if (childVMs.ContainsKey(typeof(BattleDSViewModel).FullName))
		{
			GetChildVM<BattleDSViewModel>().RefreshDS(entityId, data, total);
		}
	}

	public void ResetAllDS()
	{
		if (childVMs.ContainsKey(typeof(BattleDSViewModel).FullName))
		{
			GetChildVM<BattleDSViewModel>().ResetAllDS();
		}
	}

	public void RefreshSelf()
	{
		if (childVMs.ContainsKey(typeof(BattleDSViewModel).FullName))
		{
			GetChildVM<BattleDSViewModel>().RefreshSelf(userInfoViewModel);
		}
	}

	public void SetBossDownState(bool enterDown, string damageRatio)
	{
		bossBloodBarViewModel?.SetBossDown(enterDown, damageRatio);
		if (childVMs.ContainsKey(typeof(BattleDSViewModel).FullName))
		{
			GetChildVM<BattleDSViewModel>()?.SetBossDown(enterDown);
		}
	}

	public void InitBattleStatView()
	{
		systemInfoViewModel.ShowMenuShort = true;
	}

	public async Task OpenBattleStatWindow(BattleSpecialModeEnum specialModeEnum, List<HeroEntity> heroList)
	{
		battleStatWindowViewModel = new BattleStatWindowModel(this);
		BattleStatWindow obj = await GameEntry.UI.LoadWindow<BattleStatWindow>(AssetUtility.GetUIFormAsset("Battle/BattleStatWindow"), "DEFAULT", battleStatWindowViewModel);
		battleStatWindowViewModel?.OnInit(specialModeEnum, heroList);
		await obj.Show();
	}

	public void StartBattleStatTimer(bool isStart)
	{
		battleStatWindowViewModel?.OnStartTimer(isStart);
	}

	public void RefreshStatInfo(int battleTime, int entityId, EntityStatInfo info, Dictionary<int, EntityStatInfo> total)
	{
		battleStatWindowViewModel?.RefreshStat(battleTime, entityId, info, total.Values.ToList());
	}

	public void ResetStatInfo()
	{
		battleStatWindowViewModel?.ResetStatInfo();
	}

	public void UpdateStatTime(float modeTime)
	{
		battleStatWindowViewModel?.UpdateStatTime(modeTime);
	}

	public void UpdateGMState(BattleGMEnum gmEnum, bool isOpen)
	{
		battleStatWindowViewModel?.UpdateGMState(gmEnum, isOpen);
	}

	public void SetGMInteractable(BattleGMEnum gmEnum, bool isInter)
	{
		battleStatWindowViewModel?.SetGMInteractable(gmEnum, isInter);
	}

	public void OnUpdate(float deltaTime, int worldPing)
	{
		systemInfoViewModel.FPS_Update();
		systemInfoViewModel.SetBattlePing(worldPing);
		tweenInfoViewModel?.OnUpdate(deltaTime);
	}

	public void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		UpdateBossDownStateTimer(deltaTime);
		UpdateSelfEntityTrans();
	}

	private void UpdateSelfEntityTrans()
	{
		if (_selfEntity != null && _selfEntity.transform != null)
		{
			EntityViewComponent component = _selfEntity.GetComponent<EntityViewComponent>();
			if (component != null && component.EntityView != null)
			{
				Transform transform = component.EntityView.transform;
				miniMapViewModel?.UpdateHeroPos(transform.position, transform.rotation);
				taskTargetViewModel?.UpdateHeroPos(transform.position);
				dirPosViewModel.UpdateActorPos(transform.position);
			}
		}
	}

	public int GetBattleTime()
	{
		return systemInfoViewModel.GetBattleTime();
	}

	public void HideTaotieEatUI()
	{
		if (taotieEatViewModel != null)
		{
			taotieEatViewModel.IsVisible = false;
			showViewRequest.Raise(new ShowViewArg(taotieEatViewModel, isShow: false));
		}
	}

	public void ShowTaotieEatUI(List<HeroEntity> heroEntities)
	{
		if (taotieEatViewModel == null)
		{
			taotieEatViewModel = new TaotieEatViewModel(this);
			openWindowRequest.Raise(new OpenViewArg(typeof(TaotieEatView), taotieEatViewModel, "Battle", isOpenWindow: false));
			taotieEatViewModel.IsVisible = true;
			taotieEatViewModel.SetEatHeroList(heroEntities);
		}
		else
		{
			taotieEatViewModel.SetEatHeroList(heroEntities);
			taotieEatViewModel.IsVisible = true;
			showViewRequest.Raise(new ShowViewArg(taotieEatViewModel, isShow: true));
		}
	}

	public void UpdateTaotiePos(Vector3 bossPos)
	{
		if (taotieEatViewModel != null && taotieEatViewModel.IsVisible)
		{
			taotieEatViewModel.UpdateBossPos(bossPos);
		}
	}

	public void SetMiniMapData(MapConfigData mapConfigData)
	{
		miniMapViewModel?.RefreshMiniMapData(mapConfigData);
	}

	public void SetMiniMapVisible(bool visible)
	{
		showMiniMap = visible;
		updateMiniMapRst.Raise();
	}

	public void SetLockMiniMap(bool lockMiniMap)
	{
		miniMapViewModel?.EnableClick(!lockMiniMap);
	}

	public void OpenMapWindow(int levelId, Action cb = null, int trackTaskId = 0, Action<MapFunction> closeCb = null)
	{
		miniMapViewModel?.OpenMapWindow(levelId, cb, trackTaskId, closeCb);
	}

	public void InitAddTaskTarget(int levelId, bool inBattleState)
	{
		if (!childVMs.ContainsKey(typeof(BattleTaskTargetViewModel).FullName))
		{
			taskTargetViewModel = new BattleTaskTargetViewModel(this, levelId, ChildViewParent);
			ITaskServices service = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>();
			List<TaskDataViewModel> list = service.FilterTrackingTask(service.GetDisplayLevelTask(levelId));
			taskTargetViewModel.UpdateItemList(list);
			taskTargetViewModel.InBattleState = inBattleState;
			taskTargetViewModel.SetCavernID(enterCaverId);
			taskTargetViewModel.UpdateTaskUIPos();
			AddChildVM(taskTargetViewModel);
			AddInitOpenViews(new OpenViewArg(typeof(BattleTaskTargetView), taskTargetViewModel, "Battle", isOpenWindow: false));
		}
	}

	public void TaskBtnCanClick(bool lockLick)
	{
		if (taskTargetViewModel != null)
		{
			taskTargetViewModel.TaskBtnCanClick = !lockLick;
		}
	}

	private void OnLevelSaveChanged(LevelSaveMessage message)
	{
		if (message != null && message.MessageType == LevelSaveMessageType.BonfireActiveStateChange)
		{
			OpenBonfireActiveWindow(message.ItemId);
		}
	}

	private void OpenBonfireActiveWindow(int bonfireId)
	{
		BonfireActiveViewModel userData = new BonfireActiveViewModel(this, bonfireId);
		openWindowRequest.Raise(new OpenViewArg(typeof(BonfireActiveWindow), userData));
	}

	public void OpenBonfireMenuWindow(int levelId, int selfHeroId, List<PeripheryHeroData> teamHeroModels, Action<BonfireRestViewModel> callback)
	{
		BonfireMenuViewModel bonfireMenuViewModel = new BonfireMenuViewModel(this, levelId, selfHeroId, teamHeroModels);
		bonfireMenuViewModel.OnFinish = (Action<BonfireRestViewModel>)Delegate.Combine(bonfireMenuViewModel.OnFinish, callback);
		openWindowRequest.Raise(new OpenViewArg(typeof(BonfireMenuWindow), bonfireMenuViewModel), delegate
		{
		});
	}

	public async void OpenShopWindow(int tabIndex = 0, int subTabIndex = 0)
	{
		ShopWindowViewModel userData = new ShopWindowViewModel(this, tabIndex, subTabIndex);
		openWindowRequest.Raise(new OpenViewArg(typeof(ShopWindow), userData));
	}

	public void SendEmote(int emoteConfigId)
	{
		if (!SingleModelShowEmote(emoteConfigId))
		{
			BattleSendEmoteClientMessage battleSendEmoteClientMessage = BattleSendEmoteClientMessage.Create();
			battleSendEmoteClientMessage.UserId = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().Uid;
			battleSendEmoteClientMessage.BattleActorId = _selfEntity.Id;
			battleSendEmoteClientMessage.Index = emoteConfigId;
			Singleton<NetworkSystem>.Instance.Call(battleSendEmoteClientMessage);
		}
	}

	public void SendEmote(int emoteConfigId, HeroEntity heroEntity)
	{
		if (!SingleModelShowEmote(emoteConfigId))
		{
			BattleSendEmoteClientMessage battleSendEmoteClientMessage = BattleSendEmoteClientMessage.Create();
			battleSendEmoteClientMessage.UserId = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().Uid;
			battleSendEmoteClientMessage.BattleActorId = heroEntity.Id;
			battleSendEmoteClientMessage.Index = emoteConfigId;
			Singleton<NetworkSystem>.Instance.Call(battleSendEmoteClientMessage);
		}
	}

	private bool SingleModelShowEmote(int emoteConfigId)
	{
		if (_battleMode == BattleWorldMode.SingleBattle)
		{
			_battleEmoteViewModel.ShowEmote(_selfEntity.BattleHeroData?.GetEmoteModelByConfigId(emoteConfigId), _selfEntity);
			return true;
		}
		return false;
	}

	public void ShowTaskTime(bool isShow)
	{
		if (systemInfoViewModel != null)
		{
			systemInfoViewModel.ShowTaskTime = isShow;
		}
	}

	public void SetSystemShowInfo(bool isShowBag, bool isShowPing, AutoFightToogleEnum autoFightToogleEnum)
	{
		if (systemInfoViewModel != null)
		{
			systemInfoViewModel.ShowBagIcon = isShowBag;
			systemInfoViewModel.ShowBattlePing = isShowPing;
			systemInfoViewModel.AutoFightToogleEnum = autoFightToogleEnum;
		}
	}

	public void SetTaskTime(int time)
	{
		if (systemInfoViewModel != null)
		{
			systemInfoViewModel.SetTaskTime(time);
		}
	}

	public void HideInteractiveView()
	{
		if (interactiveViewModel != null)
		{
			interactiveViewModel.Active = false;
			interactiveViewModel.SetInteractiveCallback(null);
		}
	}

	private void AddInitOpenViews(OpenViewArg openViewArg)
	{
		initOpenViews.Add(openViewArg);
	}

	private T GetChildVM<T>() where T : OptionBase
	{
		if (childVMs.ContainsKey(typeof(T).FullName))
		{
			return (T)childVMs[typeof(T).FullName];
		}
		return null;
	}

	private void AddChildVM<T>(T child) where T : OptionBase
	{
		if (!childVMs.ContainsKey(typeof(T).FullName))
		{
			childVMs.Add(typeof(T).FullName, child);
		}
	}

	public override void Close()
	{
		_monsterCopyViewModel?.Close();
		_battleEmoteViewModel?.Close();
		taskTargetViewModel?.Close();
		battleStatWindowViewModel?.Close();
		npcPopDialogViewModel?.Close();
		tweenInfoViewModel.Close();
		miniMapViewModel?.Close();
		interactiveViewModel?.Close();
		systemInfoViewModel?.Close();
		bossBloodBarViewModel?.Close();
		userInfoViewModel?.Close();
		base.Close();
	}

	public void SetPause(bool isPause)
	{
		userInfoViewModel.SetPause(isPause);
		taskTargetViewModel?.SetPause(isPause);
	}

	public void ActorBattleStateChange(bool battleStateResult)
	{
		if (taskTargetViewModel != null)
		{
			taskTargetViewModel.InBattleState = battleStateResult;
		}
	}

	public void HideSetWindowQuitBtn()
	{
		hideSetWindowQuitBtn = true;
	}

	public void HidePanel(bool isShow, bool xpCastingWindow)
	{
		showUIStatis += (isShow ? 1 : (-1));
		hidePanelRequest.Raise(showUIStatis >= 0);
		if (xpCastingWindow && battleStatWindowViewModel != null)
		{
			battleStatWindowViewModel.IsVisible = showUIStatis >= 0;
		}
	}

	public void SetBossShowUp(bool showUp)
	{
		bossBloodBarViewModel?.Show(showUp, _battleMode == BattleWorldMode.LevelBattle);
		if (childVMs.ContainsKey(typeof(BattleDSViewModel).FullName))
		{
			GetChildVM<BattleDSViewModel>()?.SetBossShowUp(showUp);
		}
	}

	public int AddDirUI(string iconName, Vector3 pos)
	{
		if (dirPosViewModel == null)
		{
			return 0;
		}
		return dirPosViewModel.AddDirUI(iconName, pos);
	}

	public void RemoveDirUIById(int index)
	{
		if (dirPosViewModel != null)
		{
			dirPosViewModel.RemoveDirUI(index);
		}
	}

	public void RemoveAllDirUI()
	{
		if (dirPosViewModel != null)
		{
			dirPosViewModel.RemoveAllDirUI();
		}
	}
}
