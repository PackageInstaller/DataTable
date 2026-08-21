#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class ActivityPointsViewModel : OptionBase
{
	private List<ActivityTaskItemData> activityTaskItemDataList;

	private ActivityRewardSlider2ViewModel sliderViewModel;

	private int activityTypeId;

	private int subActivityTypeId;

	private InteractionRequest refreshTaskRequest;

	private bool redPoint;

	private List<ActivityTaskData> taskDataList;

	public bool RedPoint
	{
		get
		{
			return redPoint;
		}
		set
		{
			Set(ref redPoint, value, "RedPoint");
		}
	}

	public List<ActivityTaskItemData> ActivityTaskItemDataList
	{
		get
		{
			return activityTaskItemDataList;
		}
		set
		{
			Set(ref activityTaskItemDataList, value, "ActivityTaskItemDataList");
		}
	}

	public InteractionRequest RefreshTaskRequest => refreshTaskRequest;

	public ActivityRewardSlider2ViewModel SliderViewModel => sliderViewModel;

	public ActivityPointsViewModel(OptionBase parent, List<ActivityTaskData> taskDataList, int activityTypeId, int subActivityTypeId = 0)
	{
		base.parent = parent;
		this.activityTypeId = activityTypeId;
		this.subActivityTypeId = subActivityTypeId;
		activityTaskItemDataList = new List<ActivityTaskItemData>();
		refreshTaskRequest = new InteractionRequest();
		InitTaskList(taskDataList);
	}

	public void OpenSliderViewModel()
	{
		sliderViewModel = new ActivityRewardSlider2ViewModel(this);
		sliderViewModel.RefreshData(activityTypeId);
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is OptionArg optionArg)
		{
			if (optionArg.Obj is ActivityTaskItemData)
			{
				parent?.ItemOnClick(optionArg);
			}
		}
		else if (obj is KnapsackItemViewModel)
		{
			parent?.ItemOnClick(obj);
		}
	}

	private void InitTaskList(List<ActivityTaskData> taskDataList)
	{
		this.taskDataList = taskDataList;
		DRActivityRankTask[] dataRows = GameEntry.DataTable.GetDataTable<DRActivityRankTask>().GetDataRows((DRActivityRankTask p) => p.ActivityTypeId == activityTypeId && p.ActivityRankId == subActivityTypeId);
		if (dataRows.Length == 0)
		{
			Log.Error($"活动{activityTypeId}任务数据配置错误");
			return;
		}
		DRActivityRankTask[] array = dataRows;
		foreach (DRActivityRankTask dRActivityRankTask in array)
		{
			ActivityTaskItemData activityTaskItemData = new ActivityTaskItemData(this, dRActivityRankTask.ActivityTaskId, dRActivityRankTask.Id);
			activityTaskItemData.SetTextColor(activityTypeId);
			activityTaskItemData.SetPropItem(dRActivityRankTask.RewardId);
			activityTaskItemData.SetActivityInfo(dRActivityRankTask.ActivityTypeId, dRActivityRankTask.ActivityRankId);
			activityTaskItemData.AddJumpWindow(dRActivityRankTask.TargetWindow, dRActivityRankTask.WindowParams);
			ActivityTaskData activityTaskData = taskDataList?.Find((ActivityTaskData p) => p.Id == activityTaskItemData.Uid);
			int value = (int)((activityTaskData != null) ? activityTaskData.CompleteValue : 0);
			bool canAccept = activityTaskData != null && activityTaskData.CompleteState == 1;
			bool received = activityTaskData != null && activityTaskData.RewardState == 1;
			activityTaskItemData.RefreshFinishCount(value, canAccept, received);
			activityTaskItemData.IsPhasedActivityTask = false;
			activityTaskItemDataList.Add(activityTaskItemData);
		}
		activityTaskItemDataList.Sort(new PhasedActivitySort());
	}

	public void Sort()
	{
		activityTaskItemDataList.Sort(new PhasedActivitySort());
		refreshTaskRequest.Raise();
	}

	public async UniTask<bool> RefreshRewardSlider()
	{
		if (sliderViewModel == null)
		{
			return true;
		}
		bool flag = await Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetTaskRankProgress(sliderViewModel.ActivityTypeId);
		if (flag)
		{
			ActivityViewModelBase activityViewModel = Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetActivityVm().GetActivityViewModel(activityTypeId);
			if (activityViewModel == null)
			{
				return false;
			}
			List<ActivityTaskData> activityTaskDataList = activityViewModel.ActivityProgressList.FindAll((ActivityTaskData p) => p.GroupId == sliderViewModel.ProgressId);
			sliderViewModel.RefreshItemState(activityTaskDataList);
		}
		return flag;
	}

	public void UpdateTask(int taskId)
	{
		ActivityTaskData activityTaskData = taskDataList?.Find((ActivityTaskData p) => p.Id == taskId);
		int value = (int)((activityTaskData != null) ? activityTaskData.CompleteValue : 0);
		bool canAccept = activityTaskData != null && activityTaskData.CompleteState == 1;
		bool received = activityTaskData != null && activityTaskData.RewardState == 1;
		activityTaskItemDataList.Find((ActivityTaskItemData p) => p.Uid == taskId)?.RefreshFinishCount(value, canAccept, received);
		Sort();
	}

	public void UpdateAllTask()
	{
		foreach (ActivityTaskItemData activityTaskItemData in activityTaskItemDataList)
		{
			ActivityTaskData activityTaskData = Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetActivityVm().GetActivityTaskData(activityTypeId, activityTaskItemData.Uid);
			int value = (int)((activityTaskData != null) ? activityTaskData.CompleteValue : 0);
			bool canAccept = activityTaskData != null && activityTaskData.CompleteState == 1;
			bool received = activityTaskData != null && activityTaskData.RewardState == 1;
			activityTaskItemData.RefreshFinishCount(value, canAccept, received);
		}
		Sort();
	}

	public bool CheckRedPoint()
	{
		RedPoint = false;
		foreach (ActivityTaskItemData activityTaskItemData in activityTaskItemDataList)
		{
			if (activityTaskItemData.TaskState == ActivityTaskStateEnum.Accept)
			{
				RedPoint = true;
				return RedPoint;
			}
		}
		if (sliderViewModel != null)
		{
			foreach (GameActivityRewardItemData rewardItem in sliderViewModel.RewardItemList)
			{
				if (rewardItem.State == 2)
				{
					RedPoint = true;
					return RedPoint;
				}
			}
		}
		return RedPoint;
	}
}
