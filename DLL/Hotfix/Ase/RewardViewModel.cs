#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class RewardViewModel : OptionBase
{
	private InteractionRequest interactionRequest;

	private int towerId;

	private int activityTypeId;

	private List<TowerRewardItemData> rewardItemDataList;

	private List<ActivityTaskData> activityTaskDatas;

	public List<TowerRewardItemData> RewardItemDataList
	{
		get
		{
			return rewardItemDataList;
		}
		set
		{
			Set(ref rewardItemDataList, value, "RewardItemDataList");
		}
	}

	public int TowerId
	{
		get
		{
			return towerId;
		}
		set
		{
			towerId = value;
		}
	}

	public InteractionRequest InteractionRequest
	{
		get
		{
			return interactionRequest;
		}
		set
		{
			interactionRequest = value;
		}
	}

	public RewardViewModel(int towerId, OptionBase parent, List<ActivityTaskData> activityTaskDatas, int activityTypeId)
	{
		InteractionRequest = new InteractionRequest();
		TowerId = towerId;
		base.parent = parent;
		this.activityTaskDatas = activityTaskDatas;
		RewardItemDataList = new List<TowerRewardItemData>();
		this.activityTypeId = activityTypeId;
		InitItems();
	}

	public void InitItems()
	{
		RewardItemDataList.Clear();
		DRActivityRankTask[] towerRankTaskConfig = GameEntry.DataTable.GetDataRows((DRActivityRankTask x) => x.ActivityRankId == towerId);
		if (towerRankTaskConfig == null || towerRankTaskConfig.Length == 0)
		{
			Log.Error("表是空的");
			return;
		}
		ActivityTaskDataSort();
		for (int num = 0; num < activityTaskDatas.Count; num++)
		{
			int j;
			for (j = 0; j < towerRankTaskConfig.Length; j++)
			{
				if (activityTaskDatas[num].Id == towerRankTaskConfig[j].Id)
				{
					DRActivityTask dataRow = GameEntry.DataTable.GetDataRow((DRActivityTask x) => x.Id == towerRankTaskConfig[j].ActivityTaskId);
					DRActivityTaskReward dataRow2 = GameEntry.DataTable.GetDataRow<DRActivityTaskReward>(towerRankTaskConfig[j].RewardId);
					TowerRewardItemData item = new TowerRewardItemData(this, activityTaskDatas[num].RewardState, activityTaskDatas[num].CompleteState, dataRow.TargetDesc, towerRankTaskConfig[j].Id, towerRankTaskConfig[j].ActivityTaskId, towerRankTaskConfig[j].ActivityRankId, activityTypeId, dataRow2, activityTaskDatas[num].CompleteValue, activityTaskDatas[num].TargetValue);
					RewardItemDataList.Add(item);
					break;
				}
			}
		}
	}

	public void ActivityTaskDataSort()
	{
		activityTaskDatas.Sort(delegate(ActivityTaskData x, ActivityTaskData y)
		{
			int num = int.MinValue;
			foreach (ActivityTaskData activityTaskData in activityTaskDatas)
			{
				if (activityTaskData.RewardState > num)
				{
					num = activityTaskData.RewardState;
				}
			}
			if (x.RewardState == num && y.RewardState != num)
			{
				return 1;
			}
			if (x.RewardState != num && y.RewardState == num)
			{
				return -1;
			}
			if (x.RewardState == num && y.RewardState == num)
			{
				int num2 = y.CompleteState.CompareTo(x.CompleteState);
				if (num2 != 0)
				{
					return num2;
				}
				return x.Id.CompareTo(y.Id);
			}
			int num3 = y.CompleteState.CompareTo(x.CompleteState);
			return (num3 != 0) ? num3 : x.Id.CompareTo(y.Id);
		});
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is OptionArg optionArg)
		{
			if (optionArg.Obj is TowerRewardItemData rewardItemData && optionArg.OptionName.Equals("GetReward"))
			{
				GetReward(rewardItemData);
			}
		}
		else if (obj is ReceiveItemViewModel)
		{
			parent?.ItemOnClick(obj);
		}
	}

	public async void GetReward(TowerRewardItemData rewardItemData)
	{
		if (rewardItemData.CompleteState == 0)
		{
			Log.Error("任务未完成");
			return;
		}
		if (rewardItemData.State == 1)
		{
			Log.Error("奖励已领取");
			return;
		}
		ActivityReward activityReward = await Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetTaskReward(activityTypeId, 0, rewardItemData.ActivityRankId);
		if (!activityReward.Result)
		{
			Log.Error("请求失败");
			return;
		}
		if (!activityReward.RewardEmpty())
		{
			PropGetViewModel userData = new PropGetViewModel(parent, activityReward.Rewards);
			parent?.ItemOnClick(new OpenViewArg(typeof(PropGetWindow), userData));
		}
		foreach (TowerRewardItemData rewardItemData2 in rewardItemDataList)
		{
			if (rewardItemData2.CompleteState == 1 && rewardItemData2.State == 0)
			{
				rewardItemData2.SetState();
			}
		}
		InitItems();
		SetRaise();
	}

	public void SetRaise()
	{
		interactionRequest.Raise();
		if (parent is TowerEnterCopyViewModel towerEnterCopyViewModel)
		{
			towerEnterCopyViewModel.SetRewardRedPointImg();
		}
		else if (parent is TowerActivityAreaViewModel towerActivityAreaViewModel)
		{
			towerActivityAreaViewModel.SetRewardRedPointImg();
		}
	}
}
