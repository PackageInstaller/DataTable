using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class ActivityTaskItemData : OptionBase
{
	private int uid;

	private int taskId;

	private int taskRankId;

	private int activityId;

	private bool countingTypeTask;

	private ActivityTaskStateEnum taskState = ActivityTaskStateEnum.Normal;

	private string stateText = "";

	private string taskName = "";

	private string taskCompleteText = "";

	private int realFinishCount;

	private int maxFinishCount = 1;

	private List<KnapsackItemViewModel> rewardPropList = new List<KnapsackItemViewModel>();

	private string jumpWindow = "";

	private List<int> jumpFlagValueList = new List<int>();

	private bool received;

	private SimpleCommand stateOnclickCmd;

	private bool isPhasedActivityTask;

	public string ColorAccept = "#e3a863";

	public string ColorJump = "#a18770";

	public string ColorNormal = "#a18770";

	public string ColorFinish = "#e3a863";

	public ActivityTaskStateEnum TaskState
	{
		get
		{
			return taskState;
		}
		set
		{
			Set(ref taskState, value, "TaskState");
		}
	}

	public string StateText
	{
		get
		{
			return stateText;
		}
		set
		{
			Set(ref stateText, value, "StateText");
		}
	}

	public string TaskCompleteText
	{
		get
		{
			return taskCompleteText;
		}
		set
		{
			Set(ref taskCompleteText, value, "TaskCompleteText");
		}
	}

	public bool IsPhasedActivityTask
	{
		get
		{
			return isPhasedActivityTask;
		}
		set
		{
			Set(ref isPhasedActivityTask, value, "IsPhasedActivityTask");
		}
	}

	public int Uid => uid;

	public int TaskId => taskId;

	public int TaskRankId => taskRankId;

	public int ActivityId => activityId;

	public string TaskName => taskName;

	public List<KnapsackItemViewModel> RewardPropList => rewardPropList;

	public SimpleCommand StateOnclickCmd => stateOnclickCmd;

	public string JumpWindow => jumpWindow;

	public List<int> JumpFlagValueList => jumpFlagValueList;

	public override void ItemOnClick(object obj)
	{
		parent?.ItemOnClick(obj);
	}

	public ActivityTaskItemData(OptionBase parent, int taskId, int uid = 0)
	{
		base.parent = parent;
		this.taskId = taskId;
		this.uid = uid;
		stateOnclickCmd = new SimpleCommand(StateOnClick);
		InitTaskInfo();
	}

	public void SetTextColor(Color normal, Color jump, Color accept, Color finish)
	{
		ColorNormal = "#" + ColorUtility.ToHtmlStringRGB(normal);
		ColorJump = "#" + ColorUtility.ToHtmlStringRGB(jump);
		ColorAccept = "#" + ColorUtility.ToHtmlStringRGB(accept);
		ColorFinish = "#" + ColorUtility.ToHtmlStringRGB(finish);
		RefreshStateColor();
	}

	private void InitTaskInfo()
	{
		DRActivityTask dataRow = GameEntry.DataTable.GetDataTable<DRActivityTask>().GetDataRow(taskId);
		if (dataRow == null)
		{
			return;
		}
		taskName = dataRow.TargetDesc;
		if (dataRow.RateShowFlag.Count != dataRow.RequireValue.Count)
		{
			return;
		}
		for (int i = 0; i < dataRow.RateShowFlag.Count; i++)
		{
			if (dataRow.RateShowFlag[i] == 1)
			{
				maxFinishCount = ((dataRow.RequireId[i] != 22 && dataRow.RequireId[i] != 7 && dataRow.RequireId[i] != 1) ? 1 : dataRow.RequireValue[i]);
				countingTypeTask = dataRow.RequireId[i] == 22 || dataRow.RequireId[i] == 7 || dataRow.RequireId[i] == 1;
			}
		}
	}

	public void InitTaskInfo(string taskName, int taskMaxFinishCount)
	{
		this.taskName = taskName;
		maxFinishCount = taskMaxFinishCount;
		countingTypeTask = true;
	}

	public void SetPropItem(int rewardId)
	{
		DRActivityTaskReward dataRow = GameEntry.DataTable.GetDataRow<DRActivityTaskReward>(rewardId);
		if (dataRow != null && dataRow.RewardType.Count == dataRow.RewardId.Count && dataRow.RewardType.Count == dataRow.RewardNum.Count)
		{
			for (int i = 0; i < dataRow.RewardType.Count; i++)
			{
				PropDataBase data = PropDataBase.CreateByType(dataRow.RewardType[i], dataRow.RewardId[i], dataRow.RewardNum[i]);
				KnapsackItemViewModel item = new KnapsackItemViewModel(this, data);
				rewardPropList.Add(item);
			}
		}
	}

	public void AddJumpWindow(string windowName, List<int> value)
	{
		jumpWindow = windowName;
		jumpFlagValueList = value;
	}

	public void RefreshFinishCount(int value, bool canAccept, bool received)
	{
		if (countingTypeTask)
		{
			realFinishCount = value;
		}
		if (canAccept)
		{
			realFinishCount = maxFinishCount;
		}
		this.received = received;
		realFinishCount = ((realFinishCount >= maxFinishCount) ? maxFinishCount : realFinishCount);
		TaskCompleteText = $"{realFinishCount}/{maxFinishCount}";
		CheckState();
	}

	public void SetActivityInfo(int activityId, int taskRankId)
	{
		this.activityId = activityId;
		this.taskRankId = taskRankId;
	}

	private void CheckState()
	{
		TaskState = (jumpWindow.Equals("") ? ActivityTaskStateEnum.Normal : ActivityTaskStateEnum.Jump);
		if (realFinishCount >= maxFinishCount)
		{
			TaskState = ActivityTaskStateEnum.Accept;
		}
		if (received)
		{
			TaskState = ActivityTaskStateEnum.Finished;
		}
		RefreshStateColor();
	}

	private void RefreshStateColor()
	{
		StateText = TaskState switch
		{
			ActivityTaskStateEnum.Accept => "<color=" + ColorAccept + ">完成</color>", 
			ActivityTaskStateEnum.Jump => "<color=" + ColorJump + ">前往</color>", 
			ActivityTaskStateEnum.Normal => "<color=" + ColorNormal + ">进行中</color>", 
			ActivityTaskStateEnum.Finished => "<color=" + ColorFinish + ">已完成</color>", 
			_ => StateText, 
		};
	}

	public void SetTextColor(int id)
	{
	}

	private void SetPhasedActivityTextColor()
	{
		ColorFinish = "#f6ce9f";
		ColorAccept = "#f6ce9f";
		ColorJump = "#f6ce9f";
		ColorNormal = "#88796c";
	}

	private void SetPhasedActivity2TextColor()
	{
		ColorFinish = "#9fdcf6";
		ColorAccept = "#7ebbff";
		ColorJump = "#7ebbff";
		ColorNormal = "#485483";
	}

	private void SetPhasedActivity3TextColor()
	{
		ColorFinish = "#67a0b7";
		ColorAccept = "#d9fff9";
		ColorJump = "#7edcff";
		ColorNormal = "#487283";
	}

	public void SetFinishState()
	{
		received = true;
		TaskState = ActivityTaskStateEnum.Finished;
		StateText = "<color=" + ColorFinish + ">已完成</color>";
	}

	private void StateOnClick()
	{
		if (TaskState != ActivityTaskStateEnum.Normal)
		{
			stateOnclickCmd.Enabled = false;
			if (TaskState == ActivityTaskStateEnum.Jump)
			{
				parent?.ItemOnClick(new OptionArg(this, "Jump"));
			}
			else if (taskState == ActivityTaskStateEnum.Accept)
			{
				parent?.ItemOnClick(new OptionArg(this, "Accept"));
			}
		}
	}

	public void ResetCmd()
	{
		stateOnclickCmd.Enabled = true;
	}

	public void SetItemState(ActivityTaskStateEnum stateEnum)
	{
		for (int i = 0; i < rewardPropList.Count; i++)
		{
			rewardPropList[i].IsActive = stateEnum != ActivityTaskStateEnum.Finished;
		}
	}
}
