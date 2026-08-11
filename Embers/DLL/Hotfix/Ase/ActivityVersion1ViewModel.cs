#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class ActivityVersion1ViewModel : ActivityViewModelBase
{
	private SimpleCommand<string> optCmd;

	private InteractionRequest<string> optRequest;

	private List<ReceiveItemViewModel> rewardItemViewModels;

	private LockTipsData rankLockVM;

	private LockTipsData levelLockVM;

	public string activityDesc = "";

	public int curCount;

	public int maxCount;

	public int acumCount;

	public bool isOpenPanel1;

	public bool isOpenPanel2;

	private Dictionary<int, ActivityVersionPointItemViewModel> pointVMs;

	private ActivityVersionPointItemViewModel curSelect;

	private InteractionRequest<OpenViewArgTemp> openWindowRequest2;

	private bool storeRed;

	private bool goToRed;

	private bool taskRed;

	private bool achiRed;

	private bool showLimitedContent = true;

	private ActivityVersionStoryViewModel storyVM;

	private CopyItemDetail1ViewModel copyVM;

	private ActivityPointsViewModel activityPointsViewModel;

	private ISubscription<ShopMessage> subscription_Shop;

	private ISubscription<OpActivityMessage> subscription_OpActivity;

	private bool isEntering;

	private int openTag;

	public OptionArg initParam;

	private List<VersionMoneyViewModel> propItems = new List<VersionMoneyViewModel>();

	protected string _activityTimeText2 = "";

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

	public ICommand OptCmd => optCmd;

	public IInteractionRequest OptRequest => optRequest;

	public IInteractionRequest OpenWindowRequest2 => openWindowRequest2;

	public int AcumCount
	{
		get
		{
			return acumCount;
		}
		private set
		{
			Set(ref acumCount, value, "AcumCount");
		}
	}

	public int MaxCount
	{
		get
		{
			return maxCount;
		}
		private set
		{
			Set(ref maxCount, value, "MaxCount");
		}
	}

	public int CurCount
	{
		get
		{
			return curCount;
		}
		private set
		{
			Set(ref curCount, value, "CurCount");
		}
	}

	public bool TaskRed
	{
		get
		{
			return taskRed;
		}
		private set
		{
			Set(ref taskRed, value, "TaskRed");
		}
	}

	public bool StoreRed
	{
		get
		{
			return storeRed;
		}
		private set
		{
			Set(ref storeRed, value, "StoreRed");
		}
	}

	public bool GoToRed
	{
		get
		{
			return goToRed;
		}
		private set
		{
			Set(ref goToRed, value, "GoToRed");
		}
	}

	public bool AchiRed
	{
		get
		{
			return achiRed;
		}
		private set
		{
			Set(ref achiRed, value, "AchiRed");
		}
	}

	public bool ShowLimitedContent
	{
		get
		{
			return showLimitedContent;
		}
		private set
		{
			Set(ref showLimitedContent, value, "ShowLimitedContent");
		}
	}

	public string ActivityDesc
	{
		get
		{
			return activityDesc;
		}
		private set
		{
			Set(ref activityDesc, value, "ActivityDesc");
		}
	}

	public LockTipsData RankLockVm => rankLockVM;

	public LockTipsData LevelLockVm => levelLockVM;

	public ActivityVersionPointItemViewModel CurSelect => curSelect;

	public List<ReceiveItemViewModel> RewardItemViewModels => rewardItemViewModels;

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is OptionArg optionArg)
		{
			if (optionArg.OptionName.Equals("OnClickPoint"))
			{
				SettlePoint((ActivityVersionPointItemViewModel)optionArg.Obj);
			}
			else if ("OpenPanel2".Equals(optionArg.OptionName))
			{
				OpenVersionWindowPanel2();
			}
			else if (optionArg.Obj is ActivityTaskItemData activityTaskItemData)
			{
				string optionName = optionArg.OptionName;
				if (!(optionName == "Jump"))
				{
					if (optionName == "Accept")
					{
						SendTaskAccept(activityTaskItemData);
					}
				}
				else
				{
					JumpWindow(activityTaskItemData);
				}
				TaskRed = activityPointsViewModel.CheckRedPoint();
			}
		}
		else if (obj is string text)
		{
			if ("CloseStoryView".Equals(text))
			{
				CloseStoryView(text);
			}
			if ("ShowTimeline".Equals(text))
			{
				ShowTimeline();
			}
			if ("OpenSingle".Equals(text))
			{
				OpenSingle();
			}
		}
		else if (openTag != 0 && obj is ReceiveItemViewModel receiveItemViewModel)
		{
			OpenViewArg openViewArg = receiveItemViewModel.OpenPopupWindow(this);
			if (openViewArg != null)
			{
				openWindowRequest.Raise(openViewArg);
			}
		}
		else if (openTag == 0 && obj is ReceiveItemViewModel)
		{
			parent?.ItemOnClick(obj);
		}
		else if (obj is BattleReadyViewModel battleReadyViewModel)
		{
			if (battleReadyViewModel.ReadyType == BattleReadyType.Ready)
			{
				isEntering = true;
				EnterBattle(battleReadyViewModel);
			}
		}
		else if (obj is KnapsackItemViewModel knapsackItemViewModel)
		{
			OpenViewArg openViewArg2 = knapsackItemViewModel.OpenPopupWindow(this);
			if (openViewArg2 != null)
			{
				openWindowRequest.Raise(openViewArg2);
			}
		}
		else
		{
			OpenViewArgTemp arg = obj as OpenViewArgTemp;
			if (arg != null)
			{
				openWindowRequest2.Raise(arg, delegate
				{
					arg.CallBack?.Invoke();
				});
			}
			else
			{
				parent?.ItemOnClick(obj);
			}
		}
		UpdateRed();
	}

	public void LightResetOnViewInit()
	{
		RefreshLimitedContentState();
		if (optCmd != null)
		{
			optCmd.Enabled = true;
		}
		isEntering = false;
		if (openTag != 1 && initParam == null)
		{
			openTag = 0;
			isOpenPanel1 = true;
			isOpenPanel2 = false;
		}
	}

	public override void SetServiceTaskData(List<ActivityTaskData> taskDataList)
	{
		base.SetServiceTaskData(taskDataList);
		RefreshLimitedContentState();
		openWindowRequest2 = new InteractionRequest<OpenViewArgTemp>();
		optCmd = new SimpleCommand<string>(OnOpt);
		optRequest = new InteractionRequest<string>();
		ActivityDesc = _drActivityType.Desc.Replace("\\n", "\n");
		rewardItemViewModels = PropHelper.GetActivityCopyDrop(this, _drActivityType.RewardId);
		pointVMs = new Dictionary<int, ActivityVersionPointItemViewModel>();
		List<ActivityVersionData> list = new List<ActivityVersionData>();
		DRVersionActivity[] dataRows = GameEntry.DataTable.GetDataRows((DRVersionActivity p) => p.ActivityId == base.ActivityTypeId);
		List<ActivityVersionData> versionActivityDataList = Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetActivityVm().GetVersionActivityDataList(base.ActivityTypeId);
		for (int num = 0; num < dataRows.Length; num++)
		{
			ActivityVersionData activityVersionData = null;
			if (versionActivityDataList != null)
			{
				for (int num2 = 0; num2 < versionActivityDataList.Count; num2++)
				{
					if (versionActivityDataList[num2].DrVersionActivity.Id == dataRows[num].Id)
					{
						activityVersionData = versionActivityDataList[num2];
						break;
					}
				}
			}
			if (activityVersionData == null)
			{
				activityVersionData = ActivityVersionData.Create(dataRows[num]);
			}
			list.Add(activityVersionData);
			pointVMs.Add(list[num].DrVersionActivity.Id, new ActivityVersionPointItemViewModel(this, list[num]));
		}
		CopyViewModel copyViewModel = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM();
		copyViewModel.LoadActivityVersionCopys(base.ActivityTypeId);
		for (int num3 = 0; num3 < list.Count; num3++)
		{
			if (list[num3].Type == 2)
			{
				CopyData copyById = copyViewModel.GetCopyById(list[num3].DrVersionActivity.Content);
				if (copyById != null)
				{
					list[num3].SetCopyMaxStar(copyById.StarConfigMax);
				}
			}
		}
		Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetActivityVm().SetActivityVersionData(base.ActivityTypeId, list);
		Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetActivityVm().AddKnapsackChange(base.ActivityTypeId);
		InitActivityPoints();
		subscription_Shop = Singleton<ServiceSystem>.Instance.GetService<IShopService>().GetMessager().Subscribe<ShopMessage>(OnShopMsg);
		subscription_OpActivity = Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetMessager().Subscribe<OpActivityMessage>(OnOpActivityNotify);
		InitActivityPointsRed();
	}

	public override void OnKnapsackChange(PropChangeMessage message)
	{
		base.OnKnapsackChange(message);
		for (int i = 0; i < propItems.Count; i++)
		{
			KnapsackPropData prop = Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().GetKnapsackViewModel().GetProp(propItems[i].PropId);
			if (prop != null)
			{
				propItems[i].SetCount(prop.Amount);
			}
			else
			{
				propItems[i].SetCount(0);
			}
			propItems[i].SetAcum(Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetActivityVm().GetAcumCount(propItems[i].PropId));
		}
		Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetActivityVm().UpdateActivityVersionProgress(base.ActivityTypeId, -1, -1);
	}

	private async void OnOpt(string optName)
	{
		optCmd.Enabled = false;
		try
		{
			if (!IsActivityOpen())
			{
				Toast.ShowInfo("活动已结束！");
				optCmd.Enabled = true;
			}
			else if ("OpenAchieve".Equals(optName))
			{
				AchievementMedalViewModel userData = new AchievementMedalViewModel(this, 6);
				openWindowRequest.Raise(new OpenViewArg(typeof(AchievementMedalWindow), userData), delegate
				{
					optCmd.Enabled = true;
				});
			}
			else if ("OpenVersionMain".Equals(optName))
			{
				if (openTag == 1)
				{
					optCmd.Enabled = true;
					return;
				}
				optCmd.Enabled = true;
				OpenVersionWindow();
			}
			else if ("OpenShop".Equals(optName))
			{
				if (ShouldHideLimitedContent())
				{
					optCmd.Enabled = true;
					return;
				}
				ActivityVersionRewardViewModel rewardVM = new ActivityVersionRewardViewModel(this, _activityTypeId, base.PbTaskDataList, propItems);
				await rewardVM.RequestData();
				if (openTag == 1)
				{
					openWindowRequest2.Raise(new OpenViewArgTemp(typeof(ActivityVersionRewardWindow), ActivityVersionConfig.GetConfigRewardPath(_activityTypeId), rewardVM), delegate
					{
						optCmd.Enabled = true;
						UpdateRed();
					});
					return;
				}
				if (parent == null)
				{
					Log.Error($"打开版本活动商店失败：parent为空，activityTypeId={_activityTypeId}");
					optCmd.Enabled = true;
					return;
				}
				OpenViewArgTemp obj = new OpenViewArgTemp(typeof(ActivityVersionRewardWindow), ActivityVersionConfig.GetConfigRewardPath(_activityTypeId), rewardVM, delegate
				{
					optCmd.Enabled = true;
					UpdateRed();
				});
				parent.ItemOnClick(obj);
			}
			else if ("OpenScoreTask".Equals(optName))
			{
				OpenActivityPointsWindow();
			}
			else if ("OpenPanel1".Equals(optName))
			{
				optCmd.Enabled = true;
				isOpenPanel1 = true;
				isOpenPanel2 = false;
				optRequest.Raise(optName);
			}
			else if ("OpenPanel2".Equals(optName))
			{
				optCmd.Enabled = true;
				isOpenPanel1 = false;
				isOpenPanel2 = true;
				if (curSelect != null)
				{
					curSelect.SetSelect(isSelect: false);
				}
				optRequest.Raise(optName);
			}
			else if ("OnCancel".Equals(optName))
			{
				optCmd.Enabled = true;
				if (curSelect != null)
				{
					curSelect.SetSelect(isSelect: false);
				}
				optRequest.Raise(optName);
			}
		}
		catch (Exception ex)
		{
			Log.Error(ex.Message + " /" + ex.StackTrace);
			optCmd.Enabled = true;
		}
	}

	private bool IsActivityOpen()
	{
		if (Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetActivityVm().GetActivityViewModel(_activityTypeId) == null)
		{
			return false;
		}
		return true;
	}

	private void SettlePoint(ActivityVersionPointItemViewModel point)
	{
		if (!optCmd.Enabled)
		{
			return;
		}
		optCmd.Enabled = false;
		if (point.Data.IsLock)
		{
			point.Data.OnClickLockItem();
			optCmd.Enabled = true;
			return;
		}
		if (point.Data.IsNew)
		{
			point.Data.SetRed(value: false);
			Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetActivityVm().UpdateVersionRed(_activityTypeId, point.Data.DrVersionActivity.Id, red: false);
			UpdateRed();
		}
		if (curSelect != null && curSelect != point)
		{
			curSelect.SetSelect(isSelect: false);
		}
		curSelect = point;
		curSelect.SetSelect(isSelect: true);
		if (point.Data.Type == 1)
		{
			optRequest.Raise("ShowStoryView");
		}
		if (point.Data.Type == 2 && point.GetCopyData() != null)
		{
			optRequest.Raise("ShowCopyDetailView");
		}
		optCmd.Enabled = true;
	}

	private void CloseStoryView(string s)
	{
		if (curSelect != null)
		{
			curSelect.SetSelect(isSelect: false);
		}
		optRequest.Raise(s);
	}

	private void OpenSingle()
	{
		if (!optCmd.Enabled)
		{
			return;
		}
		CopyData copyData = curSelect.GetCopyData();
		if (CopyEntryLimitHelper.TryBlockEntry(copyData, isMulti: false))
		{
			return;
		}
		optCmd.Enabled = false;
		try
		{
			BattleReadyViewModel userData = new BattleReadyViewModel(this, BattleReadyData.CreateByHeroTry(BattleReadyTarget.ActivityHeroTry, copyData.Id, copyData.TeamSeatId));
			openWindowRequest.Raise(new OpenViewArg(typeof(BattleReadyWindow), userData), delegate
			{
				optCmd.Enabled = true;
			});
		}
		catch (Exception ex)
		{
			Toast.ShowInfo("打开组队界面失败！请重试！");
			Log.Error("打开组队界面失败!" + ex.Message + " / " + ex.StackTrace);
			optCmd.Enabled = true;
		}
	}

	public void OpenSingle(CopyData copyData)
	{
		if (!optCmd.Enabled || CopyEntryLimitHelper.TryBlockEntry(copyData, isMulti: false))
		{
			return;
		}
		optCmd.Enabled = false;
		try
		{
			BattleReadyViewModel userData = new BattleReadyViewModel(this, BattleReadyData.CreateByHeroTry(BattleReadyTarget.ActivityHeroTry, copyData.Id, copyData.TeamSeatId));
			openWindowRequest.Raise(new OpenViewArg(typeof(BattleReadyWindow), userData), delegate
			{
				optCmd.Enabled = true;
			});
		}
		catch (Exception ex)
		{
			Toast.ShowInfo("打开组队界面失败！请重试！");
			Log.Error("打开组队界面失败!" + ex.Message + " / " + ex.StackTrace);
			optCmd.Enabled = true;
		}
	}

	private async void ShowTimeline()
	{
		_ = 1;
		try
		{
			if (await Singleton<Story>.Instance.PlayStory(0u, curSelect.Data.DrVersionActivity.Content) && !curSelect.Data.IsComplete)
			{
				ActivityReward activityReward = await Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetActivtiyVersionReward(curSelect.Data.DrVersionActivity.ActivityId, curSelect.Data.DrVersionActivity.Id);
				if (activityReward.Result)
				{
					openWindowRequest.Raise(new OpenViewArg(typeof(PropGetWindow), new PropGetViewModel(this, activityReward.Rewards)));
					storyVM.SetGot();
					CloseStoryView("CloseStoryView");
				}
				else if (!activityReward.Result && activityReward.ErrorCode == 200159)
				{
					storyVM.SetGot();
					CloseStoryView("CloseStoryView");
				}
			}
		}
		catch (Exception)
		{
		}
		storyVM.EnableOpt();
	}

	public ActivityVersionStoryViewModel GetStoryVM()
	{
		if (storyVM == null)
		{
			storyVM = new ActivityVersionStoryViewModel(this, curSelect.Data);
		}
		else
		{
			storyVM.SetData(curSelect.Data);
		}
		return storyVM;
	}

	public CopyItemDetail1ViewModel GetCopyDetailVM()
	{
		if (copyVM == null)
		{
			copyVM = new CopyItemDetail1ViewModel(this);
		}
		copyVM.RefreshData(curSelect.GetCopyData(), 0);
		return copyVM;
	}

	public ActivityVersionPointItemViewModel GetPointVM(int vaItemId)
	{
		if (pointVMs.ContainsKey(vaItemId))
		{
			return pointVMs[vaItemId];
		}
		return null;
	}

	public override ActivityTaskData OnTaskRateNotify(ActivityTaskRateNotify rateNotify)
	{
		ActivityTaskData result = base.OnTaskRateNotify(rateNotify);
		ActivityPointsViewModel obj = activityPointsViewModel;
		if (obj != null)
		{
			obj.UpdateTask(rateNotify.Id);
			return result;
		}
		return result;
	}

	public override bool UpdateRed(bool notifyParent = true)
	{
		try
		{
			RefreshLimitedContentState();
			bool flag = false;
			bool flag2 = false;
			bool flag3 = false;
			bool flag4 = false;
			if (!ShouldHideLimitedContent())
			{
				DRActivityRank[] dataRows = GameEntry.DataTable.GetDataRows((DRActivityRank p) => p.ActivityTypeId == _activityTypeId);
				int subActivityId = ((dataRows.Length > 1) ? dataRows[1].Id : 0);
				DRActivityRankTask[] dataRows2 = GameEntry.DataTable.GetDataTable<DRActivityRankTask>().GetDataRows((DRActivityRankTask p) => p.ActivityTypeId == _activityTypeId && p.ActivityRankId == subActivityId);
				if (dataRows2 != null && dataRows2.Length != 0)
				{
					DRActivityRankTask[] array = dataRows2;
					foreach (DRActivityRankTask activityRankTask in array)
					{
						ActivityTaskData activityTaskData = _pbTaskDataList?.Find((ActivityTaskData p) => p.Id == activityRankTask.Id);
						if (activityTaskData != null && activityTaskData.CompleteState == 1 && activityTaskData.RewardState == 0)
						{
							flag4 = true;
							break;
						}
					}
				}
				flag2 = flag4 || Singleton<ServiceSystem>.Instance.GetService<IRedPointService>().GetShopRedByShopPosition(ShopGoodItemData.ShopPosition.ActivityShop);
			}
			flag = activityPointsViewModel.CheckRedPoint();
			AchiRed = Singleton<ServiceSystem>.Instance.GetService<IAchievementService>().CheckByAchiTypeRedPoint(6);
			foreach (KeyValuePair<int, ActivityVersionPointItemViewModel> pointVM in pointVMs)
			{
				if (pointVM.Value.Data.IsNew)
				{
					flag3 = true;
					break;
				}
			}
			TaskRed = flag;
			StoreRed = flag2;
			GoToRed = flag3;
			base.Red = flag3 | flag | flag2;
			return base.UpdateRed(notifyParent);
		}
		catch (Exception)
		{
		}
		base.Red = false;
		return false;
	}

	public void InitAchiRedPoint()
	{
		AchiRed = Singleton<ServiceSystem>.Instance.GetService<IAchievementService>().CheckByAchiTypeRedPoint(6);
	}

	private void OnShopMsg(ShopMessage msg)
	{
		UpdateRed();
	}

	private void OnOpActivityNotify(OpActivityMessage msg)
	{
		if (isEntering)
		{
			return;
		}
		try
		{
			if (msg.Type == OpActivityMessageEnum.ActivityTabTypeChange)
			{
				if (ContainsActivityType(msg.Arg))
				{
					HandleLimitedContentTypeChanged();
				}
			}
			else if (openTag == 1 && (msg.Type == OpActivityMessageEnum.ActivityClose || msg.Type == OpActivityMessageEnum.ActivityOff) && (int)msg.Arg == _activityTypeId && Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetActivityVm().GetActivityViewModel(_activityTypeId) == null)
			{
				AlertDialog.Show("提示", "活动已结束！", null, null, "确定").Callbackable().OnCallback(delegate
				{
					CloseWindowActivityEnd();
				});
			}
		}
		catch (Exception ex)
		{
			Log.Error("处理活动结束发生异常 " + ex.Message + " / " + ex.StackTrace);
		}
	}

	private void HandleLimitedContentTypeChanged()
	{
		RefreshLimitedContentState();
		UpdateRed();
	}

	private bool ContainsActivityType(object arg)
	{
		if (arg is List<int> list)
		{
			return list.Contains(_activityTypeId);
		}
		return false;
	}

	public void RefreshLimitedContentState()
	{
		ShowLimitedContent = !ShouldHideLimitedContent();
	}

	public bool ShouldHideLimitedContent()
	{
		return base.CurType == 2;
	}

	public void CloseWindow()
	{
		if (openTag == 1)
		{
			if (isOpenPanel1)
			{
				dismissRequest.Raise();
				OnMainWindowClosed();
			}
			else if (isOpenPanel2)
			{
				OnOpt("OpenPanel1");
			}
		}
		else
		{
			Close();
		}
	}

	public void CloseWindowActivityEnd()
	{
		if (openTag == 1)
		{
			dismissRequest.Raise();
			OnMainWindowClosed();
		}
	}

	public void SetOpenTag()
	{
		openTag = 1;
		isOpenPanel1 = true;
		isOpenPanel2 = false;
	}

	public void SyncPanelState(bool isPanel1)
	{
		isOpenPanel1 = isPanel1;
		isOpenPanel2 = !isPanel1;
	}

	public void OnMainWindowClosed()
	{
		openTag = 0;
		isOpenPanel1 = true;
		isOpenPanel2 = false;
		isEntering = false;
		if (optCmd != null)
		{
			optCmd.Enabled = true;
		}
	}

	public void SetInitPanel2(CopyData copyData = null)
	{
		initParam = new OptionArg(copyData, "OpenPanel2");
	}

	public void SetPanel2(CopyData copyData)
	{
		openTag = 1;
		SetInitPanel2(copyData);
		OnOpt("OpenPanel2");
	}

	private void OpenVersionWindow()
	{
		SetOpenTag();
		OpenViewArgTemp openViewArg = new OpenViewArgTemp(typeof(ActivityVersion1Window), ActivityVersionConfig.GetConfigWindowPath(_activityTypeId), this, delegate
		{
			OnMainWindowClosed();
		});
		if (parent != null)
		{
			parent.ItemOnClick(openViewArg);
			return;
		}
		openWindowRequest2.Raise(openViewArg, delegate
		{
			openViewArg.CallBack?.Invoke();
		});
	}

	private void OpenVersionWindowPanel2(CopyData copyData = null)
	{
		if (openTag == 1)
		{
			initParam = ((copyData == null) ? null : new OptionArg(copyData, "OpenPanel2"));
			OnOpt("OpenPanel2");
		}
		else
		{
			SetInitPanel2(copyData);
			OpenVersionWindow();
		}
	}

	public VersionMoneyViewModel AddProp(int id)
	{
		try
		{
			for (int i = 0; i < propItems.Count; i++)
			{
				if (propItems[i].PropId == id)
				{
					return propItems[i];
				}
			}
			DRVersionMoney dataRow = GameEntry.DataTable.GetDataRow((DRVersionMoney p) => p.PropId == id);
			if (dataRow == null)
			{
				return null;
			}
			VersionMoneyViewModel versionMoneyViewModel = new VersionMoneyViewModel(dataRow);
			propItems.Add(versionMoneyViewModel);
			return versionMoneyViewModel;
		}
		catch (Exception)
		{
		}
		return null;
	}

	public void CreateRankLock()
	{
		if (levelLockVM == null)
		{
			levelLockVM = new LockTipsData();
		}
		if (rankLockVM == null)
		{
			rankLockVM = new LockTipsData();
		}
		List<ActivityVersionLockData> versionLockActivityDataList = Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetActivityVm().GetVersionLockActivityDataList(base.ActivityTypeId);
		int num = 0;
		if (versionLockActivityDataList != null && versionLockActivityDataList.Count > 0)
		{
			for (int i = 0; i < versionLockActivityDataList.Count; i++)
			{
				if (versionLockActivityDataList[i].IsLock)
				{
					if (!versionLockActivityDataList[num].IsLock)
					{
						num = i;
					}
					else if (num != i && versionLockActivityDataList[num].DrVersionLock.Rank > versionLockActivityDataList[i].DrVersionLock.Rank)
					{
						num = i;
					}
				}
			}
			rankLockVM.SetData(versionLockActivityDataList[num]);
		}
		num = 0;
		List<ActivityVersionData> versionActivityDataList = Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetActivityVm().GetVersionActivityDataList(base.ActivityTypeId);
		for (int j = 0; j < versionActivityDataList.Count; j++)
		{
			if (versionActivityDataList[j].IsLevelLock())
			{
				if (!versionActivityDataList[num].IsLevelLock())
				{
					num = j;
				}
				else if (num != j && versionActivityDataList[num].DrVersionActivity.RankSecond > versionActivityDataList[j].DrVersionActivity.RankSecond)
				{
					num = j;
				}
			}
		}
		levelLockVM.SetData(versionActivityDataList[num]);
	}

	public void CreateRankLockTime()
	{
		if (rankLockVM == null)
		{
			rankLockVM = new LockTipsData();
		}
		List<ActivityVersionLockData> versionLockActivityDataList = Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetActivityVm().GetVersionLockActivityDataList(base.ActivityTypeId);
		int num = 0;
		if (versionLockActivityDataList == null || versionLockActivityDataList.Count <= 0)
		{
			return;
		}
		for (int i = 0; i < versionLockActivityDataList.Count; i++)
		{
			if (versionLockActivityDataList[i].IsLock)
			{
				if (!versionLockActivityDataList[num].IsLock)
				{
					num = i;
				}
				else if (num != i && versionLockActivityDataList[num].DrVersionLock.Rank > versionLockActivityDataList[i].DrVersionLock.Rank)
				{
					num = i;
				}
			}
		}
		rankLockVM.SetData(versionLockActivityDataList[num]);
	}

	public ContentConfig GetRankLockRank()
	{
		ContentConfig contentConfig = new ContentConfig();
		contentConfig.lockId = -1;
		contentConfig.rank = -1;
		if (rankLockVM != null && rankLockVM.LockType != -1)
		{
			contentConfig.lockId = rankLockVM.LockId;
			contentConfig.rank = rankLockVM.Rank;
		}
		return contentConfig;
	}

	public void OnCheckRankLock()
	{
		CreateRankLock();
		optRequest.Raise("CheckRankLock");
	}

	public void OnCheckTimeRankLock()
	{
		CreateRankLockTime();
		optRequest.Raise("CheckRankLock");
	}

	private async void EnterBattle(BattleReadyViewModel battleReadyViewModel)
	{
		optCmd.Enabled = false;
		battleReadyViewModel.SetStartBattleResult(await EnterBattleWorldVersion(battleReadyViewModel));
		optCmd.Enabled = true;
	}

	private async Task<bool> EnterBattleWorldVersion(BattleReadyViewModel readyVm)
	{
		_ = 4;
		try
		{
			CopyData copyData = curSelect.GetCopyData();
			if (copyData == null)
			{
				return false;
			}
			CopyEnterInfoData copyEnterInfoData = await Singleton<ServiceSystem>.Instance.GetService<ICopyService>().EnterBattleWorld(copyData, new List<int> { 1104 }, readyVm.TeamData(), 1, readyVm.ReadyData.CopyDropType, null);
			if (copyEnterInfoData != null)
			{
				bool flag = GameEntry.DataTable.GetDataRow<DRTeamSet>(readyVm.ReadyData.TeamSetId)?.IsBattleProp ?? true;
				List<PeripheryHeroData> list = new List<PeripheryHeroData>();
				foreach (TeamMember teamMember in copyEnterInfoData.TeamMembers)
				{
					if (copyData.HasFirstBuff())
					{
						teamMember.HeroModel.AddOuterBuff(OuterBuffEnum.CopyFirstAccessBuff, copyData.CopyEnvironId);
					}
					PeripheryHeroData peripheryHeroData = teamMember.GetPeripheryHeroData();
					if (!flag)
					{
						peripheryHeroData.ClearBattleProps();
					}
					list.Add(peripheryHeroData);
				}
				List<AchievementMedal> battleAchievementMedals = Singleton<ServiceSystem>.Instance.GetService<IAchievementService>().GetBattleAchievementMedals(copyData.CopyType == 99000 || copyData.CopyType == 99100);
				WorldData worldData = ActivityBattleWorldData.Create(copyData.Id, 0u, list, null, copyEnterInfoData.SeedID, copyEnterInfoData.RoomId, 0L, 0, Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().Uid, 0, "", 0, 0u, battleAchievementMedals, copyData.Id);
				LoadingActivitiyBattleViewModel loadingSingleViewModel = new LoadingActivitiyBattleViewModel("Outer/Outer", worldData, autoUnload: true);
				Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().SetSceneLoadPath(worldData.SceneLoadPath);
				DRLoadingTips randomLoadingTap = await Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().PrepareLoading(GameProcessType.Battle);
				loadingSingleViewModel.SetRandomLoadingTap(randomLoadingTap);
				await GameEntry.UI.OpenWindow<LoadingWindow>("Loading/LoadingWindow", "LOADING", loadingSingleViewModel);
				await UniTask.WaitUntil(() => loadingSingleViewModel.IsLoadingFinish);
				if (loadingSingleViewModel.LoadingSuccess)
				{
					readyVm.Close();
					UIWindowHelper.WindowRelease();
					await loadingSingleViewModel.CloseLoading();
					Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().LoadingEnd(loadingSingleViewModel.LoadingSuccess);
					Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().SetIsSingleBattle(value: true);
					Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().AddEnterCopyTDA(copyEnterInfoData);
					return true;
				}
			}
		}
		catch (Exception)
		{
		}
		isEntering = false;
		return false;
	}

	private void InitActivityPoints()
	{
		DRActivityRank[] dataRows = GameEntry.DataTable.GetDataRows((DRActivityRank p) => p.ActivityTypeId == base.ActivityTypeId);
		int subActivityTypeId = ((dataRows.Length != 0) ? dataRows[0].Id : 0);
		activityPointsViewModel = new ActivityPointsViewModel(this, _pbTaskDataList, base.ActivityTypeId, subActivityTypeId);
		activityPointsViewModel.OpenSliderViewModel();
	}

	private async void OpenActivityPointsWindow()
	{
		optCmd.Enabled = true;
		activityPointsViewModel.SetParent(this);
		Loading loading = await Loading.Show();
		await activityPointsViewModel.RefreshRewardSlider();
		openWindowRequest2.Raise(new OpenViewArgTemp(typeof(ActivityPointsWindow), ActivityVersionConfig.GetConfigActivityPointsPath(_activityTypeId), activityPointsViewModel), delegate
		{
			optCmd.Enabled = true;
			UpdateRed();
		});
		loading.Dispose();
	}

	private async void InitActivityPointsRed()
	{
		await activityPointsViewModel.RefreshRewardSlider();
		UpdateRed();
	}

	private async void JumpWindow(ActivityTaskItemData activityTaskItemData)
	{
		if (ActivityVersionConfig.IsActivityVersionWindow(activityTaskItemData.JumpWindow))
		{
			activityPointsViewModel?.Close();
			OpenVersionWindowPanel2();
			activityTaskItemData.ResetCmd();
			return;
		}
		Loading loading = await Loading.Show();
		OpenViewArg openViewArg = await new UIJumpHelper().CreateViewJumpData(new JumpWindowParams(activityTaskItemData.JumpWindow, activityTaskItemData.JumpFlagValueList), this, "ActivityVersion1");
		loading.Dispose();
		if (openViewArg != null)
		{
			parent?.ItemOnClick(openViewArg);
			await activityPointsViewModel.RefreshRewardSlider();
		}
		activityTaskItemData.ResetCmd();
	}

	private async void SendTaskAccept(ActivityTaskItemData activityTaskItemData)
	{
		ActivityReward activityReward = await Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetTaskReward(base.ActivityTypeId, 0, activityTaskItemData.TaskRankId);
		foreach (ActivityTaskItemData activityTaskItemData2 in activityPointsViewModel.ActivityTaskItemDataList)
		{
			if (activityTaskItemData2.TaskState == ActivityTaskStateEnum.Accept)
			{
				activityTaskItemData2.ResetCmd();
			}
		}
		await activityPointsViewModel.RefreshRewardSlider();
		if (!activityReward.Result)
		{
			if (activityReward.ErrorCode != 200159)
			{
				return;
			}
			foreach (ActivityTaskItemData activityTaskItemData3 in activityPointsViewModel.ActivityTaskItemDataList)
			{
				if (activityTaskItemData3.TaskState == ActivityTaskStateEnum.Accept)
				{
					activityTaskItemData3.SetFinishState();
				}
			}
			activityPointsViewModel.Sort();
			return;
		}
		foreach (ActivityTaskItemData activityTaskItemData4 in activityPointsViewModel.ActivityTaskItemDataList)
		{
			if (activityTaskItemData4.TaskState == ActivityTaskStateEnum.Accept)
			{
				activityTaskItemData4.SetFinishState();
			}
		}
		activityPointsViewModel.Sort();
		PropGetViewModel propGetViewModel = new PropGetViewModel(parent, activityReward.Rewards);
		propGetViewModel.MergeProp();
		openWindowRequest.Raise(new OpenViewArg(typeof(PropGetWindow), propGetViewModel));
	}

	public void CheckTime()
	{
		RefreshActivityTime();
	}

	public override void RefreshActivityTime(bool getLeftTime = true)
	{
		if (_activityTypeId == 10)
		{
			base.RefreshActivityTime();
			return;
		}
		_leftActivityTime = OpActivityDefinition.GetActivityTime(base.DrActivityType);
		string activityTimeText = OpActivityDefinition.GetActivityTimeText(_leftActivityTime);
		base.ActivityTimeText = (string.IsNullOrEmpty(activityTimeText) ? activityTimeText : ("剩余时间：" + activityTimeText));
		ActivityTimeText2 = activityTimeText;
	}
}
