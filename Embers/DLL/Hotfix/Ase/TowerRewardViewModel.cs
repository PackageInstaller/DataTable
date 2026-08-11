using System.Collections.Generic;

namespace Ase;

public class TowerRewardViewModel : OptionBase
{
	private int towerId;

	private int activityTypeId;

	private RewardViewModel rewardViewModel;

	public RewardViewModel RewardViewModel
	{
		get
		{
			return rewardViewModel;
		}
		set
		{
			rewardViewModel = value;
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

	public TowerRewardViewModel(OptionBase parent, int towerId, List<ActivityTaskData> activityTaskDatas, int activityTypeId)
	{
		base.parent = parent;
		TowerId = towerId;
		this.activityTypeId = activityTypeId;
		RewardViewModel = new RewardViewModel(towerId, base.parent, activityTaskDatas, activityTypeId);
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is ReceiveItemViewModel receiveItemViewModel)
		{
			TowerRewardItemData towerRewardItemData = (obj as ReceiveItemViewModel).Parent as TowerRewardItemData;
			if (towerRewardItemData.State == 1 && towerRewardItemData.CompleteState == 1)
			{
				towerRewardItemData.SendGetTaskReward();
				towerRewardItemData.SetRedPoint();
				return;
			}
			OpenViewArg openViewArg = receiveItemViewModel.OpenPopupWindow(this, null, showOutsideMask: true, showOwnCount: true, allowSkipWindow: false);
			if (openViewArg != null)
			{
				openWindowRequest.Raise(openViewArg);
			}
		}
		else if (obj is TowerRewardItemData)
		{
			TowerRewardItemData towerRewardItemData2 = obj as TowerRewardItemData;
			if (towerRewardItemData2.State == 1 && towerRewardItemData2.CompleteState == 1)
			{
				towerRewardItemData2.SendGetTaskReward();
				towerRewardItemData2.SetRedPoint();
			}
		}
		else
		{
			parent?.ItemOnClick(obj);
		}
	}
}
