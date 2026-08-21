#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class BattleReadyViewModel : OptionBase
{
	private TeamBPConfigViewModel bpConfigViewModel;

	private PrepareTeamViewModel _prepareTeamViewModel;

	private ChangeTeamNameViewModel _changeTeamNameViewModel;

	private List<BattleReadySeatViewModel> _seatVmList;

	private BattleReadySeatViewModel _dragSeatVm;

	private TeamAttributeViewModel _teamAttributeViewModel;

	private InteractionRequest _onPointChangeRequest = new InteractionRequest();

	private InteractionRequest _changeNameViewCloseRequest = new InteractionRequest();

	private InteractionRequest _teamChangedRequest = new InteractionRequest();

	private InteractionRequest<BattleReadySeatView.SeatState> _seatStateChangeRst = new InteractionRequest<BattleReadySeatView.SeatState>();

	private SimpleCommand<BattleReadySeatViewModel> selectHeroCmd;

	private SimpleCommand startBattleCommand;

	private string _curTeamName;

	private List<int> adItemList;

	private BattleReadyData readyData;

	private BattleReadyType readyType = BattleReadyType.Cancel;

	private bool _secondConfirm;

	private bool btnBackEnable = true;

	private ISubscription<MoneyMessage> subscription_moneyMsg;

	private VoiceGroup voiceGroup;

	private List<MultiRoomCostItemData> costItemDataList = new List<MultiRoomCostItemData>();

	private MultiRoomCostItemData curCostItemData;

	private string curCostDesc;

	private bool showCostItemList;

	private bool showCost;

	private bool hasCopyBuff;

	private string costPropIcon = "";

	private int costPropCount;

	private float costPropRate = 1f;

	private bool costEnough;

	private PropDataBase costProp;

	private bool showCostProp;

	private BattleReadySeatViewModel catchedSeatVm;

	private BattleReadySeatViewModel seatCovered;

	public bool ShowCost
	{
		get
		{
			return showCost;
		}
		private set
		{
			Set(ref showCost, value, "ShowCost");
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

	public List<MultiRoomCostItemData> CostItemDataList
	{
		get
		{
			return costItemDataList;
		}
		private set
		{
			Set(ref costItemDataList, value, "CostItemDataList");
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

	public BattleReadyData ReadyData => readyData;

	public string CurTeamName
	{
		get
		{
			return _curTeamName;
		}
		set
		{
			Set(ref _curTeamName, value, "CurTeamName");
		}
	}

	public bool BtnBackEnable
	{
		get
		{
			return btnBackEnable;
		}
		private set
		{
			Set(ref btnBackEnable, value, "BtnBackEnable");
		}
	}

	public PrepareTeamViewModel PrepareTeamViewModel => _prepareTeamViewModel;

	public ChangeTeamNameViewModel ChangeTeamNameViewModel => _changeTeamNameViewModel;

	public TeamAttributeViewModel TeamAttributeViewModel => _teamAttributeViewModel;

	public TeamBPConfigViewModel BpConfigViewModel => bpConfigViewModel;

	public BattleReadyType ReadyType => readyType;

	public bool SecondConfirm
	{
		get
		{
			return _secondConfirm;
		}
		set
		{
			_secondConfirm = value;
		}
	}

	public List<BattleReadySeatViewModel> SeatVmList => _seatVmList;

	public BattleReadySeatViewModel DragSeatVm => _dragSeatVm;

	public InteractionRequest OnPointChangeRequest => _onPointChangeRequest;

	public InteractionRequest TeamChangedRequest => _teamChangedRequest;

	public InteractionRequest ChangeNameViewCloseRequest => _changeNameViewCloseRequest;

	public SimpleCommand StartBattleCommand => startBattleCommand;

	public InteractionRequest<BattleReadySeatView.SeatState> SeatStateChangeRst => _seatStateChangeRst;

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

	public BattleReadyViewModel()
	{
	}

	public BattleReadyViewModel(OptionBase parent, BattleReadyData readyData, bool loadCacheDropRate = false)
	{
		base.parent = parent;
		this.readyData = readyData;
		subscription_moneyMsg = Context.GetApplicationContext().GetService<IMessenger>().Subscribe<MoneyMessage>(OnMoneyMsgReceived);
		if (readyData.Target == BattleReadyTarget.Copy && !loadCacheDropRate)
		{
			Singleton<ServiceSystem>.Instance.GetService<ICopyService>()?.ResetCacheDropRate(readyData.TargetId);
		}
		BtnBackEnable = Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().GetGameProcess() != GameProcessType.Story;
		selectHeroCmd = new SimpleCommand<BattleReadySeatViewModel>(OpenHeroSelectionWindow);
		InitSeatViewModels();
		InitBattleMode();
		bpConfigViewModel = new TeamBPConfigViewModel(this);
		bpConfigViewModel.SetTeamSetId(readyData.TeamSetId);
		_prepareTeamViewModel = new PrepareTeamViewModel(this);
		_changeTeamNameViewModel = new ChangeTeamNameViewModel(this);
		_teamAttributeViewModel = new TeamAttributeViewModel(this);
		startBattleCommand = new SimpleCommand(TryStartBattle);
		voiceGroup = Singleton<AudioSystem>.Instance.RegisterGroup(VoiceGroupEnum.BattleReady);
	}

	private void InitSeatViewModels()
	{
		_seatVmList = new List<BattleReadySeatViewModel>();
		for (int i = 0; i < 3; i++)
		{
			_seatVmList.Add(new BattleReadySeatViewModel(this));
		}
		_dragSeatVm = new BattleReadySeatViewModel(this);
	}

	public async void GetSelectionResult(HeroSelectionViewModel selectVM)
	{
		try
		{
			if (ReadyData.Target == BattleReadyTarget.ActivityHeroTry)
			{
				Dictionary<int, HeroItemViewModel> result = selectVM.Result;
				int heroTryId = _seatVmList[selectVM.ParentSeatId - 1].HeroTryId;
				List<int> list = new List<int>();
				for (int i = 1; i < 4; i++)
				{
					list.Add((result[i] != null) ? result[i].HeroTryId : 0);
				}
				if (!Singleton<ServiceSystem>.Instance.GetService<ITeamService>().SetActivityHeroTryTroopRequest(readyData.TargetId, list))
				{
					return;
				}
				int newHeroId = list[selectVM.ParentSeatId - 1];
				if (newHeroId > 0 && newHeroId != heroTryId)
				{
					HeroItemViewModel heroItemViewModel = result.Values.ToList().Find((HeroItemViewModel p) => p.HeroTryId == newHeroId);
					DRVoice heroSkinVoiceConfig = HeroDefinition.GetHeroSkinVoiceConfig(newHeroId, heroItemViewModel.HeroModel.SkinConfigId, 2);
					if (heroSkinVoiceConfig != null)
					{
						voiceGroup.Stop();
						voiceGroup.Play(heroSkinVoiceConfig.VoiceId);
					}
				}
				ITeamService service = Singleton<ServiceSystem>.Instance.GetService<ITeamService>();
				ChangeHeroInCurTeam(service.GetHeroTryTeamDataById(readyData.TargetId));
				return;
			}
			Dictionary<int, HeroItemViewModel> result2 = selectVM.Result;
			int oldHeroId = _seatVmList[selectVM.ParentSeatId - 1].Data.Id;
			List<int> roleIds = new List<int>();
			for (int num = 1; num < 4; num++)
			{
				roleIds.Add((result2[num] != null) ? result2[num].HeroModel.Id : 0);
			}
			if (!(await SetCurTeamMemberRequest(roleIds)))
			{
				return;
			}
			if (ReadyData.Target == BattleReadyTarget.HeroChallenge)
			{
				int heroIdForHeroChallenge = ((roleIds.Count >= 1) ? roleIds[0] : 0);
				Singleton<ServiceSystem>.Instance.GetService<ITeamService>().SetHeroIdForHeroChallenge(heroIdForHeroChallenge);
				ChangeHeroInCurTeam(CreateHeroChallengeTeamModel(roleIds));
			}
			else if (ReadyData.Target == BattleReadyTarget.CopyType3FirePower)
			{
				int heroIdForCopyType3FirePower = ((roleIds.Count >= 1) ? roleIds[0] : 0);
				Singleton<ServiceSystem>.Instance.GetService<ITeamService>().SetHeroIdForCopyType3FirePower(heroIdForCopyType3FirePower);
				ChangeHeroInCurTeam(CreateHeroChallengeTeamModel(roleIds));
			}
			int newHeroId2 = roleIds[selectVM.ParentSeatId - 1];
			if (newHeroId2 > 0 && newHeroId2 != oldHeroId)
			{
				HeroItemViewModel heroItemViewModel2 = result2.Values.ToList().Find((HeroItemViewModel p) => p.HeroTryId == newHeroId2);
				DRVoice heroSkinVoiceConfig2 = HeroDefinition.GetHeroSkinVoiceConfig(newHeroId2, heroItemViewModel2.HeroModel.SkinConfigId, 2);
				if (heroSkinVoiceConfig2 != null)
				{
					voiceGroup.Stop();
					voiceGroup.Play(heroSkinVoiceConfig2.VoiceId);
				}
			}
			if (ReadyData.Target != BattleReadyTarget.HeroChallenge && ReadyData.Target != BattleReadyTarget.CopyType3FirePower)
			{
				ITeamService service2 = Singleton<ServiceSystem>.Instance.GetService<ITeamService>();
				ChangeHeroInCurTeam(service2.GetTeamDataById(service2.GetCurSelectTeamId()));
			}
		}
		catch (Exception)
		{
		}
	}

	public async Task<bool> SetCurTeamMemberRequest(List<int> roleIds)
	{
		if (ReadyData.Target == BattleReadyTarget.HeroChallenge || ReadyData.Target == BattleReadyTarget.CopyType3FirePower)
		{
			return true;
		}
		int teamId = Singleton<ServiceSystem>.Instance.GetService<ITeamService>().GetCurSelectTeamId();
		Loading loading = await Loading.Show();
		bool result = false;
		try
		{
			result = await Singleton<ServiceSystem>.Instance.GetService<ITeamService>().SetSingleTroopRequest(teamId, roleIds);
		}
		catch (Exception ex)
		{
			Log.Error(ex?.ToString() + ex.StackTrace);
		}
		loading.Dispose();
		return result;
	}

	private TeamModel CreateHeroChallengeTeamModel(List<int> roleIds)
	{
		return new TeamModel(-1, string.Empty, roleIds);
	}

	public async void ChangeTeamNameRequest(int teamId, string newTeamName)
	{
		Loading loading = await Loading.Show();
		bool num = await Singleton<ServiceSystem>.Instance.GetService<ITeamService>().RenameSingleTroopRequest(teamId, newTeamName);
		loading.Dispose();
		if (num)
		{
			CurTeamName = newTeamName;
			_changeNameViewCloseRequest.Raise();
		}
		else
		{
			_changeTeamNameViewModel.ErrorText = "修改队伍名称失败";
		}
	}

	private void RefreshTeamAttribute()
	{
		List<HeroModel> list = new List<HeroModel>();
		foreach (BattleReadySeatViewModel seatVm in _seatVmList)
		{
			if (seatVm.Empty)
			{
				list.Add(null);
			}
			else
			{
				list.Add(seatVm.Data);
			}
		}
		_teamAttributeViewModel.RefreshData(list);
	}

	private void ChangeHeroInCurTeam(TeamModel teamModel)
	{
		List<HeroModel> heroModels = teamModel.GetHeroModels();
		for (int i = 0; i < 3; i++)
		{
			_seatVmList[i].RefreshHero((heroModels.Count > i) ? heroModels[i] : new HeroModel());
			if (readyData.Target == BattleReadyTarget.ActivityHeroTry)
			{
				DRTeamSet dataRow = GameEntry.DataTable.GetDataRow<DRTeamSet>(readyData.TeamSetId);
				_seatVmList[i].SetHeroTry(dataRow.Lock.Count > i && dataRow.Lock[i] == 1, teamModel.IsHeroTry(i), teamModel.GetHeroTryId(i));
			}
		}
		RefreshTeamAttribute();
		readyData.SetTeamModel(teamModel);
		_teamChangedRequest.Raise();
	}

	public void OnLeftArrowBtnClick()
	{
		int num = Singleton<ServiceSystem>.Instance.GetService<ITeamService>().GetCurSelectTeamId() - 1;
		num = ((num < 1) ? 6 : num);
		SelectionTeamChanged(num);
	}

	public void OnRightArrowBtnClick()
	{
		int num = Singleton<ServiceSystem>.Instance.GetService<ITeamService>().GetCurSelectTeamId() + 1;
		num = ((num > 6) ? 1 : num);
		SelectionTeamChanged(num);
	}

	public void SelectionTeamChanged(int targetTeamId, bool setService = true)
	{
		if (targetTeamId > 0 && targetTeamId <= 6)
		{
			if (setService)
			{
				Singleton<ServiceSystem>.Instance.GetService<ITeamService>().SetCurSelectTeamId(targetTeamId);
			}
			TeamModel teamDataById = Singleton<ServiceSystem>.Instance.GetService<ITeamService>().GetTeamDataById(targetTeamId);
			SetTeamModel(teamDataById);
		}
	}

	public void SetTeamModel(TeamModel teamModel)
	{
		ChangeHeroInCurTeam(teamModel);
		CurTeamName = teamModel.TeamName;
		_onPointChangeRequest.Raise();
		RefreshTeamAttribute();
	}

	private void TryStartBattle()
	{
		if (ShowCost && !CostEnough)
		{
			Toast.ShowInfo(costProp.Name + " 不足");
			return;
		}
		startBattleCommand.Enabled = false;
		StartBattle();
	}

	private async void StartBattle()
	{
		BattleReadySeatViewModel battleReadySeatViewModel = _seatVmList[0];
		if (battleReadySeatViewModel.Data == null || battleReadySeatViewModel.Data.Empty)
		{
			Toast.ShowInfo("必须要有队长");
			startBattleCommand.Enabled = true;
			return;
		}
		battleReadySeatViewModel.Data.AddBPData(Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().GetBpCarrying());
		readyType = BattleReadyType.Ready;
		DisposeVoiceGroup();
		if (parent != null)
		{
			parent.ItemOnClick(this);
		}
		else
		{
			dismissRequest.Raise();
		}
	}

	public void SetStartBattleResult(bool success)
	{
		if (success)
		{
			dismissRequest.Raise();
		}
		else
		{
			startBattleCommand.Enabled = true;
		}
	}

	public List<TeamMember> TeamData()
	{
		List<TeamMember> list = new List<TeamMember>();
		for (int i = 0; i < 3; i++)
		{
			HeroModel data = _seatVmList[i].Data;
			if (!data.IsNullOrEmpty())
			{
				bool flag = i + 1 == 1;
				list.Add(new TeamMember(i + 1, flag, data, flag, !flag));
			}
		}
		return list;
	}

	private void InitBattleMode()
	{
		if (readyData.Target == BattleReadyTarget.Level)
		{
			readyData.SetBattleMode(BattleMode.Level);
			ShowCost = false;
			HasCopyBuff = false;
		}
		else if (readyData.Target == BattleReadyTarget.Copy)
		{
			InitCopyCostRate();
			AddCopyBuff(readyData.TargetId);
		}
		else if (readyData.Target == BattleReadyTarget.HeroChallenge || readyData.Target == BattleReadyTarget.CopyType3FirePower)
		{
			BattleMode copyMode = Singleton<ServiceSystem>.Instance.GetService<ITeamService>().GetCopyMode(readyData.TargetId);
			readyData.SetBattleMode(copyMode);
			ShowCost = false;
			AddCopyBuff(readyData.TargetId);
		}
		else if (readyData.Target == BattleReadyTarget.ActivityHeroTry)
		{
			readyData.SetBattleMode(BattleMode.HeroTry);
			ShowCost = false;
			AddCopyBuff(readyData.TargetId);
		}
		else if (readyData.Target == BattleReadyTarget.CopyFirstPass)
		{
			readyData.SetBattleMode(BattleMode.CopyNormal);
			ShowCost = false;
			InitCostPropData();
			SetCostMode(new MultiRoomCostItemData(this, costProp, "首通", 0f, 1, 0, 0));
			AddCopyBuff(readyData.TargetId);
		}
		RefreshCostEnoughState();
	}

	private void InitCostPropData()
	{
		DRCopy dataRow = GameEntry.DataTable.GetDataRow<DRCopy>(readyData.TargetId);
		if (dataRow != null)
		{
			int count = ((readyData.Target != BattleReadyTarget.CopyFirstPass) ? dataRow.CostNum : 0);
			costProp = PropDataBase.CreateByType(dataRow.CostType, dataRow.CostId, count);
			if (costProp == null || costProp.Empty)
			{
				ShowCost = false;
				ShowCostProp = false;
				HasCopyBuff = false;
			}
			else
			{
				CostPropIcon = costProp.Icon;
				CostPropCount = costProp.Amount;
			}
		}
	}

	private void RefreshCostEnoughState()
	{
		if (readyData != null)
		{
			if (readyData.Target == BattleReadyTarget.Level)
			{
				CostEnough = true;
			}
			else if (readyData.Target == BattleReadyTarget.HeroChallenge || readyData.Target == BattleReadyTarget.CopyType3FirePower)
			{
				CostEnough = true;
			}
			else if (readyData.Target == BattleReadyTarget.ActivityHeroTry)
			{
				CostEnough = true;
			}
			else if (readyData.Target == BattleReadyTarget.CopyFirstPass)
			{
				CostEnough = true;
			}
			else if (costProp != null && !costProp.Empty)
			{
				CostEnough = (float)PropHelper.GetPropOwnedCount(costProp.Id) >= (float)CostPropCount * CostPropRate;
			}
		}
	}

	private void InitCopyCostRate()
	{
		DRCopy dataRow = GameEntry.DataTable.GetDataRow<DRCopy>(readyData.TargetId);
		DRCopyType dataRow2 = GameEntry.DataTable.GetDataRow<DRCopyType>(dataRow?.CopyType ?? 0);
		DRRate dataRow3 = GameEntry.DataTable.GetDataRow<DRRate>(dataRow2?.Rate ?? 0);
		if (dataRow == null || dataRow2 == null || dataRow3 == null)
		{
			ShowCost = false;
			HasCopyBuff = false;
			return;
		}
		InitCostPropData();
		int defaultDropRate = Singleton<ServiceSystem>.Instance.GetService<ICopyService>()?.GetCacheDropRate(readyData.TargetId) ?? (-1);
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
			costItemDataList.Add(new MultiRoomCostItemData(this, costProp, desc, costRate, dropRate, unlockType, unlockNum));
		}
		costItemDataList.Add(new MultiRoomCostItemData(this, costProp, "无报酬", 0f, 0, 0, 0));
		MultiRoomCostItemData multiRoomCostItemData = costItemDataList.Find((MultiRoomCostItemData p) => p.DropRate == defaultDropRate);
		if (multiRoomCostItemData != null)
		{
			SetCostMode(multiRoomCostItemData);
		}
		costItemDataList.Sort((MultiRoomCostItemData a, MultiRoomCostItemData b) => a.DropRate.CompareTo(b.DropRate));
		ShowCost = true;
	}

	public void OpenCostList()
	{
		ShowCostItemList = true;
	}

	public void CloseCostList()
	{
		ShowCostItemList = false;
	}

	private void SetCostMode(MultiRoomCostItemData costItemData)
	{
		if (curCostItemData != null)
		{
			if (curCostItemData.DropRate == costItemData.DropRate)
			{
				return;
			}
			curCostItemData.IsSelected = false;
		}
		curCostItemData = costItemData;
		curCostItemData.IsSelected = true;
		CurCostDesc = costItemData.RateDesc;
		CostPropRate = costItemData.CostRate;
		readyData.SetDropRate(costItemData.DropRate);
		BattleMode mode = ((costItemData.DropRate > 0) ? BattleMode.CopyNormal : BattleMode.CopyPractice);
		readyData.SetBattleMode(mode);
		Singleton<ServiceSystem>.Instance.GetService<ITeamService>().SetCopyMode(readyData.TargetId, mode);
		_seatVmList?.ForEach(delegate(BattleReadySeatViewModel p)
		{
			p.SetPracticeTag(mode.Equals(BattleMode.CopyPractice));
		});
		ShowCostProp = mode.Equals(BattleMode.CopyNormal) && costProp != null && !costProp.Empty;
		RefreshCostEnoughState();
	}

	private void OnMoneyMsgReceived(MoneyMessage msg)
	{
		if (msg != null && costProp != null && costProp.Id == (int)msg.MoneyType)
		{
			RefreshCostEnoughState();
		}
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is BattleReadySeatViewModel parameter)
		{
			selectHeroCmd.Execute(parameter);
		}
		else if (obj is HeroSelectionViewModel selectVM)
		{
			GetSelectionResult(selectVM);
		}
		else if (obj is BattlePropConfigViewModel userData)
		{
			openWindowRequest.Raise(new OpenViewArg(typeof(BattlePropConfigWindow), userData), delegate
			{
				BpConfigViewModel.Refresh();
			});
		}
		else if (obj is MultiRoomCostItemData costMode)
		{
			SetCostMode(costMode);
			ShowCostItemList = false;
		}
		base.ItemOnClick(obj);
	}

	private void OpenHeroSelectionWindow(BattleReadySeatViewModel seatViewModel)
	{
		selectHeroCmd.Enabled = false;
		HeroSelectionViewModel heroSelectionViewModel = null;
		heroSelectionViewModel = ((readyData.BattleMode != BattleMode.HeroTry) ? new HeroSelectionViewModel(this) : new HeroTrySelectionViewModel(this, readyData.TeamSetId));
		heroSelectionViewModel.OnBattleReadyOpen(_seatVmList, seatViewModel, seatViewModel.SeatId);
		openWindowRequest.Raise(new OpenViewArg(typeof(HeroSelectionWindow), heroSelectionViewModel), delegate
		{
			if (_seatVmList != null)
			{
				foreach (BattleReadySeatViewModel seatVm in _seatVmList)
				{
					seatVm?.OnHeroModelChangedRequest?.Raise(seatVm.Data);
				}
			}
			selectHeroCmd.Enabled = true;
		});
	}

	public void Cancel()
	{
		readyType = BattleReadyType.Cancel;
		parent?.ItemOnClick(this);
		Close();
	}

	public override void Close()
	{
		parent?.ItemOnClick(new OptionArg(this, "Close"));
		base.Close();
	}

	private void DisposeVoiceGroup()
	{
		List<AudioParameter> fadeOutParameters = AudioManagerExtension.GetFadeOutParameters(AudioDef.DefaultFadeOutParams.x, 1f);
		Singleton<AudioSystem>.Instance.UnRegisterGroup(VoiceGroupEnum.BattleReady, stopVoice: true, fadeOutParameters);
		voiceGroup = null;
	}

	public override void Dispose()
	{
		DisposeVoiceGroup();
		subscription_moneyMsg?.Dispose();
		subscription_moneyMsg = null;
		base.Dispose();
	}

	public void OnBeginDrag(BattleReadySeatViewModel seatVm)
	{
		catchedSeatVm = seatVm;
		_dragSeatVm.RefreshHero(seatVm.Data);
		_dragSeatVm.SetHeroTry(isLock: false, seatVm.HeroTryTag, seatVm.HeroTryId);
		catchedSeatVm.RefreshHero(null);
	}

	public async void OnEndDrag()
	{
		HeroModel dragHero = _dragSeatVm.Data;
		if (catchedSeatVm != null && seatCovered != null)
		{
			if (readyData.Target == BattleReadyTarget.ActivityHeroTry && (seatCovered.SeatLockTag || seatCovered == null || seatCovered.ConfigDisable))
			{
				seatCovered.ShowHeroTryLockToast();
				_seatVmList[seatCovered.SeatId - 1].RefreshHero(seatCovered.Data);
				_seatVmList[catchedSeatVm.SeatId - 1].RefreshHero(catchedSeatVm.Data);
				return;
			}
			int catchIndex = catchedSeatVm.SeatId;
			int coveredIndex = seatCovered.SeatId;
			HeroModel catchHero = catchedSeatVm.Data;
			List<int> list = new List<int>();
			for (int i = 1; i < 4; i++)
			{
				if (catchIndex == i)
				{
					list.Add(catchHero.Id);
				}
				else if (coveredIndex == i)
				{
					list.Add(dragHero.Id);
				}
				else
				{
					list.Add(_seatVmList[i - 1].Data.Id);
				}
			}
			if (!(await SetCurTeamMemberRequest(list)))
			{
				_seatVmList[coveredIndex - 1].RefreshHero(catchHero);
				_seatVmList[catchIndex - 1].RefreshHero(dragHero);
			}
			else
			{
				_seatVmList[coveredIndex - 1].RefreshHero(dragHero);
				_seatVmList[catchIndex - 1].RefreshHero(catchHero);
			}
		}
		else
		{
			catchedSeatVm?.RefreshHero(dragHero);
		}
		ClearCacheDragVm();
		_seatStateChangeRst.Raise(BattleReadySeatView.SeatState.Normal);
	}

	public void OnPointerEnterSeat(BattleReadySeatViewModel seatVm)
	{
		if (seatVm.SeatId == catchedSeatVm.SeatId)
		{
			return;
		}
		if (readyData.Target == BattleReadyTarget.ActivityHeroTry)
		{
			if (seatVm.SeatLockTag)
			{
				seatVm.ShowHeroTryLockToast();
				return;
			}
			if (seatVm == null || seatVm.ConfigDisable)
			{
				return;
			}
		}
		HeroModel data = seatVm.Data;
		seatVm.RefreshHero(catchedSeatVm.Data);
		catchedSeatVm.RefreshHero(data);
		seatCovered = seatVm;
	}

	public void OnPointerExitSeat(BattleReadySeatViewModel seatVm)
	{
		if (seatVm.SeatId == catchedSeatVm.SeatId)
		{
			return;
		}
		if (readyData.Target == BattleReadyTarget.ActivityHeroTry)
		{
			if (seatVm.SeatLockTag)
			{
				seatVm.ShowHeroTryLockToast();
				return;
			}
			if (seatVm == null || seatVm.ConfigDisable)
			{
				return;
			}
		}
		HeroModel data = catchedSeatVm.Data;
		catchedSeatVm.RefreshHero(seatVm.Data);
		seatVm.RefreshHero(data);
		seatCovered = null;
	}

	private void ClearCacheDragVm()
	{
		_dragSeatVm.RefreshHero(null);
		catchedSeatVm = null;
		seatCovered = null;
	}

	private void AddCopyBuff(int copyId)
	{
		CopyData copyById = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().GetCopyById(copyId);
		if (copyById == null)
		{
			DRCopy dataRow = GameEntry.DataTable.GetDataRow<DRCopy>(copyId);
			if (dataRow != null && dataRow.Buff != null && dataRow.Buff.Count > 0)
			{
				adItemList = dataRow.Buff;
				adItemList.Sort((int a, int b) => a.CompareTo(b));
				HasCopyBuff = true;
			}
			HasCopyBuff = false;
		}
		else if (copyById.Buffs != null && copyById.Buffs.Count > 0 && copyById.Buffs[0] > 0)
		{
			adItemList = new List<int>();
			for (int num = 0; num < copyById.Buffs.Count; num++)
			{
				adItemList.Insert(0, copyById.Buffs[num]);
			}
			HasCopyBuff = true;
		}
		else
		{
			HasCopyBuff = false;
		}
	}
}
