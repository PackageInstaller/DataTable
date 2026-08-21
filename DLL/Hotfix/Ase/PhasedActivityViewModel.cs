#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class PhasedActivityViewModel : ActivityViewModelBase
{
	private List<ActivityTabItemData2> phasedItemList;

	private List<ActivityTaskItemData> totalActivityTaskItemDataList;

	private List<ActivityTaskItemData> showActivityTaskItemDataList;

	private ActivityTabItemData2 curTab;

	private ActivityRewardSliderViewModel activityRewardSliderViewModel;

	private int subActivityId;

	private InteractionRequest refreshActivityTaskRequest;

	protected virtual bool useUpdateRedPoint => true;

	public List<ActivityTabItemData2> PhasedItemList => phasedItemList;

	public List<ActivityTaskItemData> ShowActivityTaskItemDataList => showActivityTaskItemDataList;

	public InteractionRequest RefreshActivityTaskRequest => refreshActivityTaskRequest;

	public ActivityRewardSliderViewModel ActivityRewardSliderViewModel => activityRewardSliderViewModel;

	public override void SetServiceTaskData(List<ActivityTaskData> taskDataList)
	{
		base.SetServiceTaskData(taskDataList);
		phasedItemList = new List<ActivityTabItemData2>();
		totalActivityTaskItemDataList = new List<ActivityTaskItemData>();
		showActivityTaskItemDataList = new List<ActivityTaskItemData>();
		refreshActivityTaskRequest = new InteractionRequest();
		activityRewardSliderViewModel = new ActivityRewardSliderViewModel(this);
		InitTab();
		InitTaskList();
		Singleton<ServiceSystem>.Instance.GetService<ITimeService>().AddDailyUpdateAction(CheckRedPoint);
		MoveToPhased();
	}

	public int MoveToPhased()
	{
		int num = 0;
		if (phasedItemList.Count > 0)
		{
			for (int i = 0; i < PhasedItemList.Count; i++)
			{
				if (PhasedItemList[i].StateEnum == ActivityTabStateEnum.Normal || PhasedItemList[i].StateEnum == ActivityTabStateEnum.RedPoint)
				{
					num = i;
					break;
				}
				if (PhasedItemList[i].StateEnum == ActivityTabStateEnum.Lock)
				{
					break;
				}
				num = i;
			}
			TabOnClick(phasedItemList[num]);
		}
		return num;
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is OptionArg optionArg)
		{
			if (optionArg.Obj is ActivityTabItemData2 activityTabItemData)
			{
				if (activityTabItemData.StateEnum == ActivityTabStateEnum.Lock)
				{
					CheckUnLock(activityTabItemData);
					return;
				}
				TabOnClick(activityTabItemData);
				refreshActivityTaskRequest.Raise();
			}
			else
			{
				if (!(optionArg.Obj is ActivityTaskItemData activityTaskItemData))
				{
					return;
				}
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
			}
		}
		else if (obj is KnapsackItemViewModel knapsackItemViewModel)
		{
			if (!TryOpenSuitBoxPreview(knapsackItemViewModel))
			{
				OpenViewArg obj2 = knapsackItemViewModel.OpenPopupWindow(parent);
				parent?.ItemOnClick(obj2);
			}
		}
		else if (obj is string text)
		{
			if (text.Equals("RedPoint"))
			{
				UpdateRed();
			}
			else if (text.Equals("RefreshRewardSlider"))
			{
				RefreshRewardSlider();
			}
		}
		else if (obj is OpenViewArg obj3)
		{
			parent?.ItemOnClick(obj3);
		}
	}

	private bool TryOpenSuitBoxPreview(KnapsackItemViewModel knapsackItemViewModel)
	{
		if (!(knapsackItemViewModel?.PropDataBase is ArmourData { EquipmentEnum: EquipmentEnum.SuitBox } armourData))
		{
			return false;
		}
		if (HasSingleMainEntry(armourData.Id))
		{
			SuitBoxPreviewUtil.FillPreviewEntriesIfEmpty(armourData);
			RockPopupViewModel rockPopupViewModel = new RockPopupViewModel(this, armourData);
			rockPopupViewModel.LoadDefaultEntry();
			parent?.ItemOnClick(new OpenViewArg(typeof(RockPopupWindow), rockPopupViewModel));
		}
		else
		{
			RockPopupViewModel userData = new RockPopupViewModel(this, armourData);
			parent?.ItemOnClick(new OpenViewArg(typeof(RockPopupSampleWindow), userData));
		}
		return true;
	}

	private static bool HasSingleMainEntry(int suitBoxId)
	{
		DRSuitbox drSuitbox = GameEntry.DataTable.GetDataRow<DRSuitbox>(suitBoxId);
		if (drSuitbox == null)
		{
			return false;
		}
		DRSuitboxMainStore[] dataRows = GameEntry.DataTable.GetDataRows((DRSuitboxMainStore p) => p.StoreId == drSuitbox.BuffPool);
		if (dataRows != null)
		{
			return dataRows.Length == 1;
		}
		return false;
	}

	private async void InitTab()
	{
		DRActivityRank[] activityRankList = GameEntry.DataTable.GetDataTable<DRActivityRank>().GetDataRows((DRActivityRank p) => p.ActivityTypeId == base.ActivityTypeId);
		if (activityRankList.Length == 0)
		{
			Log.Error($"活动{base.ActivityTypeId}数据配置错误");
			return;
		}
		long accountCreateTime = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().AccountCreateTime;
		DateTime createDateTime = DateTimeOffset.FromUnixTimeSeconds(accountCreateTime).LocalDateTime;
		long num = Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetCurServerTime();
		if (num < accountCreateTime)
		{
			num = await Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetServiceTime();
		}
		DateTime localDateTime = DateTimeOffset.FromUnixTimeSeconds(num).LocalDateTime;
		int num2 = ((localDateTime.Year != createDateTime.Year) ? ((DateTime.IsLeapYear(createDateTime.Year) ? 366 : 365) - createDateTime.DayOfYear + localDateTime.DayOfYear) : (localDateTime.DayOfYear - createDateTime.DayOfYear));
		if (createDateTime.Hour < 4)
		{
			num2++;
		}
		if (localDateTime.Hour < 4)
		{
			num2--;
		}
		DRActivityRank[] array = activityRankList;
		foreach (DRActivityRank dRActivityRank in array)
		{
			ActivityTabItemData2 activityTabItemData = new ActivityTabItemData2(this, base.ActivityTypeId, dRActivityRank.Id, dRActivityRank.Name);
			activityTabItemData.StateEnum = ActivityTabStateEnum.Normal;
			for (int num4 = 0; num4 < dRActivityRank.UnlockType.Count; num4++)
			{
				if (dRActivityRank.UnlockType[num4] == 3)
				{
					int num5 = dRActivityRank.UnlockNum[num4] - num2;
					if (num5 <= 0)
					{
						break;
					}
					int num6 = ((localDateTime.Hour < 4) ? (num5 - 1) : num5);
					DateTime dateTime = localDateTime.AddDays(num6);
					activityTabItemData.UnLockTime = (long)(new DateTime(dateTime.Year, dateTime.Month, dateTime.Day, 4, 0, 0) - new DateTime(1970, 1, 1, 0, 0, 0).AddHours(8.0)).TotalSeconds;
				}
			}
			if (!string.IsNullOrEmpty(dRActivityRank.UnlockTime))
			{
				activityTabItemData.UnLockTime = Utility.DateTime.GetSeverRefreshTimeSpan(dRActivityRank.UnlockTime);
			}
			phasedItemList.Add(activityTabItemData);
		}
	}

	private async void InitTaskList()
	{
		DRActivityRankTask[] dataRows = GameEntry.DataTable.GetDataTable<DRActivityRankTask>().GetDataRows((DRActivityRankTask p) => p.ActivityTypeId == base.ActivityTypeId);
		if (dataRows.Length == 0)
		{
			Log.Error($"活动{base.ActivityTypeId}阶段任务数据配置错误");
			return;
		}
		DRActivityRankTask[] array = dataRows;
		foreach (DRActivityRankTask dRActivityRankTask in array)
		{
			ActivityTaskItemData activityTaskItemData = new ActivityTaskItemData(this, dRActivityRankTask.ActivityTaskId, dRActivityRankTask.Id);
			activityTaskItemData.SetTextColor(base.ActivityTypeId);
			activityTaskItemData.SetPropItem(dRActivityRankTask.RewardId);
			activityTaskItemData.SetActivityInfo(dRActivityRankTask.ActivityTypeId, dRActivityRankTask.ActivityRankId);
			activityTaskItemData.AddJumpWindow(dRActivityRankTask.TargetWindow, dRActivityRankTask.WindowParams);
			ActivityTaskData activityTaskData = _pbTaskDataList?.Find((ActivityTaskData p) => p.Id == activityTaskItemData.Uid);
			int value = (int)((activityTaskData != null) ? activityTaskData.CompleteValue : 0);
			bool canAccept = activityTaskData != null && activityTaskData.CompleteState == 1;
			bool received = activityTaskData != null && activityTaskData.RewardState == 1;
			activityTaskItemData.RefreshFinishCount(value, canAccept, received);
			activityTaskItemData.IsPhasedActivityTask = false;
			totalActivityTaskItemDataList.Add(activityTaskItemData);
		}
		await Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetTaskRankProgress(base.ActivityTypeId);
		DRActivityRank[] dataRows2 = GameEntry.DataTable.GetDataTable<DRActivityRank>().GetDataRows((DRActivityRank p) => p.RewardId > 0);
		if (dataRows2.Length == 0)
		{
			return;
		}
		DRActivityRank[] array2 = dataRows2;
		foreach (DRActivityRank dRActivityRank in array2)
		{
			ActivityTaskItemData activityTaskItemData2 = new ActivityTaskItemData(this, dRActivityRank.Id, dRActivityRank.Id);
			activityTaskItemData2.SetTextColor(base.ActivityTypeId);
			activityTaskItemData2.SetPropItem(dRActivityRank.RewardId);
			activityTaskItemData2.SetActivityInfo(dRActivityRank.ActivityTypeId, dRActivityRank.Id);
			activityTaskItemData2.InitTaskInfo(dRActivityRank.Desc, dRActivityRank.CompleteNum);
			ActivityTaskData activityTaskData2 = _pbTaskDataList?.Find((ActivityTaskData p) => p.Id == activityTaskItemData2.Uid);
			int value2 = (int)((activityTaskData2 != null) ? activityTaskData2.CompleteValue : 0);
			bool canAccept2 = activityTaskData2 != null && activityTaskData2.CompleteState == 1;
			bool received2 = activityTaskData2 != null && activityTaskData2.RewardState == 1;
			activityTaskItemData2.RefreshFinishCount(value2, canAccept2, received2);
			activityTaskItemData2.IsPhasedActivityTask = true;
			totalActivityTaskItemDataList.Add(activityTaskItemData2);
		}
		CheckRedPoint();
	}

	private void TabOnClick(ActivityTabItemData2 tab)
	{
		curTab?.SetSelect(value: false);
		curTab = tab;
		curTab.SetSelect(value: true);
		subActivityId = tab.TagId;
		showActivityTaskItemDataList = totalActivityTaskItemDataList.FindAll((ActivityTaskItemData p) => p.ActivityId == base.ActivityTypeId && p.TaskRankId == subActivityId);
		SortTask();
		RefreshRewardSlider();
		refreshActivityTaskRequest.Raise();
	}

	public void GetActivityTaskItemByRankId(int activityRankId)
	{
		showActivityTaskItemDataList = totalActivityTaskItemDataList.FindAll((ActivityTaskItemData p) => p.ActivityId == base.ActivityTypeId && p.TaskRankId == activityRankId);
	}

	private async void SendTaskAccept(ActivityTaskItemData activityTaskItemData)
	{
		ActivityReward activityReward = await Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetTaskReward(base.ActivityTypeId, 0, activityTaskItemData.TaskRankId);
		activityTaskItemData.ResetCmd();
		RefreshRewardSlider();
		if (!activityReward.Result)
		{
			if (activityReward.ErrorCode == 200159)
			{
				activityTaskItemData.SetFinishState();
				SortTask();
				refreshActivityTaskRequest.Raise();
			}
			return;
		}
		foreach (ActivityTaskItemData showActivityTaskItemData in showActivityTaskItemDataList)
		{
			if (showActivityTaskItemData.TaskState == ActivityTaskStateEnum.Accept)
			{
				showActivityTaskItemData.SetFinishState();
			}
		}
		SortTask();
		refreshActivityTaskRequest.Raise();
		CheckRedPoint();
		bool num = HasSuitBoxReward(activityReward.Rewards);
		PropGetViewModel propGetViewModel = new PropGetViewModel(parent, activityReward.Rewards);
		if (num)
		{
			parent?.ItemOnClick(new OpenViewArg(typeof(PropGetWindow), propGetViewModel));
		}
		else
		{
			parent?.ItemOnClick(propGetViewModel);
		}
	}

	private bool HasSuitBoxReward(RewardThings rewards)
	{
		for (int i = 0; i < rewards.propItems.Count; i++)
		{
			PropDataBase propDataBase = rewards.propItems[i];
			if (propDataBase != null && propDataBase.PropTypeEnum == PropTypeEnum.SuitBox)
			{
				return true;
			}
		}
		return false;
	}

	public override ActivityTaskData OnTaskRateNotify(ActivityTaskRateNotify rateNotify)
	{
		ActivityTaskData taskData = base.OnTaskRateNotify(rateNotify);
		if (taskData == null)
		{
			return null;
		}
		totalActivityTaskItemDataList.Find((ActivityTaskItemData p) => p.Uid == taskData.Id)?.RefreshFinishCount((int)taskData.CompleteValue, taskData.CompleteState == 1, taskData.RewardState == 1);
		if (showActivityTaskItemDataList != null && showActivityTaskItemDataList.Exists((ActivityTaskItemData p) => p.Uid == taskData.Id))
		{
			SortTask();
			refreshActivityTaskRequest.Raise();
		}
		RefreshRewardSlider();
		CheckRedPoint();
		return taskData;
	}

	private async void RefreshRewardSlider()
	{
		if (await Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetTaskRankProgress(activityRewardSliderViewModel.ActivityId))
		{
			activityRewardSliderViewModel.RefreshData(base.ActivityTypeId, subActivityId);
			List<ActivityTaskData> activityTaskDataList = activityProgressList.FindAll((ActivityTaskData p) => p.GroupId == activityRewardSliderViewModel.GroupId);
			activityRewardSliderViewModel.RefreshItemState(activityTaskDataList);
		}
	}

	private async void JumpWindow(ActivityTaskItemData activityTaskItemData)
	{
		Loading loading = await Loading.Show();
		if (CheckHaveTargetHero(activityTaskItemData))
		{
			OpenViewArg openViewArg = await new UIJumpHelper().CreateViewJumpData(new JumpWindowParams(activityTaskItemData.JumpWindow, activityTaskItemData.JumpFlagValueList), this, "PhasedActivity", CheckRedPoint);
			if (openViewArg != null)
			{
				parent?.ItemOnClick(openViewArg);
			}
		}
		else
		{
			Toast.ShowInfo("暂未获取烬天使");
		}
		loading.Dispose();
		activityTaskItemData.ResetCmd();
	}

	public bool CheckHaveTargetHero(ActivityTaskItemData activityTaskItemData)
	{
		if (activityTaskItemData == null)
		{
			return false;
		}
		if (!string.Equals(activityTaskItemData.JumpWindow, "HeroCultivateWindow", StringComparison.Ordinal))
		{
			return true;
		}
		List<int> jumpFlagValueList = activityTaskItemData.JumpFlagValueList;
		if (jumpFlagValueList == null || jumpFlagValueList.Count < 2)
		{
			return false;
		}
		int num = jumpFlagValueList[1];
		if (num <= 0)
		{
			return false;
		}
		return Singleton<ServiceSystem>.Instance.GetService<IHeroService>()?.HasHero(num) ?? false;
	}

	private void SortTask()
	{
		showActivityTaskItemDataList.Sort(new PhasedActivitySort());
	}

	protected async void UpdateRedPoint()
	{
		try
		{
			if (PhasedItemList == null)
			{
				return;
			}
			foreach (ActivityTabItemData2 phasedItem in PhasedItemList)
			{
				DRActivityRank drActivityRank = GameEntry.DataTable.GetDataTable<DRActivityRank>().GetDataRow(phasedItem.TagId);
				if (drActivityRank == null)
				{
					continue;
				}
				phasedItem.StateEnum = ActivityTabStateEnum.Normal;
				if (!string.IsNullOrEmpty(drActivityRank.UnlockTime))
				{
					long severRefreshTimeSpan = Utility.DateTime.GetSeverRefreshTimeSpan(drActivityRank.UnlockTime);
					if (Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetCurServerTime() < severRefreshTimeSpan)
					{
						phasedItem.StateEnum = ActivityTabStateEnum.Lock;
						continue;
					}
				}
				if (drActivityRank.UnlockType.Count > 0)
				{
					int i;
					for (i = 0; i < drActivityRank.UnlockType.Count; i++)
					{
						if (drActivityRank.UnlockType[i] == 1)
						{
							List<ActivityTaskItemData> list = totalActivityTaskItemDataList.FindAll((ActivityTaskItemData p) => p.TaskRankId == drActivityRank.UnlockNum[i] && (p.TaskState == ActivityTaskStateEnum.Accept || p.TaskState == ActivityTaskStateEnum.Finished));
							int num = GameEntry.DataTable.GetDataTable<DRActivityRank>().GetDataRow(drActivityRank.UnlockNum[i])?.CompleteNum ?? 0;
							if (list.Count < num)
							{
								phasedItem.StateEnum = ActivityTabStateEnum.Lock;
								break;
							}
						}
						else if (drActivityRank.UnlockType[i] != 2 && drActivityRank.UnlockType[i] == 3)
						{
							long num2 = Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetCurServerTime();
							if (num2 < Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().AccountCreateTime)
							{
								num2 = await Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetServiceTime();
							}
							if (num2 < phasedItem.UnLockTime)
							{
								phasedItem.StateEnum = ActivityTabStateEnum.Lock;
								break;
							}
						}
					}
					if (phasedItem.StateEnum == ActivityTabStateEnum.Lock)
					{
						continue;
					}
				}
				if (phasedItem.StateEnum == ActivityTabStateEnum.Finish)
				{
					continue;
				}
				List<ActivityTaskItemData> list2 = totalActivityTaskItemDataList.FindAll((ActivityTaskItemData p) => p.TaskRankId == phasedItem.TagId);
				bool flag = true;
				foreach (ActivityTaskItemData item in list2)
				{
					if (item.TaskState != ActivityTaskStateEnum.Finished)
					{
						flag = false;
						break;
					}
				}
				if (flag)
				{
					phasedItem.StateEnum = ActivityTabStateEnum.Finish;
				}
				else
				{
					phasedItem.StateEnum = (CheckRedPoint(phasedItem.TagId) ? ActivityTabStateEnum.RedPoint : ActivityTabStateEnum.Normal);
				}
			}
		}
		catch (Exception)
		{
		}
	}

	public void CheckRedPoint()
	{
		UpdateRed();
	}

	protected bool CheckUnLock(ActivityTabItemData2 tab)
	{
		long curServerTime = Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetCurServerTime();
		if (curServerTime < tab.UnLockTime)
		{
			Toast.ShowInfo(Utility.DateTime.GetActivityLeftTime(tab.UnLockTime - curServerTime) + "后解锁");
			return false;
		}
		DRActivityRank drActivityRank = GameEntry.DataTable.GetDataTable<DRActivityRank>().GetDataRow(tab.TagId);
		int i;
		for (i = 0; i < drActivityRank.UnlockType.Count; i++)
		{
			if (drActivityRank.UnlockType[i] == 1)
			{
				List<ActivityTaskItemData> list = totalActivityTaskItemDataList.FindAll((ActivityTaskItemData p) => p.TaskRankId == drActivityRank.UnlockNum[i] && (p.TaskState == ActivityTaskStateEnum.Accept || p.TaskState == ActivityTaskStateEnum.Finished));
				DRActivityRank dataRow = GameEntry.DataTable.GetDataTable<DRActivityRank>().GetDataRow(drActivityRank.UnlockNum[i]);
				if (list.Count < dataRow.CompleteNum)
				{
					Toast.ShowInfo(dataRow.Name + "全部任务完成后解锁");
					return false;
				}
			}
		}
		return true;
	}

	public void GetTabLockFinishInfo()
	{
		foreach (ActivityTabItemData2 phasedItem in PhasedItemList)
		{
			int num = 0;
			int num2 = 0;
			foreach (ActivityTaskItemData totalActivityTaskItemData in totalActivityTaskItemDataList)
			{
				if (totalActivityTaskItemData.TaskRankId == phasedItem.TagId)
				{
					num++;
					if (totalActivityTaskItemData.TaskState == ActivityTaskStateEnum.Finished || totalActivityTaskItemData.TaskState == ActivityTaskStateEnum.Accept)
					{
						num2++;
					}
				}
			}
			phasedItem.ActivityfinishDes = $"<color=#ffc962>{num2}</color>/{num}";
			phasedItem.PassAllLevel = num2 >= num;
			long curServerTime = Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetCurServerTime();
			if (curServerTime < phasedItem.UnLockTime)
			{
				string activityLeftTime = Utility.DateTime.GetActivityLeftTime(phasedItem.UnLockTime - curServerTime);
				phasedItem.TimeLock = true;
				phasedItem.LockDes = "<color=#ffc962>" + activityLeftTime + "</color>后解锁";
				continue;
			}
			DRActivityRank drActivityRank = GameEntry.DataTable.GetDataTable<DRActivityRank>().GetDataRow(phasedItem.TagId);
			int i;
			for (i = 0; i < drActivityRank.UnlockType.Count; i++)
			{
				if (drActivityRank.UnlockType[i] == 1)
				{
					List<ActivityTaskItemData> list = totalActivityTaskItemDataList.FindAll((ActivityTaskItemData p) => p.TaskRankId == drActivityRank.UnlockNum[i] && (p.TaskState == ActivityTaskStateEnum.Accept || p.TaskState == ActivityTaskStateEnum.Finished));
					DRActivityRank dataRow = GameEntry.DataTable.GetDataTable<DRActivityRank>().GetDataRow(drActivityRank.UnlockNum[i]);
					if (list.Count < dataRow.CompleteNum)
					{
						phasedItem.TimeLock = false;
						phasedItem.LockDes = dataRow.Name + "全部任务完成后解锁";
					}
				}
			}
		}
	}

	private bool CheckRedPoint(int activityId)
	{
		foreach (ActivityTaskItemData item in totalActivityTaskItemDataList.FindAll((ActivityTaskItemData p) => p.TaskRankId == activityId))
		{
			if (item.TaskState == ActivityTaskStateEnum.Accept)
			{
				return true;
			}
		}
		return false;
	}

	public override bool UpdateRed(bool notifyParent = true)
	{
		if (useUpdateRedPoint)
		{
			UpdateRedPoint();
			base.Red = phasedItemList.Exists((ActivityTabItemData2 p) => p.StateEnum == ActivityTabStateEnum.RedPoint);
			if (ActivityRewardSliderViewModel.IsVisible)
			{
				base.Red = base.Red || ActivityRewardSliderViewModel.Red;
			}
		}
		return base.UpdateRed(notifyParent);
	}
}
