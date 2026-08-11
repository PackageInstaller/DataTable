using System.Collections.Generic;

namespace Ase;

public class TowerRewardItemData : OptionBase
{
	private int state;

	private int completeState;

	private bool redPoint;

	private string rewardDes;

	private int activityRankTaskId;

	private int activityTaskId;

	private int activityRankId;

	private int activityTypeId;

	private List<int> towerRewardIds;

	private List<int> towerRewardTypes;

	private List<int> towerRewardNums;

	private string taskProgressText;

	private long completeValue;

	private int targetValue;

	private List<ReceiveItemViewModel> dropProps;

	public long CompleteValue
	{
		get
		{
			return completeValue;
		}
		set
		{
			Set(ref completeValue, value, "CompleteValue");
			RefreshTaskProgressText();
		}
	}

	public int TargetValue
	{
		get
		{
			return targetValue;
		}
		set
		{
			Set(ref targetValue, value, "TargetValue");
			RefreshTaskProgressText();
		}
	}

	public string TaskProgressText
	{
		get
		{
			return taskProgressText;
		}
		set
		{
			Set(ref taskProgressText, value, "TaskProgressText");
		}
	}

	public string RewardDes
	{
		get
		{
			return rewardDes;
		}
		set
		{
			Set(ref rewardDes, value, "RewardDes");
		}
	}

	public int ActivityTaskId
	{
		get
		{
			return activityTaskId;
		}
		set
		{
			activityTaskId = value;
		}
	}

	public List<int> TowerRewardIds
	{
		get
		{
			return towerRewardIds;
		}
		set
		{
			towerRewardIds = value;
		}
	}

	public List<int> TowerRewardNums
	{
		get
		{
			return towerRewardNums;
		}
		set
		{
			towerRewardNums = value;
		}
	}

	public List<int> TowerRewardTypes
	{
		get
		{
			return towerRewardTypes;
		}
		set
		{
			towerRewardTypes = value;
		}
	}

	public List<ReceiveItemViewModel> DropProps
	{
		get
		{
			return dropProps;
		}
		set
		{
			dropProps = value;
		}
	}

	public int ActivityRankTaskId
	{
		get
		{
			return activityRankTaskId;
		}
		set
		{
			activityRankTaskId = value;
		}
	}

	public int State
	{
		get
		{
			return state;
		}
		set
		{
			state = value;
		}
	}

	public int CompleteState
	{
		get
		{
			return completeState;
		}
		set
		{
			completeState = value;
		}
	}

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

	public int ActivityRankId
	{
		get
		{
			return activityRankId;
		}
		set
		{
			activityRankId = value;
		}
	}

	public TowerRewardItemData(OptionBase parent, int state, int completeState, string rewardDes, int activityRankTaskId, int activityTaskId, int activityRankId, int activityTypeId, DRActivityTaskReward cf, long completeValue, int targetValue)
	{
		base.parent = parent;
		State = state;
		CompleteState = completeState;
		RewardDes = rewardDes;
		ActivityRankTaskId = activityRankTaskId;
		ActivityTaskId = activityTaskId;
		TowerRewardIds = cf.RewardId;
		TowerRewardTypes = cf.RewardType;
		TowerRewardNums = cf.RewardNum;
		ActivityRankId = activityRankId;
		this.activityTypeId = activityTypeId;
		CompleteValue = completeValue;
		TargetValue = targetValue;
		RefreshTaskProgressText();
		DropProps = new List<ReceiveItemViewModel>();
		for (int i = 0; i < TowerRewardIds.Count; i++)
		{
			ReceiveItemViewModel item = new ReceiveItemViewModel(PropDataBase.CreateByType(TowerRewardTypes[i], TowerRewardIds[i], TowerRewardNums[i]), this);
			DropProps.Add(item);
		}
		InitReceiveItemState();
	}

	public void InitReceiveItemState()
	{
		if (CompleteState == 0)
		{
			for (int i = 0; i < DropProps.Count; i++)
			{
				DropProps[i].SetGot(isGot: false);
				DropProps[i].SetLock(isLock: true);
			}
			SetRedPoint();
		}
		else
		{
			if (CompleteState != 1)
			{
				return;
			}
			if (State == 0)
			{
				for (int j = 0; j < DropProps.Count; j++)
				{
					DropProps[j].SetGot(isGot: false);
					DropProps[j].SetLock(isLock: false);
				}
				SetRedPoint();
			}
			else if (State == 1)
			{
				for (int k = 0; k < DropProps.Count; k++)
				{
					DropProps[k].SetGot(isGot: true);
					DropProps[k].SetLock(isLock: false);
				}
				SetRedPoint();
			}
		}
	}

	public async void SendGetTaskReward()
	{
		parent?.ItemOnClick(new OptionArg(this, "GetReward"));
	}

	public void SetState()
	{
		State = 1;
		SetRedPoint();
		InitReceiveItemState();
	}

	public void SetRedPoint()
	{
		if (CompleteState == 0)
		{
			RedPoint = false;
		}
		else if (CompleteState == 1)
		{
			if (State == 0)
			{
				RedPoint = true;
			}
			else if (State == 1)
			{
				RedPoint = false;
			}
		}
	}

	public override void ItemOnClick(object obj)
	{
		parent?.ItemOnClick(obj);
	}

	private void RefreshTaskProgressText()
	{
		TaskProgressText = $"{CompleteValue}/{TargetValue}";
	}
}
