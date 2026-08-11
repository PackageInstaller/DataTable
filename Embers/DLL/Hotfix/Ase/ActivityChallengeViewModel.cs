#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class ActivityChallengeViewModel : ActivityViewModelBase
{
	private const int ActivityChallengeRankTypeType = 9;

	private int ActivityChallengeRankType;

	protected InteractionRequest<string> optRequest;

	protected SimpleCommand<string> optCommand;

	private string bossName;

	private bool isFirst;

	protected string _activityTimeText2;

	protected List<CopyItemViewModel> listItems;

	protected CopyItemDetail1ViewModel detailViewModel;

	protected CopyItemViewModel curSelectViewModel;

	private List<KnapsackItemViewModel> showRewardItemDataList;

	protected List<ReceiveItemViewModel> rewardItemViewModels;

	private List<TimeDuraValidData> openTimeItemViewModels;

	private DRActivityChallenge activityChallengeConfig;

	private List<ReportItemViewModel> enviroBuffItems = new List<ReportItemViewModel>();

	public string activityDesc = "";

	private bool isReward;

	private bool canReward;

	private int curBeatCount;

	private int maxBeatCount;

	protected bool isInit;

	private string buffName;

	private string buffDesc;

	private bool showBuffBar;

	private bool showRankRoot;

	private long rankScore;

	private bool isRequestingChallengeCopyPlayerRankInfo;

	private Dictionary<int, int> challengeCopyPlayerScores;

	protected int openTag;

	protected virtual string ChallengeWindowPath => null;

	public bool ShowRankRoot
	{
		get
		{
			return showRankRoot;
		}
		private set
		{
			Set(ref showRankRoot, value, "ShowRankRoot");
		}
	}

	public long RankScore
	{
		get
		{
			return rankScore;
		}
		private set
		{
			Set(ref rankScore, value, "RankScore");
		}
	}

	public CopyItemDetail1ViewModel DetailViewModel
	{
		get
		{
			return detailViewModel;
		}
		private set
		{
			Set(ref detailViewModel, value, "DetailViewModel");
		}
	}

	public bool IsReward
	{
		get
		{
			return isReward;
		}
		private set
		{
			Set(ref isReward, value, "IsReward");
		}
	}

	public CopyItemViewModel SelectItemViewModel
	{
		get
		{
			return curSelectViewModel;
		}
		private set
		{
			Set(ref curSelectViewModel, value, "SelectItemViewModel");
		}
	}

	public string ActivityDesc
	{
		get
		{
			return activityDesc;
		}
		protected set
		{
			Set(ref activityDesc, value, "ActivityDesc");
		}
	}

	public string BuffName
	{
		get
		{
			return buffName;
		}
		protected set
		{
			Set(ref buffName, value, "BuffName");
		}
	}

	public string BuffDesc
	{
		get
		{
			return buffDesc;
		}
		protected set
		{
			Set(ref buffDesc, value, "BuffDesc");
		}
	}

	public bool ShowBuffBar
	{
		get
		{
			return showBuffBar;
		}
		private set
		{
			Set(ref showBuffBar, value, "ShowBuffBar");
		}
	}

	public int CurBeatCount
	{
		get
		{
			return curBeatCount;
		}
		private set
		{
			Set(ref curBeatCount, value, "CurBeatCount");
		}
	}

	public int MaxBeatCount
	{
		get
		{
			return maxBeatCount;
		}
		private set
		{
			Set(ref maxBeatCount, value, "MaxBeatCount");
		}
	}

	public string BossName
	{
		get
		{
			return bossName;
		}
		private set
		{
			Set(ref bossName, value, "BossName");
		}
	}

	public bool IsFirst
	{
		get
		{
			return isFirst;
		}
		private set
		{
			Set(ref isFirst, value, "IsFirst");
		}
	}

	public string ActivityTimeText2
	{
		get
		{
			return _activityTimeText2;
		}
		protected set
		{
			Set(ref _activityTimeText2, value, "ActivityTimeText2");
		}
	}

	public List<ReportItemViewModel> EnviroBuffItems => enviroBuffItems;

	public List<KnapsackItemViewModel> ShowRewardItemDataList => showRewardItemDataList;

	public List<CopyItemViewModel> ListItems => listItems;

	public ICommand OptCommand => optCommand;

	public IInteractionRequest OptRequest => optRequest;

	public List<ReceiveItemViewModel> RewardItemViewModels => rewardItemViewModels;

	public List<TimeDuraValidData> OpenTimeItemViewModels => openTimeItemViewModels;

	public void CreateTimeDura()
	{
		if (openTimeItemViewModels == null)
		{
			DRActivityChallenge dataRow = GameEntry.DataTable.GetDataRow((DRActivityChallenge p) => p.ActivityId == _activityTypeId);
			string[] array = SettleOpenTime(dataRow.OpenTime).Split('|');
			openTimeItemViewModels = new List<TimeDuraValidData>();
			for (int num = 0; num < array.Length; num++)
			{
				TimeDuraValidData timeDuraValidData = new TimeDuraValidData(GroupTagEnum.ActivtiyChallenge, array[num]);
				openTimeItemViewModels.Add(timeDuraValidData);
				timeDuraValidData.AddFinishAction(OnFinish);
				Singleton<ServiceSystem>.Instance.GetService<ITimeService>().AddTimeDuraSettle(timeDuraValidData.TimeDura);
			}
		}
		else
		{
			for (int num2 = 0; num2 < openTimeItemViewModels.Count; num2++)
			{
				openTimeItemViewModels[num2].AddFinishAction(OnFinish);
			}
		}
	}

	public void RemoveTimeDura()
	{
		if (openTimeItemViewModels != null)
		{
			for (int i = 0; i < openTimeItemViewModels.Count; i++)
			{
				openTimeItemViewModels[i].Clear();
			}
			Singleton<ServiceSystem>.Instance?.GetService<ITimeService>()?.ClearTimeDureByTag(GroupTagEnum.ActivtiyChallenge);
			openTimeItemViewModels = null;
		}
	}

	private string SettleOpenTime(string oriConfigString)
	{
		try
		{
			return oriConfigString.Replace('：', ':');
		}
		catch (Exception ex)
		{
			Log.Error("处理时间字符串发生异常 【" + oriConfigString + "】 " + ex.Message + " / " + ex.StackTrace);
		}
		return "";
	}

	public override void SetServiceTaskData(List<ActivityTaskData> taskDataList)
	{
		base.SetServiceTaskData(taskDataList);
		Singleton<ServiceSystem>.Instance.GetService<ITimeService>().AddDailyUpdateAction(OnDailyUpdate);
		optCommand = new SimpleCommand<string>(OnOpt);
		optRequest = new InteractionRequest<string>();
		detailViewModel = new CopyItemDetail1ViewModel(this);
		ActivityDesc = _drActivityType.Desc.Replace("\\n", "\n");
		rewardItemViewModels = PropHelper.GetActivityCopyDrop(this, _drActivityType.RewardId);
		activityChallengeConfig = GameEntry.DataTable.GetDataRow((DRActivityChallenge p) => p.ActivityId == _drActivityType.Id);
		CheckTaskReward();
		CopyViewModel copyVM = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM();
		listItems = new List<CopyItemViewModel>();
		if (activityChallengeConfig == null)
		{
			Log.Error($"ActivityChallenge找不到配置{_drActivityType.Id}");
			isInit = true;
			return;
		}
		DRChallengeCopy[] dataRows = GameEntry.DataTable.GetDataRows((DRChallengeCopy p) => p.ActivityId == activityChallengeConfig.Id);
		if (dataRows != null)
		{
			copyVM.LoadActivityChallengeCopys(dataRows, _activityTypeId);
			int curDayOfWeek = Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetCurDayOfWeek();
			for (int num = 0; num < dataRows.Length; num++)
			{
				if (dataRows[num].RefreshConfig == null || !dataRows[num].RefreshConfig.Contains(curDayOfWeek))
				{
					continue;
				}
				CopyData activityChallengeCopyById = copyVM.GetActivityChallengeCopyById(_activityTypeId, dataRows[num].RefreshType);
				if (activityChallengeCopyById == null)
				{
					Log.Error($"活动{_activityTypeId}，找不到Id为{dataRows[num].RefreshType}的副本！");
					continue;
				}
				CopyItemViewModel copyItemViewModel = new CopyItemViewModel(this, activityChallengeCopyById);
				SetCopyItemBossName(copyItemViewModel);
				listItems.Add(copyItemViewModel);
				for (int num2 = 0; num2 < taskDataList.Count; num2++)
				{
					if (taskDataList[num2].Id == dataRows[num].TaskId)
					{
						copyItemViewModel.AddTaskId(dataRows[num].TaskId);
						if (taskDataList[num2].CompleteState == 1)
						{
							activityChallengeCopyById.CopyAccess((int)taskDataList[num2].CompleteValue);
						}
					}
				}
			}
			if (listItems != null && listItems.Count > 0)
			{
				SelectCopyItem(listItems[0]);
			}
		}
		else
		{
			Log.Error($"ChallengeCopy表找不到配置，ActivityId：{activityChallengeConfig.Id}");
		}
		isInit = true;
	}

	public override void RefreshActivityTime(bool getLeftTime = true)
	{
		_leftActivityTime = OpActivityDefinition.GetActivityTime(base.DrActivityType);
		string activityTimeText = OpActivityDefinition.GetActivityTimeText(_leftActivityTime);
		base.ActivityTimeText = (string.IsNullOrEmpty(activityTimeText) ? activityTimeText : ("剩余时间：" + activityTimeText));
		ActivityTimeText2 = (string.IsNullOrEmpty(activityTimeText) ? activityTimeText : (activityTimeText ?? ""));
	}

	private void OnDailyUpdate()
	{
		DailyUpdate();
	}

	protected virtual async UniTask DailyUpdate()
	{
		await UniTask.WaitUntil(() => isInit);
		CopyViewModel copyVM = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM();
		DRChallengeCopy[] dataRows = GameEntry.DataTable.GetDataRows((DRChallengeCopy p) => p.ActivityId == activityChallengeConfig.Id);
		if (dataRows == null)
		{
			return;
		}
		int curDayOfWeek = Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetCurDayOfWeek();
		for (int num = 0; num < dataRows.Length; num++)
		{
			if (dataRows[num].RefreshConfig != null && !dataRows[num].RefreshConfig.Contains(curDayOfWeek))
			{
				for (int num2 = 0; num2 < listItems.Count; num2++)
				{
					if (listItems[num2].Data.Id == dataRows[num].RefreshType)
					{
						listItems.RemoveAt(num2);
						break;
					}
				}
			}
			else
			{
				if (dataRows[num].RefreshConfig == null || !dataRows[num].RefreshConfig.Contains(curDayOfWeek))
				{
					continue;
				}
				bool flag = true;
				for (int num3 = 0; num3 < listItems.Count; num3++)
				{
					if (listItems[num3].Data.Id == dataRows[num].RefreshType)
					{
						flag = false;
						break;
					}
				}
				if (!flag)
				{
					continue;
				}
				CopyData activityChallengeCopyById = copyVM.GetActivityChallengeCopyById(_activityTypeId, dataRows[num].RefreshType);
				CopyItemViewModel copyItemViewModel = new CopyItemViewModel(this, activityChallengeCopyById);
				SetCopyItemBossName(copyItemViewModel);
				listItems.Add(copyItemViewModel);
				for (int num4 = 0; num4 < _pbTaskDataList.Count; num4++)
				{
					if (_pbTaskDataList[num].Id == dataRows[num].TaskId && _pbTaskDataList[num].CompleteState == 1)
					{
						activityChallengeCopyById.CopyAccess((int)_pbTaskDataList[num].CompleteValue);
					}
				}
			}
		}
		bool flag2 = false;
		for (int num5 = 0; num5 < listItems.Count; num5++)
		{
			if (listItems[num5].IsSelect)
			{
				flag2 = true;
			}
		}
		if (!flag2 && (listItems != null || listItems.Count > 0))
		{
			SelectCopyItem(listItems[0]);
		}
		optRequest.Raise("OnDayRefresh");
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is CopyItemViewModel copyItemVm)
		{
			HideBuffBar();
			SelectCopyItem(copyItemVm);
		}
		else if (openTag == 0 && obj is ReceiveItemViewModel)
		{
			parent?.ItemOnClick(obj);
		}
		else if (obj is KnapsackItemViewModel knapsackItemViewModel)
		{
			HideBuffBar();
			if (knapsackItemViewModel.PropDataBase.PropTypeEnum == PropTypeEnum.Equipment)
			{
				ArmourPopupViewModel userData = new ArmourPopupViewModel(this, (ArmourData)knapsackItemViewModel.PropDataBase);
				openWindowRequest.Raise(new OpenViewArg(typeof(ArmourPopupSampleView), userData));
				return;
			}
			OpenViewArg openViewArg = knapsackItemViewModel.OpenPopupWindow(this);
			if (openViewArg != null)
			{
				openWindowRequest.Raise(openViewArg);
			}
		}
		else if (obj is ReportItemViewModel buffItem)
		{
			SelectBuffItem(buffItem);
		}
	}

	private async void OnOpt(string optName)
	{
		HideBuffBar();
		if (!optCommand.Enabled)
		{
			return;
		}
		optCommand.Enabled = false;
		if ("OnReward".Equals(optName))
		{
			if (canReward)
			{
				await OnReward();
			}
			else
			{
				SetReward();
				optRequest.Raise("ShowRewardPop");
			}
			optCommand.Enabled = true;
		}
		else if ("OnMulti".Equals(optName))
		{
			OnMulti();
		}
		else if ("OpenChallengeMain".Equals(optName))
		{
			OpenChallengeMain();
		}
		else if ("OnRank".Equals(optName))
		{
			OnRank();
		}
		else
		{
			optCommand.Enabled = true;
		}
	}

	public async void OnRank()
	{
		try
		{
			if (!ShowRankRoot || curSelectViewModel == null)
			{
				optCommand.Enabled = true;
				return;
			}
			int id = curSelectViewModel.Data.Id;
			RankViewModel userData = new RankViewModel(this, ActivityChallengeRankType, id);
			openWindowRequest.Raise(new OpenViewArg(typeof(RankWindow), userData), delegate
			{
				optCommand.Enabled = true;
			});
		}
		catch (Exception ex)
		{
			Log.Error("打开排行榜失败！" + ex.Message + " / " + ex.StackTrace);
			optCommand.Enabled = true;
		}
	}

	private void OpenChallengeMain()
	{
		try
		{
			if (curSelectViewModel == null)
			{
				Toast.ShowInfo("暂无活动副本开放！");
				optCommand.Enabled = true;
			}
			else if (openTag == 1)
			{
				optCommand.Enabled = true;
			}
			else if (_lockState == OpActivityLockState.Locked)
			{
				if (_drActivityType.UnlockCondition == 1)
				{
					Toast.ShowInfo($"传火等级达到{_drActivityType.UnlockConditionValue}开启！");
				}
				else
				{
					Toast.ShowInfo("活动暂未开启！");
				}
				optCommand.Enabled = true;
			}
			else
			{
				SetOpenTag();
				parent.ItemOnClick(CreateChallengeWindowOpenArg());
				optCommand.Enabled = true;
			}
		}
		catch (Exception)
		{
			optCommand.Enabled = true;
		}
	}

	public ActivityChallengeWindowOpenArg CreateChallengeWindowOpenArg()
	{
		return new ActivityChallengeWindowOpenArg(this, ChallengeWindowPath, delegate
		{
			openTag = 0;
		});
	}

	private void CheckTaskReward()
	{
		canReward = false;
		IsReward = false;
		for (int i = 0; i < _pbTaskDataList.Count; i++)
		{
			if (_pbTaskDataList[i].Id == activityChallengeConfig.ActivityTaskId)
			{
				curBeatCount = (int)_pbTaskDataList[i].CompleteValue;
				maxBeatCount = _pbTaskDataList[i].TargetValue;
				canReward = _pbTaskDataList[i].CompleteState == 1 && _pbTaskDataList[i].RewardState == 0;
				IsReward = _pbTaskDataList[i].CompleteState == 1 && _pbTaskDataList[i].RewardState != 0;
			}
		}
		UpdateRed();
	}

	public bool IsTimeValid()
	{
		if (openTimeItemViewModels == null)
		{
			Log.Error("未找到活动副本开放时间！");
			optCommand.Enabled = true;
			return false;
		}
		bool flag = false;
		for (int i = 0; i < openTimeItemViewModels.Count; i++)
		{
			flag = openTimeItemViewModels[i].IsValid();
			if (flag)
			{
				break;
			}
		}
		return flag;
	}

	private void SetReward()
	{
		if (showRewardItemDataList == null)
		{
			DRActivityTaskReward dataRow = GameEntry.DataTable.GetDataRow<DRActivityTaskReward>(activityChallengeConfig.RewardId);
			showRewardItemDataList = PropHelper.GetPropList(this, dataRow.RewardId, dataRow.RewardType, dataRow.RewardNum);
		}
		SetRewardState();
	}

	private void SetRewardState()
	{
		if (showRewardItemDataList != null)
		{
			for (int i = 0; i < showRewardItemDataList.Count; i++)
			{
				showRewardItemDataList[i].IsSelected = isReward;
			}
		}
	}

	private async UniTask OnReward()
	{
		try
		{
			ActivityReward activityReward = await Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetTaskReward(base.ActivityTypeId, activityChallengeConfig.ActivityTaskId);
			if (activityReward.Rewards != null)
			{
				IsReward = true;
				canReward = false;
				SetRewardState();
				PropGetViewModel userData = new PropGetViewModel(this, activityReward.Rewards);
				openWindowRequest.Raise(new OpenViewArg(typeof(PropGetWindow), userData), delegate
				{
				});
				UpdateRed();
			}
		}
		catch (Exception)
		{
		}
	}

	public void SelectCopy(CopyData copyData)
	{
		for (int i = 0; i < listItems.Count; i++)
		{
			if (listItems[i].Data.Id == copyData.Id)
			{
				SelectCopyItem(listItems[i]);
				return;
			}
		}
		curSelectViewModel = null;
	}

	protected void SelectCopyItem(CopyItemViewModel copyItemVm)
	{
		if (copyItemVm == null)
		{
			return;
		}
		if (curSelectViewModel == copyItemVm)
		{
			IsFirst = !curSelectViewModel.Data.IsAccessed && curSelectViewModel.Data.IsNeedFirst;
			return;
		}
		if (curSelectViewModel != null)
		{
			curSelectViewModel.SetSelect(isSelect: false);
		}
		detailViewModel.RefreshData(copyItemVm.Data, 0);
		SelectItemViewModel = copyItemVm;
		SetCopyItemBossName(curSelectViewModel);
		curSelectViewModel.SetSelect(isSelect: true);
		RefreshEnviroBuff();
		optRequest.Raise("RefreshCopyList");
		BossName = curSelectViewModel.BossNameAndLv;
		IsFirst = !curSelectViewModel.Data.IsAccessed && curSelectViewModel.Data.IsNeedFirst;
		RefreshRankUI();
	}

	protected virtual void SetCopyItemBossName(CopyItemViewModel copyItemVm)
	{
		copyItemVm?.SetBossNameAndLv();
	}

	public void RefreshRankUI()
	{
		bool flag = false;
		ActivityChallengeRankType = 0;
		if (curSelectViewModel != null)
		{
			int id = curSelectViewModel.Data.Id;
			List<DRRankType> list = (Singleton<ServiceSystem>.Instance?.GetService<IRankService>()?.GetOpenRankTypes())?.FindAll((DRRankType p) => p != null && p.Type == 9);
			if (list != null && list.Count > 0)
			{
				for (int num = 0; num < list.Count; num++)
				{
					DRRankType openRank = list[num];
					DRRank[] dataRows = GameEntry.DataTable.GetDataRows((DRRank p) => p.RankType == openRank.Id);
					if (dataRows == null)
					{
						continue;
					}
					foreach (DRRank dRRank in dataRows)
					{
						if (dRRank != null && dRRank.RankTarget == id)
						{
							ActivityChallengeRankType = openRank.Id;
							break;
						}
					}
					if (ActivityChallengeRankType != 0)
					{
						break;
					}
				}
				if (ActivityChallengeRankType == 0)
				{
					ActivityChallengeRankType = list[0].Id;
				}
				flag = true;
			}
		}
		ShowRankRoot = flag;
		RankScore = 0L;
		if (flag && curSelectViewModel != null)
		{
			int id2 = curSelectViewModel.Data.Id;
			if (challengeCopyPlayerScores != null && challengeCopyPlayerScores.TryGetValue(id2, out var value))
			{
				RankScore = value;
			}
		}
	}

	public async UniTask RequestChallengeCopyPlayerRankInfo()
	{
		if (isRequestingChallengeCopyPlayerRankInfo)
		{
			return;
		}
		isRequestingChallengeCopyPlayerRankInfo = true;
		try
		{
			ICopyService copyService = Singleton<ServiceSystem>.Instance?.GetService<ICopyService>();
			if (copyService == null)
			{
				return;
			}
			KeyValuePair<bool, Dictionary<int, int>> keyValuePair = await copyService.GetChallengeCopyPlayerRankInfo();
			if (!keyValuePair.Key)
			{
				return;
			}
			if (challengeCopyPlayerScores == null)
			{
				challengeCopyPlayerScores = new Dictionary<int, int>();
			}
			else
			{
				challengeCopyPlayerScores.Clear();
			}
			if (keyValuePair.Value == null)
			{
				return;
			}
			foreach (KeyValuePair<int, int> item in keyValuePair.Value)
			{
				challengeCopyPlayerScores[item.Key] = item.Value;
			}
		}
		catch (Exception ex)
		{
			Log.Error("获取挑战副本分数失败 " + ex.Message + " / " + ex.StackTrace);
		}
		finally
		{
			isRequestingChallengeCopyPlayerRankInfo = false;
		}
	}

	protected virtual void RefreshEnviroBuff()
	{
		if (curSelectViewModel == null)
		{
			enviroBuffItems.Clear();
			optRequest.Raise("RefreshBuff");
			return;
		}
		List<int> enviroEnvironIds = curSelectViewModel.Data.EnviroEnvironIds;
		int num = enviroEnvironIds?.Count ?? 0;
		if (num > enviroBuffItems.Count)
		{
			for (int i = enviroBuffItems.Count; i < num; i++)
			{
				enviroBuffItems.Add(new ReportItemViewModel(this));
			}
		}
		else if (num < enviroBuffItems.Count)
		{
			for (int j = 0; j < enviroBuffItems.Count - num; j++)
			{
				enviroBuffItems.RemoveAt(0);
			}
		}
		for (int k = 0; k < num; k++)
		{
			int num2 = enviroEnvironIds[k];
			EnvironmentModifierDisplayInfo displayInfo = EnvironmentModifierHelper.GetDisplayInfo(num2);
			if (displayInfo.EnvironId != 0)
			{
				enviroBuffItems[k].RefreshData(displayInfo.Name, num2);
			}
			else
			{
				Log.Error($"找不到EnvironmentModifier配置【{num2}】,活动Id:{_activityTypeId},副本ID:{curSelectViewModel.Data.Id}");
			}
		}
		optRequest.Raise("RefreshBuff");
	}

	private void SelectBuffItem(ReportItemViewModel buffItem)
	{
		BuffName = buffItem.Name;
		BuffDesc = EnvironmentModifierHelper.GetDisplayInfo(buffItem.ReportId).Desc;
		SetShowBuffBar(isShow: true);
		buffItem.SetSelect(isSelect: false);
	}

	private void SetShowBuffBar(bool isShow)
	{
		ShowBuffBar = isShow;
	}

	public void HideBuffBar()
	{
		SetShowBuffBar(isShow: false);
	}

	protected virtual async UniTask OnMulti()
	{
		_ = 1;
		try
		{
			optCommand.Enabled = false;
			if (curSelectViewModel.Data.IsLock)
			{
				Toast.ShowInfo($"传火等级达到Lv{curSelectViewModel.Data.AdvLevel}开放！");
				optCommand.Enabled = true;
				return;
			}
			if (_leftActivityTime != -1 && _leftActivityTime <= 0)
			{
				Toast.ShowInfo("活动已结束！");
				optCommand.Enabled = true;
				return;
			}
			if (CopyEntryLimitHelper.TryBlockEntry(curSelectViewModel.Data, isMulti: true))
			{
				optCommand.Enabled = true;
				return;
			}
			Loading loading = await Loading.Show();
			ProtocolRequestResult num = await Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().CreateMultiRoom(curSelectViewModel.Data);
			loading.Dispose();
			if (num == ProtocolRequestResult.Exception)
			{
				Toast.ShowInfo("打开多人房间失败!");
			}
			optCommand.Enabled = true;
		}
		catch (Exception ex)
		{
			Toast.ShowInfo("打开组队界面失败！请重试！");
			Log.Error("打开组队界面失败!" + ex.Message + " / " + ex.StackTrace);
			optCommand.Enabled = true;
		}
	}

	private void OnFinish()
	{
		SettleFinish();
	}

	public virtual async UniTask SettleFinish()
	{
		if (isCloseView || Singleton<ServiceSystem>.Instance == null || Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>() == null)
		{
			return;
		}
		try
		{
			await UniTask.WaitForSeconds(1);
			MultiRoomViewModel multiRoomViewModel = Singleton<ServiceSystem>.Instance?.GetService<IMultiRoomService>()?.GetMultiRoomViewModel();
			if (multiRoomViewModel != null && multiRoomViewModel.CopyData != null && !multiRoomViewModel.IsCloseView && multiRoomViewModel.CopyData.ActivityTypeId == _activityTypeId && !IsTimeValid())
			{
				multiRoomViewModel.ForceLeaveRoom();
				Toast.ShowInfo("不在开放时间内！");
			}
			if (_leftActivityTime != -1 && _leftActivityTime <= 0)
			{
				if (multiRoomViewModel != null && multiRoomViewModel.CopyData != null && !multiRoomViewModel.IsCloseView && multiRoomViewModel.CopyData.ActivityTypeId == _activityTypeId)
				{
					multiRoomViewModel.ForceLeaveRoom();
				}
				Toast.ShowInfo("活动已结束！");
			}
		}
		catch (Exception ex)
		{
			Log.Error("关闭界面发生异常" + ex.Message + " / " + ex.StackTrace);
		}
	}

	public override ActivityTaskData OnTaskRateNotify(ActivityTaskRateNotify rateNotify)
	{
		ActivityTaskData activityTaskData = base.OnTaskRateNotify(rateNotify);
		if (activityTaskData != null)
		{
			if (activityTaskData.Id == activityChallengeConfig.ActivityTaskId)
			{
				CurBeatCount = (int)activityTaskData.CompleteValue;
				MaxBeatCount = activityTaskData.TargetValue;
				canReward = activityTaskData.CompleteState == 1 && activityTaskData.RewardState == 0;
				IsReward = activityTaskData.CompleteState == 1 && activityTaskData.RewardState != 0;
			}
			else
			{
				for (int i = 0; i < listItems.Count; i++)
				{
					if (listItems[i].TaskId == activityTaskData.Id && activityTaskData.CompleteState == 1)
					{
						listItems[i].Data.CopyAccess((int)activityTaskData.CompleteValue);
						if (curSelectViewModel != null)
						{
							detailViewModel.RefreshData(SelectItemViewModel.Data, 0);
							IsFirst = !curSelectViewModel.Data.IsAccessed && curSelectViewModel.Data.IsNeedFirst;
						}
						break;
					}
				}
			}
		}
		UpdateRed();
		return activityTaskData;
	}

	public override bool UpdateRed(bool notifyParent = true)
	{
		OnChallengeRed();
		return base.UpdateRed(notifyParent);
	}

	protected virtual void OnChallengeRed()
	{
		base.Red = canReward;
	}

	public void SetOpenTag()
	{
		openTag = 1;
	}

	public void ResetOpenTag()
	{
		openTag = 0;
	}

	public void CloseWindow()
	{
		if (openTag == 1)
		{
			dismissRequest.Raise();
			openTag = 0;
		}
		else
		{
			Close();
		}
	}
}
