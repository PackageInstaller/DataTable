#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using FMOD.Studio;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class MultiRoomViewModel : OptionBase
{
	private long roomId;

	private long uid;

	private SimpleCommand startCommand;

	private SimpleCommand matchCommand;

	private SimpleCommand backCommand;

	private SimpleCommand openFriendWindowCmd;

	private SimpleCommand sendRecruitCmd;

	private SimpleCommand readyCmd;

	private bool isMatch;

	private bool isCaptain;

	private bool isLeavingRoom;

	private MoneyData moneyData;

	private CopyData copyData;

	private ChatBarViewModel chatBar;

	private FriendWindowViewModel friendWindowViewModel;

	private Timer timer;

	private InteractionRequest refreshAttributeRequest;

	private InteractionRequest refreshMatchBpRequest;

	private HeroChangeViewModel heroChangeViewModel;

	private int waitTime;

	private string waitTimeText;

	private bool showEffect;

	private MultiRoomFunctionViewModel multiRoomFunctionViewModel;

	private bool isFirstGame;

	public int playerEnterSound;

	public int playerOutSound;

	private EventInstance _playerEnterIns;

	private EventInstance _playerOutIns;

	private VoiceGroup voiceGroup;

	private List<MultiRoomPlayerViewModel> gamerInfoList;

	private List<MultiRoomCostItemData> multiRoomCostItemDataList;

	private MultiRoomCostItemData curCostItemData;

	private int mode;

	private bool showCost;

	private bool showCostItemList;

	private string costPropIcon;

	private int costPropCount;

	private string curCostDesc;

	private float costPropRate;

	private bool costEnough;

	private PropDataBase costProp;

	private bool showCostProp;

	private bool isReady;

	private bool showMatch;

	private string btnReadyText;

	private string teamLevelTipText;

	private bool hasCopyBuff;

	private List<int> adItemList;

	private TeamAttributeViewModel _teamAttributeViewModel;

	private ISubscription<MoneyMessage> subscription_moneyMsg;

	private int levelFix;

	private bool isInLoading;

	private int recruitCD;

	private ISubscription<MatchRoomUserChangeNotify> subscription_TeammateChange;

	private ISubscription<TeamRoomMatchEnterNotify> subscription_TeamRoomMatchEnterNotify;

	private ISubscription<MultiFightStartFightNotify> subscription_FightStartFight;

	private ISubscription<MultiFightStartMatchNotify> subscription_FightStartMatch;

	private ISubscription<MultiFightStopMatchNotify> subscription_FightStopMatch;

	private ISubscription<MultiFightMatchSuccessNotify> subscription_MultiFightMatchSuccessNotify;

	private ISubscription<MultiFightInviteFeedbackNotify> subscription_InviteFeedBack;

	private ISubscription<MultiFightUserStateChangeNotify> subscription_FightUserStateChange;

	private ISubscription<MultiFightBeKickNotify> subscription_BeKick;

	private ISubscription<MultiFightPreEnterSettingRoomNotify> subscription_EnterSettingRoom;

	private ISubscription<TeamRoomChangeSelectRoleNotify> subscription_HeroChange;

	private ISubscription<MultiFightSettingRoomUserStateChangeNotify> subscription_UpdateState;

	private ISubscription<BattleChangeBattlePropNotify> subscription_BattlePropChange;

	private ISubscription<MultiFightDisbandNotify> subscription_Disband;

	private Timer recruitTimer;

	public CopyData CopyData
	{
		get
		{
			return copyData;
		}
		private set
		{
			Set(ref copyData, value, "CopyData");
		}
	}

	public List<MultiRoomPlayerViewModel> GamerInfoList
	{
		get
		{
			return gamerInfoList;
		}
		private set
		{
			Set(ref gamerInfoList, value, "GamerInfoList");
		}
	}

	public MoneyData MoneyData
	{
		get
		{
			return moneyData;
		}
		private set
		{
			Set(ref moneyData, value, "MoneyData");
		}
	}

	public int Mode
	{
		get
		{
			return mode;
		}
		private set
		{
			Set(ref mode, value, "Mode");
		}
	}

	public bool ShowEffect
	{
		get
		{
			return showEffect;
		}
		private set
		{
			Set(ref showEffect, value, "ShowEffect");
		}
	}

	public bool IsMatch
	{
		get
		{
			return isMatch;
		}
		private set
		{
			Set(ref isMatch, value, "IsMatch");
			ChangePlayerInviteIconObj();
		}
	}

	public bool IsCaptain
	{
		get
		{
			return isCaptain;
		}
		private set
		{
			Set(ref isCaptain, value, "IsCaptain");
		}
	}

	public bool IsReady
	{
		get
		{
			return isReady;
		}
		private set
		{
			Set(ref isReady, value, "IsReady");
		}
	}

	public bool ShowMatch
	{
		get
		{
			return showMatch;
		}
		private set
		{
			Set(ref showMatch, value, "ShowMatch");
		}
	}

	public string BtnReadyText
	{
		get
		{
			return btnReadyText;
		}
		private set
		{
			Set(ref btnReadyText, value, "BtnReadyText");
		}
	}

	public string TeamLevelTipText
	{
		get
		{
			return teamLevelTipText;
		}
		private set
		{
			Set(ref teamLevelTipText, value, "TeamLevelTipText");
		}
	}

	public bool ShowCostItemList
	{
		get
		{
			return showCostItemList;
		}
		private set
		{
			Set(ref showCostItemList, value, "ShowCostItemList");
		}
	}

	public bool ShowCost
	{
		get
		{
			return showCost;
		}
		set
		{
			Set(ref showCost, value, "ShowCost");
		}
	}

	public MultiRoomFunctionViewModel MultiRoomFunctionViewModel
	{
		get
		{
			return multiRoomFunctionViewModel;
		}
		private set
		{
			Set(ref multiRoomFunctionViewModel, value, "MultiRoomFunctionViewModel");
		}
	}

	public List<MultiRoomCostItemData> MultiRoomCostItemDataList
	{
		get
		{
			return multiRoomCostItemDataList;
		}
		private set
		{
			Set(ref multiRoomCostItemDataList, value, "MultiRoomCostItemDataList");
		}
	}

	public string WaitTimeText
	{
		get
		{
			return waitTimeText;
		}
		private set
		{
			Set(ref waitTimeText, value, "WaitTimeText");
		}
	}

	public List<int> AdItemList => adItemList;

	public bool HasCopyBuff
	{
		get
		{
			return hasCopyBuff;
		}
		private set
		{
			Set(ref hasCopyBuff, value, "HasCopyBuff");
		}
	}

	public bool IsFirstGame => isFirstGame;

	public TeamAttributeViewModel TeamAttributeViewModel => _teamAttributeViewModel;

	public InteractionRequest RefreshMatchBpRequest => refreshMatchBpRequest;

	public ICommand BackCommand => backCommand;

	public ICommand StartCommand => startCommand;

	public ICommand MatchCommand => matchCommand;

	public SimpleCommand OpenFriendWindowCmd => openFriendWindowCmd;

	public SimpleCommand SendRecruitCmd => sendRecruitCmd;

	public SimpleCommand ReadyCmd => readyCmd;

	public ChatBarViewModel ChatBar => chatBar;

	public bool CostEnough
	{
		get
		{
			return costEnough;
		}
		set
		{
			Set(ref costEnough, value, "CostEnough");
		}
	}

	public string CurCostDesc
	{
		get
		{
			return curCostDesc;
		}
		set
		{
			Set(ref curCostDesc, value, "CurCostDesc");
		}
	}

	public string CostPropIcon
	{
		get
		{
			return costPropIcon;
		}
		set
		{
			Set(ref costPropIcon, value, "CostPropIcon");
		}
	}

	public int CostPropCount
	{
		get
		{
			return costPropCount;
		}
		set
		{
			Set(ref costPropCount, value, "CostPropCount");
		}
	}

	public float CostPropRate
	{
		get
		{
			return costPropRate;
		}
		set
		{
			Set(ref costPropRate, value, "CostPropRate");
		}
	}

	public bool ShowCostProp
	{
		get
		{
			return showCostProp;
		}
		set
		{
			Set(ref showCostProp, value, "ShowCostProp");
		}
	}

	public MultiRoomViewModel(OptionBase parent, CopyData copyData, List<MatchRoomUserInfo> gamerInfos, bool loadCacheDropRate = false)
	{
		//IL_0147: Unknown result type (might be due to invalid IL or missing references)
		//IL_014c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0164: Unknown result type (might be due to invalid IL or missing references)
		//IL_0169: Unknown result type (might be due to invalid IL or missing references)
		refreshMatchBpRequest = new InteractionRequest();
		multiRoomCostItemDataList = new List<MultiRoomCostItemData>();
		costPropIcon = "";
		costPropRate = 1f;
		showMatch = true;
		base._002Ector();
		voiceGroup = Singleton<AudioSystem>.Instance.RegisterGroup(VoiceGroupEnum.BattleReady);
		subscription_moneyMsg = Context.GetApplicationContext().GetService<IMessenger>().Subscribe<MoneyMessage>(OnMoneyMsgReceived);
		AddListener();
		base.parent = parent;
		this.copyData = copyData;
		startCommand = new SimpleCommand(ServiceSendStartGame);
		matchCommand = new SimpleCommand(ServiceSendMatchGame);
		backCommand = new SimpleCommand(QuitMultiRoom);
		openFriendWindowCmd = new SimpleCommand(OpenFriendWindow);
		sendRecruitCmd = new SimpleCommand(SendRecruitMsg);
		readyCmd = new SimpleCommand(SendReady);
		IsMatch = false;
		isReady = false;
		btnReadyText = "准备";
		multiRoomFunctionViewModel = new MultiRoomFunctionViewModel(this);
		_playerEnterIns = Singleton<AudioSystem>.Instance.CreateInstance(playerEnterSound, 1f);
		_playerOutIns = Singleton<AudioSystem>.Instance.CreateInstance(playerOutSound, 1f);
		CreateGamersInfo(gamerInfos);
		moneyData = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().GetMoneyData();
		isFirstGame = CopyData.IsNeedFirst && !CopyData.IsAccessed;
		InitCopyCostRate(loadCacheDropRate);
		chatBar = new ChatBarViewModel(this);
		refreshAttributeRequest = new InteractionRequest();
		_teamAttributeViewModel = new TeamAttributeViewModel(this);
		SetHeroAttributeList();
		Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().AddMultiListener(LoadingMulti);
		Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().SetIsMatch(isMatch: false);
		Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().SetMatchTime(0);
		AddCopyBuff(this.copyData);
		if (this.copyData.CopyMainId == Constant.ConstantConfig.GuildCopyType)
		{
			showMatch = false;
		}
		else if (this.copyData.CopyMainId == 6)
		{
			DRCopyKit dataRow = GameEntry.DataTable.GetDataRow<DRCopyKit>(this.copyData.Id);
			if (dataRow != null && dataRow.IsCharLvBal)
			{
				SetLevelFix(Constant.ConstantConfig.Copy6LevelFix);
			}
		}
		if (Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().GetCampaignTeamRoomContext() != null)
		{
			ShowMatch = false;
		}
	}

	private void SetLevelFix(int level)
	{
		levelFix = level;
		for (int i = 0; i < gamerInfoList.Count; i++)
		{
			gamerInfoList[i].SetLevelFix(level);
		}
	}

	private void SetChangeVMLevelFix()
	{
		if (levelFix > 0 && heroChangeViewModel != null)
		{
			heroChangeViewModel.SetLevelFix(levelFix);
		}
	}

	private void InitCopyCostRate(bool loadCacheDropRate)
	{
		if (!loadCacheDropRate)
		{
			Singleton<ServiceSystem>.Instance.GetService<ICopyService>()?.ResetCacheDropRate(copyData.Id);
		}
		ShowCost = false;
		DRCopy dataRow = GameEntry.DataTable.GetDataRow<DRCopy>(copyData.Id);
		DRCopyType dataRow2 = GameEntry.DataTable.GetDataRow<DRCopyType>(dataRow?.CopyType ?? 0);
		DRRate dataRow3 = GameEntry.DataTable.GetDataRow<DRRate>(dataRow2?.Rate ?? 0);
		if (dataRow == null || dataRow2 == null || dataRow3 == null)
		{
			return;
		}
		costProp = PropDataBase.CreateByType(dataRow.CostType, dataRow.CostId, dataRow.CostNum);
		if (costProp == null || costProp.Empty)
		{
			return;
		}
		CostPropIcon = costProp.Icon;
		CostPropCount = costProp.Amount;
		if (isFirstGame)
		{
			ServiceSendChangeMode(new MultiRoomCostItemData(this, costProp, "首通", 0f, 1, 0, 0), isInit: true);
			return;
		}
		int defaultDropRate = Singleton<ServiceSystem>.Instance.GetService<ICopyService>()?.GetCacheDropRate(copyData.Id) ?? (-1);
		if (defaultDropRate < 0)
		{
			defaultDropRate = ((dataRow3.DropRate.Count > 0) ? dataRow3.DropRate[0] : 0);
		}
		for (int i = 0; i < dataRow3.DropRate.Count; i++)
		{
			string desc = ((dataRow3.RateDesc.Count > i) ? dataRow3.RateDesc[i] : "");
			float costRate = ((dataRow3.CostRate.Count > i) ? dataRow3.CostRate[i] : 1f);
			int dropRate = dataRow3.DropRate[i];
			int unlockType = ((dataRow3.UnlockType.Count > i) ? dataRow3.UnlockType[i] : 0);
			int unlockNum = ((dataRow3.UnlockNum.Count > i) ? dataRow3.UnlockNum[i] : 0);
			multiRoomCostItemDataList.Add(new MultiRoomCostItemData(this, costProp, desc, costRate, dropRate, unlockType, unlockNum));
		}
		multiRoomCostItemDataList.Add(new MultiRoomCostItemData(this, costProp, "无报酬", 0f, 0, 0, 0));
		MultiRoomCostItemData multiRoomCostItemData = multiRoomCostItemDataList.Find((MultiRoomCostItemData p) => p.DropRate == defaultDropRate);
		if (multiRoomCostItemData != null)
		{
			ServiceSendChangeMode(multiRoomCostItemData, isInit: true);
		}
		multiRoomCostItemDataList.Sort((MultiRoomCostItemData a, MultiRoomCostItemData b) => a.DropRate.CompareTo(b.DropRate));
		ShowCost = true;
	}

	public void OpenCopyCostList()
	{
		if (!IsFirstGame)
		{
			ShowCostItemList = true;
		}
	}

	public void CloseCopyCostList()
	{
		ShowCostItemList = false;
	}

	private bool StartGameCheck()
	{
		if (Mode == 1 && !IsFirstGame)
		{
			return CostEnough;
		}
		return true;
	}

	private void OnMoneyMsgReceived(MoneyMessage msg)
	{
		if (msg != null && costProp != null && costProp.Id == (int)msg.MoneyType)
		{
			RefreshCostEnoughState();
		}
	}

	private void RefreshCostEnoughState()
	{
		if (costProp != null && !costProp.Empty)
		{
			CostEnough = (float)PropHelper.GetPropOwnedCount(costProp.Id) >= (float)CostPropCount * CostPropRate;
		}
	}

	private void SetHeroAttributeList()
	{
		List<HeroModel> list = new List<HeroModel>();
		foreach (MultiRoomPlayerViewModel gamerInfo in gamerInfoList)
		{
			if (gamerInfo.IsEmpty)
			{
				list.Add(null);
			}
			else
			{
				list.Add(gamerInfo.HeroModel);
			}
		}
		_teamAttributeViewModel.RefreshData(list);
	}

	private void AddCopyBuff(CopyData copyData)
	{
		if (copyData.Buffs != null && copyData.Buffs.Count > 0 && copyData.Buffs[0] > 0)
		{
			adItemList = new List<int>();
			for (int i = 0; i < copyData.Buffs.Count; i++)
			{
				adItemList.Insert(0, copyData.Buffs[i]);
			}
			HasCopyBuff = true;
		}
		else
		{
			HasCopyBuff = false;
		}
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is string text)
		{
			if (text.Equals("StartConfirmOnclick"))
			{
				SendFightStartFightOpe(1);
			}
			else if (text.Equals("StartCancelOnclick"))
			{
				SendFightStartFightOpe(2);
			}
			return;
		}
		if (obj is MultiRoomInviteViewModel multiRoomInviteViewModel)
		{
			ServiceSendInviteFriends(multiRoomInviteViewModel.MultiRoomInviteItemData);
			return;
		}
		if (obj is MultiRoomCostItemData multiRoomCostItemData)
		{
			ServiceSendChangeMode(multiRoomCostItemData);
			return;
		}
		if (obj is ChatViewModel chatViewModel)
		{
			chatViewModel.OnOpen();
			openWindowRequest.Raise(new OpenViewArg(typeof(ChatWindow), chatViewModel), delegate
			{
				chatBar.ActiveChatCommand();
			});
			return;
		}
		if (obj is MultiRoomData multiRoomData)
		{
			parent?.ItemOnClick(multiRoomData);
			return;
		}
		BattlePropConfigViewModel configViewModel = obj as BattlePropConfigViewModel;
		if (configViewModel != null)
		{
			openWindowRequest.Raise(new OpenViewArg(typeof(BattlePropConfigWindow), configViewModel), delegate
			{
				for (int i = 0; i < GamerInfoList.Count; i++)
				{
					if (gamerInfoList[i].IsSelf)
					{
						SendChangeBattleProp(configViewModel, gamerInfoList[i].TeamBpConfigViewModel);
						break;
					}
				}
			});
		}
		else
		{
			if (!(obj is OptionArg optionArg))
			{
				return;
			}
			if (optionArg.Obj is HeroChangeViewModel heroChangeViewModel)
			{
				if (optionArg.OptionName.Equals("Change"))
				{
					SendChangeHero(heroChangeViewModel);
				}
				else if (optionArg.OptionName.Equals("Close"))
				{
					SendCloseHeroChangeWindow();
				}
				else if (optionArg.OptionName.Equals("Skin"))
				{
					ChangeHeroSkin(heroChangeViewModel);
				}
			}
			else
			{
				if (!(optionArg.Obj is MultiRoomPlayerViewModel multiRoomPlayerViewModel))
				{
					return;
				}
				if ("Invite".Equals(optionArg.OptionName))
				{
					if (!IsMatch)
					{
						ServiceSendOpenMultiFriendsInfoView();
					}
				}
				else if ("Kick".Equals(optionArg.OptionName))
				{
					KickGamer(multiRoomPlayerViewModel);
				}
				else if ("ChangeHero".Equals(optionArg.OptionName))
				{
					OpenChangeHeroWindow(multiRoomPlayerViewModel);
				}
				else if ("AddGamer".Equals(optionArg.OptionName))
				{
					AddGamer(multiRoomPlayerViewModel);
				}
				else if ("OpenRoleFunctionList".Equals(optionArg.OptionName))
				{
					OpenPlayerFunctionView(multiRoomPlayerViewModel);
				}
			}
		}
	}

	private void OpenPlayerFunctionView(MultiRoomPlayerViewModel vm)
	{
		vm.RefreshFunctionList();
		MultiRoomFunctionViewModel.SetFunctionList(vm);
	}

	private void RefreshTeamLevelTipText()
	{
		int num = 0;
		int num2 = 0;
		foreach (MultiRoomPlayerViewModel gamerInfo in gamerInfoList)
		{
			if (!gamerInfo.IsEmpty)
			{
				num += gamerInfo.HeroModel.Level;
				num2++;
			}
		}
		float num3 = ((num2 != 0) ? (num / num2) : 0);
		TeamLevelTipText = ((num3 >= (float)copyData.MatchTeamLevel) ? "" : "队伍平均等级过低");
	}

	private async void SendReady()
	{
		readyCmd.Enabled = false;
		int ope = ((!IsReady) ? 1 : 2);
		if (ope == 1 && !StartGameCheck())
		{
			Toast.ShowInfo(costProp.Name + "不足");
			readyCmd.Enabled = true;
			return;
		}
		try
		{
			Loading loading = await Loading.Show();
			bool num = await Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().FightConfirmSetting(ope);
			loading.Dispose();
			if (num)
			{
				IsReady = !IsReady;
				BtnReadyText = (IsReady ? "取消" : "确认");
				foreach (MultiRoomPlayerViewModel gamerInfo in gamerInfoList)
				{
					if (gamerInfo.IsSelf)
					{
						int playerState = ((!IsReady) ? 1 : 3);
						gamerInfo.SetPlayerState(playerState);
					}
				}
				AllCheckHeroRepeat();
			}
		}
		catch (Exception ex)
		{
			Log.Error("战斗确认，发生异常！" + ex.Message + " / " + ex.StackTrace);
		}
		readyCmd.Enabled = true;
	}

	private void ChangePlayerInviteIconObj()
	{
		if (gamerInfoList == null)
		{
			return;
		}
		foreach (MultiRoomPlayerViewModel gamerInfo in gamerInfoList)
		{
			gamerInfo.SetIsMatch(IsMatch);
		}
	}

	private async void SendChangeBattleProp(BattlePropConfigViewModel configViewModel, TeamBPConfigViewModel teamBpConfigViewModel)
	{
		List<int> list = new List<int>();
		if (configViewModel != null)
		{
			BPData bPData = configViewModel.GetItemByNum(1)?.Data;
			BPData bPData2 = configViewModel.GetItemByNum(2)?.Data;
			list.Add(bPData?.TeamId ?? 0);
			list.Add(bPData2?.TeamId ?? 0);
			Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().SaveCarringBPs(bPData, bPData2);
		}
		else if (teamBpConfigViewModel != null)
		{
			BPData data = teamBpConfigViewModel.Vm1.Data;
			BPData data2 = teamBpConfigViewModel.Vm2.Data;
			list.Add(data?.TeamId ?? 0);
			list.Add(data2?.TeamId ?? 0);
		}
		if (await Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().TeamRoomChangeSelectBattleProp(list))
		{
			teamBpConfigViewModel.RefreshMulti();
		}
	}

	private async void SendChangeHero(HeroChangeViewModel heroChangeViewModel)
	{
		if (await Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().TeamRoomChangeSelectRole(heroChangeViewModel.SelectedHero.HeroModel.Id))
		{
			heroChangeViewModel.Close();
		}
	}

	private async void SendCloseHeroChangeWindow()
	{
		await Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().FightConfirmSetting(0);
	}

	private async void ChangeHeroSkin(HeroChangeViewModel heroChangeViewModel)
	{
		await Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().TeamRoomChangeSelectRole(heroChangeViewModel.SelectedHero.HeroModel.Id);
	}

	private void CreateGamersInfo(List<MatchRoomUserInfo> gamerInfos)
	{
		gamerInfoList = new List<MultiRoomPlayerViewModel>();
		uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().Uid;
		for (int i = 0; i < 3; i++)
		{
			gamerInfoList.Add(new MultiRoomPlayerViewModel(this, isSelf: false, null, i + 1));
		}
		for (int j = 0; j < gamerInfos.Count; j++)
		{
			if (gamerInfos[j].CapFlag == 1)
			{
				IsCaptain = gamerInfos[j].UserId == uid;
			}
		}
		for (int k = 0; k < gamerInfos.Count; k++)
		{
			if (uid == gamerInfos[k].UserId)
			{
				gamerInfoList[gamerInfos[k].SeatId - 1].SetTeamBPViewModel(new TeamBPConfigViewModel(gamerInfoList[gamerInfos[k].SeatId - 1]), isSelf: true);
				SendChangeBattleProp(null, gamerInfoList[gamerInfos[k].SeatId - 1].TeamBpConfigViewModel);
			}
			else
			{
				gamerInfoList[gamerInfos[k].SeatId - 1].SetTeamBPViewModel(TeamBPConfigViewModel.CreateMultiTeammate(gamerInfoList[gamerInfos[k].SeatId - 1], gamerInfos[k].CarryingBPs), isSelf: false);
			}
			gamerInfoList[gamerInfos[k].SeatId - 1].SetType(IsCaptain);
			gamerInfoList[gamerInfos[k].SeatId - 1].SetIsCaption(gamerInfos[k].CapFlag == 1);
			gamerInfoList[gamerInfos[k].SeatId - 1].UpdateView(uid == gamerInfos[k].UserId, gamerInfos[k]);
			gamerInfoList[gamerInfos[k].SeatId - 1].SetPlayerState(gamerInfos[k].State);
		}
		AllCheckHeroRepeat();
		FightStopMatch();
	}

	private void QuitMultiRoom()
	{
		if (backCommand.Enabled)
		{
			backCommand.Enabled = false;
			isLeavingRoom = true;
			if (IsMatch)
			{
				ServiceSendMatchGame();
			}
			ServiceSendLeaveRoom();
			chatBar.ClearChatMsg(ChatChannel.Team);
			backCommand.Enabled = true;
			Close();
		}
	}

	public void ForceLeaveRoom()
	{
		QuitMultiRoom();
	}

	public bool ConsumeCampaignRoomDismissToast()
	{
		if (!isLeavingRoom)
		{
			return false;
		}
		isLeavingRoom = false;
		IMultiRoomService service = Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>();
		if (service?.GetCampaignTeamRoomContext() == null)
		{
			return false;
		}
		service.ClearCampaignTeamRoomContext();
		return true;
	}

	private async void LoadingMulti(LoadingMultiBattleViewModel loadingViewModel)
	{
		isInLoading = true;
		if (loadingViewModel == null)
		{
			Log.Error("创建多人Loading失败！");
			return;
		}
		DRLoadingTips randomLoadingTap = await Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().PrepareLoading(GameProcessType.Battle);
		loadingViewModel.SetRandomLoadingTap(randomLoadingTap);
		openWindowRequest.Raise(new OpenViewArg(typeof(LoadingMultiWindow), loadingViewModel, "MultiRoom", isOpenWindow: true, "LOADING"));
		await UniTask.WaitUntil(() => loadingViewModel.IsLoadingFinish);
		bool loadingSuccess = loadingViewModel.LoadingSuccess;
		if (loadingViewModel.LoadingSuccess)
		{
			await loadingViewModel.CloseLoading();
			Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().ReleaseRoom();
			Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().LoadingEnd(loadingSuccess);
			Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().AddEnterCopyTDA(Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().GetCopyEnterInfoData());
			return;
		}
		if (loadingViewModel.LoadingException == LoadingExceptionEnum.BeforeUnloadOuter)
		{
			Log.Error("Loading异常 卸载外围场景 退回登录界面 关闭Loading");
			await loadingViewModel.CloseLoading();
			Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().ResetOuter();
			Singleton<ServiceSystem>.Instance.GetService<IAccountService>().OnAccountDisconnect(6);
		}
		else if (loadingViewModel.LoadingException == LoadingExceptionEnum.Unknow)
		{
			Log.Error("未知战斗异常 关闭Loading");
			await loadingViewModel.CloseLoading();
		}
		else
		{
			Log.Error("无Loading异常 关闭Loading");
			await loadingViewModel.CloseLoading();
		}
		Log.Error("进入多人Loading过程中发生异常！");
		Toast.ShowInfo("进入多人过程中发生异常，请退出后重试！");
	}

	private async void ServiceSendLeaveRoom()
	{
		Loading loading = await Loading.Show();
		if (await Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().LevelRoomAsync())
		{
			loading.Dispose();
			Close();
		}
		loading.Dispose();
	}

	private void KickGamer(MultiRoomPlayerViewModel vm)
	{
		IAsyncResult<int> result = AlertDialog.Show("提醒", "确定要请出" + vm.GamerName + "玩家吗?", "确认", "取消");
		result.Callbackable().OnCallback(delegate
		{
			if (result.Result == -1)
			{
				ServiceSendKickGamer(vm);
			}
		});
	}

	private async void AddGamer(MultiRoomPlayerViewModel vm)
	{
		await Singleton<ServiceSystem>.Instance.GetService<ISocialService>().AddFriend(vm.GamerUid, "");
		MultiRoomFunctionViewModel.CloseView();
	}

	private async void ServiceSendKickGamer(MultiRoomPlayerViewModel vm)
	{
		long userId = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().Uid;
		if (await Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().KickGamerAsync(vm.GamerUid, userId))
		{
			for (int i = 0; i < GamerInfoList.Count; i++)
			{
				if (GamerInfoList[i].GamerUid == vm.GamerUid)
				{
					GamerInfoList[i].UpdateView(isSelf: false, null);
					GamerInfoList[i].SetPlayerState(1);
					GamerInfoList[i].SetTeamBPViewModel(null, isSelf: false);
				}
			}
			if (IsMatch)
			{
				ServiceSendMatchGame();
			}
			else
			{
				FightStopMatch();
			}
			AllCheckHeroRepeat();
		}
		SetHeroAttributeList();
		refreshAttributeRequest.Raise();
		MultiRoomFunctionViewModel.CloseView();
	}

	private async void OpenChangeHeroWindow(MultiRoomPlayerViewModel vm1)
	{
		if (IsReady)
		{
			return;
		}
		try
		{
			Loading loading = await Loading.Show();
			bool num = await Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().FightConfirmSetting(3);
			loading.Dispose();
			if (num)
			{
				heroChangeViewModel?.Close();
				heroChangeViewModel = new HeroChangeViewModel(this, vm1.HeroModel.Id, vm1.Index, vm1.IsCaption, "MultiRoomWindow");
				SetChangeVMLevelFix();
				openWindowRequest.Raise(new OpenViewArg(typeof(HeroChangeWindow), heroChangeViewModel));
			}
		}
		catch (Exception ex)
		{
			Log.Error("打开更换烬天使界面，发生异常！" + ex.Message + " / " + ex.StackTrace);
		}
	}

	private async void ServiceSendStartGame()
	{
		if (!startCommand.Enabled)
		{
			return;
		}
		bool flag = true;
		string text = "";
		foreach (MultiRoomPlayerViewModel gamerInfo in GamerInfoList)
		{
			if (!gamerInfo.IsSelf && !gamerInfo.IsEmpty && gamerInfo.State != 3)
			{
				flag = false;
				text = gamerInfo.GamerName;
				break;
			}
		}
		if (!flag)
		{
			Toast.ShowInfo(text + "尚未准备");
			return;
		}
		if (!StartGameCheck())
		{
			Toast.ShowInfo(costProp.Name + "不足");
			return;
		}
		if (AllCheckHeroRepeat())
		{
			Toast.ShowInfo("有重复角色");
			return;
		}
		startCommand.Enabled = false;
		matchCommand.Enabled = false;
		if (!(await CheckCampaignBeforeStartFight()))
		{
			startCommand.Enabled = true;
			matchCommand.Enabled = true;
		}
		else if (await Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().StartGameAsync())
		{
			if (heroChangeViewModel != null)
			{
				heroChangeViewModel.Close();
			}
		}
		else
		{
			startCommand.Enabled = true;
			matchCommand.Enabled = true;
			startCommand.Enabled = true;
			matchCommand.Enabled = true;
		}
	}

	private async void ServiceSendMatchGame()
	{
		if (IsMatch)
		{
			if (matchCommand.Enabled)
			{
				matchCommand.Enabled = false;
				startCommand.Enabled = true;
				if (await Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().StopMatchAsync())
				{
					IsMatch = false;
					CloseTimer();
				}
				matchCommand.Enabled = true;
			}
		}
		else
		{
			if (!matchCommand.Enabled)
			{
				return;
			}
			matchCommand.Enabled = false;
			startCommand.Enabled = false;
			try
			{
				if (await Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().StartMatchAsync())
				{
					OpenTimer();
					IsMatch = true;
				}
				else
				{
					startCommand.Enabled = true;
				}
			}
			catch (Exception ex)
			{
				Log.Error("开始匹配，发生异常！" + ex.Message + " / " + ex.StackTrace);
				startCommand.Enabled = true;
			}
			matchCommand.Enabled = true;
		}
	}

	private async void ServiceSendInviteFriends(List<MultiRoomInviteItemData> dataList)
	{
		if (IsMatch)
		{
			Toast.ShowInfo("已开始匹配，无法邀请");
			return;
		}
		int num = 0;
		foreach (MultiRoomPlayerViewModel gamerInfo in GamerInfoList)
		{
			if (!gamerInfo.IsEmpty)
			{
				num++;
			}
		}
		if (num == 3)
		{
			Toast.ShowInfo("邀请失败,房间已满");
			return;
		}
		List<long> list = new List<long>();
		foreach (MultiRoomInviteItemData data in dataList)
		{
			if (data.IsSelected)
			{
				list.Add(data.Uid);
			}
		}
		await Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().InviteFriendsAsync(list);
	}

	private async void ServiceSendOpenMultiFriendsInfoView()
	{
		Loading getFriendInfoLoading = await Loading.Show();
		await Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().SendGetMultiFriendsInfoView(copyData.CopyMainId);
		getFriendInfoLoading.Dispose();
	}

	public void OpenFriendInfoWindow(MultiRoomInviteViewModel multiRoomInviteViewModel)
	{
		multiRoomInviteViewModel.SetParent(this);
		openWindowRequest.Raise(new OpenViewArg(typeof(MultiRoomInviteView), multiRoomInviteViewModel));
	}

	private void ServiceSendChangeMode(MultiRoomCostItemData multiRoomCostItemData, bool isInit = false)
	{
		if (isInit)
		{
			SendChangeMode(multiRoomCostItemData);
		}
		else if (!multiRoomCostItemData.IsSelected && (curCostItemData == null || curCostItemData.DropRate != multiRoomCostItemData.DropRate))
		{
			if (IsReady)
			{
				Toast.ShowInfo("准备状态下无法切换消耗");
			}
			else
			{
				SendChangeMode(multiRoomCostItemData);
			}
		}
	}

	private async void SendChangeMode(MultiRoomCostItemData multiRoomCostItemData)
	{
		if (curCostItemData != null)
		{
			curCostItemData.IsSelected = false;
		}
		curCostItemData = multiRoomCostItemData;
		curCostItemData.IsSelected = true;
		CurCostDesc = multiRoomCostItemData.RateDesc;
		CostPropRate = multiRoomCostItemData.CostRate;
		ShowCostProp = curCostItemData.DropRate > 0;
		RefreshCostEnoughState();
		int targetMode = CopyData.GetServiceCopyType(curCostItemData.DropRate, IsFirstGame);
		Loading loading = await Loading.Show();
		bool num = await Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().ChangeModel(copyData.Id, targetMode, curCostItemData.DropRate);
		loading.Dispose();
		if (num)
		{
			Mode = targetMode;
			copyData.SetDropRate(multiRoomCostItemData.DropRate);
			Singleton<ServiceSystem>.Instance.GetService<ICopyService>()?.SetCacheDropRate(copyData.Id, copyData.DropRate);
			CloseCopyCostList();
		}
	}

	private async void OpenFriendWindow()
	{
		openFriendWindowCmd.Enabled = false;
		try
		{
			friendWindowViewModel = new FriendWindowViewModel(this);
			await friendWindowViewModel.RequestAllFriendData();
			openWindowRequest.Raise(new OpenViewArg(typeof(FriendWindow), friendWindowViewModel), delegate
			{
				openFriendWindowCmd.Enabled = true;
			});
		}
		catch (Exception message)
		{
			Log.Error(message);
			openFriendWindowCmd.Enabled = true;
		}
	}

	private async void SendRecruitMsg()
	{
		if (recruitCD > 0)
		{
			Toast.ShowInfo($"{recruitCD}秒后可发送招募信息");
			return;
		}
		sendRecruitCmd.Enabled = false;
		OpenRecruitCDTimer();
		if (await Singleton<ServiceSystem>.Instance.GetService<IChatService>().SendCopyRecruitMsg())
		{
			Toast.ShowInfo("招募信息发送成功");
		}
		sendRecruitCmd.Enabled = true;
	}

	private void AddListener()
	{
		Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().RegisterMultiMessage();
		subscription_TeammateChange = Singleton<NetworkSystem>.Instance.Subscribe<MatchRoomUserChangeNotify>(TeammateChange);
		subscription_TeamRoomMatchEnterNotify = Singleton<NetworkSystem>.Instance.Subscribe<TeamRoomMatchEnterNotify>(MatchEnter);
		subscription_FightStartMatch = Singleton<NetworkSystem>.Instance.Subscribe<MultiFightStartMatchNotify>(FightStartMatch);
		subscription_FightStopMatch = Singleton<NetworkSystem>.Instance.Subscribe<MultiFightStopMatchNotify>(FightStopMatch);
		subscription_InviteFeedBack = Singleton<NetworkSystem>.Instance.Subscribe<MultiFightInviteFeedbackNotify>(InviteFeedBack);
		subscription_BeKick = Singleton<NetworkSystem>.Instance.Subscribe<MultiFightBeKickNotify>(BeKick);
		subscription_HeroChange = Singleton<NetworkSystem>.Instance.Subscribe<TeamRoomChangeSelectRoleNotify>(HeroChange);
		subscription_UpdateState = Singleton<NetworkSystem>.Instance.Subscribe<MultiFightSettingRoomUserStateChangeNotify>(UpdateState);
		subscription_MultiFightMatchSuccessNotify = Singleton<NetworkSystem>.Instance.Subscribe<MultiFightMatchSuccessNotify>(FightStopMatch);
		subscription_BattlePropChange = Singleton<NetworkSystem>.Instance.Subscribe<BattleChangeBattlePropNotify>(BattlePropChangeNotify);
		subscription_Disband = Singleton<NetworkSystem>.Instance.Subscribe<MultiFightDisbandNotify>(Disband);
	}

	private void UpdateState(MultiFightSettingRoomUserStateChangeNotify message)
	{
		if (message.State == 4)
		{
			return;
		}
		foreach (MultiRoomPlayerViewModel gamerInfo in gamerInfoList)
		{
			if (gamerInfo.GamerUid == message.UserId)
			{
				gamerInfo.SetPlayerState(message.State);
			}
		}
		AllCheckHeroRepeat();
	}

	private bool AllCheckHeroRepeat()
	{
		RefreshTeamLevelTipText();
		bool result = false;
		if (copyData.IsMultiRepeat)
		{
			return result;
		}
		Dictionary<int, long> dictionary = new Dictionary<int, long>();
		foreach (MultiRoomPlayerViewModel gamerInfo in gamerInfoList)
		{
			if (gamerInfo.State == 3 && !dictionary.ContainsKey(gamerInfo.HeroModel.Id))
			{
				dictionary.Add(gamerInfo.HeroModel.Id, gamerInfo.GamerUid);
			}
		}
		foreach (MultiRoomPlayerViewModel gamerInfo2 in gamerInfoList)
		{
			if (gamerInfo2.State == 1)
			{
				if (dictionary.ContainsKey(gamerInfo2.HeroModel.Id) && dictionary[gamerInfo2.HeroModel.Id] != gamerInfo2.GamerUid)
				{
					gamerInfo2.SetPlayerState(6);
					result = true;
				}
			}
			else if (gamerInfo2.State == 6 && !dictionary.ContainsKey(gamerInfo2.HeroModel.Id))
			{
				gamerInfo2.SetPlayerState(1);
			}
		}
		RefreshTeamLevelTipText();
		return result;
	}

	private void TeammateChange(MatchRoomUserChangeNotify message)
	{
		if (message.EnterState == 1)
		{
			if (GamerInfoList.Count > message.SeatId - 1)
			{
				GamerInfoList[message.SeatId - 1].SetType(IsCaptain);
			}
			MatchRoomUserInfo matchRoomUserInfo = new MatchRoomUserInfo(message.MatchUserInfo.CapFlag, message.MatchUserInfo.UserId, message.MatchUserInfo.SeatId, message.MatchUserInfo.State, message.MatchUserInfo.SelectModel, message.MatchUserInfo.UserBaseInfo.Icon, message.MatchUserInfo.UserBaseInfo.Name, message.MatchUserInfo.RoleInfo.RoleId, message.MatchUserInfo.RoleInfo.Star, message.MatchUserInfo.RoleInfo.Level, message.MatchUserInfo.RoleInfo.SkinId, message.MatchUserInfo.HeroCardFrame, message.MatchUserInfo.RoleInfo.SeatLevel, Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().GetBPCarryings(message.MatchUserInfo.BattleProp));
			if (GamerInfoList.Count > message.SeatId - 1)
			{
				GamerInfoList[message.SeatId - 1].UpdateView(isSelf: false, matchRoomUserInfo);
				GamerInfoList[message.SeatId - 1].SetPlayerState(message.MatchUserInfo.State);
				GamerInfoList[message.SeatId - 1].SetTeamBPViewModel(TeamBPConfigViewModel.CreateMultiTeammate(GamerInfoList[message.SeatId - 1], matchRoomUserInfo.CarryingBPs), isSelf: false);
			}
		}
		else if (message.EnterState == 2)
		{
			long num = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().Uid;
			if (GamerInfoList.Count > message.SeatId - 1)
			{
				GamerInfoList[message.SeatId - 1].UpdateView(isSelf: false, null);
				GamerInfoList[message.SeatId - 1].SetPlayerState(1);
				GamerInfoList[message.SeatId - 1].SetTeamBPViewModel(null, isSelf: false);
			}
			if (message.NewCapId != 0L)
			{
				if (num == message.NewCapId)
				{
					IsCaptain = true;
					IsReady = false;
				}
				else
				{
					IsCaptain = false;
				}
			}
			foreach (MultiRoomPlayerViewModel gamerInfo in GamerInfoList)
			{
				gamerInfo.SetType(IsCaptain);
				gamerInfo.RefreshFunctionList();
				if (gamerInfo.GamerUid == message.NewCapId)
				{
					gamerInfo.SetPlayerState(1);
				}
			}
			matchCommand.Enabled = true;
		}
		foreach (MultiRoomPlayerViewModel gamerInfo2 in GamerInfoList)
		{
			if (gamerInfo2.GamerUid == message.NewCapId && message.NewCapId != 0L)
			{
				gamerInfo2.SetIsCaption(isCaption: true);
			}
		}
		AllCheckHeroRepeat();
		SetHeroAttributeList();
		refreshAttributeRequest.Raise();
		FightStopMatch();
		refreshMatchBpRequest.Raise();
	}

	private void MatchEnter(TeamRoomMatchEnterNotify message)
	{
		if (message.MatchUserInfos.Count <= 1)
		{
			return;
		}
		Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().SaveRoomId(message.RoomId);
		for (int i = 0; i < message.MatchUserInfos.Count; i++)
		{
			if (message.MatchUserInfos[i].CapFlag == 1)
			{
				IsCaptain = message.MatchUserInfos[i].UserId == uid;
			}
		}
		for (int j = 0; j < message.MatchUserInfos.Count; j++)
		{
			MatchRoomUserInfo matchRoomUserInfo = new MatchRoomUserInfo(message.MatchUserInfos[j].CapFlag, message.MatchUserInfos[j].UserId, message.MatchUserInfos[j].SeatId, message.MatchUserInfos[j].State, message.MatchUserInfos[j].SelectModel, message.MatchUserInfos[j].UserBaseInfo.Icon, message.MatchUserInfos[j].UserBaseInfo.Name, message.MatchUserInfos[j].RoleInfo.RoleId, message.MatchUserInfos[j].RoleInfo.Star, message.MatchUserInfos[j].RoleInfo.Level, message.MatchUserInfos[j].RoleInfo.SkinId, message.MatchUserInfos[j].HeroCardFrame, message.MatchUserInfos[j].RoleInfo.SeatLevel, Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().GetBPCarryings(message.MatchUserInfos[j].BattleProp));
			int index = message.MatchUserInfos[j].SeatId - 1;
			if (uid == message.MatchUserInfos[j].UserId)
			{
				gamerInfoList[index].SetTeamBPViewModel(new TeamBPConfigViewModel(gamerInfoList[index]), isSelf: true);
				SendChangeBattleProp(null, gamerInfoList[index].TeamBpConfigViewModel);
			}
			else
			{
				gamerInfoList[index].SetTeamBPViewModel(TeamBPConfigViewModel.CreateMultiTeammate(gamerInfoList[index], matchRoomUserInfo.CarryingBPs), isSelf: false);
			}
			gamerInfoList[index].SetType(IsCaptain);
			gamerInfoList[index].SetIsCaption(message.MatchUserInfos[j].CapFlag == 1);
			gamerInfoList[index].UpdateView(uid == message.MatchUserInfos[j].UserId, matchRoomUserInfo);
			gamerInfoList[index].SetPlayerState(message.MatchUserInfos[j].State);
		}
		AllCheckHeroRepeat();
		SetHeroAttributeList();
		refreshAttributeRequest.Raise();
		FightStopMatch();
		foreach (MultiRoomPlayerViewModel gamerInfo in gamerInfoList)
		{
			if (gamerInfo.IsSelf)
			{
				IsReady = gamerInfo.State == 3;
				BtnReadyText = (IsReady ? "取消" : "确认");
			}
		}
		refreshMatchBpRequest.Raise();
	}

	private bool CheckIsMax()
	{
		foreach (MultiRoomPlayerViewModel gamerInfo in GamerInfoList)
		{
			if (gamerInfo.IsEmpty)
			{
				return false;
			}
		}
		return true;
	}

	private async void SendFightStartFightOpe(int ope)
	{
		MultiFightStartFightOpeRequest multiFightStartFightOpeRequest = MultiFightStartFightOpeRequest.Create();
		multiFightStartFightOpeRequest.Ope = ope;
		try
		{
			await Singleton<NetworkSystem>.Instance.Call<MultiFightStartFightOpeResponse>(multiFightStartFightOpeRequest, false);
		}
		catch (Exception ex)
		{
			Log.Error("发送MultiFightStartFightOpeRequest，发生异常！" + ex.Message + " / " + ex.StackTrace);
		}
	}

	private void FightStartMatch(MultiFightStartMatchNotify message)
	{
		if (message.ErrorCode == 0)
		{
			IsMatch = true;
			OpenTimer();
		}
		else if (message.ErrorCode == 200093)
		{
			Toast.ShowInfo($"{message.PunishUserName}玩家剩余{message.PunishLeftTime}秒惩罚时间");
		}
		else if (message.ErrorCode == 200089)
		{
			Toast.ShowInfo("队伍玩家可燃魂不足");
		}
		else if (message.ErrorCode == 200096)
		{
			Toast.ShowInfo($"{message.PunishUserName}玩家剩余{message.PunishLeftTime}秒惩罚时间");
		}
		else
		{
			Toast.ShowInfo($"错误信息:{message.ErrorCode}");
		}
	}

	private void FightStopMatch()
	{
		IsMatch = false;
		CloseTimer();
		bool flag = CheckIsMax();
		matchCommand.Enabled = !flag;
		startCommand.Enabled = true;
	}

	private void FightStopMatch(MultiFightMatchSuccessNotify message)
	{
		Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().SetIsMatch(isMatch: true);
		Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().SetMatchTime(waitTime);
		FightStopMatch();
	}

	private void FightStopMatch(MultiFightStopMatchNotify message)
	{
		FightStopMatch();
	}

	private void BattlePropChangeNotify(BattleChangeBattlePropNotify message)
	{
		if (message.NewBattleProps != null && message.NewBattleProps.Count > 0)
		{
			Dictionary<int, BPData> dictionary = new Dictionary<int, BPData>();
			int i;
			for (i = 0; i < message.NewBattleProps.Count; i++)
			{
				DRBattlePropInfo dataRow = GameEntry.DataTable.GetDataRow((DRBattlePropInfo p) => p.TeamId == message.NewBattleProps[i].Id && p.Lev == message.NewBattleProps[i].Level);
				if (dataRow != null)
				{
					dictionary.Add(i + 1, BPData.Create(dataRow, isLock: false, message.NewBattleProps[i].Count));
				}
			}
			for (int num = 0; num < gamerInfoList.Count; num++)
			{
				if (!gamerInfoList[num].IsEmpty && gamerInfoList[num].GamerUid == message.UserId)
				{
					gamerInfoList[num].TeamBpConfigViewModel.RefreshTeammateBP(dictionary);
				}
			}
		}
		refreshMatchBpRequest.Raise();
	}

	private void RefreshHeroInfo()
	{
	}

	private void InviteFeedBack(MultiFightInviteFeedbackNotify message)
	{
		Toast.ShowInfo("玩家:" + message.UserName + "拒绝了您的邀请");
	}

	private void BeKick(MultiFightBeKickNotify message)
	{
		Toast.ShowInfo("被请出队伍");
		Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().SaveRoomId(0L);
		Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().SetMatchTime(0);
		Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().SetIsMatch(isMatch: false);
		Close();
	}

	private void Disband(MultiFightDisbandNotify message)
	{
		Toast.ShowInfo("房主已解散房间");
		Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().SaveRoomId(0L);
		Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().SetMatchTime(0);
		Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().SetIsMatch(isMatch: false);
		Close();
	}

	private void HeroChange(TeamRoomChangeSelectRoleNotify message)
	{
		foreach (MultiRoomPlayerViewModel gamerInfo in GamerInfoList)
		{
			if (gamerInfo.GamerUid != message.UserId)
			{
				continue;
			}
			HeroModel heroModel = new HeroModel(message.NewRole.RoleId, message.NewRole.SkinId, message.NewRole.Star, message.NewRole.Level, message.NewRole.SeatLevel);
			heroModel.SetSkin(message.NewRole.SkinId);
			gamerInfo.UpdateHeroView(heroModel);
			if (gamerInfo.IsSelf)
			{
				DRVoice heroSkinVoiceConfig = HeroDefinition.GetHeroSkinVoiceConfig(heroModel.Id, heroModel.SkinConfigId, 2);
				if (heroSkinVoiceConfig != null)
				{
					voiceGroup.Stop();
					voiceGroup.Play(heroSkinVoiceConfig.VoiceId);
				}
			}
		}
		AllCheckHeroRepeat();
		SetHeroAttributeList();
		refreshAttributeRequest.Raise();
	}

	private void OpenTimer()
	{
		CloseTimer();
		timer = Timer.Register(1f, TimeChange, null, isLooped: true, useRealTime: true);
	}

	private void OpenRecruitCDTimer()
	{
		CloseRecruitTimer();
		recruitCD = 5;
		recruitTimer = Timer.Register(1f, RecruitCDChange, null, isLooped: true, useRealTime: true);
	}

	private void TimeChange()
	{
		waitTime++;
		if (waitTime > 300)
		{
			ServiceSendMatchGame();
			CloseTimer();
		}
		else
		{
			WaitTimeText = Utility.DateTime.GetLeftDateTime(waitTime, "mm\\:ss");
		}
	}

	private void RecruitCDChange()
	{
		if (recruitCD <= 0)
		{
			CloseRecruitTimer();
		}
		recruitCD--;
	}

	private void CloseTimer()
	{
		if (timer != null)
		{
			timer.Cancel();
			timer = null;
		}
		waitTime = 0;
		WaitTimeText = Utility.DateTime.GetLeftDateTime(waitTime, "mm\\:ss");
	}

	private void CloseRecruitTimer()
	{
		if (recruitTimer != null)
		{
			recruitTimer.Cancel();
			recruitTimer = null;
		}
	}

	private async UniTask<bool> CheckCampaignBeforeStartFight()
	{
		CampaignTeamRoomContext campaignTeamRoomContext = Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().GetCampaignTeamRoomContext();
		if (campaignTeamRoomContext == null)
		{
			return true;
		}
		CampaignTeamRoomCheckResult campaignTeamRoomCheckResult = await Singleton<ServiceSystem>.Instance.GetService<ICampaignService>().CheckCampaignTeamRoom(campaignTeamRoomContext, CampaignTeamRoomCheckScene.StartFight);
		if (campaignTeamRoomCheckResult.Success)
		{
			return true;
		}
		Toast.ShowInfo(campaignTeamRoomCheckResult.ToastText);
		await Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().LevelRoomAsync();
		Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().ClearCampaignTeamRoomContext();
		Close();
		return false;
	}

	public override void Close()
	{
		CloseTimer();
		CloseRecruitTimer();
		Unregister();
		friendWindowViewModel?.FriendViewModel.Close();
		heroChangeViewModel?.Close();
		chatBar.ClearChatMsg(ChatChannel.Team);
		Singleton<AudioSystem>.Instance.UnRegisterGroup(VoiceGroupEnum.BattleReady, stopVoice: true);
		voiceGroup = null;
		subscription_moneyMsg?.Dispose();
		subscription_moneyMsg = null;
		parent?.ItemOnClick(new OptionArg(this, "Close"));
		base.Close();
	}

	private void Unregister()
	{
		if (subscription_TeammateChange != null)
		{
			subscription_TeammateChange.Dispose();
			subscription_TeammateChange = null;
		}
		if (subscription_TeamRoomMatchEnterNotify != null)
		{
			subscription_TeamRoomMatchEnterNotify.Dispose();
			subscription_TeamRoomMatchEnterNotify = null;
		}
		if (subscription_FightStartFight != null)
		{
			subscription_FightStartFight.Dispose();
			subscription_FightStartFight = null;
		}
		if (subscription_FightStartMatch != null)
		{
			subscription_FightStartMatch.Dispose();
			subscription_FightStartMatch = null;
		}
		if (subscription_FightStopMatch != null)
		{
			subscription_FightStopMatch.Dispose();
			subscription_FightStopMatch = null;
		}
		if (subscription_MultiFightMatchSuccessNotify != null)
		{
			subscription_MultiFightMatchSuccessNotify.Dispose();
			subscription_MultiFightMatchSuccessNotify = null;
		}
		if (subscription_InviteFeedBack != null)
		{
			subscription_InviteFeedBack.Dispose();
			subscription_InviteFeedBack = null;
		}
		if (subscription_FightUserStateChange != null)
		{
			subscription_FightUserStateChange.Dispose();
			subscription_FightUserStateChange = null;
		}
		if (subscription_FightStartFight != null)
		{
			subscription_FightStartFight.Dispose();
			subscription_FightStartFight = null;
		}
		if (subscription_BeKick != null)
		{
			subscription_BeKick.Dispose();
			subscription_BeKick = null;
		}
		if (subscription_EnterSettingRoom != null)
		{
			subscription_EnterSettingRoom.Dispose();
			subscription_EnterSettingRoom = null;
		}
		if (subscription_HeroChange != null)
		{
			subscription_HeroChange.Dispose();
			subscription_HeroChange = null;
		}
		if (subscription_UpdateState != null)
		{
			subscription_UpdateState.Dispose();
			subscription_UpdateState = null;
		}
		if (subscription_BattlePropChange != null)
		{
			subscription_BattlePropChange.Dispose();
			subscription_BattlePropChange = null;
		}
		if (subscription_Disband != null)
		{
			subscription_Disband.Dispose();
			subscription_Disband = null;
		}
	}
}
