#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class BattleResultViewModel : OptionBase
{
	private SimpleCommand openHeroCultivateCmd;

	private SimpleCommand openWeaponCmd;

	private SimpleCommand openArmourCmd;

	private SimpleCommand openHeroTalendCmd;

	private SimpleCommand openCopyCmd;

	private SimpleCommand openTeamWindowCmd;

	private SimpleCommand openCopyType4Cmd;

	private BattleResultShowType resultShowType;

	private int copyMaxStar;

	private int copyGetStar;

	private List<TabItemNormalData> starList;

	private int score;

	private bool higherScore;

	private BattleReward battleReward;

	private string battleTitle;

	private string battleValue;

	private string rewardTitle;

	private List<KnapsackItemViewModel> rewardList;

	private KnapsackItemViewModel selectedItem;

	private bool showAddLikability;

	private RoleViewModel roleViewModel;

	private string roleExpAdd;

	private float roleOldExpFill;

	private float roleCurExpFill;

	private CopyData copyData;

	private bool isMulti;

	private bool isWin;

	private List<GamerHeadInfoViewModel> gamersInfo;

	private BattleWorldMode worldMode;

	private List<TeamMember> teamList;

	private float time;

	public bool Canslider;

	private VoiceGroup voiceGroup;

	private Type4ProgressViewModel type4ProgressVM;

	private Dictionary<int, Dictionary<int, BSData>> _battleAccount;

	private BattleStatisticViewModel statisticViewModel;

	private bool isStatisticOpen;

	private List<int> battlePropIdList = new List<int>();

	private int battlePropIndex;

	public List<KnapsackItemViewModel> RewardList => rewardList;

	public float RoleOldExpFill => roleOldExpFill;

	public float RoleCurExpFill => roleCurExpFill;

	public string RoleExpAdd => roleExpAdd;

	public List<TeamMember> TeamList => teamList;

	public bool IsMulti => isMulti;

	public List<GamerHeadInfoViewModel> GamersInfo => gamersInfo;

	public RoleViewModel RoleViewModel => roleViewModel;

	public bool IsWin => isWin;

	public float Time => time;

	public int CopyMaxStar => copyMaxStar;

	public int CopyGetStar => copyGetStar;

	public List<TabItemNormalData> StarList => starList;

	public string BattleTitle => battleTitle;

	public string BattleValue => battleValue;

	public string RewardTitle => rewardTitle;

	public int Score => score;

	public BattleResultShowType ResultShowType => resultShowType;

	public bool HigherScore => higherScore;

	public bool ShowAddLikability => showAddLikability;

	public SimpleCommand OpenHeroCultivateCmd => openHeroCultivateCmd;

	public SimpleCommand OpenWeaponCmd => openWeaponCmd;

	public SimpleCommand OpenArmourCmd => openArmourCmd;

	public SimpleCommand OpenHeroTalendCmd => openHeroTalendCmd;

	public SimpleCommand OpenCopyCmd => openCopyCmd;

	public SimpleCommand OpenTeamWindowCmd => openTeamWindowCmd;

	public SimpleCommand OpenCopyType4Cmd => openCopyType4Cmd;

	public Type4ProgressViewModel Type4ProgressVm => type4ProgressVM;

	public BattleReward BattleReward => battleReward;

	public bool IsCampaignMultiBattle
	{
		get
		{
			if (IsMulti && copyData != null)
			{
				return copyData.CopyMainId == 91;
			}
			return false;
		}
	}

	public BattleResultViewModel(CopyData copyData, List<TeamMember> teamMembers, RoleViewModel roleViewModel, bool isSingleBattle, Dictionary<int, Dictionary<int, BSData>> accounts, BattleReward battleReward, List<KnapsackItemViewModel> rewardList)
	{
		Canslider = true;
		gamersInfo = new List<GamerHeadInfoViewModel>();
		voiceGroup = Singleton<AudioSystem>.Instance.RegisterGroup(VoiceGroupEnum.BattleResult);
		this.battleReward = battleReward;
		LoadDefault(copyData, teamMembers, roleViewModel);
		_battleAccount = accounts;
		worldMode = (isSingleBattle ? BattleWorldMode.SingleBattle : BattleWorldMode.SyncBattle);
		showAddLikability = battleReward.CostEnergy > 0;
		isMulti = battleReward.IsMulti;
		if (IsMulti)
		{
			LoadTeamInfo(battleReward);
		}
		isWin = battleReward.IsWin;
		roleCurExpFill = ((roleViewModel.PlayerInfo.MaxExp == 0L) ? 1f : ((float)roleViewModel.PlayerInfo.Exp / (float)roleViewModel.PlayerInfo.MaxExp));
		roleOldExpFill = ((roleViewModel.PlayerInfo.MaxExp == 0L) ? 1f : ((float)battleReward.AccountOldExp / (float)roleViewModel.PlayerInfo.MaxExp));
		roleOldExpFill = ((battleReward.IsUpgrade && roleViewModel.PlayerInfo.MaxExp != 0L) ? 0f : roleOldExpFill);
		roleExpAdd = $"EXP  +{battleReward.AccountExpDelta}";
		score = battleReward.RaceCopyScore;
		higherScore = battleReward.IsNewRecord;
		time = battleReward.PassTime;
		LoadStar(battleReward.Star);
		foreach (KnapsackItemViewModel reward in rewardList)
		{
			reward.SetParent(this);
		}
		this.rewardList = rewardList;
		foreach (KnapsackItemViewModel reward2 in this.rewardList)
		{
			reward2.SetParent(this);
		}
		RewardList.Sort(new BattleRewardItemSort());
		resultShowType = BattleResultShowType.StarAndTime;
		switch (copyData.CopyMainId)
		{
		case 1:
		case 2:
			resultShowType = BattleResultShowType.StarAndTime;
			break;
		case 3:
			resultShowType = BattleResultShowType.Score;
			break;
		case 4:
			resultShowType = BattleResultShowType.CopyMainType4;
			break;
		case 5:
			resultShowType = BattleResultShowType.Score;
			break;
		case 6:
		case 7:
		case 8:
			resultShowType = BattleResultShowType.StarAndTime;
			break;
		case 91:
		{
			bool isCampaignWorldBoss = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetIsCampaignWorldBoss(copyData.Id);
			resultShowType = ((!isCampaignWorldBoss) ? BattleResultShowType.StarAndTime : BattleResultShowType.Score);
			break;
		}
		default:
			var (flag, gAECopyShowTypeEnum) = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().CheckGuildCopy(copyData);
			if (flag)
			{
				resultShowType = ((gAECopyShowTypeEnum != GAECopyShowTypeEnum.Final) ? BattleResultShowType.StarAndTime : BattleResultShowType.Score);
			}
			else
			{
				resultShowType = BattleResultShowType.StarAndTime;
			}
			break;
		}
		if (resultShowType == BattleResultShowType.CopyMainType4)
		{
			List<CopyData> zoneAllCopyByCopyId = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().GetZoneAllCopyByCopyId(copyData.Id);
			type4ProgressVM = new Type4ProgressViewModel(this, copyData, zoneAllCopyByCopyId, isWin);
		}
		battleTitle = ((resultShowType == BattleResultShowType.Score) ? "战斗积分" : "战斗时间");
		battleValue = ((resultShowType == BattleResultShowType.Score) ? $"{Score}" : GetTime());
		rewardTitle = ((resultShowType == BattleResultShowType.CopyMainType4) ? "裂隙进度" : "战斗奖励");
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is KnapsackItemViewModel knapsackItemViewModel)
		{
			selectedItem = knapsackItemViewModel;
			OpenViewArg openViewArg = knapsackItemViewModel.OpenPopupWindow(this, null, showOutsideMask: true, showOwnCount: true, allowSkipWindow: false);
			if (openViewArg != null)
			{
				openWindowRequest.Raise(openViewArg);
				Canslider = false;
			}
		}
		else if (obj is PropInfoViewModel || obj is PropWindowViewModel)
		{
			Canslider = true;
		}
		else
		{
			if (!(obj is OptionArg optionArg))
			{
				return;
			}
			if (optionArg.OptionName.Equals("Close"))
			{
				Canslider = true;
			}
			else if (optionArg.OptionName.Equals("ChangeLock"))
			{
				if (selectedItem != null)
				{
					selectedItem.IsSelected = !selectedItem.IsSelected;
					if (selectedItem.PropDataBase is WeaponData weaponData)
					{
						weaponData.IsLock = selectedItem.IsSelected;
					}
					if (selectedItem.PropDataBase is ArmourData armourData)
					{
						armourData.IsLock = selectedItem.IsSelected;
					}
				}
			}
			else if (optionArg.OptionName.Equals("EnterNextBattle"))
			{
				if (optionArg.Obj != copyData)
				{
					OpenNextScene((CopyData)optionArg.Obj);
				}
			}
			else if (optionArg.OptionName.Equals("ReturnNextCopy"))
			{
				int num = 0;
				int curId = 0;
				if (type4ProgressVM != null)
				{
					num = type4ProgressVM.GetCurId(1);
					curId = type4ProgressVM.GetCurId(2);
				}
				else
				{
					num = copyData.Id;
				}
				Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().SetType4ReturnCopy((List<CopyData>)optionArg.Obj, num, curId);
				OpenWindow("ReturnNextCopy");
			}
		}
	}

	private void Type4OnNext()
	{
		if (type4ProgressVM != null)
		{
			OptionArg nextCopyData = type4ProgressVM.GetNextCopyData();
			if (nextCopyData == null)
			{
				Toast.ShowInfo("进入下个挑战失败！");
			}
			else
			{
				ItemOnClick(nextCopyData);
			}
		}
	}

	public string GetTime()
	{
		int num = (int)(Time / 60f) % 60;
		int num2 = (int)Time % 60;
		return $"{num:00}:{num2:00}";
	}

	private void LoadDefault(CopyData copyData, List<TeamMember> teamMembers, RoleViewModel roleViewModel)
	{
		openHeroCultivateCmd = new SimpleCommand(OpenHeroUpgrade);
		openWeaponCmd = new SimpleCommand(OpenWeapon);
		openArmourCmd = new SimpleCommand(OpenArmour);
		openHeroTalendCmd = new SimpleCommand(OpenHeroTalend);
		openCopyCmd = new SimpleCommand(OpenCopy);
		openTeamWindowCmd = new SimpleCommand(OpenTeamWindow);
		openCopyType4Cmd = new SimpleCommand(Type4OnNext);
		teamList = new List<TeamMember>();
		rewardList = new List<KnapsackItemViewModel>();
		this.copyData = copyData;
		this.roleViewModel = roleViewModel;
		foreach (TeamMember teamMember in teamMembers)
		{
			if (teamMember.IsSelf)
			{
				teamList.Add(teamMember);
			}
		}
		foreach (TeamMember teamMember2 in teamMembers)
		{
			if (!teamMember2.IsSelf)
			{
				teamList.Add(teamMember2);
			}
		}
	}

	public void OpenStatistic()
	{
		if (!isStatisticOpen && _battleAccount != null)
		{
			if (statisticViewModel == null)
			{
				statisticViewModel = new BattleStatisticViewModel(this, teamList, _battleAccount, worldMode);
				isStatisticOpen = true;
			}
			Canslider = false;
			openWindowRequest.Raise(new OpenViewArg(typeof(BattleStatisticWindow), statisticViewModel), delegate
			{
				isStatisticOpen = false;
				Canslider = true;
			});
		}
	}

	private void LoadTeamInfo(BattleReward battleReward)
	{
		foreach (TeamInfo teamInfo in battleReward.TeamInfos)
		{
			foreach (TeamMember team in teamList)
			{
				if (teamInfo.UserId == team.uid)
				{
					GamerHeadInfoViewModel item = new GamerHeadInfoViewModel(this, teamInfo, team.HeroModel.Original);
					gamersInfo.Add(item);
				}
			}
		}
	}

	private bool CheckIsCampaignHomeowner()
	{
		if (copyData.CopyMainId == 91)
		{
			return teamList.Exists((TeamMember p) => p.IsSelf && p.MemberId == 1);
		}
		return false;
	}

	private void OpenCopy()
	{
		openCopyCmd.Enabled = false;
		string text = "";
		text = ((!CheckIsCampaignHomeowner()) ? ((copyData.CopyMainId == Constant.ConstantConfig.GuildCopyType) ? "GuildCopy" : ((copyData.CopyMainId == 6 || copyData.CopyMainId == 7 || copyData.CopyMainId == 8) ? "OperatingActivityWindow" : "Copy")) : "CampaignMapWindow");
		OpenWindow(text);
	}

	private void OpenHeroUpgrade()
	{
		openHeroCultivateCmd.Enabled = false;
		OpenWindow("HeroCultivateWindow");
	}

	private void OpenWeapon()
	{
		openWeaponCmd.Enabled = false;
		OpenWindow("WeaponUpgrade");
	}

	private void OpenArmour()
	{
		openArmourCmd.Enabled = false;
		OpenWindow("ArmourUpgrade");
	}

	private void OpenHeroTalend()
	{
		openHeroTalendCmd.Enabled = false;
		OpenWindow("HeroTalend");
	}

	private void OpenTeamWindow()
	{
		openTeamWindowCmd.Enabled = false;
		if (!Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().GetCanReturnRoom())
		{
			Toast.ShowInfo("因主动退出,无法返回队伍!");
			OpenCopy();
			Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().SetCanReturnRoom(value: true);
		}
		else
		{
			OpenWindow((worldMode == BattleWorldMode.SyncBattle) ? "MultiTeam" : "SingleTeam");
		}
	}

	public void OpenLevelUpTip()
	{
		Canslider = false;
		if (battleReward.IsUpgrade)
		{
			LevelUpTipViewModel userData = new LevelUpTipViewModel(this, roleViewModel.PlayerInfo.Level);
			openWindowRequest.Raise(new OpenViewArg(typeof(LevelUpTipWindow), userData), delegate
			{
				OpenBattleProp();
			});
		}
		else
		{
			OpenBattleProp();
		}
	}

	private void OpenBattleProp()
	{
		foreach (KnapsackItemViewModel reward in RewardList)
		{
			if (reward.PropDataBase.PropTypeEnum == PropTypeEnum.BattlePropDrawing)
			{
				battlePropIdList.Add(reward.PropDataBase.ExValue);
			}
		}
		OpenGetBattlePropWindow();
	}

	private void OpenGetBattlePropWindow()
	{
		if (battlePropIdList.Count == 0 || battlePropIdList.Count <= battlePropIndex)
		{
			Canslider = true;
			OpenGameScoreWindow();
		}
		else
		{
			OpenGetBattlePropWindow(battlePropIdList[battlePropIndex]);
		}
	}

	private void OpenGameScoreWindow()
	{
		if (GameEntry.BuiltinData.OpenTestFlight || !battleReward.IsFirst)
		{
			return;
		}
		DRGameScore[] dataRows = GameEntry.DataTable.GetDataRows((DRGameScore p) => p.Type == 2);
		foreach (DRGameScore dRGameScore in dataRows)
		{
			if (dRGameScore != null && dRGameScore.EventId.Exists((int p) => p.Equals(copyData.Id)) && Singleton<ServiceSystem>.Instance.GetService<IGameNewsTipService>().CheckOpenScoreWindow(dRGameScore.Id))
			{
				openWindowRequest.Raise(new OpenViewArg(typeof(GameScoreWindow), new GameScoreViewModel(this, dRGameScore.Id, copyData.Name)));
				break;
			}
		}
	}

	private void OpenGetBattlePropWindow(int battlePropId)
	{
		BPData bPData = Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().ShowBattlePropDrawingGet(battlePropId);
		if (bPData != null)
		{
			BattlePropGetViewModel userData = new BattlePropGetViewModel(bPData, bPData.Level == 1, bPData.Level - 1);
			openWindowRequest.Raise(new OpenViewArg(typeof(BattlePropGetWindow), userData), delegate
			{
				battlePropIndex++;
				OpenGetBattlePropWindow();
			});
		}
	}

	private async void OpenWindow(string name)
	{
		if (IsMulti && !name.Equals("MultiTeam"))
		{
			Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().SendLeaveCopyRequest();
		}
		string sceneLoadPath = Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().GetSceneLoadPath();
		LoadingBackToMainViewModel loadingBackToMainViewModel = new LoadingBackToMainViewModel(sceneLoadPath, autoUnload: true, name);
		DRLoadingTips randomLoadingTap = await Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().PrepareLoading(GameProcessType.Outer);
		loadingBackToMainViewModel.SetRandomLoadingTap(randomLoadingTap);
		await GameEntry.UI.OpenWindow<LoadingWindow>("Loading/LoadingWindow", "LOADING", loadingBackToMainViewModel);
		await UniTask.WaitUntil(() => loadingBackToMainViewModel.IsLoadingFinish);
		bool loadingSuccess = loadingBackToMainViewModel.LoadingSuccess;
		if (loadingBackToMainViewModel.LoadingSuccess)
		{
			dismissRequest.Raise();
			await loadingBackToMainViewModel.CloseLoading();
		}
		Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().SetSceneLoadPath(null);
		Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().LoadingEnd(loadingSuccess);
	}

	private async void OpenNextScene(CopyData copyData)
	{
		Loading loading = await Loading.Show();
		try
		{
			Singleton<ServiceSystem>.Instance.GetService<IHeroService>().ClearHeroAdditionalDatas();
			if (!(await Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetType4CopySettingInfos(copyData)))
			{
				Log.Error("获取深渊副本组队配置失败");
			}
			CopyType4TeamConfig teamConfig = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().GetTeamConfig(copyData.Id);
			List<int> heroList = teamConfig.HeroList;
			List<TeamMember> teamMembers = new List<TeamMember>();
			for (int i = 0; i < 3; i++)
			{
				HeroModel heroById = teamConfig.GetHeroById((heroList.Count > i) ? heroList[i] : 0);
				if (!heroById.IsNullOrEmpty())
				{
					bool flag = i + 1 == 1;
					teamMembers.Add(new TeamMember(i + 1, flag, heroById, flag, !flag));
				}
				if (i == 0 && teamConfig.BpList != null && teamConfig.BpList.Count > 0)
				{
					Dictionary<int, BPData> dictionary = new Dictionary<int, BPData>();
					for (int j = 0; j < teamConfig.BpList.Count; j++)
					{
						BPData bpDataById = Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().GetBpDataById(teamConfig.BpList[j]);
						dictionary.Add((j == 0) ? 1 : 2, bpDataById);
					}
					heroById.AddBPData(dictionary);
				}
			}
			CopyEnterInfoData copyEnterInfoData = await Singleton<ServiceSystem>.Instance.GetService<ICopyService>().EnterBattleWorld(copyData, heroList, teamMembers, 0, 0, null);
			if (copyEnterInfoData != null)
			{
				List<PeripheryHeroData> list = new List<PeripheryHeroData>();
				for (int k = 0; k < teamMembers.Count; k++)
				{
					list.Add(teamMembers[k].GetPeripheryHeroData());
				}
				List<AchievementMedal> battleAchievementMedals = Singleton<ServiceSystem>.Instance.GetService<IAchievementService>().GetBattleAchievementMedals(copyData.CopyType == 99000 || copyData.CopyType == 99100);
				WorldData worldData = BattleWorldData.CreateBattleWorldData(0u, copyData.SceneName, copyData.Id, copyData.GetBossId(0), copyData.MapData, copyData.NavMeshId, list, teamMembers, null, battleAchievementMedals);
				worldData.RoomId = copyEnterInfoData.RoomId;
				worldData.RandomSeed = copyEnterInfoData.SeedID;
				worldData.IsBattleSend = copyEnterInfoData.IsBattleSend;
				loading.Dispose();
				LoadingToNextBattleViewModel loadingViewModel = new LoadingToNextBattleViewModel("Copy/" + this.copyData.SceneName, autoUnload: true, worldData);
				DRLoadingTips randomLoadingTap = await Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().PrepareLoading(GameProcessType.Battle);
				loadingViewModel.SetRandomLoadingTap(randomLoadingTap);
				await GameEntry.UI.OpenWindow<LoadingWindow>("Loading/LoadingWindow", "LOADING", loadingViewModel);
				await UniTask.WaitUntil(() => loadingViewModel.IsLoadingFinish);
				if (loadingViewModel.LoadingSuccess)
				{
					UIWindowHelper.WindowRelease();
					await loadingViewModel.CloseLoading();
					Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().LoadingEnd(loadingViewModel.LoadingSuccess);
					Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().AddEnterCopyTDA(copyEnterInfoData);
					dismissRequest.Raise();
				}
			}
		}
		catch (Exception ex)
		{
			Toast.ShowInfo("进入下一场景失败！");
			Log.Error("进入下一场景失败！ " + ex.Message + "/" + ex.StackTrace);
			loading.Dispose();
		}
	}

	private void LoadStar(int starCount)
	{
		DRStarCondition[] dataRows = GameEntry.DataTable.GetDataTable<DRStarCondition>().GetDataRows((DRStarCondition p) => p.CopyId == copyData.Id);
		if (!UiConvert.TextConvert.DebugDataTable(dataRows, "战斗结算条件", copyData.Id))
		{
			return;
		}
		starList = new List<TabItemNormalData>();
		copyMaxStar = dataRows.Length;
		copyGetStar = 0;
		for (int num = 0; num < dataRows.Length; num++)
		{
			bool flag = Bitwise(starCount, num);
			TabItemNormalData tabItemNormalData = new TabItemNormalData(Translate(dataRows[num].StarCondition, dataRows[num].StarConditionNum, dataRows[num].JudgingCondition));
			tabItemNormalData.SetSelected(flag);
			tabItemNormalData.SetCanOnClick(value: true);
			starList.Add(tabItemNormalData);
			if (flag)
			{
				copyGetStar++;
			}
		}
	}

	private string Translate(int condition, float num, int judging)
	{
		string text = "";
		DRStarConditionList dataRow = GameEntry.DataTable.GetDataRow<DRStarConditionList>(condition);
		if (dataRow != null)
		{
			text += dataRow.StarCondition;
			text = judging switch
			{
				1 => text + "不超过", 
				2 => text + "低于", 
				_ => text + "等于", 
			} + $"{num}{dataRow.Suffix}";
		}
		if (condition == 1002 && judging == 1 && num == 0f)
		{
			return "队伍中无人战败";
		}
		if (condition == 1003)
		{
			return "消灭全部敌人";
		}
		return text;
	}

	private bool Bitwise(int num, int index)
	{
		return (num & (1 << index)) > 0;
	}

	public void PlayBattleResultAudio()
	{
		int voiceType = (IsWin ? 8 : 7);
		HeroModel heroModel = TeamList[0].HeroModel;
		DRVoice heroSkinVoiceConfig = HeroDefinition.GetHeroSkinVoiceConfig(heroModel.Id, heroModel.SkinConfigId, voiceType);
		if (heroSkinVoiceConfig != null)
		{
			voiceGroup.Stop();
			voiceGroup.Play(heroSkinVoiceConfig.VoiceId);
		}
	}

	public void StopBattleResultAudio()
	{
		voiceGroup.Dispose(stopVoice: true);
		Singleton<AudioSystem>.Instance.UnRegisterGroup(VoiceGroupEnum.BattleResult, stopVoice: true);
		voiceGroup = null;
	}

	public override void Dispose()
	{
		StopBattleResultAudio();
		base.Dispose();
	}
}
