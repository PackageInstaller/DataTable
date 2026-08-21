using System;
using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class ActivityAchievementRewardViewModel : OptionBase
{
	private List<ActivityAchievementRewardItemData> rewardList = new List<ActivityAchievementRewardItemData>();

	private InteractionRequest refreshRst = new InteractionRequest();

	public List<ActivityAchievementRewardItemData> RewardList => rewardList;

	public InteractionRequest RefreshRst => RefreshRst;

	public ActivityAchievementRewardViewModel()
	{
	}

	public ActivityAchievementRewardViewModel(OptionBase parent, List<ActivityAchievementTaskData> taskList)
	{
		base.parent = parent;
		InitData(taskList);
	}

	private void InitData(List<ActivityAchievementTaskData> taskList)
	{
		foreach (ActivityAchievementTaskData task in taskList)
		{
			ActivityAchievementRewardItemData item = new ActivityAchievementRewardItemData(this, task);
			rewardList.Add(item);
		}
		ListSort();
	}

	private void ListSort()
	{
		rewardList.Sort(delegate(ActivityAchievementRewardItemData a, ActivityAchievementRewardItemData b)
		{
			if (a.RedPoint != b.RedPoint)
			{
				return b.RedPoint.CompareTo(a.RedPoint);
			}
			return (a.Config != null && b.Config != null) ? a.Config.sort.CompareTo(b.Config.sort) : 0;
		});
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is ActivityAchievementRewardItemData activityAchievementRewardItemData)
		{
			if (activityAchievementRewardItemData.RedPoint)
			{
				OnReward(activityAchievementRewardItemData);
			}
		}
		else if (obj is ReceiveItemViewModel receiveItemViewModel)
		{
			OpenViewArg openViewArg = receiveItemViewModel.OpenPopupWindow(this);
			if (openViewArg != null)
			{
				openWindowRequest.Raise(openViewArg);
			}
		}
	}

	private async void OnReward(ActivityAchievementRewardItemData rewardData)
	{
		try
		{
			ActivityReward activityReward = await Singleton<ServiceSystem>.Instance.GetService<IActivityAchievementService>().GetTaskRewardRst(rewardData.Config.id);
			if (activityReward.Rewards != null)
			{
				rewardData.RedPoint = false;
				ListSort();
				RefreshRst.Raise();
				PropGetViewModel userData = new PropGetViewModel(this, activityReward.Rewards);
				openWindowRequest.Raise(new OpenViewArg(typeof(PropGetWindow), userData), delegate
				{
				});
			}
		}
		catch (Exception)
		{
		}
	}
}
